CREATE VIEW dbo.cv_tracking AS
	SELECT t.fn_user AS f_user,
    to_char(t.d_date, 'YYYY-MM-dd HH24:MI'::text) AS d_date_str,
    avg(t.n_longitude) AS n_longitude,
    avg(t.n_latitude) AS n_latitude,
    max(t.c_network_status) AS c_network_status
   FROM core.ad_tracking t
  GROUP BY t.fn_user, (to_char(t.d_date, 'YYYY-MM-dd HH24:MI'::text))
  ORDER BY (max(t.d_date));

ALTER VIEW dbo.cv_tracking OWNER TO mobnius;
