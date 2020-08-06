CREATE VIEW dbo.cv_house_bind AS
	SELECT h.id,
    h.f_street,
    s.c_name AS c_street_name,
    s.c_type AS c_street_type,
    h.c_house_num,
    h.c_build_num,
    h.n_uik,
    h.f_subdivision,
    ( SELECT count(*) AS count
           FROM dbo.cs_appartament a
          WHERE (a.f_house = h.id)) AS n_appartament_count,
    ( SELECT min(a.n_number) AS min
           FROM dbo.cs_appartament a
          WHERE (a.f_house = h.id)) AS n_appartament_min,
    ( SELECT max(a.n_number) AS max
           FROM dbo.cs_appartament a
          WHERE (a.f_house = h.id)) AS n_appartament_max,
    ( SELECT array_to_json(array_agg(row_to_json(t.*))) AS array_to_json
           FROM ( SELECT a.f_house,
                    a.f_main_user,
                    max(a.n_number) AS n_max,
                    min(a.n_number) AS n_min,
                    count(*) AS n_count
                   FROM dbo.cs_appartament a
                  WHERE ((a.f_house = h.id) AND (a.f_main_user IS NOT NULL))
                  GROUP BY a.f_house, a.f_main_user) t) AS f_users
   FROM (dbo.cs_house h
     JOIN dbo.cs_street s ON ((h.f_street = s.id)));

ALTER VIEW dbo.cv_house_bind OWNER TO mobnius;

COMMENT ON VIEW dbo.cv_house_bind IS 'Список домов к которым привязаны пользователи';
