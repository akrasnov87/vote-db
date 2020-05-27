CREATE VIEW dbo.cv_userinroutes AS
	SELECT ur.f_user AS user_id,
    concat(u.c_firstname, ' ', u.c_lastname, ' ', u.c_patronymic) AS c_fio,
    u.f_uik AS n_uik,
    o.c_area,
    o.c_name AS c_uik_name,
    r.f_type,
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
     JOIN dbo.cs_uik o ON ((o.id = u.f_uik)))
     JOIN core.cd_routes r ON ((ur.f_route = r.id)));

ALTER VIEW dbo.cv_userinroutes OWNER TO mobnius;
