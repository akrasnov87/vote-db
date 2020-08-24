CREATE OR REPLACE FUNCTION dbo.cf_double_appartament(_fn_point uuid) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	_result integer;
	_route_id uuid;
	_appartament_id uuid;
BEGIN
	select p.f_route into _route_id from core.cd_points as p
	where p.id = _fn_point;

	select p.f_appartament into _appartament_id from core.cd_points as p
	where p.id = _fn_point;
	
	IF (select count(*) from core.cd_points as p where p.id = _fn_point and p.b_double = true) = 0 THEN
	
		IF (select count(*) from core.cd_points as p where p.f_route = _route_id and p.f_appartament = _appartament_id) > 1 THEN
			-- тут задвоение

			IF (select count(*) from core.cd_user_points as up where up.fn_route = _route_id and up.fn_point = _fn_point) > 1 THEN
				-- есть выполненый результат
				UPDATE core.cd_points
				set b_double = true
				where f_route = _route_id and f_appartament = _appartament_id and id != _fn_point;
				
				UPDATE core.cd_points
				set b_double = false
				where f_route = _route_id and f_appartament = _appartament_id and id = _fn_point;

				_result = 0;
			ELSE
				UPDATE core.cd_points
				set b_double = true
				where f_route = _route_id and f_appartament = _appartament_id and id = _fn_point;
				
				UPDATE core.cd_points
				set b_double = false
				where f_route = _route_id and f_appartament = _appartament_id and id != _fn_point;
				
				_result = 1;
			END IF;
		ELSE
			_result = 2;
		END IF;
	ELSE
		_result = 3;
	END IF;
	
	RETURN _result;
END
$$;

ALTER FUNCTION dbo.cf_double_appartament(_fn_point uuid) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_double_appartament(_fn_point uuid) IS 'Удаление дублей квартир';
