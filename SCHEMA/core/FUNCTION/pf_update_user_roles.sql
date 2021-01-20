CREATE OR REPLACE FUNCTION core.pf_update_user_roles(_user_id integer, _claims json) RETURNS integer
    LANGUAGE plpgsql
    AS $$
/**
* @params {integer} _user_id - идент. пользователя
* @params {json} _claims - роли в виде строки '["manager", "inspector"]'
*
* @returns {integer} идент. пользователя
*/
BEGIN
	delete from core.pd_userinroles
	where f_user = _user_id;

	insert into core.pd_userinroles(f_user, f_role, sn_delete)
	SELECT _user_id, (select id from core.pd_roles where t.value = c_name), false 
	FROM json_array_elements_text(_claims) as t;
	
	RETURN _user_id;
END
$$;

ALTER FUNCTION core.pf_update_user_roles(_user_id integer, _claims json) OWNER TO mobnius;

COMMENT ON FUNCTION core.pf_update_user_roles(_user_id integer, _claims json) IS 'Обновление ролей у пользователя';
