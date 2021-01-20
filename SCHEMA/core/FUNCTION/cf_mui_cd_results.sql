CREATE OR REPLACE FUNCTION core.cf_mui_cd_results(_fn_user integer, _c_version text) RETURNS TABLE(id uuid, fn_route uuid, fn_point uuid, fn_user_point uuid, fn_type integer, fn_user integer, d_date timestamp with time zone, c_notice text, b_warning boolean, jb_data text, dx_created timestamp with time zone)
    LANGUAGE plpgsql STABLE
    AS $$
/**
* @params {integer} _fn_user - идентификатор пользователя
* @params {text} _c_version - текущая версия приложения
*
* @example
* [{ "action": "cf_mui_cd_results", "method": "Select", "data": [{ "params": [_fn_user, _c_version] }], "type": "rpc", "tid": 0 }]
*/
BEGIN
	RETURN QUERY select r.id, r.fn_route, r.fn_point, r.fn_user_point, r.fn_type, r.fn_user, r.d_date, r.c_notice, r.b_warning, r.jb_data::text, r.dx_created
    from core.cd_userinroutes as uir
    LEFT JOIN core.cd_routes as rt ON rt.id = uir.f_route
    INNER JOIN core.cd_results as r ON r.fn_route = rt.id
	left join core.cs_route_statuses as rs ON rt.f_status = rs.id
	where uir.f_user = _fn_user and core.sf_is_mobile_route(rt.id);
END
$$;

ALTER FUNCTION core.cf_mui_cd_results(_fn_user integer, _c_version text) OWNER TO mobnius;

COMMENT ON FUNCTION core.cf_mui_cd_results(_fn_user integer, _c_version text) IS 'Получение списка "Результаты обхода" мобильным приложением';
