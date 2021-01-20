CREATE OR REPLACE FUNCTION dbo.cf_arm_assign_route(_f_current_user integer, _users json, _f_route uuid, _b_plan boolean) RETURNS integer
    LANGUAGE plpgsql
    AS $$
/**
* @params {integer} _f_current_user - текущий пользователь
* @params {json} _users - массив пользователей. В функцияю должно передаваться как строка, например: '[{ "id":4, "b_main": true }, { "id": 13, "b_main": false }]'
* @params {uuid} _f_route - иден. маршрута
* @params {boolean} _b_plan - true - применяется в пранировании
*
* @returns {integer}
* 0 - ОК
* 1 - маршрут не найден
* 2 - пользователь не найден
*
* @example
* [{ "action": "cf_arm_assign_route", "method": "Query", "data": [{ "params": [_f_current_user, _users, _f_route, _b_plan] }], "type": "rpc", "tid": 1 }]
*/
DECLARE
	_status_id integer; -- иден. статус передан (назначен)
	_transfered_status_id integer; -- иден. статуса передан
	_re_assign boolean; -- переназначенение
BEGIN
	select false into _re_assign;

	IF (select count(*) from core.cd_routes as r where r.id = _f_route) = 1 THEN
		IF (select count(*) from core.pd_users as u where u.id = _f_current_user) = 1 THEN

			select rs.id into _status_id 
			from core.cs_route_statuses as rs
			where rs.c_const = CASE WHEN _b_plan = true THEN 'CREATED' ELSE 'ASSINGNED' END;

			-- находим информацию о статусе
			IF (select count(*) from core.cd_routes as r
				where r.id = _f_route and r.f_status = _status_id) = 1 THEN

				select true into _re_assign;

				-- удаляем информацию из истории
				delete from core.cd_route_history as rh
				where rh.fn_route = _f_route and rh.fn_status = _status_id;		

				-- удаляем привязку к пользователю
				delete from core.cd_userinroutes as uir
				where uir.f_route = _f_route;
			END IF;

			-- статус не меняется если вес положительный
			IF(select rs.n_order from core.cd_routes as r
				inner join core.cs_route_statuses as rs ON r.f_status = rs.id
				where r.id = _f_route) < 0 THEN

				-- создаем новый статус
				insert into core.cd_route_history (fn_route, fn_status, fn_user, d_date, c_notice)
				values (_f_route, _status_id, _f_current_user, now(), (CASE WHEN _re_assign THEN 'Переназначен' ELSE 'Назначен' END));

			ELSE

				select rs.id into _transfered_status_id 
				from core.cs_route_statuses as rs
				where rs.c_const = 'TRANSFERRED';

				-- создаем новый статус "Передан"
				insert into core.cd_route_history (fn_route, fn_status, fn_user, d_date, c_notice)
				values (_f_route, _transfered_status_id, _f_current_user, now(), 'Назначен(ы) новый(е) пользователь(и)');

			END IF;

			IF _users is not null and (select count(*) from json_array_elements(_users::json)) > 0 THEN
				-- создаем привязку
				insert into core.cd_userinroutes(f_route, f_user, b_main)
				select 
					_f_route, 
					(t.value #>> '{id}')::integer, 
					(t.value #>> '{b_main}')::boolean 
				from json_array_elements(_users::json) as t
				where (t.value #>> '{id}')::integer NOT IN (select uir.f_user from core.cd_userinroutes as uir where uir.f_route = _f_route);
			END IF;

			RETURN 0;
		ELSE
			RETURN 2; -- нет пользователя
		END IF;
	ELSE
		RETURN 1; -- нет маршрута
	END IF;
END
$$;

ALTER FUNCTION dbo.cf_arm_assign_route(_f_current_user integer, _users json, _f_route uuid, _b_plan boolean) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_arm_assign_route(_f_current_user integer, _users json, _f_route uuid, _b_plan boolean) IS 'Функция предназначена для назначения или переназначения исполнителей в маршруте';
