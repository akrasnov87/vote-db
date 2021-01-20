CREATE OR REPLACE FUNCTION core.sf_del_route(_route_id uuid) RETURNS integer
    LANGUAGE plpgsql
    AS $$
/**
* @params {uuid} _route_id - идентификатор маршрута
* 
* @returns {integer} 0 - маршрут удален, 1 - ошибка при удалении
*/
DECLARE
	_result integer;
BEGIN	
	delete from core.cd_files
	where id IN (select fn_file from core.cd_attachments
	where fn_route = _route_id);
	
	delete from core.cd_attachments
	where fn_route = _route_id;

	delete from core.cd_results
	where fn_route = _route_id;
	
	delete from core.cd_user_points
	where fn_route = _route_id;

	delete from core.cd_route_history
	where fn_route = _route_id;
	
	delete from core.cd_userinroutes
	where f_route = _route_id;
	
	delete from dbo.ed_output_meter_readings
	where fn_route = _route_id;	
	
	delete from core.cd_points
	where f_route = _route_id;

	delete from core.cd_routes
	where id = _route_id;
	
  	RETURN 0;
END
$$;

ALTER FUNCTION core.sf_del_route(_route_id uuid) OWNER TO mobnius;

COMMENT ON FUNCTION core.sf_del_route(_route_id uuid) IS 'Окончательное удаление маршрута без сохранения истории';
