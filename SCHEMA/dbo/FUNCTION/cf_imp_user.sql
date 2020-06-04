CREATE OR REPLACE FUNCTION dbo.cf_imp_user(_num text, _n_uik integer, _c_password text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
	insert into core.pd_users(id, c_login, c_password, b_disabled, sn_delete)
	values (dbo.sf_convert_number(_num), _num, _num, false, false);
	
	insert into core.pd_userinroles(f_user, f_role, sn_delete)
	values (dbo.sf_convert_number(_num), 5, false);
	RETURN dbo.sf_convert_number(_num);
END
$$;

ALTER FUNCTION dbo.cf_imp_user(_num text, _n_uik integer, _c_password text) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_imp_user(_num text, _n_uik integer, _c_password text) IS 'Импорт пользователя';
