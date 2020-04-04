CREATE OR REPLACE FUNCTION dbo.cf_imp_by_user(_user_id integer, _route_type_id integer, _date_activate date) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	_result integer;
	_route_number text;
BEGIN
	IF (select count(*) from dbo.cs_apartament where f_user = _user_id) > 0 THEN
		_result = ( select 
						sum((SELECT dbo.cf_imp_points(_user_id, t.f_house, t.route_id)))
					from (select 
								f_house, 
								f_user,
								(SELECT dbo.cf_create_route(f_house, _user_id, _route_type_id, now()::date)) as route_id
							from dbo.cs_apartament
							where f_user = _user_id
							group by f_house, f_user) as t);
	ELSE
		_result = 0;
	END IF;
	
	RETURN _result;
END
$$;

ALTER FUNCTION dbo.cf_imp_by_user(_user_id integer, _route_type_id integer, _date_activate date) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_imp_by_user(_user_id integer, _route_type_id integer, _date_activate date) IS 'Импорт данных для пользователя';
