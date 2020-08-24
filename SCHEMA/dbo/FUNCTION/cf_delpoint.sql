CREATE OR REPLACE FUNCTION dbo.cf_delpoint(_point_id uuid) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
	delete from core.cd_results as t
	where t.fn_point = _point_id;
	
	delete from core.cd_user_points as t
	where t.fn_point = _point_id;
	
	delete from core.cd_points as t
	where t.id = _point_id;
	
	RETURN 0;
END
$$;

ALTER FUNCTION dbo.cf_delpoint(_point_id uuid) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_delpoint(_point_id uuid) IS 'Удаление точки из маршрута';
