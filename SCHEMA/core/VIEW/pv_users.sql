CREATE VIEW core.pv_users AS
	SELECT u.id,
    u.f_parent,
    u.c_login,
    concat('.', ( SELECT string_agg(t.c_name, '.'::text) AS string_agg
           FROM ( SELECT r.c_name
                   FROM (core.pd_userinroles uir
                     JOIN core.pd_roles r ON ((uir.f_role = r.id)))
                  WHERE (uir.f_user = u.id)
                  ORDER BY r.n_weight DESC) t), '.') AS c_claims,
    u.fn_file,
    u.c_description,
    u.c_first_name,
    u.n_uik,
    u.c_phone,
    u.c_email,
    u.c_version,
    u.n_version,
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
         SELECT concat('.', string_agg(DISTINCT (r_1.id)::text, '.'::text), '.') AS string_agg
           FROM tab_rec r_1) AS c_all_divisions,
    ( SELECT concat('.', string_agg(DISTINCT (pud.f_division)::text, '.'::text), '.') AS string_agg
           FROM core.pd_userindivisions pud
          WHERE (pud.f_user = u.id)) AS c_divisions,
    ( SELECT concat('.', string_agg(DISTINCT (pud.f_subdivision)::text, ','::text), '.') AS string_agg
           FROM core.pd_userindivisions pud
          WHERE (pud.f_user = u.id)) AS c_subdivisions,
    u.b_disabled
   FROM core.pd_users u
  WHERE (u.sn_delete = false);

ALTER VIEW core.pv_users OWNER TO mobnius;

COMMENT ON VIEW core.pv_users IS 'Открытый список пользователей';
