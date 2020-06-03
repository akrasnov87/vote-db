CREATE VIEW dbo.cv_userinroutes AS
	SELECT u.id,
    u.c_login,
    u.n_uik,
    r.f_type,
    rt.c_name AS c_route_type_name,
    r.c_number,
    COALESCE(( SELECT count(*) AS count
           FROM core.cd_points p
          WHERE (p.f_route = ur.f_route)), (0)::bigint) AS n_all,
    COALESCE(( SELECT count(*) AS count
           FROM core.cd_user_points up
          WHERE ((up.fn_user = u.id) AND (ur.f_route = up.fn_route))), (0)::bigint) AS n_count,
    COALESCE(( SELECT count(*) AS count
           FROM core.cd_user_points up
          WHERE ((up.fn_user = u.id) AND (ur.f_route = up.fn_route) AND (( SELECT date_trunc('month'::text, up.d_date) AS date_trunc) = ( SELECT date_trunc('month'::text, (CURRENT_DATE)::timestamp with time zone) AS date_trunc)))), (0)::bigint) AS n_today_count
   FROM (((core.cd_userinroutes ur
     JOIN core.pd_users u ON ((u.id = ur.f_user)))
     JOIN core.cd_routes r ON ((ur.f_route = r.id)))
     JOIN core.cs_route_types rt ON ((rt.id = r.f_type)));

ALTER VIEW dbo.cv_userinroutes OWNER TO mobnius;
