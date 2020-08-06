CREATE VIEW dbo.cv_people AS
	SELECT pt.c_name AS c_people_type,
    d.c_name AS c_area,
    s.c_type AS c_street_type,
    s.c_name AS c_street_name,
    s.id AS f_street,
    h.c_house_num,
    h.c_build_num AS c_house_build,
    h.id AS f_house,
    a.c_number AS c_appartament_num,
    a.id AS f_appartament,
    p.c_first_name,
    p.c_last_name,
    p.c_patronymic,
    p.c_phone,
    p.n_birth_year,
    p.c_org,
    h.n_uik,
    sd.c_name AS c_subdivision
   FROM ((((((dbo.cd_people p
     JOIN dbo.cs_people_types pt ON ((pt.id = p.f_type)))
     LEFT JOIN dbo.cs_street s ON ((p.f_street = s.id)))
     LEFT JOIN core.sd_divisions d ON ((s.f_division = d.id)))
     LEFT JOIN dbo.cs_house h ON ((p.f_house = h.id)))
     LEFT JOIN core.sd_subdivisions sd ON ((sd.id = h.f_subdivision)))
     LEFT JOIN dbo.cs_appartament a ON ((p.f_appartament = a.id)))
  ORDER BY d.c_name, s.c_name, h.c_house_num, a.n_number;

ALTER VIEW dbo.cv_people OWNER TO mobnius;
