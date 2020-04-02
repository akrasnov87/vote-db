CREATE VIEW dbo.cv_users AS
	SELECT u.c_area,
    u.n_area,
    u.id AS id_uik,
    u2.id AS user_id_main,
    concat(u2.c_firstname, ' ', u2.c_lastname, ' ', u2.c_patronymic) AS c_fio_main,
    u2.c_tel AS c_tel_main,
    u1.id AS user_id_uik,
    concat(u1.c_firstname, ' ', u1.c_lastname, ' ', u1.c_patronymic) AS c_fio_uik,
    u1.c_tel AS c_tel_uik,
    u1.c_work AS c_work_uik,
    u1.c_post AS c_post_uik,
    ur.id AS user_id,
    concat(ur.c_firstname, ' ', ur.c_lastname, ' ', ur.c_patronymic) AS c_fio,
    ur.c_tel,
    ur.c_work,
    ur.c_post
   FROM (((core.pd_users ur
     LEFT JOIN core.pd_users u2 ON ((ur.f_parent = u2.id)))
     LEFT JOIN dbo.cs_uik u ON ((ur.f_uik = u.id)))
     LEFT JOIN core.pd_users u1 ON ((u.f_user = u1.id)));

ALTER VIEW dbo.cv_users OWNER TO mobnius;

COMMENT ON VIEW dbo.cv_users IS 'Сведения о Кураторах, ОзаУИК и волонтерах, закрепленных за УИК';
