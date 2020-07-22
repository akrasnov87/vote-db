CREATE VIEW dbo.cv_tmp_appartament AS
	SELECT a.id,
    lower(d.c_name) AS c_area,
    concat(s.c_short_type, ' ', s.c_name) AS c_street,
        CASE
            WHEN (btrim(h.c_build_num) = ''::text) THEN h.c_house_num
            ELSE concat(h.c_house_num, ' корп. ', h.c_build_num)
        END AS c_house_num,
    h.c_build_num,
    a.c_number AS c_appartament_number
   FROM (((dbo.cs_appartament a
     JOIN dbo.cs_house h ON ((a.f_house = h.id)))
     JOIN dbo.cs_street s ON ((h.f_street = s.id)))
     JOIN core.sd_divisions d ON ((s.f_division = d.id)));

ALTER VIEW dbo.cv_tmp_appartament OWNER TO mobnius;
