CREATE OR REPLACE FUNCTION dbo.cf_clearroute(_id uuid) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
	delete from core.cd_results
	where fn_route = _id;
	
	delete from core.cd_user_points
	where fn_route = _id;

	delete from core.cd_route_history
	where fn_route = _id and fn_status not IN (2,3);
	
	RETURN 0;
END
$$;

ALTER FUNCTION dbo.cf_clearroute(_id uuid) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_clearroute(_id uuid) IS 'Очистка маршрута';
