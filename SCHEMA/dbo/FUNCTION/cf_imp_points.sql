CREATE OR REPLACE FUNCTION dbo.cf_imp_points(_user_id integer, _f_house uuid, _route_id uuid) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	_result integer;
BEGIN
	-- _route_id = uuid_generate_v4();
	
	insert into core.cd_points(f_appartament, f_route, c_notice, c_info, jb_data, n_order)
	select a.id, _route_id, 'auto', null, 
	json_build_object('c_appartament_num', a.c_number, 
					  'n_appartament_num', a.n_number,
					 'c_address', concat(s.c_short_type, ' ', s.c_name),
					 'f_division', s.f_division,
					 'f_subdivision', h.f_subdivision,
					 'c_house_num', h.c_house_num,
					 'c_build_num', h.c_build_num,
					 'n_uik', h.n_uik,
					 'n_signature_2018', a.n_signature_2018)::jsonb, a.n_number 
	from dbo.cs_appartament as a
	inner join dbo.cs_house as h ON h.id = a.f_house
	inner join dbo.cs_street as s ON s.id = h.f_street
	where f_main_user = _user_id and f_house = _f_house;
	
	_result = (select count(*) from dbo.cs_appartament where f_main_user = _user_id and f_house = _f_house);
	RETURN _result;
END
$$;

ALTER FUNCTION dbo.cf_imp_points(_user_id integer, _f_house uuid, _route_id uuid) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_imp_points(_user_id integer, _f_house uuid, _route_id uuid) IS 'Импорт точек маршрута';
