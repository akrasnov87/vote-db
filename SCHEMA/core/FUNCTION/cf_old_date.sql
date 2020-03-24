-- Проверка даты на валидность текущего дня
CREATE OR REPLACE FUNCTION core.cf_old_date(d_date date) RETURNS boolean
    LANGUAGE plv8 IMMUTABLE STRICT
    AS $$
		return d_date.getTime() >= new Date().getTime();
	$$;

ALTER FUNCTION core.cf_old_date(d_date date) OWNER TO mobnius;

COMMENT ON FUNCTION core.cf_old_date(d_date date) IS 'Проверка даты';