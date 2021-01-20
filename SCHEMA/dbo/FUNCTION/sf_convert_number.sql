CREATE OR REPLACE FUNCTION dbo.sf_convert_number(_c_num text) RETURNS integer
    LANGUAGE plv8 IMMUTABLE STRICT
    AS $$
	/**
	* Преобразование номера агитатора в число
	*
	* @params {text} _c_num - например 1801-01
	* @returns {integer} 180101
	*
	* @example
	* [{ "action": "sf_convert_number", "method": "Select", "data": [{ "params": [_c_num] }], "type": "rpc", "tid": 0 }]
	*/
	return parseInt(_c_num.replace('-', ''));
$$;

ALTER FUNCTION dbo.sf_convert_number(_c_num text) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.sf_convert_number(_c_num text) IS 'Преобразование номера агитатора в число';
