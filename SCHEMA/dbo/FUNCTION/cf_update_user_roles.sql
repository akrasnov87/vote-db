CREATE OR REPLACE FUNCTION dbo.cf_update_user_roles(_user_id integer, _claims text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
	delete from core.pd_userinroles
	where f_user = _user_id;

	insert into core.pd_userinroles(f_user, f_role, sn_delete)
	SELECT _user_id, (select id from core.pd_roles where t.value = c_name), false 
	FROM json_array_elements_text(_claims::json) as t;
	
	RETURN _user_id;
END
$$;

ALTER FUNCTION dbo.cf_update_user_roles(_user_id integer, _claims text) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_update_user_roles(_user_id integer, _claims text) IS 'Обновление ролей у пользователя';
