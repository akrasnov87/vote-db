CREATE VIEW dbo.cv_userinroutes AS
	SELECT 
	ur.f_user AS user_id,
    u.n_uik AS n_uik,
    r.f_type,
	rt.c_name as c_route_type_name,
    COALESCE((SELECT count(*) FROM core.cd_points p WHERE p.f_route = ur.f_route),0) AS n_all,
    COALESCE((SELECT count(*) AS count FROM core.cd_user_points up WHERE up.fn_user = u.id AND ur.f_route = up.fn_route), (0)) AS n_count,
    COALESCE(( SELECT count(*) AS count
           FROM core.cd_user_points up
          WHERE ((up.fn_user = u.id) AND (ur.f_route = up.fn_route) AND (( SELECT date_trunc('month'::text, up.d_date) AS date_trunc) = ( SELECT date_trunc('month'::text, (CURRENT_DATE)::timestamp with time zone) AS date_trunc)))), (0)::bigint) AS n_today_count
FROM core.cd_userinroutes ur
inner JOIN core.pd_users u ON u.id = ur.f_user
inner JOIN core.cd_routes r ON ur.f_route = r.id
INNER JOIN core.cs_route_types as rt ON rt.id = r.f_type;

ALTER VIEW dbo.cv_userinroutes OWNER TO mobnius;
