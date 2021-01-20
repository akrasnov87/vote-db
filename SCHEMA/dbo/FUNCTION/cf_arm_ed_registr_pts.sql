CREATE OR REPLACE FUNCTION dbo.cf_arm_ed_registr_pts() RETURNS TABLE(id uuid, c_address text, n_longitude numeric, n_latitude numeric, f_division integer, c_division text, f_subdivision integer, c_subdivision text, c_device_number text, c_subscr text, c_owner text, d_meter_date date, c_network_item text, c_network_type text, f_device_type integer, c_device_type text, b_meter_exists boolean, b_disabled boolean)
    LANGUAGE plpgsql
    AS $$
/**
* @example 
* [{ "action": "cf_arm_ed_registr_pts", "method": "Select", "data": [{ }], "type": "rpc", "tid": 0 }]
*
* @todo 
* колонка b_meter_exists - возвращается доступность показания, для снятия показаний точка валидна
*/
BEGIN
	RETURN QUERY
	select 
		rp.id, 
		rp.c_address, 
		ad.n_geo_lon, 
		ad.n_geo_lat, 
		rp.f_division, 
		d.c_name, 
		rp.f_subdivision, 
		sd.c_name, 
		rp.c_device_number, 
		rp.c_subscr, 
		rp.c_owner, 
		rp.d_meter_date, 
		rp.c_network_item, 
		rp.c_network_type, 
		rp.f_device_type, 
		dt.c_name, 
		(select count(*) from dbo.ed_output_meter_readings as omr
		inner join dbo.ed_input_meter_readings as imr ON imr.id = omr.fn_meter_reading
		where imr.f_registr_pts = rp.id) > 0, 
		rp.b_disabled 
	from dbo.ed_registr_pts as rp
	left join dbo.ss_address as ad ON ad.id = rp.f_address
	inner join core.sd_divisions as d ON rp.f_division = d.id
	inner join core.sd_subdivisions as sd ON rp.f_subdivision = sd.id
	inner join dbo.es_device_types as dt ON rp.f_device_type = dt.id;
END
$$;

ALTER FUNCTION dbo.cf_arm_ed_registr_pts() OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_arm_ed_registr_pts() IS 'Этап "Планирование": получение списка точек учета';
