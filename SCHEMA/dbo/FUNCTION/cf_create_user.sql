CREATE OR REPLACE FUNCTION dbo.cf_create_user(_login text, _password text, _claims text, _f_subdivision integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	_userId integer;
BEGIN
	insert into core.pd_users(c_login, c_password, f_subdivision)
	values (_login, _password, _f_subdivision) RETURNING id INTO _userId;
	
	insert into core.pd_userinroles(f_user, f_role, sn_delete)
	SELECT _userId, (select id from core.pd_roles where t.value = c_name), false 
	FROM json_array_elements_text(_claims::json) as t;
	
	RETURN _userId;
END
$$;

ALTER FUNCTION dbo.cf_create_user(_login text, _password text, _claims text, _f_subdivision integer) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_create_user(_login text, _password text, _claims text, _f_subdivision integer) IS 'Создание пользователя с определенными ролями';
