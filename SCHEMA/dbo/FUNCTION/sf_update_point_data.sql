CREATE OR REPLACE FUNCTION dbo.sf_update_point_data(_f_point uuid) RETURNS integer
    LANGUAGE plpgsql
    AS $$
/**
* @params {uuid} _f_point - идентификатор точки маршрута
*
* @returns
* 0 - OK
* 1 - нет точки маршрута
*
* @example
* [{ "action": "sf_update_point_jb_data", "method": "Query", "data": [{ "params": [_f_point] }], "type": "rpc", "tid": 0}]
*/
DECLARE
	_f_registr_pts uuid;
BEGIN
	IF (select count(*) from core.cd_points as p where p.id = _f_point) = 1 THEN
		select p.f_registr_pts into _f_registr_pts from core.cd_points as p where p.id = _f_point;
	
		update core.cd_points as p
		set jb_data = dbo.sf_generate_point_jb_data(_f_registr_pts),
		c_info = dbo.sf_generate_point_info(_f_registr_pts)
		where p.id = _f_point;
		
		RETURN 0;
	ELSE
		RETURN 1; -- нет точки маршрута
	END IF;
END
$$;

ALTER FUNCTION dbo.sf_update_point_data(_f_point uuid) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.sf_update_point_data(_f_point uuid) IS 'Обновление JSON и общей информации у точки маршрута';
