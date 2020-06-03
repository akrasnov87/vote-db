CREATE VIEW dbo.cv_user_bind AS
	SELECT u.id AS user_id,
    d.c_name AS c_division,
    sd.c_name AS c_subdivision,
    h.n_uik,
    s.c_type,
    s.c_name AS c_street,
    h.c_house_num,
    h.c_build_num,
        CASE
            WHEN (t.min_number = 0) THEN '0'::text
            ELSE concat(t.min_number, '-', t.max_number)
        END AS c_appartament,
    t.count_number AS n_appartament
   FROM (((((( SELECT a.f_user,
            a.f_house,
            min(a.n_number) AS min_number,
            max(a.n_number) AS max_number,
            count(*) AS count_number
           FROM dbo.cs_appartament a
          WHERE (a.f_user IS NOT NULL)
          GROUP BY a.f_user, a.f_house) t
     JOIN dbo.cs_house h ON ((h.id = t.f_house)))
     JOIN dbo.cs_street s ON ((h.f_street = s.id)))
     LEFT JOIN core.pd_users u ON ((t.f_user = u.id)))
     LEFT JOIN core.sd_divisions d ON ((d.id = s.f_division)))
     LEFT JOIN core.sd_subdivisions sd ON ((sd.id = h.f_subdivision)));

ALTER VIEW dbo.cv_user_bind OWNER TO mobnius;

COMMENT ON VIEW dbo.cv_user_bind IS 'Закрепление волонтеров';
