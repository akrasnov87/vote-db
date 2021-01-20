CREATE OR REPLACE FUNCTION dbo.cf_arm_pd_user_managers(_f_current_user integer, _f_main_division integer, _f_division integer, _f_subdivision integer) RETURNS TABLE(id integer, c_login text, c_first_name text, c_last_name text, c_middle_name text)
    LANGUAGE plpgsql STABLE
    AS $$
/**
* @params {integer} _f_current_user - иден. текущего пользователя
* @params {integer} _f_main_division - иден. филиал
* @params {integer} _f_division - иден. отделение
* @params {integer} _f_subdivision - иден. участок
*
* @example
* [{ "action": "cf_arm_pd_user_managers", "method": "Select", "data": [{ "params": [_f_current_user, _f_main_division, _f_division, _f_subdivision] }], "type": "rpc", "tid": 0}]
*/
DECLARE
	_f_role integer;
BEGIN
	select r.id into _f_role from core.pd_roles as r
	where r.c_name = 'manager';

	IF _f_current_user is not null AND _f_main_division is not null THEN
		CASE WHEN _f_division is null AND _f_subdivision is null THEN
			-- пользователь и Филиал выбраны
			RETURN QUERY 
			select u.id, u.c_login, u.c_first_name, u.c_last_name, u.c_middle_name 
			from core.pd_userindivisions as uid 
			inner join core.pd_users as u ON uid.f_user = u.id
			inner join core.pd_userinroles as uir ON uir.f_user = u.id
			inner join dbo.cf_arm_sd_main_divisions(_f_current_user) as smd ON smd.id = uid.f_division
			where uir.f_role = _f_role and smd.id = _f_main_division;		
		WHEN _f_division is not null AND _f_subdivision is null THEN
			-- пользователь, Филиал и Отделение выбраны
			RETURN QUERY 
			select u.id, u.c_login, u.c_first_name, u.c_last_name, u.c_middle_name 
			from core.pd_userindivisions as uid 
			inner join core.pd_users as u ON uid.f_user = u.id
			inner join core.pd_userinroles as uir ON uir.f_user = u.id
			inner join dbo.cf_arm_sd_divisions(_f_current_user, _f_main_division) as smd ON smd.id = uid.f_division
			where uir.f_role = _f_role and smd.id = _f_division;
		WHEN _f_division is not null AND _f_subdivision is not null THEN
			-- пользователь, Филиал, Отделение и Участок выбраны
			RETURN QUERY 
			select u.id, u.c_login, u.c_first_name, u.c_last_name, u.c_middle_name
			from dbo.cf_arm_sd_subdivisions(_f_current_user, _f_division) as smd
			inner join core.pd_userindivisions as uid ON smd.f_division = uid.f_division OR smd.id = uid.f_subdivision
			inner join core.pd_users as u ON uid.f_user = u.id
			inner join core.pd_userinroles as uir ON uir.f_user = u.id
			where uir.f_role = _f_role and smd.id = _f_subdivision;
		END CASE;
	END IF;
END
$$;

ALTER FUNCTION dbo.cf_arm_pd_user_managers(_f_current_user integer, _f_main_division integer, _f_division integer, _f_subdivision integer) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_arm_pd_user_managers(_f_current_user integer, _f_main_division integer, _f_division integer, _f_subdivision integer) IS 'Получение диспетчеров по заданному фильтру';
