CREATE OR REPLACE FUNCTION dbo.cf_arm_update_route(_f_route uuid, _registr_pts json, _b_delete boolean) RETURNS integer
    LANGUAGE plpgsql
    AS $$
/**
* @params {uuid} _f_route - маршрут
* @params {json} _registr_pts - идент-ры точек учета, передавать в виде строку иден-ров, например '[{"id": "40170afe-498d-4ff0-a1e7-9f29d470cf0a", "f_type": 1}, {"id": "16dc8d78-04db-45ac-ab02-2112000478c2", "f_type": 2}]'
* @params {boolean} _b_delete - нужно ли удалить указанные точки учета. true - да
*
* @returns
* 0 - OK
* 1 - нет маршрута
* 2 - точки учета не переданы
*
* @example
* [{ "action": "cf_arm_update_route", "method": "Query", "data": [{ "params": [_f_route, _registr_pts, _b_delete] }], "type": "rpc", "tid": 0}]
*/
BEGIN
	IF (select count(*) from core.cd_routes as r where r.id = _f_route) = 1 THEN
		IF (select count(*) from json_array_elements(_registr_pts)) > 0 THEN

			IF _b_delete THEN 
				delete from core.cd_points as p 
				where p.f_route = _f_route and p.f_registr_pts in (select (t.value #>> '{id}')::uuid from json_array_elements(_registr_pts) as t);
				
				RETURN 0;
			ELSE
				insert into core.cd_points (f_registr_pts, f_route, f_type, c_notice, c_info, jb_data, n_order, sn_delete)
				select (t.value #>> '{id}')::uuid, _f_route, (t.value #>> '{f_type}')::integer, null, dbo.sf_generate_point_info(rp.id), dbo.sf_generate_point_jb_data(rp.id), 1, false
				from json_array_elements(_registr_pts) as t
				inner join dbo.ed_registr_pts as rp ON rp.id = (t.value #>> '{id}')::uuid
				left join dbo.ss_address as ad ON ad.id = rp.f_address
				order by ad.c_name;

				RETURN 0;
			END IF;
		ELSE
			RETURN 2; -- точки не переданы
		END IF;
	ELSE
		RETURN 1; -- нет маршрута
	END IF;
END
$$;

ALTER FUNCTION dbo.cf_arm_update_route(_f_route uuid, _registr_pts json, _b_delete boolean) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_arm_update_route(_f_route uuid, _registr_pts json, _b_delete boolean) IS 'Обновление точек маршрута на основе точек учета';
