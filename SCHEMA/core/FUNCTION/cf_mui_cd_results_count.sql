CREATE OR REPLACE FUNCTION core.cf_mui_cd_results_count(_fn_user integer) RETURNS bigint
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
DECLARE
	_count bigint;
BEGIN

	WITH items as (
		select uir.f_route from core.cd_userinroutes as uir
		INNER JOIN core.cd_routes as r ON r.id = uir.f_route
		where uir.f_user = _fn_user and now()::date >= r.d_date_start and dbo.cf_old_date(r.d_date_end)
	)
	select count(*) into _count from core.cd_results as p
	where p.fn_route IN (select i.f_route from items as i) and p.b_disabled = false;
	
	RETURN _count;
END
$$;

ALTER FUNCTION core.cf_mui_cd_results_count(_fn_user integer) OWNER TO mobnius;

--------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION core.cf_mui_cd_results_count(_fn_user integer, _d_filter_date date) RETURNS bigint
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
DECLARE
	_count bigint;
BEGIN

	WITH items as (
		select uir.f_route from core.cd_userinroutes as uir
		INNER JOIN core.cd_routes as r ON r.id = uir.f_route
		where uir.f_user = _fn_user and now()::date >= r.d_date_start and dbo.cf_old_date(r.d_date_end)
	)
	select count(*) into _count from core.cd_results as p
	where p.fn_route IN (select i.f_route from items as i) and p.b_disabled = false and p.d_date::date = _d_filter_date;
	
	RETURN _count;
END
$$;

ALTER FUNCTION core.cf_mui_cd_results_count(_fn_user integer, _d_filter_date date) OWNER TO mobnius;
