CREATE MATERIALIZED VIEW dbo.msv_appartament2 AS
	SELECT t.id,
    t.f_house,
    t.c_number,
    t.n_number,
    t.dx_date,
    t.b_disabled,
    t.f_user,
    t.n_signature_2018,
    t.f_main_user,
    t.f_type
   FROM ( SELECT a.id,
            a.f_house,
            a.c_number,
            a.n_number,
            a.dx_date,
            a.b_disabled,
            a.f_user,
            a.n_signature_2018,
            a.f_main_user,
            'VOTE'::text AS f_type
           FROM (dbo.cd_people p
             JOIN dbo.cs_appartament a ON ((a.id = p.f_appartament)))
          WHERE (p.f_type = 1)
        UNION
         SELECT a.id,
            a.f_house,
            a.c_number,
            a.n_number,
            a.dx_date,
            a.b_disabled,
            a.f_user,
            a.n_signature_2018,
            a.f_main_user,
            'RATING_BIG'::text AS f_type
           FROM (((core.cd_results rr
             JOIN core.cd_routes r ON ((rr.fn_route = r.id)))
             JOIN core.cd_points p ON ((p.id = rr.fn_point)))
             JOIN dbo.cs_appartament a ON ((a.id = p.f_appartament)))
          WHERE ((r.f_type = 2) AND (rr.n_rating >= 8))) t
  WHERE (NOT (t.id IN ( SELECT p.f_appartament
           FROM ((core.cd_results rr
             JOIN core.cd_routes r ON ((rr.fn_route = r.id)))
             JOIN core.cd_points p ON ((p.id = rr.fn_point)))
          WHERE ((r.f_type = 2) AND (rr.n_rating >= 1) AND (rr.n_rating <= 4)))))
WITH DATA;

ALTER MATERIALIZED VIEW dbo.msv_appartament2 OWNER TO mobnius;

COMMENT ON VIEW dbo.msv_appartament2 IS 'Для второй волны';

--------------------------------------------------------------------------------

CREATE INDEX msv_appartament_f_main_user_f_house_idx ON dbo.msv_appartament2 USING btree (f_main_user, f_house);
