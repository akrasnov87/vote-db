CREATE VIEW dbo.cv_inspector AS
	SELECT u.id,
    u.c_login,
    u.c_email,
    u.c_tel,
    u.c_description,
    u.n_uik,
    ( SELECT string_agg(d.c_name, ','::text) AS string_agg
           FROM (core.pd_userindivisions pud
             JOIN core.sd_divisions d ON ((d.id = pud.f_division)))
          WHERE (pud.f_user = u.id)) AS c_divisions,
    ( SELECT string_agg(sd.c_name, ','::text) AS string_agg
           FROM (core.pd_userindivisions pud
             JOIN core.sd_subdivisions sd ON ((sd.id = pud.f_subdivision)))
          WHERE (pud.f_user = u.id)) AS c_subdivisions,
    u.b_disabled
   FROM ((core.pd_users u
     LEFT JOIN core.pd_userinroles uir ON ((u.id = uir.f_user)))
     LEFT JOIN core.pd_roles r ON ((r.id = uir.f_role)))
  WHERE (r.c_name = 'inspector'::text)
  ORDER BY u.id;

ALTER VIEW dbo.cv_inspector OWNER TO mobnius;
