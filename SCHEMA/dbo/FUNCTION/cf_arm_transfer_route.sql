CREATE OR REPLACE FUNCTION dbo.cf_arm_transfer_route(_f_current_user integer, _route_id uuid) RETURNS integer
    LANGUAGE plpgsql
    AS $$
/**
* @params {integer} _f_current_user - текущий пользователь
* @params {uuid} _route_id - идентификатор маршрута
*
* @returns {integer}
* 0 - ОК
* 1 - маршрут не найден
* 2 - пользователь не найден
* 3 - статус документ отличается от "назначен"
*
* @example
* [{ "action": "cf_arm_transfer_route", "method": "Query", "data": [{ "params": [_f_current_user, _route_id] }], "type": "rpc", "tid": 0}]
*/
DECLARE
	_c_status text; -- текущий статус маршрута
	_f_next_status_id integer; -- статус - передан
BEGIN

	IF(select count(*) from core.cd_routes as r where r.id = _route_id) = 1 THEN
	
		IF(select count(*) from core.pd_users as u where u.id = _f_current_user) = 1 THEN
		
			-- текущий статус
			select rs.c_const into _c_status from core.cd_routes as r
			left join core.cs_route_statuses as rs ON rs.id = r.f_status
			where r.id = _route_id;
			
			-- Передаем только после назначен
			IF _c_status = 'ASSINGNED' THEN
			
				-- новый статус
				select rs.id into _f_next_status_id 
				from core.cs_route_statuses as rs
				where rs.c_const = 'TRANSFERRED';
			
				-- создаем новый статус "передан"
				insert into core.cd_route_history (fn_route, fn_status, fn_user, d_date)
				values (_route_id, _f_next_status_id, _f_current_user, now());
				
				RETURN 0;
				
			ELSE
				RETURN 3; -- статус документ отличается от "назначен"
			END IF;
			
		ELSE
			RETURN 2; -- нет пользователя
		END IF;	
		
	ELSE
		RETURN 1; -- нет маршрута
	END IF;
END
$$;

ALTER FUNCTION dbo.cf_arm_transfer_route(_f_current_user integer, _route_id uuid) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_arm_transfer_route(_f_current_user integer, _route_id uuid) IS 'Передача маршрута на исполнение';
