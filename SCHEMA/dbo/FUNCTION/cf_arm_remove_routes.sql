CREATE OR REPLACE FUNCTION dbo.cf_arm_remove_routes(_routes json) RETURNS TABLE(id uuid, n_status integer)
    LANGUAGE plpgsql STABLE
    AS $$
/**
* @params {json} _routes - массив маршрутов, требуется передать в виде строки '["e7ded0cd-12dd-47f5-a75b-192376291e83"]'
*
* @returns возвращается таблица с двумя колонками id:uuid и n_status: integer, дополнительно о статусах можно узнать в функции dbo.cf_arm_remove_route
*
* @example
* [{ "action": "cf_arm_remove_routes", "method": "Query", "data": [{ "params": [_f_current_user, routes] }], "type": "rpc", "tid": 0}]
*/
BEGIN
	RETURN QUERY select 
		t.value::uuid as id, 
		dbo.cf_arm_remove_route(t.value::uuid) as n_status 
	from json_array_elements_text(_routes) as t;
END
$$;

ALTER FUNCTION dbo.cf_arm_remove_routes(_routes json) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_arm_remove_routes(_routes json) IS 'Массовое удаление маршрутов со статусом "Сформирован" или "Формируется"';
