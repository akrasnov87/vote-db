CREATE OR REPLACE FUNCTION core.sf_version_to_number(c_version text) RETURNS bigint
    LANGUAGE plv8 IMMUTABLE STRICT
    AS $$
/**
* @params {text} c_version - версия приложения
* @returns {bigint} числовой вариант версии
*/
try {
		var data = c_version.split('.');
		return (parseInt(data[1]) * 24 * 60) + parseInt(data[3]);
	} catch(e) { 
		return 0;
	}
$$;

ALTER FUNCTION core.sf_version_to_number(c_version text) OWNER TO mobnius;

COMMENT ON FUNCTION core.sf_version_to_number(c_version text) IS 'Преобразование версии в число';
