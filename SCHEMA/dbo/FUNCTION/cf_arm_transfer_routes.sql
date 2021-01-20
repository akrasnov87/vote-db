CREATE OR REPLACE FUNCTION dbo.cf_arm_transfer_routes(_f_current_user integer, _routes json) RETURNS TABLE(id uuid, n_status integer)
    LANGUAGE plpgsql STABLE
    AS $$
/**
* @params {integer} _f_current_user - текущий пользователь
* @params {json} _routes - массив маршрутов, требуется передать в виде строки '["e7ded0cd-12dd-47f5-a75b-192376291e83"]'
*
* @returns
* возвращается таблица с двумя колонками route_id:uuid и status_id: integer, где статус может содержать значение 0 - ОК, 1 - пользователь не найден.
* дополнительные статусы можно узнать в функции dbo.cf_arm_transfer_route 
*
* @example
* [{ "action": "cf_arm_transfer_routes", "method": "Query", "data": [{ "params": [_f_current_user, routes] }], "type": "rpc", "tid": 0}]
*/
BEGIN
	IF (select count(*) from core.pd_users as u where u.id = _f_current_user) = 1 THEN
		RETURN QUERY 
		select t.value::uuid, dbo.cf_arm_transfer_route(_f_current_user, t.value::uuid)
		from json_array_elements_text(_routes) as t;
	ELSE
		RETURN QUERY select null, 1;
	END IF;
END
$$;

ALTER FUNCTION dbo.cf_arm_transfer_routes(_f_current_user integer, _routes json) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_arm_transfer_routes(_f_current_user integer, _routes json) IS 'Передача нескольких маршрутов на исполнение';
