CREATE OR REPLACE FUNCTION dbo.cf_rpt_cd_results_count(_fn_user integer, _f_type integer) RETURNS bigint
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
	select count(*) into _count from core.cd_results as p
	where p.fn_route IN (select i.f_route from items as i);
	
	RETURN _count;
END
$$;

ALTER FUNCTION dbo.cf_rpt_cd_results_count(_fn_user integer, _f_type integer) OWNER TO mobnius;

--------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION dbo.cf_rpt_cd_results_count(_fn_user integer, _d_filter_date date, _f_type integer) RETURNS bigint
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
	select count(*) into _count from core.cd_results as p
	where p.fn_route IN (select i.f_route from items as i) and p.d_date::date = _d_filter_date;
	
	RETURN _count;
END
$$;

ALTER FUNCTION dbo.cf_rpt_cd_results_count(_fn_user integer, _d_filter_date date, _f_type integer) OWNER TO mobnius;

--------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION dbo.cf_rpt_cd_results_count(_fn_user integer, _default integer, _f_type integer) RETURNS bigint
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
	select count(*) into _count from core.cd_results as p
	where p.fn_route IN (select i.f_route from items as i);
	
	RETURN CASE WHEN _count > 0 THEN _count ELSE _default END;
END
$$;

ALTER FUNCTION dbo.cf_rpt_cd_results_count(_fn_user integer, _default integer, _f_type integer) OWNER TO mobnius;
