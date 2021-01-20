CREATE OR REPLACE FUNCTION dbo.cf_mui_es_restrictions(_fn_user integer, _c_version text) RETURNS TABLE(id integer, c_name text, c_const text, n_order integer)
    LANGUAGE plpgsql STABLE
    AS $$
/**
* @params {integer} _fn_user - идентификатор пользователя
* @params {text} _c_version - текущая версия приложения
*
* @example
* [{ "action": "cf_mui_es_restrictions", "method": "Select", "data": [{ "params": [_fn_user, _c_version] }], "type": "rpc", "tid": 0 }]
*/
BEGIN	
	RETURN QUERY select r.id, r.c_name, r.c_const, r.n_order
	from dbo.es_restrictions as r
	where r.b_disabled = false;
END
$$;

ALTER FUNCTION dbo.cf_mui_es_restrictions(_fn_user integer, _c_version text) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_mui_es_restrictions(_fn_user integer, _c_version text) IS 'Типы ограничений';
