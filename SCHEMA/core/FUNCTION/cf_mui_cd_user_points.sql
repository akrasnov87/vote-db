CREATE OR REPLACE FUNCTION core.cf_mui_cd_user_points(_fn_user integer, _c_version text) RETURNS TABLE(id uuid, fn_point uuid, fn_user integer, c_user text, fn_route uuid, fn_type integer, n_longitude numeric, n_latitude numeric, c_notice text, b_check boolean, jb_data text, d_date_check timestamp with time zone, dx_created timestamp with time zone, d_date timestamp with time zone, c_telephone text)
    LANGUAGE plpgsql STABLE
    AS $$
/**
* @params {integer} _fn_user - идентификатор пользователя
* @params {text} _c_version - текущая версия приложения
*
* @example
* [{ "action": "cf_mui_cd_user_points", "method": "Select", "data": [{ "params": [_fn_user, _c_version] }], "type": "rpc", "tid": 0 }]
*/
BEGIN
    RETURN QUERY select up.id, up.fn_point, up.fn_user, u.c_login as c_user, up.fn_route, up.fn_type, up.n_longitude, up.n_latitude, up.c_notice, up.b_check, up.jb_data::text, up.d_date_check, up.dx_created, up.d_date, up.c_telephone
    from core.cd_userinroutes as uir
    LEFT JOIN core.cd_routes as rt ON rt.id = uir.f_route
    INNER JOIN core.cd_user_points as up ON up.fn_route = rt.id
    INNER JOIN core.pd_users as u ON up.fn_user = u.id
	left join core.cs_route_statuses as rs ON rt.f_status = rs.id
	where uir.f_user = _fn_user and core.sf_is_mobile_route(rt.id);
END
$$;

ALTER FUNCTION core.cf_mui_cd_user_points(_fn_user integer, _c_version text) OWNER TO mobnius;

COMMENT ON FUNCTION core.cf_mui_cd_user_points(_fn_user integer, _c_version text) IS 'Получение списка "Пользовательских точек" мобильным приложением';
