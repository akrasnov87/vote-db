CREATE OR REPLACE FUNCTION dbo.sf_generate_point_jb_data(_f_registr_pts uuid) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
/**
* @params {uuid} _f_registr_pts - идентификатор точки учета
*
* @returns {jsonb}
*
* @example
* [{ "action": "sf_generate_point_data", "method": "Query", "data": [{ "params": [_f_registr_pts] }], "type": "rpc", "tid": 0}]
*/
DECLARE
	_jb_data jsonb;
BEGIN
	IF (select count(*) from dbo.ed_registr_pts as rp where rp.id = _f_registr_pts) = 1 THEN
		select json_build_object(
							'c_address', ad.c_name, -- Адрес
							'b_person', s.b_person, -- true - Фил. лицо
							'b_technical_metering', rp.b_technical_metering, -- Признак технического учета
							'c_device_model', dt.c_name, -- Модель ПУ
							'c_device_number', d.c_serial_number, -- № ПУ
							'c_owner', CASE WHEN s.b_person THEN concat(s.c_name1, ' ', s.c_name2, ' ', s.c_name3) ELSE s.c_name1 END, -- ФИО
							'c_device_interval', '',
							'n_longitude', ad.n_geo_lon,
							'n_latitude', ad.n_geo_lat,
							'c_subscr', s.c_code,
							'c_telephone', s.c_telephone
							)::jsonb into _jb_data
		from dbo.ed_registr_pts as rp
		left join dbo.sd_subscr as s ON s.id = rp.f_subscr
		left join dbo.ss_address as ad ON ad.id = rp.f_address
		left join dbo.ed_devices as d ON d.f_registr_pts = rp.id
		left join dbo.es_device_types as dt ON dt.id = d.f_device_type
		where d.d_close_date is null and rp.id = _f_registr_pts;	
		
		RETURN _jb_data;
	ELSE
		RETURN null::jsonb;
	END IF;
END
$$;

ALTER FUNCTION dbo.sf_generate_point_jb_data(_f_registr_pts uuid) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.sf_generate_point_jb_data(_f_registr_pts uuid) IS 'Генерация JSON информации для точки учета';
