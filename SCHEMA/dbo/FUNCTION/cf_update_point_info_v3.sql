CREATE OR REPLACE FUNCTION dbo.cf_update_point_info_v3(_point_id uuid) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	_c_info text;
	_f_appartament uuid;
	_c_peoples text;
	_jb_data jsonb;
BEGIN
	select p.f_appartament into _f_appartament from core.cd_points as p
	where p.id = _point_id;

	select string_agg(concat(' - ', p.c_first_name, ' ', p.c_last_name, ' ', p.c_patronymic), '<br />') into _c_info from dbo.cd_people as p
	where p.f_type = 7 and p.f_appartament = _f_appartament;

	select string_agg(concat(p.c_first_name, ' ', p.c_last_name, ' ', p.c_patronymic), ', ') into _c_peoples 
	from dbo.cd_people as p
	where p.f_type = 7 and p.f_appartament = _f_appartament;

	select json_build_object('c_appartament_num', a.c_number, 
					  'n_appartament_num', a.n_number,
					 'c_address', concat(s.c_short_type, ' ', s.c_name),
					 'f_division', s.f_division,
					 'f_subdivision', h.f_subdivision,
					 'c_house_num', h.c_house_num,
					 'c_build_num', h.c_build_num,
					 'n_uik', h.n_uik,
					 'n_signature', coalesce(a.n_signature_2018, 0),
					 'c_peoples', _c_peoples)::jsonb into _jb_data 
	from dbo.msv_appartament3 as a
	inner join dbo.cs_house as h ON h.id = a.f_house
	inner join dbo.cs_street as s ON s.id = h.f_street
	where a.id = _f_appartament;

	update core.cd_points as p
	set c_info = concat('<p><b>Подпись за Николаева</b>:<br />', _c_info, '</p>'),
	jb_data = _jb_data
	where p.id = _point_id;
	
	RETURN 0;
END
$$;

ALTER FUNCTION dbo.cf_update_point_info_v3(_point_id uuid) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_update_point_info_v3(_point_id uuid) IS 'Обновление информации в точке маршрута для 3 волны';
