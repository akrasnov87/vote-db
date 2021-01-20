CREATE OR REPLACE FUNCTION dbo.rpt_arm_cd_route_stat(_f_route uuid) RETURNS TABLE(id integer, c_login text, c_first_name text, c_last_name text, c_middle_name text, b_main boolean, n_all_points bigint, n_done_points bigint, n_need_points bigint)
    LANGUAGE plpgsql STABLE
    AS $$
/**
* @param {uuid} _f_route - иден. маршрута
*
* @example
* [{ "action": "rpt_arm_cd_route_stat", "method": "Select", "data": [{ "params": [_f_route] }], "type": "rpc", "tid": 0 }]
*/
DECLARE
	_n_all_points bigint; -- общее количество точек
	_n_done_points bigint; -- количество пройденных точек
BEGIN
	select DISTINCT count(fn_point) into _n_done_points from core.cd_user_points as p where p.fn_route = _f_route;
	select count(*) into _n_all_points from core.cd_points as p where p.f_route = _f_route;

	RETURN QUERY select 
		u.id,
		u.c_login,
		u.c_first_name,
		u.c_last_name,
		u.c_middle_name,
		uir.b_main,
		_n_all_points as n_all_points,
		(select DISTINCT count(fn_point) from core.cd_user_points as p where p.fn_route = _f_route and p.fn_user = u.id) as n_done_points,
		_n_all_points - _n_done_points as n_need_points
	from core.cd_userinroutes as uir
	inner join core.pd_users as u ON u.id = uir.f_user
	where uir.f_route = _f_route
	order by uir.b_main DESC;
END
$$;

ALTER FUNCTION dbo.rpt_arm_cd_route_stat(_f_route uuid) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.rpt_arm_cd_route_stat(_f_route uuid) IS 'Получение статистики по маршруту';
