CREATE OR REPLACE FUNCTION dbo.cf_imp_generate_routes(_limit_date date) RETURNS TABLE(c_login text, n_status integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
	REFRESH MATERIALIZED VIEW dbo.msv_appartament5;
	
	return query select
		u.c_login,
		dbo.cf_imp_by_user(r.f_user, 8, '2020-09-12'::date, _limit_date) as status
	from (select f_user
					from core.pd_userinroles
					where f_role = 5
					group by f_user) as r
	inner join core.pd_users as u ON r.f_user = u.id;
END
$$;

ALTER FUNCTION dbo.cf_imp_generate_routes(_limit_date date) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_imp_generate_routes(_limit_date date) IS 'Генерация маршрутов для пользователей';
