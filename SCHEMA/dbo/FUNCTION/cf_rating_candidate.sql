CREATE OR REPLACE FUNCTION dbo.cf_rating_candidate(_type integer) RETURNS TABLE(user_id integer, c_login text, f_subdivision integer, c_subdivision text, n_all integer, n_count integer, n_today_count integer)
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    RETURN QUERY  
	SELECT max(u.id) AS user_id,
    max(u.c_fio) AS c_login,
    max(u.f_subdivision) AS f_subdivision,
	max(sd.c_name) as c_subdivision,
    sum(u.n_all)::integer AS n_all,
    sum(u.n_count)::integer AS n_count,
    sum(u.n_today_count)::integer AS n_today_count
   FROM dbo.cv_userinroutes u
   left join core.sd_subdivisions as sd ON sd.id = u.f_subdivision
  WHERE u.f_type = _type and u.c_claims like '%.candidate.%'
  GROUP BY u.id
  ORDER BY (sum(u.n_count)) DESC;
END
$$;

ALTER FUNCTION dbo.cf_rating_candidate(_type integer) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_rating_candidate(_type integer) IS 'Рейтинг кандидатов';
