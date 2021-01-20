CREATE OR REPLACE FUNCTION core.cf_mui_cs_point_types(_fn_user integer, _c_version text) RETURNS TABLE(id integer, c_name text, c_const text, n_order integer)
    LANGUAGE plpgsql STABLE
    AS $$
/**
* @params {integer} _fn_user - идентификатор пользователя
* @params {text} _c_version - текущая версия приложения
*
* @example
* [{ "action": "cf_mui_cs_point_types", "method": "Select", "data": [{ "params": [_fn_user, _c_version] }], "type": "rpc", "tid": 0 }]
*/
BEGIN	
	RETURN QUERY select pt.id, pt.c_name, pt.c_const, pt.n_order
	from core.cs_point_types as pt
	where pt.b_disabled = false;
END
$$;

ALTER FUNCTION core.cf_mui_cs_point_types(_fn_user integer, _c_version text) OWNER TO mobnius;

COMMENT ON FUNCTION core.cf_mui_cs_point_types(_fn_user integer, _c_version text) IS 'Тип точки';
