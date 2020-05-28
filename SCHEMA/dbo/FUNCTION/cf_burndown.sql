CREATE OR REPLACE FUNCTION dbo.cf_burndown(_type integer, _userid integer) RETURNS TABLE(n_count bigint, d_date date)
    LANGUAGE plpgsql STABLE
    AS $$

BEGIN
	RETURN QUERY 
	select 10, '2020-05-01'
	UNION ALL
	select 11, '2020-05-03'
	UNION ALL
	select 20, '2020-05-05'
	UNION ALL
	select 15, '2020-05-10'
	UNION ALL
	select 21, '2020-05-12'
	UNION ALL
	select 11, '2020-05-15'
	UNION ALL
	select 16, '2020-05-16';
    --RETURN QUERY select
	--	count(*) as n_count,
	--	(SELECT date_trunc('day', up.d_date))::date as d_date
	--from core.cd_user_points as up
	--inner join core.cd_routes as r ON up.fn_route = r.id
	--where up.fn_type = _type and up.fn_user = _userId
	--group by (SELECT date_trunc('day', up.d_date))
	--order by (SELECT date_trunc('day', up.d_date)) asc;
END
$$;

ALTER FUNCTION dbo.cf_burndown(_type integer, _userid integer) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_burndown(_type integer, _userid integer) IS 'График сгорания';
