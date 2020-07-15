CREATE OR REPLACE FUNCTION dbo.cf_create_manual_user(_login text, _password text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	_userId integer;
BEGIN
	insert into core.pd_users(c_login, c_password)
	values (_login, _password) RETURNING id INTO _userId;
	
	insert into core.pd_userinroles(f_user, f_role, sn_delete)
	values (_userId, (select id from core.pd_roles where c_name = 'manual_edit'), false);
	
	RETURN _userId;
END
$$;

ALTER FUNCTION dbo.cf_create_manual_user(_login text, _password text) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_create_manual_user(_login text, _password text) IS 'Создание пользователя для работы с cd_manual_edit_info';
