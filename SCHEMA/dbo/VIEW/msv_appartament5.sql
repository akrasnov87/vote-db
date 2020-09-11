CREATE MATERIALIZED VIEW dbo.msv_appartament5 AS
	SELECT a.id,
    a.f_house,
    a.c_number,
    a.n_number,
    a.dx_date,
    a.b_disabled,
    a.f_user,
    a.n_signature_2018,
    a.f_main_user
   FROM dbo.cs_appartament a
  WHERE ((a.b_disabled = false) AND (a.id IN ( SELECT t.f_appartament
           FROM ( SELECT t_1.f_appartament
                   FROM ( SELECT t_2.f_appartament
                           FROM ( SELECT p.f_appartament
                                   FROM (((core.cd_userinroutes uir
                                     JOIN core.cd_routes r ON ((r.id = uir.f_route)))
                                     JOIN core.cd_points p ON ((p.f_route = r.id)))
                                     JOIN core.cd_results rr ON ((rr.fn_point = p.id)))
                                  WHERE ((rr.b_disabled = false) AND (rr.n_rating >= 5) AND (r.f_type = ANY (ARRAY[2, 4])))
                                UNION
                                 SELECT p.f_appartament
                                   FROM (((core.cd_userinroutes uir
                                     JOIN core.cd_routes r ON ((r.id = uir.f_route)))
                                     JOIN core.cd_points p ON ((p.f_route = r.id)))
                                     JOIN core.cd_results rr ON ((rr.fn_point = p.id)))
                                  WHERE ((rr.b_disabled = false) AND (rr.n_rating >= 5) AND (r.f_type = 6))) t_2
                          WHERE (NOT (t_2.f_appartament IN ( SELECT p.f_appartament
                                   FROM (((core.cd_userinroutes uir
                                     JOIN core.cd_routes r ON ((r.id = uir.f_route)))
                                     JOIN core.cd_points p ON ((p.f_route = r.id)))
                                     JOIN core.cd_results rr ON ((rr.fn_point = p.id)))
                                  WHERE ((rr.b_disabled = false) AND (rr.n_rating <= 4) AND (r.f_type = ANY (ARRAY[2, 4])))
                                UNION
                                 SELECT p.f_appartament
                                   FROM (((core.cd_userinroutes uir
                                     JOIN core.cd_routes r ON ((r.id = uir.f_route)))
                                     JOIN core.cd_points p ON ((p.f_route = r.id)))
                                     JOIN core.cd_results rr ON ((rr.fn_point = p.id)))
                                  WHERE ((rr.b_disabled = false) AND (rr.n_rating <= 4) AND (r.f_type = 6)))))) t_1
                UNION
                 SELECT p.f_appartament
                   FROM (((core.cd_userinroutes uir
                     JOIN core.cd_routes r ON ((r.id = uir.f_route)))
                     JOIN core.cd_points p ON ((p.f_route = r.id)))
                     JOIN core.cd_results rr ON ((rr.fn_point = p.id)))
                  WHERE ((rr.b_disabled = false) AND (rr.n_rating >= 5) AND (r.f_type = 1))) t
          WHERE (NOT (t.f_appartament IN ( SELECT p.f_appartament
                   FROM (((core.cd_userinroutes uir
                     JOIN core.cd_routes r ON ((r.id = uir.f_route)))
                     JOIN core.cd_points p ON ((p.f_route = r.id)))
                     JOIN core.cd_results rr ON ((rr.fn_point = p.id)))
                  WHERE ((rr.b_disabled = false) AND (rr.n_rating <= 4) AND (r.f_type = 1)))))
        UNION
         SELECT p.f_appartament
           FROM (((core.cd_userinroutes uir
             JOIN core.cd_routes r ON ((r.id = uir.f_route)))
             JOIN core.cd_points p ON ((p.f_route = r.id)))
             JOIN core.cd_results rr ON ((rr.fn_point = p.id)))
          WHERE ((rr.fn_answer = 153) AND (rr.b_disabled = false) AND (r.f_type = 3)))))
WITH DATA;

ALTER MATERIALIZED VIEW dbo.msv_appartament5 OWNER TO mobnius;
