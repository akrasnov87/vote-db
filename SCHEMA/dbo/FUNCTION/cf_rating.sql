CREATE OR REPLACE FUNCTION dbo.cf_rating(_type integer) RETURNS TABLE(user_id integer, c_login text, n_uik integer, n_all bigint, n_count bigint, n_today_count bigint)
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    RETURN QUERY SELECT u.user_id,
		u.c_login,
		u.n_uik,
		u.n_all,
		u.n_count,
		u.n_today_count
   FROM dbo.msv_rating as u
   where u.c_claims = '.inspector.'
   order by u.n_count DESC;
END
$$;

ALTER FUNCTION dbo.cf_rating(_type integer) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_rating(_type integer) IS 'Рейтинг агитаторов';
