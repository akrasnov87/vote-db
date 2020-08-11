CREATE OR REPLACE FUNCTION dbo.sf_distance(n_longitude1 numeric, n_latitude1 numeric, n_longitude2 numeric, n_latitude2 numeric) RETURNS numeric
    LANGUAGE plv8 IMMUTABLE STRICT
    AS $$
return Math.sqrt(Math.pow(Math.abs(n_longitude1 - n_longitude2), 2) + Math.pow(Math.abs(n_latitude1 - n_latitude2), 2));
$$;

ALTER FUNCTION dbo.sf_distance(n_longitude1 numeric, n_latitude1 numeric, n_longitude2 numeric, n_latitude2 numeric) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.sf_distance(n_longitude1 numeric, n_latitude1 numeric, n_longitude2 numeric, n_latitude2 numeric) IS 'Дистанция между двумя точками';
