CREATE OR REPLACE FUNCTION dbo.cf_arm_filtration(_c_ps text = NULL::text, _c_line_ps text = NULL::text, _c_rp text = NULL::text, _c_line_rp text = NULL::text, _c_tp text = NULL::text, _c_line_tp text = NULL::text, _c_raion text = NULL::text, _c_city text = NULL::text, _c_settle text = NULL::text, _c_street text = NULL::text, _c_device_location text = NULL::text, _b_askue boolean = NULL::boolean, _c_askue text = NULL::text, _n_mpi smallint = NULL::smallint, _f_div integer = NULL::integer, _f_subdiv integer = NULL::integer, _n_registr_pts_type integer = NULL::integer, _c_registr_pts_name text = NULL::text, _f_consume_status integer = NULL::integer, _b_problem boolean = NULL::boolean, _b_violation boolean = NULL::boolean, _n_check_date integer = NULL::integer, _f_delivery integer = NULL::integer, _d_date_begin date = NULL::date, _d_date_end date = NULL::date, _n_absent_period integer = NULL::integer, _b_strong_check boolean = true, _f_event integer = NULL::integer) RETURNS TABLE(id uuid, c_filial text, c_pes text, c_res text, c_subscr_name text, c_subscr_code text, c_registr_pts text, c_status_registr_pts text, d_tu_close_date date, n_check_date integer, b_problem_person boolean, f_status_consume text, c_status_consume text, b_technical_metering boolean, c_status text, c_predictr text, c_serial_number text, c_device_type text, b_askue boolean, b_phase3 boolean, d_pu_setup_date date, d_close_date date, d_valid_date date, c_substation text, c_line_substation text, c_rp text, c_line_rp text, c_tp text, c_line_tp text, c_raion text, c_city_name text, c_settlement_name text, c_street_name text, c_house_name text, c_block_name text, c_flat_name text, n_geo_lat numeric, n_geo_lon numeric, c_comment_address text)
    LANGUAGE plpgsql
    AS $$
/*
  	Список возможных параметров:
 		_c_ps text default null, -- ПС
		_c_line_ps text default null, -- фидер от ПС
		_c_rp text default null, -- РП
		_c_line_rp text default null, -- фидер от РП
		_c_tp text default null, --ТП
		_c_line_tp text default null, -- фидер от ТП
		
		-- адрес
		_c_raion text default null, -- район
		_c_city text default null, -- город
		_c_settle text default null, -- населенный пункт
		_c_street text default null, -- улица
	
		-- ПУ
		_c_device_location text default null,
		_b_ASKUE bool default null,
		_c_ASKUE text default null,
		_n_mpi smallint default null,
	
		-- ТУ
		_f_div int default null, -- ссылка на отделение 37. Обязательно к заполнению
		_f_subdiv int default null, -- ссылка на участок 66. Обязательно к заполнению
		_n_registr_pts_type int default null, -- ЮЛ\ТУ\ФЛ
		_с_registr_pts_name text default null, -- наименование ТУ
		_f_consume_status int default null, -- сссылка на статус потребления
		_b_problem bool default null, -- признак проблемного абонента
		_b_violation bool default null, --наличие неисполненного предписания
		_n_check_date int default null, -- дата (день) обхода
	
		-- показания
		_f_delivery int default null, -- источник показаний
		_d_date_begin date default null, -- начало периода даты показаний
		_d_date_end date default null, -- окончание периода даты показаний
		_n_absent_period int default null, -- период (количество месяцев) с отсутствующими показаниями
		_b_strong_check bool default null, -- ищем строго заданное количество месяцев с отсутствующими показаниями (true) или более (false)
		_f_event int default null -- вид работ
		
	Пример запроса:
		select * from dbo.cf_arm_filtration(
			_f_div => 37,
			_f_subdiv => 66,
			_c_ps => 'руд')
*/
DECLARE
	_d_start_period date;
	_p_date_begin date = (now() - interval'3 year')::date; -- начало периода даты показаний. По умолчанию начальная дата годь назад
	_p_date_end date = now()::date; -- окончание периода даты показаний. По умолчанию текущая дата
