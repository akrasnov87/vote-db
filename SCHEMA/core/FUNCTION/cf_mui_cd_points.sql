CREATE OR REPLACE FUNCTION core.cf_mui_cd_points(_fn_user integer, _c_version text) RETURNS TABLE(id uuid, f_registr_pts uuid, f_route uuid, f_type integer, c_notice text, c_info text, jb_data text, dx_created timestamp with time zone, n_order integer, b_anomaly boolean, sn_delete boolean)
    LANGUAGE plpgsql STABLE
    AS $$
/**
* @params {integer} _fn_user - идентификатор пользователя
* @params {text} _c_version - текущая версия приложения
*
* @example
* [{ "action": "cf_mui_cd_points", "method": "Select", "data": [{ "params": [_fn_user, _c_version] }], "type": "rpc", "tid": 0 }]
*/
BEGIN
    RETURN QUERY select p.id, p.f_registr_pts, p.f_route, p.f_type, p.c_notice, p.c_info, p.jb_data::text, p.dx_created, p.n_order, p.b_anomaly, p.sn_delete
    from core.cd_userinroutes as uir
    LEFT JOIN core.cd_points as p ON p.f_route = uir.f_route
    INNER JOIN core.cd_routes as r ON r.id = p.f_route
	left join core.cs_route_statuses as rs ON r.f_status = rs.id
	where uir.f_user = _fn_user and core.sf_is_mobile_route(r.id);
END
$$;

ALTER FUNCTION core.cf_mui_cd_points(_fn_user integer, _c_version text) OWNER TO mobnius;

COMMENT ON FUNCTION core.cf_mui_cd_points(_fn_user integer, _c_version text) IS 'Получение списка "Точек маршрута" мобильным приложением';
