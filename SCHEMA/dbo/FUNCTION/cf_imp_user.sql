CREATE OR REPLACE FUNCTION dbo.cf_imp_user(_id integer, _c_login text, _c_password text, _c_firstname text, _c_lastname text, _c_patronymic text, _n_uik bigint, _c_tel text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
	insert into core.pd_users(id, c_login, c_password, c_firstname, c_lastname, c_patronymic, c_tel, b_disabled, sn_delete, n_uik)
	values (_id, _c_login, _c_password, _c_firstname, _c_lastname, _c_patronymic, _c_tel, false, false, _n_uik);
	
	insert into core.pd_userinroles(f_user, f_role, sn_delete)
	values (_id, 5, false);
	RETURN _id;
END
$$;

ALTER FUNCTION dbo.cf_imp_user(_id integer, _c_login text, _c_password text, _c_firstname text, _c_lastname text, _c_patronymic text, _n_uik bigint, _c_tel text) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_imp_user(_id integer, _c_login text, _c_password text, _c_firstname text, _c_lastname text, _c_patronymic text, _n_uik bigint, _c_tel text) IS 'Импорт пользователей';
