CREATE OR REPLACE FUNCTION dbo.sf_convert_number(num text) RETURNS integer
    LANGUAGE plv8 IMMUTABLE STRICT
    AS $$
		return parseInt(num.replace('-', ''));
	$$;

ALTER FUNCTION dbo.sf_convert_number(num text) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.sf_convert_number(num text) IS 'Преобразование номера агитатора в число';
