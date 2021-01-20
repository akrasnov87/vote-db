CREATE OR REPLACE FUNCTION dbo.sf_generate_meter_reading(_f_result uuid) RETURNS integer
    LANGUAGE plpgsql
    AS $$
/**
* Выполняется только после установки предыдущих показаний в d_replace_date
*
* @params {uuid} _f_result - результат с актом замены ПУ
*
* @returns {integer} 0 - запись создана
*
* @example
* [{ "action": "sf_generate_meter_reading", "method": "Query", "data": [{ "params": [_f_result] }], "type": "rpc", "tid": 0}]
*/
DECLARE
	_n_count_scale integer; -- количество шкал по тарифу
	_c_result_type text; -- тип создаваемого результата
	_f_registr_pts uuid; -- точка учета
	_meters json; -- показания
BEGIN
	-- нужно определить количество шкал для обработки
	select tz.n_count_scale, rt.c_const, p.f_registr_pts into _n_count_scale, _c_result_type, _f_registr_pts 
	from core.cd_results as r
	inner join core.cd_points as p ON p.id = r.fn_point
	inner join core.cs_result_types as rt ON rt.id = r.fn_type
	inner join dbo.es_tariff_zones as tz ON tz.id = (r.jb_data #>> '{f_tariff_zone}')::integer
	where r.id = _f_result;
	
	IF _c_result_type = 'AZPU' OR _c_result_type = 'ADEPU' THEN
		IF _n_count_scale = 1 THEN -- Сутки
		
			select array_to_json(array_agg(row_to_json(t))) into _meters
			from (
				select (r.jb_data #>> '{n_scale1}')::numeric as n_scale, r.d_date, dt.n_digits, (select id from dbo.es_scales where c_const = 'TFZ_Day') as f_scale, _f_registr_pts as f_registr_pts, (r.jb_data #>> '{f_tariff_zone}')::integer as f_tariff_zone, 1 as f_energy_type, 2 as f_delivery_method
				from core.cd_results as r
				inner join core.cs_result_types as rt ON rt.id = r.fn_type
				inner join dbo.es_device_types as dt ON dt.id = (r.jb_data #>> '{f_device_model}')::integer
				where r.id = _f_result
			) as t;
			
		ELSIF _n_count_scale = 2 THEN -- День, Ночь
		
			select array_to_json(array_agg(row_to_json(t))) into _meters
			from (
				select (r.jb_data #>> '{n_scale1}')::numeric as n_scale, r.d_date, dt.n_digits, (select id from dbo.es_scales where c_const = 'TFZ_DayTime') as f_scale, _f_registr_pts as f_registr_pts, (r.jb_data #>> '{f_tariff_zone}')::integer as f_tariff_zone, 1 as f_energy_type, 2 as f_delivery_method
				from core.cd_results as r
				inner join core.cs_result_types as rt ON rt.id = r.fn_type
				inner join dbo.es_device_types as dt ON dt.id = (r.jb_data #>> '{f_device_model}')::integer
				where r.id = _f_result
				UNION ALL
				select (r.jb_data #>> '{n_scale2}')::numeric as n_scale, r.d_date, dt.n_digits, (select id from dbo.es_scales where c_const = 'TFZ_Nigth') as f_scale, _f_registr_pts as f_registr_pts, (r.jb_data #>> '{f_tariff_zone}')::integer as f_tariff_zone, 1 as f_energy_type, 2 as f_delivery_method
				from core.cd_results as r
				inner join core.cs_result_types as rt ON rt.id = r.fn_type
				inner join dbo.es_device_types as dt ON dt.id = (r.jb_data #>> '{f_device_model}')::integer
				where r.id = _f_result
			) as t;
			
		ELSIF _n_count_scale = 3 THEN -- Ночь, Пик, Полупик
		
			select array_to_json(array_agg(row_to_json(t))) into _meters
			from (
				select (r.jb_data #>> '{n_scale1}')::numeric as n_scale, r.d_date, dt.n_digits, (select id from dbo.es_scales where c_const = 'TFZ_Nigth') as f_scale, _f_registr_pts as f_registr_pts, (r.jb_data #>> '{f_tariff_zone}')::integer as f_tariff_zone, 1 as f_energy_type, 2 as f_delivery_method
				from core.cd_results as r
				inner join core.cs_result_types as rt ON rt.id = r.fn_type
				inner join dbo.es_device_types as dt ON dt.id = (r.jb_data #>> '{f_device_model}')::integer
				where r.id = _f_result
				UNION ALL
				select (r.jb_data #>> '{n_scale2}')::numeric as n_scale, r.d_date, dt.n_digits, (select id from dbo.es_scales where c_const = 'TFZ_Peak') as f_scale, _f_registr_pts as f_registr_pts, (r.jb_data #>> '{f_tariff_zone}')::integer as f_tariff_zone, 1 as f_energy_type, 2 as f_delivery_method
				from core.cd_results as r
				inner join core.cs_result_types as rt ON rt.id = r.fn_type
				inner join dbo.es_device_types as dt ON dt.id = (r.jb_data #>> '{f_device_model}')::integer
				where r.id = _f_result
				UNION ALL
				select (r.jb_data #>> '{n_scale3}')::numeric as n_scale, r.d_date, dt.n_digits, (select id from dbo.es_scales where c_const = 'TFZ_SemiPeak') as f_scale, _f_registr_pts as f_registr_pts, (r.jb_data #>> '{f_tariff_zone}')::integer as f_tariff_zone, 1 as f_energy_type, 2 as f_delivery_method
				from core.cd_results as r
				inner join core.cs_result_types as rt ON rt.id = r.fn_type
				inner join dbo.es_device_types as dt ON dt.id = (r.jb_data #>> '{f_device_model}')::integer
				where r.id = _f_result
			) as t;
			
		ELSE
			RETURN 2; -- не удалось определить количество шкал
		END IF;
		
		--raise notice '%', _meters;
		
		-- добавляем показания
		INSERT INTO dbo.ed_input_meter_readings(n_value_prev, d_date_prev, n_digit, f_scale, f_registr_pts, f_tariff_zone, f_energy_type, f_delivery_method)
		select (t.value #>> '{n_scale}')::numeric, (t.value #>> '{d_date}')::timestamp with time zone, (t.value #>> '{n_digits}')::numeric, (t.value #>> '{f_scale}')::integer, (t.value #>> '{f_registr_pts}')::uuid, (t.value #>> '{f_tariff_zone}')::integer, (t.value #>> '{f_energy_type}')::integer, (t.value #>> '{f_delivery_method}')::integer
		from json_array_elements(_meters::json) as t;
		
	ELSE
		RETURN 1; -- результат не является актом замены ПУ
	END IF;
	
	RETURN 0;
END
$$;

ALTER FUNCTION dbo.sf_generate_meter_reading(_f_result uuid) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.sf_generate_meter_reading(_f_result uuid) IS 'Создание показаний для акта замены ПУ';
