CREATE OR REPLACE FUNCTION core.cf_mui_cs_route_types(_fn_user integer, _c_version text) RETURNS TABLE(id integer, c_name text, c_const text, n_order integer)
    LANGUAGE plpgsql STABLE
    AS $$
/**
* @params {integer} _fn_user - идентификатор пользователя
* @params {text} _c_version - текущая версия приложения
*
* @example
* [{ "action": "cf_mui_cs_route_types", "method": "Select", "data": [{ "params": [_fn_user, _c_version] }], "type": "rpc", "tid": 0 }]
*/
BEGIN	
	RETURN QUERY select rt.id, rt.c_name, rt.c_const, rt.n_order
	from core.cs_route_types as rt
	where rt.b_disabled = false;
END
$$;

ALTER FUNCTION core.cf_mui_cs_route_types(_fn_user integer, _c_version text) OWNER TO mobnius;

COMMENT ON FUNCTION core.cf_mui_cs_route_types(_fn_user integer, _c_version text) IS 'Тип маршрута';
