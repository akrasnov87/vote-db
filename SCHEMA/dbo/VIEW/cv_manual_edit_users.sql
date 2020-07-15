CREATE VIEW dbo.cv_manual_edit_users AS
	SELECT u.id,
    u.c_login,
    u.c_password,
    u.dx_created
   FROM ((core.pd_userinroles uir
     JOIN core.pd_users u ON ((u.id = uir.f_user)))
     JOIN core.pd_roles r ON ((r.id = uir.f_role)))
  WHERE (r.c_name = 'manual_edit'::text);

ALTER VIEW dbo.cv_manual_edit_users OWNER TO mobnius;
