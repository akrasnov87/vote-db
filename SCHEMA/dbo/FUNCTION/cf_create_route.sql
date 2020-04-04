CREATE OR REPLACE FUNCTION dbo.cf_create_route(_f_house uuid, _user_id integer, _route_type_id integer, _date_activate date) RETURNS uuid
    LANGUAGE plpgsql
    AS $$
DECLARE
	_result integer;
	_route_id uuid;
	_route_number text;
BEGIN
	_route_id = uuid_generate_v4();
	select concat(s.c_name, ' ', h.c_number) into _route_number from dbo.cs_house as h
	inner join dbo.cs_street as s ON h.f_street = s.id
	where h.id = _f_house;
	
	-- создать маршрут
	insert into core.cd_routes(id, f_type, c_number, d_date, d_date_start, d_date_end, b_extended, c_notice, n_order)
	values (_route_id, _route_type_id, _route_number, now(), _date_activate, '2020-12-31', false, concat('M', _route_type_id, '-', _user_id, '-', date_part('month', now()), date_part('day', now())), -1);

	-- привязать маршрут к пользователю
	insert into core.cd_userinroutes(f_route, f_user, b_main)
	values(_route_id, _user_id, true);

	-- добавить историю по маршруту
	insert into core.cd_route_history (fn_route, fn_status, fn_user, d_date) values
	(_route_id, 2, _user_id, now()),
	(_route_id, 3, _user_id, now());
	
	RETURN _route_id;
END
$$;

ALTER FUNCTION dbo.cf_create_route(_f_house uuid, _user_id integer, _route_type_id integer, _date_activate date) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_create_route(_f_house uuid, _user_id integer, _route_type_id integer, _date_activate date) IS 'Создание маршрута';
