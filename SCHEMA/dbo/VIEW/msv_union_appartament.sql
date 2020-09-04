CREATE MATERIALIZED VIEW dbo.msv_union_appartament AS
	SELECT p.f_appartament,
    'Кандидат установил рейтинг больше или равен 5'::text AS f_type,
    4 AS n_type,
    rr.d_date
   FROM (((core.cd_results rr
     JOIN core.cd_routes r ON ((r.id = rr.fn_route)))
     JOIN core.cd_points p ON ((p.id = rr.fn_point)))
     JOIN dbo.cs_appartament a ON ((a.id = p.f_appartament)))
  WHERE ((a.b_disabled = false) AND (rr.b_disabled = false) AND (r.f_type = 1) AND (p.n_priority <> 0) AND (rr.n_rating >= 5))
UNION ALL
 SELECT p.f_appartament,
    'Получен из контактов кандидата (приоритет 0)'::text AS f_type,
    3 AS n_type,
    rr.d_date
   FROM (((core.cd_results rr
     JOIN core.cd_routes r ON ((r.id = rr.fn_route)))
     JOIN core.cd_points p ON ((p.id = rr.fn_point)))
     JOIN dbo.cs_appartament a ON ((a.id = p.f_appartament)))
  WHERE ((a.b_disabled = false) AND (rr.b_disabled = false) AND (r.f_type = 1) AND (p.n_priority = 0) AND (rr.n_rating >= 5))
UNION ALL
 SELECT t.f_appartament,
    'Получен из контактов кандидата'::text AS f_type,
    2 AS n_type,
    t.d_date
   FROM ( SELECT t_1.id,
            t_1.c_first_name,
            t_1.c_last_name,
            t_1.c_patronymic,
            t_1.fn_street,
            t_1.c_appartament,
            t_1.n_rating,
            t_1.c_description,
            t_1.d_date,
            t_1.dx_created,
            t_1.fn_user,
            t_1.jb_data,
            t_1.c_phone,
            t_1.b_disabled,
            t_1.c_house_num,
            t_1.c_house_build,
            t_1.n_order,
            t_1.f_house,
            ( SELECT a.id
                   FROM dbo.cs_appartament a
                  WHERE ((a.f_house = t_1.f_house) AND (a.c_number = t_1.c_appartament))) AS f_appartament
           FROM ( SELECT c.id,
                    c.c_first_name,
                    c.c_last_name,
                    c.c_patronymic,
                    c.fn_street,
                    c.c_appartament,
                    c.n_rating,
                    c.c_description,
                    c.d_date,
                    c.dx_created,
                    c.fn_user,
                    c.jb_data,
                    c.c_phone,
                    c.b_disabled,
                    c.c_house_num,
                    c.c_house_build,
                    c.n_order,
                    ( SELECT h.id
                           FROM dbo.cs_house h
                          WHERE ((c.fn_street = h.f_street) AND (h.b_disabled = false))
                         LIMIT 1) AS f_house
                   FROM dbo.cd_contacts c) t_1) t
  WHERE (t.f_appartament IS NOT NULL)
UNION ALL
 SELECT p.f_appartament,
    'Агитатор установил рейтинг больше или равен 5'::text AS f_type,
    1 AS n_type,
    rr.d_date
   FROM (((core.cd_results rr
     JOIN core.cd_routes r ON ((r.id = rr.fn_route)))
     JOIN core.cd_points p ON ((p.id = rr.fn_point)))
     JOIN dbo.cs_appartament a ON ((a.id = p.f_appartament)))
  WHERE ((a.b_disabled = false) AND (rr.b_disabled = false) AND ((r.f_type = 2) OR (r.f_type = 4)) AND (rr.n_rating >= 5))
UNION ALL
 SELECT p.f_appartament,
    'Избиратель'::text AS f_type,
    0 AS n_type,
    p.dx_created AS d_date
   FROM (dbo.cd_people p
     JOIN dbo.cs_appartament a ON ((a.id = p.f_appartament)))
  WHERE ((a.b_disabled = false) AND (p.f_type = 1) AND (NOT (p.f_appartament IN ( SELECT p_1.f_appartament
           FROM ((((core.cd_results rr
             JOIN core.cd_routes r ON ((r.id = rr.fn_route)))
             JOIN core.cd_points p_1 ON ((p_1.id = rr.fn_point)))
             JOIN dbo.cs_appartament a_1 ON ((a_1.id = p_1.f_appartament)))
             JOIN dbo.cd_people pp ON ((pp.f_appartament = a_1.id)))
          WHERE ((a_1.b_disabled = false) AND (rr.b_disabled = false) AND (pp.f_type = 1) AND (r.f_type = 1) AND (p_1.n_priority = 1) AND (rr.n_rating <= 4))
        UNION
         SELECT p_1.f_appartament
           FROM ((((core.cd_results rr
             JOIN core.cd_routes r ON ((r.id = rr.fn_route)))
             JOIN core.cd_points p_1 ON ((p_1.id = rr.fn_point)))
             JOIN dbo.cs_appartament a_1 ON ((a_1.id = p_1.f_appartament)))
             JOIN dbo.cd_people pp ON ((pp.f_appartament = a_1.id)))
          WHERE ((a_1.b_disabled = false) AND (rr.b_disabled = false) AND (pp.f_type = 1) AND ((r.f_type = 2) OR (r.f_type = 4)) AND (rr.n_rating <= 4))))))
WITH DATA;

ALTER MATERIALIZED VIEW dbo.msv_union_appartament OWNER TO mobnius;

COMMENT ON VIEW dbo.msv_union_appartament IS 'Для обхода по 4 волне - агитатор';
