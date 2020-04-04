CREATE OR REPLACE FUNCTION dbo.cf_imp_by_user(_user_id integer, _route_type_id integer, _date_activate date) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	_result integer;
	_route_id uuid;
	_route_number text;
BEGIN
	IF (select count(*) from dbo.cs_apartament where f_user = _user_id) > 0 THEN
		_route_id = uuid_generate_v4();
		_route_number = concat('M', _route_type_id, '-', _user_id, '-', date_part('month', now()), date_part('day', now()));
		
		-- создать маршрут
		insert into core.cd_routes(id, f_type, c_number, d_date, d_date_start, d_date_end, b_extended, c_notice, n_order)
		values (_route_id, _route_type_id, _route_number, now(), _date_activate, '2020-12-31', false, 'Создан автоматически', -1);

		-- привязать маршрут к пользователю
		insert into core.cd_userinroutes(f_route, f_user, b_main)
		values(_route_id, _user_id, true);

		-- добавить историю по маршруту
		insert into core.cd_route_history (fn_route, fn_status, fn_user, d_date) values
		(_route_id, 2, _user_id, now()),
		(_route_id, 3, _user_id, now());

		-- добавление точек в маршрут
		_result = (SELECT dbo.cf_imp_points(_user_id, _route_id));
	ELSE
		_result = 0;
	END IF;
	
	RETURN _result;
END
$$;

ALTER FUNCTION dbo.cf_imp_by_user(_user_id integer, _route_type_id integer, _date_activate date) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_imp_by_user(_user_id integer, _route_type_id integer, _date_activate date) IS 'Импорт данных для пользователя';
