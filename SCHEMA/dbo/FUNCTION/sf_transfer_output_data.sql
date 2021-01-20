CREATE OR REPLACE FUNCTION dbo.sf_transfer_output_data() RETURNS integer
    LANGUAGE plpgsql
    AS $$
/**
* @returns {integer}
* 0 - ОК
*
* @example
* [{ "action": "sf_transfer_output_data", "method": "Query", "data": [{ "params": [] }], "type": "rpc", "tid": 0}]
*/
BEGIN

	-- обработка показаний
	IF (select count(*) from dbo.ed_output_meter_readings where b_export = false) > 0 THEN
		-- нужно перенести новые показаний в input
		INSERT INTO dbo.ed_input_meter_readings(id, n_value_prev, d_date_prev, n_digit, f_scale, dx_created, f_registr_pts, f_tariff_zone, f_energy_type, f_delivery_method, d_replace_date)
		select omr.id, omr.n_value, omr.d_date, imr.n_digit, imr.f_scale, now(), imr.f_registr_pts, imr.f_tariff_zone, imr.f_energy_type, imr.f_delivery_method, null
		from dbo.ed_output_meter_readings as omr
		inner join dbo.ed_input_meter_readings as imr ON omr.fn_meter_reading = imr.id
		where omr.b_export = false;
		
		-- устанавливаем признак замены показания
		update dbo.ed_input_meter_readings as imr
		set d_replace_date = t1.d_date
		from (
			select imr.id, omr.d_date from dbo.ed_output_meter_readings as omr
			inner join dbo.ed_input_meter_readings as imr ON omr.fn_meter_reading = imr.id
			where omr.b_export = false
		) as t1
		where imr.id = t1.id;
		
		-- указываем, что данные обработали
		update dbo.ed_output_meter_readings
		set b_export = true
		where b_export = false;
	END IF;

	-- обработка пломб
	IF (select count(*) from dbo.ed_output_conn_seals where b_export = false) > 0 THEN
		-- нужно обновить информацию по пломбам, которые ранее были выданы и использованы
		update dbo.ed_seals as s
		set f_registr_pts = t1.f_registr_pts,
		c_type = t1.c_type,
		c_location = t1.c_location,
		f_type = t1.f_type,
		f_place = t1.f_place,
		f_output_conn_seal = t1.f_output_conn_seal
		from (
			select ocs.fn_seal_new, p.f_registr_pts, st.c_name as c_type, st.id as f_type, sp.c_name as c_location, sp.id as f_place, ocs.id as f_output_conn_seal
			from dbo.ed_output_conn_seals as ocs
			inner join dbo.es_seal_types as st ON st.id = ocs.fn_type
			inner join dbo.es_seal_places as sp ON sp.id = ocs.fn_place
			inner join dbo.ed_seals as es ON es.id = ocs.fn_seal_new
			inner join core.cd_points as p ON p.id = ocs.fn_point
			where ocs.b_export = false
		) as t1
		where s.id = t1.fn_seal_new;
		
		-- отключаем пломбы, которые были заменены
		update dbo.ed_seals as s
		set d_replace_date = t1.d_date
		from (
			select es.id, ocs.d_date from dbo.ed_output_conn_seals as ocs
			inner join dbo.ed_seals as es ON es.id = ocs.fn_seal
			where ocs.b_export = false
		) as t1
		where s.id = t1.id;
		
		-- указываем, что данные обработали
		update dbo.ed_output_conn_seals
		set b_export = true
		where b_export = false;
	END IF;

	-- обработка трансформаторов
	IF (select count(*) from dbo.ed_output_transformers where b_export = false) > 0 THEN
		-- находим созданные трансформаторы и добавляем их общий список
		INSERT INTO dbo.ed_transformers(id, f_registr_pts, b_voltage, c_serial_number, d_replace_before, f_device_type, c_phase, imp_int, n_manufacture_year, d_check_date, d_replace_date, imp_text, n_rate)
		select ot.id, p.f_registr_pts, ot.b_voltage, ot.c_number, ot.d_date + (dt.n_check_cycle || ' year')::interval, dt.id, ph.c_name, null, ot.n_year, ot.d_date_check, null, null, ot.n_rate
		FROM dbo.ed_output_transformers as ot
		inner join dbo.es_phase as ph ON ph.id = ot.fn_phase
		inner join core.cd_points as p ON p.id = ot.fn_point
		inner join dbo.es_device_types as dt ON dt.id = ot.fn_device_type
		where ot.b_export = false;
		
		-- отключаем трансформаторы, которые были заменены
		update dbo.ed_transformers as t
		set d_replace_date = t1.d_date
		from (
			select tr.id, ot.d_date from dbo.ed_output_transformers as ot
			inner join dbo.ed_transformers as tr ON tr.id = ot.fn_transformer
			where ot.b_export = false
		) as t1
		where t.id = t1.id;
		
		-- указываем, что данные обработали
		update dbo.ed_output_transformers
		set b_export = true
		where b_export = false;
	END IF;
	
	-- обновление номера телефона
	IF (select count(*) from core.cd_user_points where b_export = false) > 0 THEN
		-- обновляем номера
		update dbo.sd_subscr as s
		set c_telephone = t1.c_telephone,
		jb_history = dbo.sf_update_jb_history(CASE WHEN jb_history is null THEN '[]'::json ELSE jb_history END, json_build_object('c_telephone', s.c_telephone,
													   'fn_user_point', t1.fn_user_point,
													   'dx_created', now()))
		from (
			select up.c_telephone, rp.f_subscr, up.id as fn_user_point 
			from core.cd_user_points as up
			inner join core.cd_points as p ON p.id = up.fn_point
			inner join dbo.ed_registr_pts as rp ON rp.id = p.f_registr_pts
			inner join dbo.sd_subscr as s ON s.id = rp.f_subscr
			where up.b_export = false and (up.c_telephone != s.c_telephone or s.c_telephone is null)
		) as t1
		where s.id = t1.f_subscr;
		
		-- проверяем есть ли задания по замене ПУ и отключаем старое ПУ
		update dbo.ed_devices as d
		set d_close_date = now()::date
		from (
			select p.f_registr_pts, r.jb_data from core.cd_user_points as up
			inner join core.cd_points as p ON p.id = up.fn_point
			inner join core.cd_results as r ON r.fn_user_point = up.id
			inner join core.cs_result_types as rt ON rt.id = r.fn_type
			where up.b_export = false and (rt.c_const = 'AZPU' or rt.c_const = 'ADEPU')
		) as t
		where d.f_registr_pts = t.f_registr_pts and d.d_close_date is null;
		
		-- устанавливаем новый ПУ
		insert into dbo.ed_devices(f_device_type, c_serial_number, n_rate, n_manufacture_year, d_setup_date, d_valid_date, f_device_location, f_registr_pts)
		select (r.jb_data #>> '{f_device_model}')::integer, (r.jb_data #>> '{c_device_number}'), (r.jb_data #>> '{n_rate}')::numeric, (r.jb_data #>> '{n_year}')::integer, up.d_date::date, (r.jb_data #>> '{d_check_date}')::date, (r.jb_data #>> '{f_device_location}')::integer, p.f_registr_pts
		from core.cd_user_points as up
		inner join core.cd_points as p ON p.id = up.fn_point
		inner join core.cd_results as r ON r.fn_user_point = up.id
		inner join core.cs_result_types as rt ON rt.id = r.fn_type
		where up.b_export = false and (rt.c_const = 'AZPU' or rt.c_const = 'ADEPU');
		
		-- отключаем старые показания
		update dbo.ed_input_meter_readings as imr
		set d_replace_date = t.d_date
		from (
			select p.f_registr_pts, up.d_date
			from core.cd_user_points as up
			inner join core.cd_points as p ON p.id = up.fn_point
			inner join core.cd_results as r ON r.fn_user_point = up.id
			inner join core.cs_result_types as rt ON rt.id = r.fn_type
			where up.b_export = false and (rt.c_const = 'AZPU' or rt.c_const = 'ADEPU')
		) as t
		where imr.f_registr_pts = t.f_registr_pts and imr.d_replace_date is null;
		
		-- создаем показания
		perform dbo.sf_generate_meter_reading(r.id) 
		from core.cd_user_points as up
		inner join core.cd_results as r ON r.fn_user_point = up.id
		inner join core.cs_result_types as rt ON rt.id = r.fn_type
		where up.b_export = false and (rt.c_const = 'AZPU' or rt.c_const = 'ADEPU');
		
		-- указываем, что данные обработали
		update core.cd_user_points
		set b_export = true
		where b_export = false;
	END IF;
	
	RETURN 0;
END
$$;

ALTER FUNCTION dbo.sf_transfer_output_data() OWNER TO mobnius;

COMMENT ON FUNCTION dbo.sf_transfer_output_data() IS 'Обработка выходных данных';
