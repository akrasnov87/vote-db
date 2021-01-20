CREATE OR REPLACE FUNCTION core.sf_is_mobile_route(_f_route uuid) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
/**
* @params {uuid} _f_route - иден. маршрута
*
* @returns {boolean} true - маршрут доступен для мобильного устройства
*
* @example
* [{ "action": "sf_is_mobile_route", "method": "Query", "data": [{ "params": [_f_route] }], "type": "rpc", "tid": 0 }]
*/
BEGIN
	IF (select count(*) from core.cd_routes as r
		inner join core.cs_route_statuses as rs ON r.f_status = rs.id
		where r.id = _f_route and rs.n_order > 0 and core.sf_finish_date(CASE WHEN r.b_extended = true THEN r.d_extended ELSE r.d_date_end END)) = 1 THEN
		RETURN true;
	ELSE
		RETURN false;	
	END IF;
END
$$;

ALTER FUNCTION core.sf_is_mobile_route(_f_route uuid) OWNER TO mobnius;

COMMENT ON FUNCTION core.sf_is_mobile_route(_f_route uuid) IS 'Является ли маршрут доступным для мобильного устройства';
