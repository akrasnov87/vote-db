CREATE OR REPLACE FUNCTION dbo.cf_not_zero(_num numeric) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
	RETURN CASE WHEN _num = 0 THEN 1 ELSE _num END;
END
$$;

ALTER FUNCTION dbo.cf_not_zero(_num numeric) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_not_zero(_num numeric) IS 'Не равно нуль';
