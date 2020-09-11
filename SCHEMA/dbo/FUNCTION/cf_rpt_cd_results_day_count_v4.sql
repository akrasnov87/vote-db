CREATE OR REPLACE FUNCTION dbo.cf_rpt_cd_results_day_count_v4(_fn_user integer, _f_type integer) RETURNS bigint
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
DECLARE
	_count bigint;
BEGIN
	select count(*) into _count from (
	WITH items as (
		select uir.f_route from core.cd_userinroutes as uir
		INNER JOIN core.cd_routes as r ON r.id = uir.f_route
		where uir.f_user = _fn_user and r.f_type = _f_type
	)
	select p.d_date:: date, count(*) from core.cd_results as p
	where p.fn_route IN (select i.f_route from items as i) and p.d_date between '2020-09-07' and '2020-09-11'
	group by p.d_date::date) as t;
	
	RETURN _count;
END
$$;

ALTER FUNCTION dbo.cf_rpt_cd_results_day_count_v4(_fn_user integer, _f_type integer) OWNER TO mobnius;
