CREATE OR REPLACE FUNCTION core.cf_update_user_divisions(_user_id integer, _divisions json) RETURNS integer
    LANGUAGE plpgsql
    AS $$
/**
* @params {integer} _user_id - идент. пользователя
* @params {json} _divisions - список отделений. Формат строки '[1,2]'
*
* @returns {integer}
* 0 - ОК
*
* @example
* [{ "action": "cf_update_user_divisions", "method": "Query", "data": [{ "params": [_user_id, _divisions] }], "type": "rpc", "tid": 0 }]
*/
BEGIN
	delete from core.pd_userindivisions
	where f_user = _user_id;

	-- проверяем divisions
	IF (select count(*) from json_array_elements_text(_divisions)) > 0 THEN
		insert into core.pd_userindivisions(f_user, f_division, f_subdivision)
		SELECT _user_id, t.value::integer, null 
		FROM json_array_elements_text(_divisions) as t;
	END IF;
	
	RETURN 0;
END
$$;

ALTER FUNCTION core.cf_update_user_divisions(_user_id integer, _divisions json) OWNER TO mobnius;

COMMENT ON FUNCTION core.cf_update_user_divisions(_user_id integer, _divisions json) IS 'Обновление Отделения у пользователя';

--------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION core.cf_update_user_divisions(_user_id integer, _divisions json, _sub_divisions json) RETURNS integer
    LANGUAGE plpgsql
    AS $$
/**
* @params {integer} _user_id - идент. пользователя
* @params {json} _divisions - список отделений. Формат строки '[1,2]'
* @params {json} _sub_divisions - список участков. Формат строки '[1,2]'
*
* @returns {integer}
* 0 - ОК
*
* @example
* [{ "action": "cf_update_user_divisions", "method": "Query", "data": [{ "params": [_user_id, _divisions, _sub_divisions] }], "type": "rpc", "tid": 0 }]
*/
BEGIN
	delete from core.pd_userindivisions
	where f_user = _user_id;

	-- проверяем divisions
	IF (select count(*) from json_array_elements_text(_divisions)) > 0 THEN
		insert into core.pd_userindivisions(f_user, f_division, f_subdivision)
		SELECT _user_id, t.value::integer, null 
		FROM json_array_elements_text(_divisions) as t;
	END IF;
	
	-- проверяем sub_divisions
	IF (select count(*) from json_array_elements_text(_sub_divisions)) > 0 THEN
		insert into core.pd_userindivisions(f_user, f_division, f_subdivision)
		SELECT _user_id, (select f_division from core.sd_subdivisions where id = t.value::integer), t.value::integer 
		FROM json_array_elements_text(_sub_divisions) as t;
	END IF;
	
	RETURN 0;
END
$$;

ALTER FUNCTION core.cf_update_user_divisions(_user_id integer, _divisions json, _sub_divisions json) OWNER TO mobnius;

COMMENT ON FUNCTION core.cf_update_user_divisions(_user_id integer, _divisions json, _sub_divisions json) IS 'Обновление Филиала/Отделения/Участка у пользователя';
