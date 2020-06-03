CREATE OR REPLACE FUNCTION dbo.cf_rating(_type integer) RETURNS TABLE(user_id integer, c_login text, n_uik integer, n_all integer, n_count integer, n_today_count integer)
    LANGUAGE plpgsql STABLE
    AS $$

BEGIN
    RETURN QUERY  
	SELECT max(u.id) AS user_id,
    max(u.c_login) AS c_login,
    max(u.n_uik) AS n_uik,
    sum(u.n_all)::integer AS n_all,
    sum(u.n_count)::integer AS n_count,
    sum(u.n_today_count)::integer AS n_today_count
   FROM dbo.cv_userinroutes u
  WHERE u.f_type = _type
  GROUP BY u.id
  ORDER BY (sum(u.n_count)) DESC;
END
$$;

ALTER FUNCTION dbo.cf_rating(_type integer) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_rating(_type integer) IS 'Рейтинг агитаторов';
