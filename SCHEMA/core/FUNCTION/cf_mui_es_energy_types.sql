CREATE OR REPLACE FUNCTION core.cf_mui_es_energy_types(_fn_user integer, _c_version text) RETURNS TABLE(id integer, c_name text, c_const text, n_code integer, b_default boolean)
    LANGUAGE plpgsql STABLE
    AS $$
/**
* @params {integer} _fn_user - идентификатор пользователя
* @params {text} _c_version - текущая версия приложения
*
* @example
* [{ "action": "cf_mui_es_energy_types", "method": "Select", "data": [{ "params": [_fn_user, _c_version] }], "type": "rpc", "tid": 0 }]
*/
BEGIN	
	RETURN QUERY select et.id, et.c_name, et.c_const, et.n_code, et.b_default
	from dbo.es_energy_types as et;
END
$$;

ALTER FUNCTION core.cf_mui_es_energy_types(_fn_user integer, _c_version text) OWNER TO mobnius;

COMMENT ON FUNCTION core.cf_mui_es_energy_types(_fn_user integer, _c_version text) IS 'Тип энергии';
