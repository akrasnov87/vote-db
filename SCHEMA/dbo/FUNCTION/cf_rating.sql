CREATE OR REPLACE FUNCTION dbo.cf_rating(_type integer) RETURNS TABLE(user_id integer, c_fio text, n_uik bigint, c_area text, c_uik_name text, n_all integer, n_count integer, n_today_count integer)
    LANGUAGE plpgsql STABLE
    AS $$

BEGIN
    RETURN QUERY  SELECT max(u.user_id) AS user_id,
    max(u.c_fio) AS c_fio,
    max(u.n_uik) AS n_uik,
    max(u.c_area) AS c_area,
    max(u.c_uik_name) AS c_uik_name,
    sum(u.n_all)::integer AS n_all,
    sum(u.n_count)::integer AS n_count,
    sum(u.n_today_count)::integer AS n_today_count
   FROM dbo.cv_userinroutes u
  WHERE u.f_type = _type
  GROUP BY u.user_id
  ORDER BY (sum(u.n_count)) DESC;
END
$$;

ALTER FUNCTION dbo.cf_rating(_type integer) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_rating(_type integer) IS 'Рейтинг агитаторов';
