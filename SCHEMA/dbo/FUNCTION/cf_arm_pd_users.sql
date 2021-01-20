CREATE OR REPLACE FUNCTION dbo.cf_arm_pd_users(_f_main_division integer, _f_division integer, _f_subdivision integer, _f_manager integer, _f_user integer) RETURNS TABLE(id integer, c_login text, c_first_name text, c_last_name text, c_middle_name text, fn_file uuid)
    LANGUAGE plpgsql
    AS $$
/**
* @params {integer} _f_main_division - иден. филиал. Обязателен при передаче
* @params {integer} _f_division - иден. отделение. Обязателен при передаче
* @params {integer} _f_subdivision - иден. участок. Обязателен при передаче
* @params {integer} _f_manager - иден. диспетчер. Может быть null
* @params {integer} _f_user - иден. обходчика. Может быть null
*
* @example
* [{ "action": "cf_arm_pd_users", "method": "Select", "data": [{ "params": [_f_main_division, _f_division, _f_subdivision, _f_manager, _f_user] }], "type": "rpc", "tid": 0}]
*/
DECLARE
	_users json; -- обходчики
BEGIN
	IF _f_main_division is not null AND _f_division is not null AND _f_subdivision is not null THEN
		-- минимальная информация для фильтрации данных
		IF _f_manager is null AND _f_user is null THEN
			-- находим всех обходчиков которые есть в Отделении/Участоке
			select array_to_json(array_agg(row_to_json(t))) into _users
			from (select DISTINCT uid.f_user from core.pd_userindivisions as uid
				inner join core.pd_userinroles as uir ON uir.f_user = uid.f_user
				inner join core.pd_roles as r ON r.id = uir.f_role
				where r.c_name = 'inspector' and (uid.f_division = _f_division and uid.f_subdivision = _f_subdivision)) as t;
		ELSE
			IF _f_manager is not null and _f_user is null THEN 
				-- выбран только диспетчер, но обходчик не выбран
				select array_to_json(array_agg(row_to_json(t))) into _users
				from (select DISTINCT uid.f_user from core.pd_userindivisions as uid
					inner join core.pd_userinroles as uir ON uir.f_user = uid.f_user
					inner join core.pd_roles as r ON r.id = uir.f_role
					inner join core.pd_users as u ON u.id = uid.f_user
					where u.f_parent = _f_manager and r.c_name = 'inspector' and (uid.f_division = _f_division and uid.f_subdivision = _f_subdivision)) as t;
			ELSE
				IF _f_user is not null THEN 
					-- обходчик выбран
					select array_to_json(array_agg(row_to_json(t))) into _users
					from (select DISTINCT uid.f_user from core.pd_userindivisions as uid
						inner join core.pd_userinroles as uir ON uir.f_user = uid.f_user
						inner join core.pd_roles as r ON r.id = uir.f_role
						where uid.f_user = _f_user and r.c_name = 'inspector' and (uid.f_division = _f_division and uid.f_subdivision = _f_subdivision)) as t;
				END IF;
			END IF;
		END IF;
		
		IF (select count(*) from json_array_elements(_users)) > 0 THEN
			-- обходчики выбраны и находим все маршруты за текущую дату
			RETURN QUERY select u.id, u.c_login, u.c_first_name, u.c_last_name, u.c_middle_name, u.fn_file from json_array_elements(_users) as t
			inner join core.pd_users as u ON u.id = (t.value #>> '{f_user}')::integer;
		END IF;
	END IF;
END
$$;

ALTER FUNCTION dbo.cf_arm_pd_users(_f_main_division integer, _f_division integer, _f_subdivision integer, _f_manager integer, _f_user integer) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_arm_pd_users(_f_main_division integer, _f_division integer, _f_subdivision integer, _f_manager integer, _f_user integer) IS 'Получение обходчиков по заданному фильтру';
