CREATE VIEW dbo.cv_unopen_appartament AS
	SELECT r.fn_user,
    p.f_appartament
   FROM ((core.cd_results r
     JOIN core.cd_points p ON ((p.id = r.fn_point)))
     JOIN dbo.cs_answer a ON ((a.id = r.fn_answer)))
  WHERE ((r.fn_route IN ( SELECT uir.f_route
           FROM (core.cd_userinroutes uir
             JOIN core.cd_routes r_1 ON ((uir.f_route = r_1.id)))
          WHERE (r_1.f_type = 1))) AND (a.c_color = '#000000'::text));

ALTER VIEW dbo.cv_unopen_appartament OWNER TO mobnius;

COMMENT ON VIEW dbo.cv_unopen_appartament IS 'Список не открытых квартир';
