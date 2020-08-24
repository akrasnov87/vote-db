CREATE OR REPLACE FUNCTION dbo.cf_imp_generate_subdivision_routes(subdivision integer, _limit_date date) RETURNS TABLE(c_login text, n_status integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
	
	return query select 
		u.c_login,
		dbo.cf_imp_by_user(u.id, 3, now()::date, _limit_date) as status
	from core.pv_users as u
	where c_claims = '.inspector.' and u.f_subdivision = subdivision;
END
$$;

ALTER FUNCTION dbo.cf_imp_generate_subdivision_routes(subdivision integer, _limit_date date) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_imp_generate_subdivision_routes(subdivision integer, _limit_date date) IS 'Генерация маршрутов для округов';
