CREATE VIEW core.sv_users AS
	SELECT u.id,
    u.f_parent,
    u.c_login,
    u.c_first_name,
    u.c_last_name,
    u.c_middle_name,
    concat(u.c_first_name, ' ', u.c_last_name, ' ', u.c_middle_name) AS c_user_name,
    u.c_password,
    u.s_salt,
    u.s_hash,
    concat('.', ( SELECT string_agg(t.c_name, '.'::text) AS string_agg
           FROM ( SELECT r.c_name
                   FROM (core.pd_userinroles uir
                     JOIN core.pd_roles r ON ((uir.f_role = r.id)))
                  WHERE (uir.f_user = u.id)
                  ORDER BY r.n_weight DESC) t), '.') AS c_claims,
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
    u.b_disabled,
    u.c_version,
    u.n_version
   FROM core.pd_users u
  WHERE (u.sn_delete = false);

ALTER VIEW core.sv_users OWNER TO mobnius;

COMMENT ON VIEW core.sv_users IS 'Системный список пользователей';
