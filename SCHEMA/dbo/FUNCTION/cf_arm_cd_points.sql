CREATE OR REPLACE FUNCTION dbo.cf_arm_cd_points(_routes json, _d_date date) RETURNS TABLE(id uuid, b_done boolean, c_address text, n_longitude numeric, n_latitude numeric, c_device_number text, c_subscr text, c_owner text, j_results json)
    LANGUAGE plpgsql STABLE
    AS $$
/**
* @params {json} _routes - массив маршрутов, требуется передать в виде строки '["e7ded0cd-12dd-47f5-a75b-192376291e83"]'
* @params {date} _d_date - дата фильтрации, например 2020-10-01

* @example
* [{ "action": "cf_arm_cd_points", "method": "Select", "data": [{ "params": [_routes, _d_date] }], "type": "rpc", "tid": 0}]
*/ 
BEGIN
    RETURN QUERY WITH user_points as (
		select up.fn_point, up.fn_user, up.d_date from core.cd_user_points as up
		where up.fn_route IN (select t.value::uuid from json_array_elements_text(_routes) as t) and _d_date::date >= up.d_date::date
	) 
	select
		p.id,
		(select count(*) from user_points as up where up.fn_point = p.id) > 0 as b_done,
		ad.c_name as c_address,
		ad.n_geo_lon,
		ad.n_geo_lat,
		d.c_serial_number as c_device_number,
		s.c_code as c_subscr,
		(CASE WHEN s.b_person THEN concat(s.c_name1, ' ', s.c_name2, ' ', s.c_name3) ELSE s.c_name1 END) as c_owner,
		(select array_to_json(array_agg(row_to_json(t))) from (
			select r.id as f_result, rt.c_const as c_type_const, rt.c_short_name as c_type_name, r.fn_user as f_user, u.c_first_name, u.c_last_name, u.c_middle_name, r.d_date
			from core.cd_results as r
			inner join core.cs_result_types as rt ON r.fn_type = rt.id
			inner join core.pd_users as u ON u.id = r.fn_user
			where r.fn_route IN (select t.value::uuid from json_array_elements_text(_routes) as t) and r.fn_point = p.id
		) as t) as j_results
	from core.cd_points as p
	left join dbo.ed_registr_pts as rp ON p.f_registr_pts = rp.id
	left join dbo.ss_address as ad ON ad.id = rp.f_address
	left join dbo.sd_subscr as s ON s.id = rp.f_subscr
	left join dbo.ed_devices as d ON d.f_registr_pts = rp.id
	where d.d_close_date is null and p.f_route IN (select t.value::uuid from json_array_elements_text(_routes) as t)
	order by p.n_order;
END
$$;

ALTER FUNCTION dbo.cf_arm_cd_points(_routes json, _d_date date) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_arm_cd_points(_routes json, _d_date date) IS 'Получить список заданий по маршруту';

--------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION dbo.cf_arm_cd_points(_f_main_division integer, _f_division integer, _f_subdivision integer, _f_manager integer, _f_user integer) RETURNS TABLE(id uuid, b_done boolean, c_address text, n_longitude numeric, n_latitude numeric, c_device_number text, c_subscr text, c_owner text, j_results json)
    LANGUAGE plpgsql
    AS $$
/**
* @params {integer} _f_main_division - иден. филиал. Обязателен при передаче
* @params {integer} _f_division - иден. отделение. Обязателен при передаче
* @params {integer} _f_subdivision - иден. участок. Обязателен при передаче
* @params {integer} _f_manager - иден. диспетчер. Может быть null
* @params {integer} _f_user - иден. обходчика. Может быть null
*
* @example
* [{ "action": "cf_arm_cd_points", "method": "Select", "data": [{ "params": [_f_main_division, _f_division, _f_subdivision, _f_manager, _f_user] }], "type": "rpc", "tid": 0}]
*/
DECLARE
	_routes json;
	_d_date date;
BEGIN
	IF _d_date is null THEN
		select now()::date into _d_date;
	END IF;
	
	-- обходчики выбраны и находим все маршруты за текущую дату
	select array_to_json(array_agg(t.id)) into _routes
	from (select r.id from core.cd_userinroutes as uir
		INNER JOIN core.cd_routes as r ON r.id = uir.f_route
		where uir.b_main = true and uir.f_user IN (
			select u.id from dbo.cf_arm_pd_users(_f_main_division, _f_division, _f_subdivision, _f_manager, _f_user) as u
		) and _d_date >= r.d_date_start and _d_date <= (CASE WHEN r.b_extended THEN r.d_extended ELSE r.d_date_end END)) as t;

	RETURN QUERY select * from dbo.cf_arm_cd_points(_routes, _d_date);
END
$$;

ALTER FUNCTION dbo.cf_arm_cd_points(_f_main_division integer, _f_division integer, _f_subdivision integer, _f_manager integer, _f_user integer) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_arm_cd_points(_f_main_division integer, _f_division integer, _f_subdivision integer, _f_manager integer, _f_user integer) IS 'Получение всех точек заданий, по значениям, выбранным в фильтре за текущий день';