BEGIN	
	-- проверка обязательных параметров
	if _f_div is null and _f_subdiv is null then
		raise exception 'Не заданы Филиал/РЭС';
	end if;

	if _d_date_begin is not null then _p_date_begin = _d_date_begin; end if;
	if _d_date_end is not null then _p_date_end = _d_date_end; end if;

		--  список ТУ заданной РЭС
	create temp table t_registr_pts (
		id uuid,
		c_registr_pts text,
		f_status_consume int,
		b_technical_metering bool,
		f_subscr uuid,
		f_address uuid,
		c_ps text,
		c_line_ps text,
		c_rp text,
		c_line_rp text,
		c_tp text,
		c_line_tp text,
		c_raion text,
		c_city_name text,
		c_settlement_name text,
		c_street_name text
	) on commit drop;
/*
	if _c_ps is not null then
		create index trgm_c_ps_idx ON t_registr_pts USING GIN (c_ps gin_trgm_ops);
	end if;
	if _c_line_ps is not null then
		create index trgm_c_line_ps_idx ON t_registr_pts USING GIN (c_line_ps gin_trgm_ops);
	end if;
	if _c_rp is not null then
		create index trgm_c_rp_idx ON t_registr_pts USING GIN (c_rp gin_trgm_ops);
	end if;
	if _c_line_rp is not null then
		create index trgm_c_line_rp_idx ON t_registr_pts USING GIN (c_line_rp gin_trgm_ops);
	end if;
	if _c_tp is not null then
		create index trgm_c_tp_idx ON t_registr_pts USING GIN (c_tp gin_trgm_ops);
	end if;
	if _c_line_tp is not null then
		create index trgm_c_line_tp_idx ON t_registr_pts USING GIN (c_line_tp gin_trgm_ops);
	end if;
	if _c_raion is not null then
		create index trgm_c_raion_idx ON t_registr_pts USING GIN (c_raion gin_trgm_ops);
	end if;
	if _c_city is not null then
		create index trgm_c_city_name_idx ON t_registr_pts USING GIN (c_city_name gin_trgm_ops);
	end if;
	if _c_settle is not null then
		create index trgm_c_settlement_name_idx ON t_registr_pts USING GIN (c_settlement_name gin_trgm_ops);
	end if;
	if _c_street is not null then
		create index trgm_c_street_name_idx ON t_registr_pts USING GIN (c_street_name gin_trgm_ops);
	end if;
*/
	insert into t_registr_pts(
		id,
		c_registr_pts,
		f_status_consume,
		b_technical_metering,
		f_subscr,
		f_address,
		c_ps,
		c_line_ps,
		c_rp,
		c_line_rp,
		c_tp,
		c_line_tp,
		c_raion,
		c_city_name,
		c_settlement_name,
		c_street_name
	)
	select 
		t.id,
		t.c_registr_pts,
		t.f_status_consume,
		t.b_technical_metering,
		t.f_subscr,
		t.f_address,
		t.c_substation as c_ps,
		t.c_line_substation as c_line_ps,
		t.c_rp,
		t.c_line_rp,
		t.c_tp,
		t.c_line_tp,
		sa.c_raion,
		sa.c_city_name,
		sa.c_settlement_name,
		sa.c_street_name
	from dbo.ed_registr_pts as t
		left join dbo.ss_address as sa
			on sa.id = t.f_address
	where t.f_division = _f_div
		and t.f_subdivision = _f_subdiv;
--/*
	-- далее отсекать все фильтры
	-- СЕТЬ
	if _c_ps is not null then
		delete from t_registr_pts t
		where coalesce(lower(t.c_ps), '') not like '%'||lower(_c_ps)||'%';
	end if;
	if _c_line_ps is not null then
		delete from t_registr_pts t 
		where coalesce(lower(t.c_line_ps), '') not like '%'||lower(_c_line_ps)||'%';
	end if;
	if _c_rp is not null then
		delete from t_registr_pts t 
		where coalesce(lower(t.c_rp), '') not like '%'||lower(_c_rp)||'%';
	end if;
	if _c_line_rp is not null then
		delete from t_registr_pts t 
		where coalesce(lower(t.c_line_rp), '') not like '%'||lower(_c_rp)||'%';
	end if;
	if _c_tp is not null then
		delete from t_registr_pts t 
		where coalesce(lower(t.c_tp), '') not like '%'||lower(_c_tp)||'%';
	end if;
	if _c_line_tp is not null then
		delete from t_registr_pts t 
		where coalesce(lower(t.c_line_tp), '') not like '%'||lower(_c_line_tp)||'%';
	end if;

	-- АДРЕСА
	if _c_raion is not null then
		delete from t_registr_pts t 
		where coalesce(lower(t.c_raion), '') not like '%'||lower(_c_raion)||'%';
	end if;
	if _c_city is not null then
		delete from t_registr_pts t 
		where coalesce(lower(t.c_city_name), '') not like '%'||lower(_c_city)||'%';
	end if;
	if _c_settle is not null then
		delete from t_registr_pts t 
		where coalesce(lower(t.c_settlement_name), '') not like '%'||lower(_c_settle)||'%';
	end if;
	if _c_street is not null then
		delete from t_registr_pts t 
		where coalesce(lower(t.c_street_name), '') not like '%'||lower(_c_street)||'%';
	end if;

	-- ПОКАЗАНИЯ
	if _f_delivery is not null then
		delete from t_registr_pts t
		where not exists (
			select 1 
			from dbo.ed_input_meter_readings eimr 
			where eimr.f_registr_pts = t.id
				and eimr.f_delivery_method = _f_delivery);
	end if;
--*/
--select count(*) into _n_cnt from t_registr_pts;
--raise notice '%', _n_cnt;

