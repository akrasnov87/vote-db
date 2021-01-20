CREATE OR REPLACE FUNCTION dbo.cf_arm_pd_user_stat(_fn_user integer, _d_date date) RETURNS TABLE(id integer, c_login text, c_first_name text, c_last_name text, c_middle_name text, c_email text, c_phone text, fn_file uuid, d_tracking_date timestamp with time zone, n_today_done_person bigint, n_all_done_person bigint, n_lost_person bigint, n_all_person bigint, n_today_done bigint, n_all_done bigint, n_lost bigint, n_all bigint)
    LANGUAGE plpgsql
    AS $$
/**
* @params {integer} _fn_user - иден. обходчика
* @params {date} _d_date - дата
*
* @example
* [{ "action": "cf_arm_pd_user_stat", "method": "Select", "data": [{ "params": [_fn_user, _d_date] }], "type": "rpc", "tid": 0}]
*/
DECLARE
	_status_weight integer;
BEGIN
	select rs.n_order into _status_weight 
	from core.cs_route_statuses as rs
	where rs.c_const = 'ASSINGNED'; -- не ниже этого статуса

	RETURN QUERY 
	with points as (
		select (CASE WHEN s.b_person THEN 1 ELSE 0 END) as b_person
		from core.cd_userinroutes as uir
		INNER JOIN core.cd_routes as r ON r.id = uir.f_route
		INNER join core.cs_route_statuses as rs ON rs.id = r.f_status
		INNER JOIN core.cd_points as p ON p.f_route = r.id
		left join dbo.ed_registr_pts as rp ON rp.id = p.f_registr_pts
		left join dbo.sd_subscr as s ON s.id = rp.f_subscr
		where uir.f_user = _fn_user and _d_date::date >= r.d_date_start and core.sf_finish_date(CASE WHEN r.b_extended THEN r.d_extended ELSE r.d_date_end END) and rs.n_order >= _status_weight
	), userpoints as (
		select max(CASE WHEN s.b_person THEN 1 ELSE 0 END) as b_person, max(up.d_date) as d_date
		from core.cd_userinroutes as uir
		INNER JOIN core.cd_routes as rt ON rt.id = uir.f_route
		INNER join core.cs_route_statuses as rs ON rs.id = rt.f_status
		INNER JOIN core.cd_points as p ON p.f_route = uir.f_route
		left join dbo.ed_registr_pts as rp ON rp.id = p.f_registr_pts
		left join dbo.sd_subscr as s ON s.id = rp.f_subscr
		inner JOIN core.cd_user_points as up ON up.fn_point = p.id
		where uir.f_user = _fn_user and _d_date::date >= rt.d_date_start and core.sf_finish_date(CASE WHEN rt.b_extended THEN rt.d_extended ELSE rt.d_date_end END) and rs.n_order >= _status_weight
		group by p.id
	) select
		u.id,
		u.c_login,
		u.c_first_name,
		u.c_last_name,
		u.c_middle_name,
		u.c_email,
		u.c_phone,
		u.fn_file,
		(select a.d_date from core.ad_tracking as a where a.fn_user = u.id order by a.d_date desc limit 1) as d_tracking_date, -- время последнего получения геокординаты
		(select count(*) from userpoints where b_person = 1 and d_date::date = _d_date) as n_today_done_person,  -- Выполнено сегодня ФЛ
		(select count(*) from userpoints where b_person = 1) as n_all_done_person,  -- Выполнено ФЛ
		((select count(*) from points where b_person = 1) - (select count(*) from userpoints where b_person = 1)) as n_lost_person,  -- Осталось ФЛ
		(select count(*) from points where b_person = 1) as n_all_person, -- Общее кол-во ФЛ 
		(select count(*) from userpoints where b_person = 0 and d_date::date = _d_date) as n_today_done, -- Выполнено сегодня ЮЛ
		(select count(*) from userpoints where b_person = 0) as n_all_done, -- Выполнено ЮЛ
		((select count(*) from points where b_person = 0) - (select count(*) from userpoints where b_person = 0)) as n_lost, -- Осталось ЮЛ
		(select count(*) from points where b_person = 0) as n_all -- Общее кол-во ЮЛ 
	from core.pd_users as u
	where u.id = _fn_user;
END
$$;

ALTER FUNCTION dbo.cf_arm_pd_user_stat(_fn_user integer, _d_date date) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_arm_pd_user_stat(_fn_user integer, _d_date date) IS 'Получение статистик по обходчику';
