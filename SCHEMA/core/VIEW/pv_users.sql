CREATE VIEW core.pv_users AS
	SELECT u.id,
    u.f_parent,
    u.c_login,
    concat('.', string_agg(r.c_name, '.'::text), '.') AS c_claims,
    u.c_email,
    u.c_tel,
    u.c_description,
    u.c_firstname,
    u.c_lastname,
    u.c_patronymic,
    ( WITH RECURSIVE tab_rec AS (
                 SELECT sd_divisions.id AS id_parent,
                    sd_divisions.id,
                    sd_divisions.f_division,
                    1 AS num
                   FROM core.sd_divisions
                  WHERE (sd_divisions.id IN ( SELECT pud.f_division
                           FROM core.pd_userindivisions pud
                          WHERE (pud.f_user = u.id)))
                UNION ALL
                 SELECT r_2.id_parent,
                    d.id,
                    d.f_division,
                    (r_2.num + 1) AS num
                   FROM core.sd_divisions d,
                    tab_rec r_2
                  WHERE (r_2.id = d.f_division)
                )
         SELECT string_agg((r_1.id)::text, ','::text) AS string_agg
           FROM tab_rec r_1) AS c_all_divisions,
    ( SELECT string_agg((pud.f_division)::text, ','::text) AS string_agg
           FROM core.pd_userindivisions pud
          WHERE (pud.f_user = u.id)) AS c_divisions,
    ( SELECT string_agg((pud.f_subdivision)::text, ','::text) AS string_agg
           FROM core.pd_userindivisions pud
          WHERE (pud.f_user = u.id)) AS c_subdivisions,
    u.b_disabled
   FROM ((core.pd_users u
     LEFT JOIN core.pd_userinroles uir ON ((u.id = uir.f_user)))
     LEFT JOIN ( SELECT pd_roles.id,
            pd_roles.c_description,
            pd_roles.c_name,
            pd_roles.n_weight,
            pd_roles.sn_delete
           FROM core.pd_roles
          ORDER BY pd_roles.n_weight DESC) r ON ((r.id = uir.f_role)))
  WHERE ((uir.sn_delete = false) AND (u.sn_delete = false) AND (r.sn_delete = false))
  GROUP BY u.id;

ALTER VIEW core.pv_users OWNER TO mobnius;

COMMENT ON VIEW core.pv_users IS 'Открытый список пользователей';