--	убираем ТУ, где нет показаний за указанный период
--/*
	if _d_date_begin is not null then
		delete from t_registr_pts t
		where not exists (
			select 1 
			from dbo.ed_input_meter_readings eimr 
			where eimr.f_registr_pts = t.id
				and eimr.d_date_prev between _p_date_begin and coalesce(_p_date_end, now()::date) );
	end if;
--*/			
	if _n_absent_period is not null then
		select now() - (_n_absent_period + case when _b_strong_check then 0 else 1 end) * interval'1 month'  into _d_start_period;
		-- убираем ТУ, где есть показания после даты _d_start_period
		delete from t_registr_pts t
		where exists (
			select 1 
			from dbo.ed_input_meter_readings eimr 
			where eimr.f_registr_pts = t.id
				and eimr.d_date_prev > _d_start_period);
	end if;

--select count(*) into _n_cnt from t_registr_pts;
--raise notice '%', _n_cnt;

	RETURN QUERY
	select 
		t.id,
		sd2.c_name as c_filial,
		sd.c_name as c_pes,
		ss2.c_name as c_res,
		
		case when ss.b_person then ss.c_name1 || ' ' || ss.c_name2 || ' ' || ss.c_name3 else ss.c_name1 end as c_subscr_name,
		ss.c_code as c_subscr_code,
		
		t.c_registr_pts,
		erp.c_status_registr_pts,
		erp.d_close_date as d_tu_close_date,
		ss.n_check_date,
		ss.b_problem_person,
		t.f_status_consume::text, -- привести справочник
		esc.c_name as c_status_consume,
		t.b_technical_metering,
		erp.c_status,
		erp.c_predictr,
		
		ed.c_serial_number,
		edt.c_name as c_device_type,
		coalesce(ed.b_askue, false) as b_askue,
		edt.b_phase3,
		ed.d_setup_date,
		ed.d_close_date as d_pu_close_date,
		ed.d_valid_date,

		t.c_ps,
		t.c_line_ps,
		t.c_rp,
		t.c_line_rp,
		t.c_tp,
		t.c_line_tp,
		t.c_raion,
		t.c_city_name,
		t.c_settlement_name,
		t.c_street_name,
		sa.c_house_name,
		sa.c_block_name,
		sa.c_flat_name,
		sa.n_geo_lat,
		sa.n_geo_lon,
		case 
			when sa.c_name is not null then '(Оригинальный адрес: '||sa.c_name ||') '
			else ''
		end || coalesce(sa.c_comment_address, '') as c_comment_address
	from t_registr_pts as t
		inner join dbo.ed_registr_pts as erp
			on erp.id = t.id
		inner join dbo.sd_subscr as ss
			on ss.id = erp.f_subscr 
		left join dbo.ss_address as sa
			on sa.id = t.f_address
		inner join dbo.ed_devices as ed
			left join dbo.es_device_types as edt 
				on edt.id = ed.f_device_type 
			on ed.f_registr_pts = t.id
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

ALTER FUNCTION dbo.cf_arm_filtration(_c_ps text, _c_line_ps text, _c_rp text, _c_line_rp text, _c_tp text, _c_line_tp text, _c_raion text, _c_city text, _c_settle text, _c_street text, _c_device_location text, _b_askue boolean, _c_askue text, _n_mpi smallint, _f_div integer, _f_subdiv integer, _n_registr_pts_type integer, _c_registr_pts_name text, _f_consume_status integer, _b_problem boolean, _b_violation boolean, _n_check_date integer, _f_delivery integer, _d_date_begin date, _d_date_end date, _n_absent_period integer, _b_strong_check boolean, _f_event integer) OWNER TO postgres;
