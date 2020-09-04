CREATE OR REPLACE FUNCTION dbo.cf_finishroute(_id uuid) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
	update core.cd_routes as r
	set d_date_end = now()::date - interval '1 day' 
	where r.id = _id;
	
	insert into core.cd_route_history(fn_route, fn_status, fn_user, d_date, c_notice, dx_created)
	values(_id, 6, 1, now(), 'Завершено принудительно', now());
	
	RETURN 0;
END
$$;

ALTER FUNCTION dbo.cf_finishroute(_id uuid) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_finishroute(_id uuid) IS 'Завершение маршрута';
