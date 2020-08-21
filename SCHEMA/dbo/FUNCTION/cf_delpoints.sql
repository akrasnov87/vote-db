CREATE OR REPLACE FUNCTION dbo.cf_delpoints(_route_id uuid, _appartament_start integer, _appartament_end integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
	delete from core.cd_results as t
	where t.fn_point IN (select id from core.cd_points as p where p.f_route = _route_id and p.n_order between _appartament_start and _appartament_end);
	
	delete from core.cd_user_points as t
	where t.fn_point IN (select id from core.cd_points as p where p.f_route = _route_id and p.n_order between _appartament_start and _appartament_end);
	
	delete from core.cd_points as t
	where t.id IN (select id from core.cd_points as p where p.f_route = _route_id and p.n_order between _appartament_start and _appartament_end);
	
	RETURN 0;
END
$$;

ALTER FUNCTION dbo.cf_delpoints(_route_id uuid, _appartament_start integer, _appartament_end integer) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_delpoints(_route_id uuid, _appartament_start integer, _appartament_end integer) IS 'Удаление точек из маршрута';
