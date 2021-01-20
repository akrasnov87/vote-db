CREATE OR REPLACE FUNCTION dbo.cf_mui_es_seal_places(_fn_user integer, _c_version text) RETURNS TABLE(id integer, c_name text, c_const text, n_order integer)
    LANGUAGE plpgsql STABLE
    AS $$
/**
* @params {integer} _fn_user - идентификатор пользователя
* @params {text} _c_version - текущая версия приложения
*
* @example
* [{ "action": "cf_mui_es_seal_places", "method": "Select", "data": [{ "params": [_fn_user, _c_version] }], "type": "rpc", "tid": 0 }]
*/
BEGIN	
	RETURN QUERY select sp.id, sp.c_name, sp.c_const, sp.n_order
	from dbo.es_seal_places as sp
	where sp.b_disabled = false;
END
$$;

ALTER FUNCTION dbo.cf_mui_es_seal_places(_fn_user integer, _c_version text) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_mui_es_seal_places(_fn_user integer, _c_version text) IS 'Справочник мест установки пломб';
