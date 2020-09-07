CREATE OR REPLACE FUNCTION dbo.cf_imp_update_points(_point_id uuid) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	_result integer;
	_sub_division integer;
	_f_appartament uuid;
	_jb_data jsonb;
BEGIN
	select f_appartament into _f_appartament from core.cd_points where id = _point_id;

	select json_build_object('c_appartament_num', a.c_number, 
							  'n_appartament_num', a.n_number,
							 'c_address', concat(s.c_short_type, ' ', s.c_name),
							 'f_division', s.f_division,
							 'f_subdivision', h.f_subdivision,
							 'c_house_num', h.c_house_num,
							 'c_build_num', h.c_build_num,
							 'n_uik', h.n_uik,
							 'n_signature', coalesce(a.n_signature_2018, 0),
							 'jb_food_kit', '[]',
						   'jb_other', '[]',
						   'jb_er', '[]',
						   'jb_budget', '[]')::jsonb into _jb_data
	from dbo.cs_appartament as a
	inner join dbo.cs_house as h ON h.id = a.f_house
	inner join dbo.cs_street as s ON s.id = h.f_street
	where a.id = _f_appartament;
	
	update core.cd_points as p
	set jb_data = _jb_data
	where p.id = _point_id;
	
	_result = 0;
	RETURN _result;
END
$$;

ALTER FUNCTION dbo.cf_imp_update_points(_point_id uuid) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_imp_update_points(_point_id uuid) IS 'Обновление информации в точек маршрута для кандидата';
