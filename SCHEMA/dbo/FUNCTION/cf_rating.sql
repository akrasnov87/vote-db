CREATE OR REPLACE FUNCTION dbo.cf_rating(_type integer) RETURNS TABLE(user_id integer, c_login text, n_uik integer, n_all bigint, n_count bigint, n_today_count bigint)
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    RETURN QUERY select * from (SELECT u.id,
		coalesce(u.c_fio, u.c_login) as c_login,
		u.n_uik,
		(select core.cf_mui_cd_points_count(u.id, 0)) AS n_all,
		(select core.cf_mui_cd_results_count(u.id)) AS n_count,
		(select core.cf_mui_cd_results_count(u.id, CURRENT_DATE)) AS n_today_count
   FROM core.pd_users as u
   where u.id between 180000 and 1000000) as t
   order by n_count DESC;
	
	--SELECT max(u.id) AS user_id,
    --max(u.c_login) AS c_login,
    --max(u.n_uik) AS n_uik,
    --sum(u.n_all)::integer AS n_all,
    --sum(u.n_count)::integer AS n_count,
    --sum(u.n_today_count)::integer AS n_today_count
   --FROM dbo.cv_userinroutes u
  --WHERE u.f_type = _type
 -- GROUP BY u.id
  --ORDER BY (sum(u.n_count)) DESC;
END
$$;

ALTER FUNCTION dbo.cf_rating(_type integer) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_rating(_type integer) IS 'Рейтинг агитаторов';
