CREATE OR REPLACE FUNCTION dbo.cf_imp_user(_id integer, _c_login text, _c_password text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
	insert into core.pd_users(id, c_login, c_password, b_disabled, sn_delete)
	values (_id, _c_login, _c_password, false, false);
	
	insert into core.pd_userinroles(f_user, f_role, sn_delete)
	values (_id, 5, false);
	RETURN _id;
END
$$;

ALTER FUNCTION dbo.cf_imp_user(_id integer, _c_login text, _c_password text) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_imp_user(_id integer, _c_login text, _c_password text) IS 'Импорт пользователей';
