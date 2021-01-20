CREATE OR REPLACE FUNCTION dbo.cf_mui_es_device_location(_fn_user integer, _c_version text) RETURNS TABLE(id integer, c_name text, c_const text)
    LANGUAGE plpgsql STABLE
    AS $$
/**
* @params {integer} _fn_user - идентификатор пользователя
* @params {text} _c_version - текущая версия приложения
*
* @example
* [{ "action": "cf_mui_es_device_location", "method": "Select", "data": [{ "params": [_fn_user, _c_version] }], "type": "rpc", "tid": 0 }]
*/
BEGIN	
	RETURN QUERY select dl.id, dl.c_name, dl.c_const
	from dbo.es_device_location as dl;
END
$$;

ALTER FUNCTION dbo.cf_mui_es_device_location(_fn_user integer, _c_version text) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_mui_es_device_location(_fn_user integer, _c_version text) IS 'Место установки';
