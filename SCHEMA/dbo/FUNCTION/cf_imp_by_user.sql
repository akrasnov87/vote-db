CREATE OR REPLACE FUNCTION dbo.cf_imp_by_user(_user_id integer, _route_type_id integer, _date_activate date, _date_limit date) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	_result integer;
	_route_number text;
BEGIN
	IF (select count(*) from dbo.msv_appartament2 where f_main_user = _user_id and b_disabled = false) > 0 THEN
		_result = ( select 
						sum((SELECT dbo.cf_imp_points(_user_id, t.f_house, t.route_id)))
					from (select 
								f_house, 
								f_main_user,
								(SELECT dbo.cf_create_route(f_house, _user_id, _route_type_id, _date_activate, _date_limit)) as route_id
							from dbo.msv_appartament2
							where f_main_user = _user_id and b_disabled = false
							group by f_house, f_main_user) as t);
	ELSE
		_result = 0;
	END IF;
	
	RETURN _result;
END
$$;

ALTER FUNCTION dbo.cf_imp_by_user(_user_id integer, _route_type_id integer, _date_activate date, _date_limit date) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_imp_by_user(_user_id integer, _route_type_id integer, _date_activate date, _date_limit date) IS 'Импорт данных для пользователя';
