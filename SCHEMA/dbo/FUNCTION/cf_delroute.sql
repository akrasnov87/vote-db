CREATE OR REPLACE FUNCTION dbo.cf_delroute(_id uuid) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
	delete from core.cd_results
	where fn_route = _id;
	
	delete from core.cd_user_points
	where fn_route = _id;
	
	delete from core.cd_route_history
	where fn_route = _id;
	
	delete from core.cd_userinroutes
	where f_route = _id;
	
	delete from core.cd_points
	where f_route = _id;

	delete from core.cd_routes
	where id = _id;
	
	RETURN 0;
END
$$;

ALTER FUNCTION dbo.cf_delroute(_id uuid) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_delroute(_id uuid) IS 'Удаление маршрута';
