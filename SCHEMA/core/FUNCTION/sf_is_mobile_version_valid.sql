CREATE OR REPLACE FUNCTION core.sf_is_mobile_version_valid(_c_version text) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
/**
* @params {text} _c_version - версия приложения
*
* @returns {boolean} true - маршрут доступен для мобильного устройства
*
* @example
* [{ "action": "sf_is_mobile_version_valid", "method": "Query", "data": [{ "params": [_c_version] }], "type": "rpc", "tid": 0 }]
*/
DECLARE
	_n_current_version integer;
	_n_version integer;
BEGIN
	select core.sf_version_to_number(_c_version) into _n_current_version;
	select core.sf_version_to_number(c_value) into _n_version from core.cd_settings as s where s.c_key = 'DB_MIN_VERSION_MOBILE';
	
	IF _n_current_version >= _n_version THEN
		RETURN true;
	ELSE
		RETURN false;	
	END IF;
END
$$;

ALTER FUNCTION core.sf_is_mobile_version_valid(_c_version text) OWNER TO mobnius;

COMMENT ON FUNCTION core.sf_is_mobile_version_valid(_c_version text) IS 'Минимальная версия мобильного приложения для получения данных';
