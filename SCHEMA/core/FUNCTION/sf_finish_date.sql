CREATE OR REPLACE FUNCTION core.sf_finish_date(_d_date timestamp with time zone) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
/**
* @params {date} _d_date - дата
* @returns {boolean} false - маршрут завершен
*/
BEGIN
	RETURN (_d_date + interval '1 day') >= now();
END
$$;

ALTER FUNCTION core.sf_finish_date(_d_date timestamp with time zone) OWNER TO mobnius;

COMMENT ON FUNCTION core.sf_finish_date(_d_date timestamp with time zone) IS 'Проверка даты завершения маршрута, true - маршрут активный';

--------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION core.sf_finish_date(_d_date date) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
/**
* @params {date} _d_date - дата
* @returns {boolean} false - маршрут завершен
*/
BEGIN
	RETURN (_d_date + interval '1 day') >= now();
END
$$;

ALTER FUNCTION core.sf_finish_date(_d_date date) OWNER TO mobnius;

COMMENT ON FUNCTION core.sf_finish_date(_d_date date) IS 'Проверка даты завершения маршрута, true - маршрут активный';
