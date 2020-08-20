CREATE OR REPLACE FUNCTION dbo.cf_rating_candidate(_type integer) RETURNS TABLE(user_id integer, c_login text, f_subdivision integer, c_subdivision text, n_all bigint, n_count bigint, n_today_count bigint)
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    RETURN QUERY select * from (SELECT u.id AS user_id,
    u.c_fio AS c_login,
    u.f_subdivision AS f_subdivision,
	sd.c_name as c_subdivision,
	(select core.cf_mui_cd_points_count(u.id, 0)) AS n_all,
	(select core.cf_mui_cd_results_count(u.id)) AS n_count,
	(select core.cf_mui_cd_results_count(u.id, CURRENT_DATE)) AS n_today_count
  FROM core.pv_users as u
  left join core.sd_subdivisions as sd ON sd.id = u.f_subdivision
  WHERE u.c_claims like '%.candidate.%' and u.c_login != 'test') as t
  order by n_count DESC;
END
$$;

ALTER FUNCTION dbo.cf_rating_candidate(_type integer) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_rating_candidate(_type integer) IS 'Рейтинг кандидатов';
