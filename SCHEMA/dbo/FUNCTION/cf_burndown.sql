CREATE OR REPLACE FUNCTION dbo.cf_burndown(_type integer, _userid integer) RETURNS TABLE(n_count bigint, d_date date)
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    RETURN QUERY select
		count(*) as n_count,
		(SELECT date_trunc('day', up.d_date))::date as d_date
	from core.cf_mui_cd_user_points(_userId) as up
	inner join core.cd_routes as r ON up.fn_route = r.id
	group by (SELECT date_trunc('day', up.d_date))
	order by (SELECT date_trunc('day', up.d_date)) asc;
END
$$;

ALTER FUNCTION dbo.cf_burndown(_type integer, _userid integer) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_burndown(_type integer, _userid integer) IS 'График сгорания';
