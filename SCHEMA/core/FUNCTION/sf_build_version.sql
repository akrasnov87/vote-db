CREATE OR REPLACE FUNCTION core.sf_build_version(status integer) RETURNS text
    LANGUAGE plv8 IMMUTABLE STRICT
    AS $$
var birthday = '2020-11-09';
	var newVersion = '1.' + Math.floor(Math.abs(new Date().getTime() - new Date(birthday).getTime()) / (1000 * 3600 * 24)) + '.' + status + '.'
											  + ((new Date().getHours() * 60) + new Date().getMinutes());
	return newVersion;
$$;

ALTER FUNCTION core.sf_build_version(status integer) OWNER TO mobnius;

COMMENT ON FUNCTION core.sf_build_version(status integer) IS 'Генерация версии БД';
