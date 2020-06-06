CREATE VIEW dbo.cv_routes AS
	SELECT uir.f_route,
    uir.f_user,
    u.c_login,
    r.f_type,
    rt.c_name AS c_type,
    r.c_number,
    r.d_date_start,
    r.d_date_end,
    ( SELECT rs.c_const
           FROM (core.cd_route_history rh
             JOIN core.cs_route_statuses rs ON ((rh.fn_status = rs.id)))
          WHERE (rh.fn_route = r.id)
          ORDER BY rh.d_date DESC
         LIMIT 1) AS c_status
   FROM (((core.cd_userinroutes uir
     JOIN core.cd_routes r ON ((r.id = uir.f_route)))
     JOIN core.cs_route_types rt ON ((rt.id = r.f_type)))
     JOIN core.pd_users u ON ((u.id = uir.f_user)));

ALTER VIEW dbo.cv_routes OWNER TO mobnius;
