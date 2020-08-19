CREATE OR REPLACE FUNCTION core.cf_mui_cd_points(_fn_user integer) RETURNS TABLE(id uuid, f_appartament uuid, f_route uuid, c_notice text, c_info text, jb_data text, dx_created timestamp with time zone, n_order integer, n_priority integer)
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
	RETURN QUERY WITH items as (
		select uir.f_route from core.cd_userinroutes as uir
		INNER JOIN core.cd_routes as r ON r.id = uir.f_route
		where uir.f_user = _fn_user and dbo.cf_old_date(r.d_date_end)
	) 
	select p.id, p.f_appartament, p.f_route, p.c_notice, p.c_info, p.jb_data::text, p.dx_created, p.n_order, p.n_priority
	from core.cd_points as p
	where p.f_route IN (select i.f_route from items as i);
END
$$;

ALTER FUNCTION core.cf_mui_cd_points(_fn_user integer) OWNER TO mobnius;
