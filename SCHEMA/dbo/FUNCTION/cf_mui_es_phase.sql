CREATE OR REPLACE FUNCTION dbo.cf_mui_es_phase(_fn_user integer, _c_version text) RETURNS TABLE(id integer, c_name text)
    LANGUAGE plpgsql STABLE
    AS $$
/**
* @params {integer} _fn_user - идентификатор пользователя
* @params {text} _c_version - текущая версия приложения
*
* @example
* [{ "action": "cf_mui_es_phase", "method": "Select", "data": [{ "params": [_fn_user, _c_version] }], "type": "rpc", "tid": 0 }]
*/
BEGIN	
	RETURN QUERY select p.id, p.c_name
	from dbo.es_phase as p;
END
$$;

ALTER FUNCTION dbo.cf_mui_es_phase(_fn_user integer, _c_version text) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_mui_es_phase(_fn_user integer, _c_version text) IS 'Фазы';
