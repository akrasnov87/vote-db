CREATE OR REPLACE FUNCTION core.cf_mui_cd_route_history(_fn_user integer, _c_version text) RETURNS TABLE(id uuid, fn_route uuid, fn_status integer, fn_user integer, d_date timestamp with time zone, c_notice text, dx_created timestamp with time zone)
    LANGUAGE plpgsql STABLE
    AS $$
/**
* @params {integer} _fn_user - идентификатор пользователя
* @params {text} _c_version - текущая версия приложения
*
* @example
* [{ "action": "cf_mui_cd_route_history", "method": "Select", "data": [{ "params": [_fn_user, _c_version] }], "type": "rpc", "tid": 0 }]
*/
BEGIN
    RETURN QUERY select rh.id, rh.fn_route, rh.fn_status, rh.fn_user, rh.d_date, rh.c_notice, rh.dx_created
    from core.cd_userinroutes as uir
	LEFT JOIN core.cd_route_history as rh ON rh.fn_route = uir.f_route
	where uir.f_user = _fn_user and core.sf_is_mobile_route(uir.f_route);
END
$$;

ALTER FUNCTION core.cf_mui_cd_route_history(_fn_user integer, _c_version text) OWNER TO mobnius;

COMMENT ON FUNCTION core.cf_mui_cd_route_history(_fn_user integer, _c_version text) IS 'Получение списка "Истории маршрутов" мобильным приложением';
