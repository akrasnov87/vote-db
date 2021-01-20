CREATE OR REPLACE FUNCTION core.sf_hard_reset_route(_route_id uuid) RETURNS integer
    LANGUAGE plpgsql
    AS $$
/**
* @params {uuid} _route_id - идентификатор маршрута
* 
* @returns {integer} 0 - маршрут очищен
*/
BEGIN
	delete from dbo.ed_output_meter_readings
	where fn_route = _route_id;
	
	delete from dbo.ed_output_conn_seals
	where fn_route = _route_id;
	
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
	where fn_route = _route_id and fn_status not IN (2,3);
	
	delete from core.cd_points
	where f_route = _route_id and b_anomaly = true;
	
	RETURN 0;
END
$$;

ALTER FUNCTION core.sf_hard_reset_route(_route_id uuid) OWNER TO mobnius;

COMMENT ON FUNCTION core.sf_hard_reset_route(_route_id uuid) IS 'Сброс результатов прохождния маршрута. Системная функция, не применять на production';
