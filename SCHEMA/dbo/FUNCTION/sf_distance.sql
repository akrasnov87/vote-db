CREATE OR REPLACE FUNCTION dbo.sf_distance(_n_longitude1 numeric, _n_latitude1 numeric, _n_longitude2 numeric, _n_latitude2 numeric) RETURNS numeric
    LANGUAGE plv8 IMMUTABLE STRICT
    AS $$
	/**
	* Дистанция между двумя точками
	*
	* @params {numeric} _n_longitude1
	* @params {numeric} _n_latitude1
	* @params {numeric} _n_longitude2
	* @params {numeric} _n_latitude2
	* @returns {numeric}
	*
	* @example
	* [{ "action": "sf_distance", "method": "Select", "data": [{ "params": [_n_longitude1, _n_latitude1, _n_longitude2, _n_latitude2] }], "type": "rpc", "tid": 0 }]
	*/
	return Math.sqrt(Math.pow(Math.abs(_n_longitude1 - _n_longitude2), 2) + Math.pow(Math.abs(_n_latitude1 - _n_latitude2), 2));
$$;

ALTER FUNCTION dbo.sf_distance(_n_longitude1 numeric, _n_latitude1 numeric, _n_longitude2 numeric, _n_latitude2 numeric) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.sf_distance(_n_longitude1 numeric, _n_latitude1 numeric, _n_longitude2 numeric, _n_latitude2 numeric) IS 'Дистанция между двумя точками';
