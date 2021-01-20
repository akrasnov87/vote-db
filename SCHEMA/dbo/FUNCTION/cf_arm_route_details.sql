CREATE OR REPLACE FUNCTION dbo.cf_arm_route_details(_f_route uuid) RETURNS TABLE(id uuid, f_registr_pts uuid, f_point_type integer, c_point_type_name text, c_filial text, c_pes text, c_res text, c_subscr_name text, c_subscr_code text, c_registr_pts text, c_status_registr_pts text, d_tu_close_date date, n_check_date integer, b_problem_person boolean, f_status_consume text, c_status_consume text, b_technical_metering boolean, c_status text, c_predictr text, c_serial_number text, c_device_type text, b_askue boolean, b_phase3 boolean, d_pu_setup_date date, d_close_date date, d_valid_date date, c_substation text, c_line_substation text, c_rp text, c_line_rp text, c_tp text, c_line_tp text, c_raion text, c_city_name text, c_settlement_name text, c_street_name text, c_house_name text, c_block_name text, c_flat_name text, n_geo_lat numeric, n_geo_lon numeric, c_comment_address text)
    LANGUAGE plpgsql
    AS $$
BEGIN	
	create temp table t_keys (
		id uuid,
		f_registr_pts uuid,
 		f_point_type int,
 		c_point_name text
	) on commit drop;

	insert into t_keys(
		id,
		f_registr_pts,
 		f_point_type,
 		c_point_name
	)
	select 
		cp.id,
		rp.id as f_registr_pts,
		cp.f_type as f_point_type,
		cpt.c_name as c_point_name
	from core.cd_points as cp 
		inner join dbo.ed_registr_pts as rp
			on rp.id = cp.f_registr_pts
		left join core.cs_point_types as cpt 
			on cpt.id = cp.f_type 
	where cp.f_route = _f_route; --'a499211a-2714-4552-a45c-45ac8959c7a1'

	RETURN QUERY
	select 
		t.id,
		t.f_registr_pts,
		t.f_point_type,
		t.c_point_name,
		sd2.c_name as c_filial,
		sd.c_name as c_pes,
		ss2.c_name as c_res,
		
		case when ss.b_person then ss.c_name1 || ' ' || ss.c_name2 || ' ' || ss.c_name3 else ss.c_name1 end as c_subscr_name,
		ss.c_code as c_subscr_code,
		
		erp.c_registr_pts,
		erp.c_status_registr_pts,
		erp.d_close_date as d_tu_close_date,
		ss.n_check_date,
		ss.b_problem_person,
		erp.f_status_consume::text, -- привести справочник
		esc.c_name as c_status_consume,
		erp.b_technical_metering,
		erp.c_status,
		erp.c_predictr,
		
		ed.c_serial_number,
		edt.c_name as c_device_type,
		coalesce(ed.b_askue, false) as b_askue,
		edt.b_phase3,
		ed.d_setup_date,
		ed.d_close_date as d_pu_close_date,
		ed.d_valid_date,

		erp.c_substation ,
		erp.c_line_substation ,
		erp.c_rp,
		erp.c_line_rp,
		erp.c_tp,
		erp.c_line_tp,
		sa.c_raion,
		sa.c_city_name,
		sa.c_settlement_name,
		sa.c_street_name,
		sa.c_house_name,
		sa.c_block_name,
		sa.c_flat_name,
		sa.n_geo_lat,
		sa.n_geo_lon,
		sa.c_comment_address
	from t_keys as t
		inner join dbo.ed_registr_pts as erp
			on erp.id = t.f_registr_pts
		inner join dbo.sd_subscr as ss
			on ss.id = erp.f_subscr 
		inner join dbo.ss_address as sa
			on sa.id = erp.f_address
		inner join dbo.ed_devices as ed
			left join dbo.es_device_types as edt 
				on edt.id = ed.f_device_type 
			on ed.f_registr_pts = t.f_registr_pts
			and ed.d_close_date is null
		left join core.sd_divisions sd
			left join core.sd_divisions as sd2 
				on sd2.id = sd.f_division 
			on sd.id = erp.f_division
		left join core.sd_subdivisions as ss2 
			on ss2.id = erp.f_subdivision
		left join dbo.es_status_consume as esc
			on esc.id = coalesce(erp.f_status_consume, 2);

END
$$;

ALTER FUNCTION dbo.cf_arm_route_details(_f_route uuid) OWNER TO postgres;
