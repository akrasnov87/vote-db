CREATE OR REPLACE FUNCTION srv.generate_routes() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
	
	select
		u.c_login,
		dbo.cf_imp_by_user(r.f_user, 1, now()::date) as status
	from (select f_user
					from core.pd_userinroles
					where f_role = 5
					group by f_user) as r
	inner join core.pd_users as u ON r.f_user = u.id;
	
	RETURN 0;
END
$$;

ALTER FUNCTION srv.generate_routes() OWNER TO mobnius;

COMMENT ON FUNCTION srv.generate_routes() IS 'Генерация маршрутов для пользователей';
