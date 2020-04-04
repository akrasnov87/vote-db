CREATE VIEW dbo.cv_user_bind AS
	SELECT u.id AS user_id,
    uik.c_area,
    uik.n_area,
    uik.id AS uik_id,
    s.c_name AS street_name,
    h.c_house_num AS house_number,
    h.c_build_num AS house_build,
    concat(t.min_number, '-', t.max_number) AS c_appartament,
        CASE
            WHEN h.b_mkd THEN t.count_number
            ELSE (0)::bigint
        END AS n_mkd_count,
        CASE
            WHEN h.b_private THEN t.count_number
            ELSE (0)::bigint
        END AS n_private_count,
    t.count_number AS n_total
   FROM ((((( SELECT a.f_user,
            a.f_house,
            min(a.n_number) AS min_number,
            max(a.n_number) AS max_number,
            count(a.n_number) AS count_number
           FROM dbo.cs_appartament a
          WHERE (a.f_user IS NOT NULL)
          GROUP BY a.f_user, a.f_house) t
     JOIN dbo.cs_house h ON ((h.id = t.f_house)))
     JOIN dbo.cs_street s ON ((h.f_street = s.id)))
     LEFT JOIN core.pd_users u ON ((t.f_user = u.id)))
     LEFT JOIN dbo.cs_uik uik ON ((u.f_uik = uik.id)));

ALTER VIEW dbo.cv_user_bind OWNER TO mobnius;

COMMENT ON VIEW dbo.cv_user_bind IS 'Закрепление волонтеров';
