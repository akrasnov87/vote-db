CREATE OR REPLACE FUNCTION dbo.cf_rating_candidate(_type integer) RETURNS TABLE(user_id integer, c_login text, f_subdivision integer, c_subdivision text, n_all integer, n_count integer, n_today_count integer)
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    RETURN QUERY SELECT r.user_id,
    r.c_login,
    r.f_subdivision,
	r.c_subdivision,
    r.n_all::integer AS n_all,
    r.n_count::integer AS n_count,
   	r.n_today_count::integer AS n_today_count
   FROM dbo.msv_rating as r
  WHERE r.c_claims like '%.candidate.%' and r.c_login != 'test'
  ORDER BY r.n_count DESC;
END
$$;

ALTER FUNCTION dbo.cf_rating_candidate(_type integer) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_rating_candidate(_type integer) IS 'Рейтинг кандидатов';
