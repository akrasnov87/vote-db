CREATE OR REPLACE FUNCTION core.cf_mui_cd_userinroutes(_fn_user integer, _c_version text) RETURNS TABLE(id uuid, f_route uuid, f_user integer, b_main boolean, dx_created timestamp with time zone)
    LANGUAGE plpgsql STABLE
    AS $$
/**
* @params {integer} _fn_user - идентификатор пользователя
* @params {text} _c_version - текущая версия приложения
*
* @example
* [{ "action": "cf_mui_cd_userinroutes", "method": "Select", "data": [{ "params": [_fn_user, _c_version] }], "type": "rpc", "tid": 0 }]
*/
BEGIN
    RETURN QUERY select * from core.cd_userinroutes as cuir
    where cuir.f_route in (select DISTINCT r.id from core.cd_userinroutes as uir
    INNER JOIN core.cd_routes as r ON r.id = uir.f_route
	left join core.cs_route_statuses as rs ON r.f_status = rs.id
	where uir.f_user = _fn_user and core.sf_is_mobile_route(r.id));
END
$$;

ALTER FUNCTION core.cf_mui_cd_userinroutes(_fn_user integer, _c_version text) OWNER TO mobnius;

COMMENT ON FUNCTION core.cf_mui_cd_userinroutes(_fn_user integer, _c_version text) IS 'Получение списка "пользователей в маршрутах" мобильным приложением';
