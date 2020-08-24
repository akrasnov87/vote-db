CREATE OR REPLACE FUNCTION dbo.cf_imp_user_add_points(_user_id integer, _f_house uuid, _route_id uuid) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	_result integer;
BEGIN
	insert into core.cd_points(f_appartament, f_route, c_notice, c_info, jb_data, n_order, n_priority)
	select a.id, _route_id, 'auto append', null, json_build_object('c_appartament_num', a.c_number, 
							  'n_appartament_num', a.n_number,
							 'c_address', concat(s.c_short_type, ' ', s.c_name),
							 'f_division', s.f_division,
							 'f_subdivision', h.f_subdivision,
							 'c_house_num', h.c_house_num,
							 'c_build_num', h.c_build_num,
							 'n_uik', h.n_uik,
							 'n_signature', a.n_signature_2018,
							 'jb_food_kit', '[]',
						   'jb_other', '[]',
						   'jb_er', '[]',
						   'jb_budget', '[]')::jsonb, 
						   a.n_number,
						   0 as n_priority 
						from dbo.msv_appartament2 as a
	inner join dbo.cs_house as h ON h.id = a.f_house
	inner join dbo.cs_street as s ON s.id = h.f_street
	where a.f_house = _f_house and a.id not in (
	select p.f_appartament from core.cd_points as p
	where p.f_route = _route_id);

	_result = 0;
	RETURN _result;
END
$$;

ALTER FUNCTION dbo.cf_imp_user_add_points(_user_id integer, _f_house uuid, _route_id uuid) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_imp_user_add_points(_user_id integer, _f_house uuid, _route_id uuid) IS 'Добавление точек маршрута для агитаторов';
