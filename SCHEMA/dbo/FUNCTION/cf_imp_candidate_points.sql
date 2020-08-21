CREATE OR REPLACE FUNCTION dbo.cf_imp_candidate_points(_user_id integer, _f_house uuid, _route_id uuid) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	_result integer;
	_sub_division integer;
BEGIN

	select f_subdivision into _sub_division from core.pd_users where id = _user_id;
	
	insert into core.cd_points(f_appartament, f_route, c_notice, c_info, jb_data, n_order, n_priority)
	select a.id, _route_id, 'auto', null, json_build_object('c_appartament_num', a.c_appartament, 
					  'n_appartament_num', a.n_appartament,
					 'c_address', concat(s.c_short_type, ' ', s.c_name),
					 'f_division', s.f_division,
					 'f_subdivision', h.f_subdivision,
					 'c_house_num', h.c_house_num,
					 'c_build_num', h.c_build_num,
					 'n_uik', h.n_uik,
					 'n_signature', a.n_signature,
					 'jb_food_kit', a.jb_food_kit,
				   'jb_other', a.jb_other,
				   'jb_er', a.jb_er,
				   'jb_budget', a.jb_budget)::jsonb, a.n_appartament,
				   (CASE WHEN a.jb_food_kit is not null THEN 1 
				   		WHEN a.jb_other is not null THEN 2
						WHEN a.jb_er is not null THEN 3
						WHEN a.jb_budget is not null THEN 4
						ELSE 5 END) as n_priority
	from dbo.msv_appartament as a
	inner join dbo.cs_house as h ON h.id = a.f_house
	inner join dbo.cs_street as s ON s.id = h.f_street
	where a.f_subdivision = _sub_division and a.f_house = _f_house;
	
	_result = (select count(*) from dbo.msv_appartament as a where a.f_subdivision = _sub_division and a.f_house = _f_house);
	RETURN _result;
END
$$;

ALTER FUNCTION dbo.cf_imp_candidate_points(_user_id integer, _f_house uuid, _route_id uuid) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_imp_candidate_points(_user_id integer, _f_house uuid, _route_id uuid) IS 'Импорт точек маршрута для кандидата';

--------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION dbo.cf_imp_candidate_points(_user_id integer, _f_house uuid, _route_id uuid, _appartament_start integer, _appartament_end integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	_result integer;
	_sub_division integer;
BEGIN

	select f_subdivision into _sub_division from core.pd_users where id = _user_id;
	
	insert into core.cd_points(f_appartament, f_route, c_notice, c_info, jb_data, n_order, n_priority)
	select a.id, _route_id, 'auto', null, json_build_object('c_appartament_num', a.c_appartament, 
					  'n_appartament_num', a.n_appartament,
					 'c_address', concat(s.c_short_type, ' ', s.c_name),
					 'f_division', s.f_division,
					 'f_subdivision', h.f_subdivision,
					 'c_house_num', h.c_house_num,
					 'c_build_num', h.c_build_num,
					 'n_uik', h.n_uik,
					 'n_signature', a.n_signature,
					 'jb_food_kit', a.jb_food_kit,
				   'jb_other', a.jb_other,
				   'jb_er', a.jb_er,
				   'jb_budget', a.jb_budget)::jsonb, a.n_appartament,
				   (CASE WHEN a.jb_food_kit is not null THEN 1 
				   		WHEN a.jb_other is not null THEN 2
						WHEN a.jb_er is not null THEN 3
						WHEN a.jb_budget is not null THEN 4
						ELSE 5 END) as n_priority
	from dbo.msv_appartament as a
	inner join dbo.cs_house as h ON h.id = a.f_house
	inner join dbo.cs_street as s ON s.id = h.f_street
	where a.f_subdivision = _sub_division and a.f_house = _f_house and a.n_appartament between _appartament_start and _appartament_end;
	
	_result = (select count(*) from dbo.msv_appartament as a where a.f_subdivision = _sub_division and a.f_house = _f_house and a.n_appartament between _appartament_start and _appartament_end);
	RETURN _result;
END
$$;

ALTER FUNCTION dbo.cf_imp_candidate_points(_user_id integer, _f_house uuid, _route_id uuid, _appartament_start integer, _appartament_end integer) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_imp_candidate_points(_user_id integer, _f_house uuid, _route_id uuid, _appartament_start integer, _appartament_end integer) IS 'Импорт определенных точек маршрута для кандидата';
