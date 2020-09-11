CREATE MATERIALIZED VIEW dbo.msv_appartament_vv AS
	SELECT cs_appartament.id,
    cs_appartament.f_house,
    cs_appartament.c_number,
    cs_appartament.n_number,
    cs_appartament.dx_date,
    cs_appartament.b_disabled,
    cs_appartament.f_user,
    cs_appartament.n_signature_2018,
    cs_appartament.f_main_user
   FROM dbo.cs_appartament
  WHERE (cs_appartament.id IN ( SELECT DISTINCT p.f_appartament
           FROM ((((((((core.cd_results rr
             JOIN dbo.cs_answer a ON ((a.id = rr.fn_answer)))
             JOIN core.pd_users u ON ((u.id = rr.fn_user)))
             JOIN core.cd_points p ON ((p.id = rr.fn_point)))
             JOIN core.cd_routes r ON ((rr.fn_route = r.id)))
             JOIN core.cs_route_types rt ON ((rt.id = r.f_type)))
             JOIN dbo.cs_house h ON ((r.f_house = h.id)))
             JOIN dbo.cs_street s ON ((s.id = h.f_street)))
             JOIN core.sd_subdivisions sd ON ((sd.id = h.f_subdivision)))
          WHERE ((sd.n_code = 9) AND (rr.b_disabled = false) AND ((rt.id = ANY (ARRAY[1, 2, 4])) AND ((p.n_priority = ANY (ARRAY[1, 2, 4])) OR (rr.n_rating >= 5))))))
WITH DATA;

ALTER MATERIALIZED VIEW dbo.msv_appartament_vv OWNER TO mobnius;

COMMENT ON MATERIALIZED VIEW dbo.msv_appartament_vv IS 'Для 9 округа';
