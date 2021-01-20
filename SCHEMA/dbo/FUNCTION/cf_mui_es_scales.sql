CREATE OR REPLACE FUNCTION dbo.cf_mui_es_scales(_fn_user integer, _c_version text) RETURNS TABLE(id integer, c_name text, c_const text, n_order integer)
    LANGUAGE plpgsql STABLE
    AS $$
/**
* @params {integer} _fn_user - идентификатор пользователя
* @params {text} _c_version - текущая версия приложения
*
* @example
* [{ "action": "cf_mui_es_scales", "method": "Select", "data": [{ "params": [_fn_user, _c_version] }], "type": "rpc", "tid": 0 }]
*/
BEGIN	
	RETURN QUERY select s.id, s.c_name, s.c_const, s.n_order
	from dbo.es_scales as s
	where s.b_disabled = false;
END
$$;

ALTER FUNCTION dbo.cf_mui_es_scales(_fn_user integer, _c_version text) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_mui_es_scales(_fn_user integer, _c_version text) IS 'Шкалы прибора учета';
