CREATE VIEW dbo.cv_tracking AS
	SELECT t.f_user,
    t.d_date_str,
    t.d_date,
    t.n_longitude,
    t.n_latitude,
    t.c_network_status
   FROM ( SELECT t_1.fn_user AS f_user,
            to_char(t_1.d_date, 'dd.MM.YYYY HH24:MI'::text) AS d_date_str,
            max(t_1.d_date) AS d_date,
            avg(t_1.n_longitude) AS n_longitude,
            avg(t_1.n_latitude) AS n_latitude,
            max(t_1.c_network_status) AS c_network_status
           FROM core.ad_tracking t_1
          GROUP BY t_1.fn_user, (to_char(t_1.d_date, 'dd.MM.YYYY HH24:MI'::text))
        UNION ALL
         SELECT t_1.fn_user AS f_user,
            to_char(t_1.d_date, 'dd.MM.YYYY HH24:MI'::text) AS d_date_str,
            t_1.d_date,
            t_1.n_longitude,
            t_1.n_latitude,
            'online'::text AS c_network_status
           FROM core.cd_user_points t_1
          WHERE (t_1.n_longitude > (1)::numeric)) t
  ORDER BY t.d_date;

ALTER VIEW dbo.cv_tracking OWNER TO mobnius;
