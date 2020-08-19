CREATE OR REPLACE FUNCTION dbo.cf_old_date(d_date date) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
BEGIN
	return d_date >= now();
END
$$;

ALTER FUNCTION dbo.cf_old_date(d_date date) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_old_date(d_date date) IS 'Проверка даты';
