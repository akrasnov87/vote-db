CREATE OR REPLACE FUNCTION dbo.cf_rpt_user_count(_d_begin_date date, _d_end_date date) RETURNS bigint
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
DECLARE
	_count bigint;
BEGIN
	WITH items as (
			select uir.f_route from core.cd_userinroutes as uir
			INNER JOIN core.cd_routes as r ON r.id = uir.f_route
			where uir.f_user = _fn_user and r.f_type = _f_type
		)
	select count(*) into _count
	from core.cd_results as r
	where r.fn_route IN (select i.f_route from items as i) and r.b_disabled = false and d_date between _d_begin_date and _d_end_date
	group by r.fn_user;
	
	RETURN _count;
END
$$;

ALTER FUNCTION dbo.cf_rpt_user_count(_d_begin_date date, _d_end_date date) OWNER TO mobnius;

--------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION dbo.cf_rpt_user_count(_d_date date) RETURNS bigint
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
DECLARE
	_count bigint;
BEGIN
	WITH items as (
			select uir.f_route from core.cd_userinroutes as uir
			INNER JOIN core.cd_routes as r ON r.id = uir.f_route
			where uir.f_user = _fn_user and r.f_type = _f_type
		)
	select count(*) into _count
	from core.cd_results as r
	where r.fn_route IN (select i.f_route from items as i) and r.b_disabled = false and d_date::date = _d_date::date
	group by r.fn_user;
	
	RETURN _count;
END
$$;

ALTER FUNCTION dbo.cf_rpt_user_count(_d_date date) OWNER TO mobnius;
