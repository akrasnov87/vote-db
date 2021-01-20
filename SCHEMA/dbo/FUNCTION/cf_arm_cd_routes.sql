CREATE OR REPLACE FUNCTION dbo.cf_arm_cd_routes(_f_author integer) RETURNS TABLE(id uuid, c_number text, d_date_start date, d_date_end date, c_status text, c_status_name text, f_type integer, c_type text, j_users json, n_points bigint)
    LANGUAGE plpgsql
    AS $$
/**
* @params {integer} _f_author - автор маршрута
* @example 
* [{ "action": "cf_arm_cd_route", "method": "Select", "data": [{ "params":[_f_author] }], "type": "rpc", "tid": 0 }]
*/
DECLARE
	_status_weight integer; -- вес статуса Сформирован
	_create_status_id integer; -- идентификатор Формируется
	_routes json; -- список маршрутов для выборки
BEGIN
	select rs.n_order into _status_weight 
	from core.cs_route_statuses as rs
	where rs.c_const = 'CREATED'; -- только до этого состояния
	
	select rs.id into _create_status_id 
	from core.cs_route_statuses as rs
	where rs.c_const = 'CREATE'; -- только до этого состояния	

	-- получаем список маршрутов которые были созданы указанным пользователем
	IF _f_author is not null THEN
		select array_to_json(array_agg(row_to_json(t))) into _routes from (
			select DISTINCT rh.fn_route from core.cd_route_history as rh
			where rh.fn_user = _f_author and rh.fn_status = _create_status_id
		) as t;
	ELSE
		select array_to_json(array_agg(row_to_json(t))) into _routes from (
			select DISTINCT rh.fn_route from core.cd_route_history as rh
			where rh.fn_status = _create_status_id
		) as t;
	END IF;

	-- обходчики выбраны и находим все маршруты за текущую дату
	RETURN QUERY select 
		r.id, 
		r.c_number, 
		r.d_date_start, 
		r.d_date_end,
		rs.c_const, 
		rs.c_name,
		r.f_type, 
		rt.c_name as c_type,
		(select array_to_json(array_agg(row_to_json(t))) from (
			select u.id, u.c_first_name, u.c_last_name, u.c_middle_name, uir.b_main from core.cd_userinroutes as uir 
			inner join core.pd_users as u ON u.id = uir.f_user
			where uir.f_route = r.id
			order by u.c_first_name, u.c_last_name
		) as t) as j_users,
		(select count(*) from core.cd_points as p where r.id = p.f_route) as n_points
	from (select (t.value #>> '{fn_route}')::uuid as fn_route from json_array_elements(_routes) as t) as uir
		INNER JOIN core.cd_routes as r ON r.id = uir.fn_route
		inner join core.cs_route_types as rt ON rt.id = r.f_type
		left join core.cs_route_statuses as rs ON rs.id = r.f_status
	where _status_weight >= rs.n_order 
	order by r.d_date_start;
END
$$;

ALTER FUNCTION dbo.cf_arm_cd_routes(_f_author integer) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_arm_cd_routes(_f_author integer) IS 'Этап "Планирование": получение списка маршрутов';

--------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION dbo.cf_arm_cd_routes(_f_user integer, _d_date date) RETURNS TABLE(id uuid, c_number text, d_date_start date, d_date_end date, c_status text, c_status_name text, f_type integer, c_type text, j_users json, n_points bigint, n_done_points bigint, n_done_today_points bigint, n_cnt_fl integer, n_cnt_ul integer, n_cnt_tu integer)
    LANGUAGE plpgsql STABLE
    AS $$
/**
* @params {integer} _f_user - обходчик
* @params {date} _d_date - дата для фильтрации маршрутов
*
* @example
* [{ "action": "cf_arm_cd_routes", "method": "Select", "data": [{ "params": [_f_user, _d_date] }], "type": "rpc", "tid": 0 }]
*/
DECLARE
	_status_weight integer;
BEGIN
	select rs.n_order into _status_weight 
	from core.cs_route_statuses as rs
	where rs.c_const = 'ASSINGNED'; -- не ниже этого статуса

    RETURN QUERY WITH routes as (
		select r.id, r.c_number, r.d_date_start, r.d_date_end, rs.c_const, rs.c_name, r.f_type, rt.c_name as c_type
		from core.cd_userinroutes as uir
		INNER JOIN core.cd_routes as r ON r.id = uir.f_route
		inner join core.cs_route_types as rt ON rt.id = r.f_type
		left join core.cs_route_statuses as rs ON rs.id = r.f_status
		where uir.b_main = true and uir.f_user = _f_user and _d_date::date >= r.d_date_start and core.sf_finish_date(CASE WHEN r.b_extended THEN r.d_extended ELSE r.d_date_end END) and rs.n_order >= _status_weight
	) select 
		r.*,
		(select array_to_json(array_agg(row_to_json(t))) from (
			select u.id, u.c_first_name, u.c_last_name, u.c_middle_name, uir.b_main from core.cd_userinroutes as uir 
			inner join core.pd_users as u ON u.id = uir.f_user
			where uir.f_route = r.id
			order by u.c_first_name, u.c_last_name
		) as t) as j_users,
		(select count(*) from core.cd_points as p where r.id = p.f_route) as n_points,
		(select count(DISTINCT fn_point) from core.cd_user_points as up where r.id = up.fn_route and up.fn_user = _f_user) as n_done_points,
		(select count(DISTINCT fn_point) from core.cd_user_points as up where r.id = up.fn_route and up.fn_user = _f_user and up.d_date::date = now()::date) as n_done_today_points,
		t.n_cnt_fl::int,
		t.n_cnt_ul::int,
		t.n_cnt_tu::int
	from routes as r
		left join lateral
		(select 
			sum(case when ss.b_person then 1 else 0 end) as n_cnt_fl,
			sum(case when not ss.b_person then 1 else 0 end) as n_cnt_ul,
			sum(case when rp.b_technical_metering then 1 else 0 end) as n_cnt_tu -- техучет
		from core.cd_points cp 
			inner join dbo.ed_registr_pts rp on rp.id = cp.f_registr_pts 
			inner join dbo.sd_subscr ss on ss.id = rp.f_subscr 
		where cp.f_route = r.id 
		) t on true
order by r.d_date_start;
END
$$;

ALTER FUNCTION dbo.cf_arm_cd_routes(_f_user integer, _d_date date) OWNER TO postgres;

COMMENT ON FUNCTION dbo.cf_arm_cd_routes(_f_user integer, _d_date date) IS 'Этап "Назначение": получить список маршрутов по заданным параметрам фильтров "Обходчик" и "Дата"';

--------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION dbo.cf_arm_cd_routes(_f_main_division integer, _f_division integer, _f_subdivision integer, _f_manager integer, _f_user integer) RETURNS TABLE(id uuid, c_number text, d_date_start date, d_date_end date, c_status text, c_status_name text, f_type integer, c_type text, j_users json, n_points bigint, n_done_points bigint, n_done_today_points bigint)
    LANGUAGE plpgsql
    AS $$
/**
* @params {integer} _f_main_division - иден. филиал. Обязателен при передаче
* @params {integer} _f_division - иден. отделение. Обязателен при передаче
* @params {integer} _f_subdivision - иден. участок. Обязателен при передаче
* @params {integer} _f_manager - иден. диспетчер. Может быть null
* @params {integer} _f_user - иден. обходчика. Может быть null
* @example
* [{ "action": "cf_arm_cd_routes", "method": "Select", "data": [{ "params": [_f_main_division, _f_division, _f_subdivision, _f_manager, _f_user] }], "type": "rpc", "tid": 0}]
*/
DECLARE
	_users json; -- обходчики
	_d_date date;
	_status_weight integer;
BEGIN
	select now()::date into _d_date;
	
	select rs.n_order into _status_weight 
	from core.cs_route_statuses as rs
	where rs.c_const = 'ASSINGNED'; -- не ниже этого статуса
	
	-- обходчики выбраны и находим все маршруты за текущую дату
	RETURN QUERY select 
		r.id, 
		r.c_number, 
		r.d_date_start, 
		r.d_date_end,
		rs.c_const, 
		rs.c_name,
		r.f_type, 
		rt.c_name as c_type,
		(select array_to_json(array_agg(row_to_json(t))) from (
			select u.id, u.c_first_name, u.c_last_name, u.c_middle_name, uir.b_main from core.cd_userinroutes as uir 
			inner join core.pd_users as u ON u.id = uir.f_user
			where uir.f_route = r.id
			order by u.c_first_name, u.c_last_name
		) as t) as j_users,
		(select count(*) from core.cd_points as p where r.id = p.f_route) as n_points,
		(select count(DISTINCT fn_point) from core.cd_user_points as up where r.id = up.fn_route and up.fn_user = _f_user) as n_done_points,
		(select count(DISTINCT fn_point) from core.cd_user_points as up where r.id = up.fn_route and up.fn_user = _f_user and up.d_date::date = now()::date) as n_done_today_points
	from core.cd_userinroutes as uir
		INNER JOIN core.cd_routes as r ON r.id = uir.f_route
		inner join core.cs_route_types as rt ON rt.id = r.f_type
		left join core.cs_route_statuses as rs ON rs.id = r.f_status
		where uir.b_main = true and uir.f_user IN (
			select u.id from dbo.cf_arm_pd_users(_f_main_division, _f_division, _f_subdivision, _f_manager, _f_user) as u
		) and _d_date >= r.d_date_start and core.sf_finish_date(CASE WHEN r.b_extended THEN r.d_extended ELSE r.d_date_end END) and rs.n_order >= _status_weight
	order by r.d_date_start;
END
$$;

ALTER FUNCTION dbo.cf_arm_cd_routes(_f_main_division integer, _f_division integer, _f_subdivision integer, _f_manager integer, _f_user integer) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_arm_cd_routes(_f_main_division integer, _f_division integer, _f_subdivision integer, _f_manager integer, _f_user integer) IS 'Этап "Назначение": получение списка маршрутов за текущий день';
