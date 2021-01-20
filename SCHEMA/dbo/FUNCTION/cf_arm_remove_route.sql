CREATE OR REPLACE FUNCTION dbo.cf_arm_remove_route(_route_id uuid) RETURNS integer
    LANGUAGE plpgsql
    AS $$
/**
* @params {uuid} _route_id - идентификатор маршрута
*
* @returns {integer}
* 0 - ОК
* 1 - статус документ отличается от "сформирован" и "формируется"
*
* @example
* [{ "action": "cf_arm_remove_route", "method": "Query", "data": [{ "params": [_route_id] }], "type": "rpc", "tid": 0}]
*/
DECLARE
	_c_status text;
BEGIN
	select rs.c_const into _c_status from core.cd_routes as r
	inner join core.cs_route_statuses as rs ON rs.id = r.f_status
	where r.id = _route_id;
	
	-- лучше статус не менять иначе при синхронизации может быть потеря данных
	IF _c_status = 'CREATE' OR _c_status = 'CREATED' THEN
		RETURN core.sf_del_route(_route_id);
	ELSE
		RETURN 1; -- статус документ отличается от "сформирован" и "формируется"
	END IF;
END
$$;

ALTER FUNCTION dbo.cf_arm_remove_route(_route_id uuid) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_arm_remove_route(_route_id uuid) IS 'Удаление маршрута со статусом "Сформирован"';
