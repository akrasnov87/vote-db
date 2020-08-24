CREATE MATERIALIZED VIEW dbo.msv_appartament2 AS
	SELECT t.id,
    t.f_house,
    t.c_number,
    t.n_number,
    t.dx_date,
    t.b_disabled,
    t.f_user,
    t.n_signature_2018,
    t.f_main_user
   FROM ( SELECT cs_appartament.id,
            cs_appartament.f_house,
            cs_appartament.c_number,
            cs_appartament.n_number,
            cs_appartament.dx_date,
            cs_appartament.b_disabled,
            cs_appartament.f_user,
            cs_appartament.n_signature_2018,
            cs_appartament.f_main_user
           FROM dbo.cs_appartament
          WHERE (cs_appartament.id IN ( SELECT a.id
                   FROM (dbo.cd_people p
                     JOIN dbo.cs_appartament a ON ((a.id = p.f_appartament)))
                  WHERE (p.f_type = 1)
                UNION
                 SELECT a.id
                   FROM (((core.cd_results rr
                     JOIN core.cd_routes r ON ((rr.fn_route = r.id)))
                     JOIN core.cd_points p ON ((p.id = rr.fn_point)))
                     JOIN dbo.cs_appartament a ON ((a.id = p.f_appartament)))
                  WHERE ((r.f_type <> 1) AND (rr.n_rating >= 8))))) t
  WHERE (NOT (t.id IN ( SELECT p.f_appartament
           FROM ((core.cd_results rr
             JOIN core.cd_routes r ON ((rr.fn_route = r.id)))
             JOIN core.cd_points p ON ((p.id = rr.fn_point)))
          WHERE ((r.f_type = 2) AND (rr.n_rating >= 1) AND (rr.n_rating <= 4)))))
WITH DATA;

ALTER MATERIALIZED VIEW dbo.msv_appartament2 OWNER TO mobnius;

--------------------------------------------------------------------------------

CREATE INDEX msv_appartament_f_main_user_f_house_idx ON dbo.msv_appartament2 USING btree (f_main_user, f_house);
