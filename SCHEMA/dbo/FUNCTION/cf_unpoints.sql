CREATE OR REPLACE FUNCTION dbo.cf_unpoints(_userid integer, _house uuid, _appartament_start integer, _appartamnt_finish integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	_result integer;
BEGIN
	IF _house is not NULL AND _userid is not null THEN
	
		IF _appartament_start is null AND _appartamnt_finish is null THEN
			PERFORM dbo.cf_delroute(r.id)
			from core.cd_userinroutes as uir
			inner join core.cd_routes as r ON r.id = uir.f_route
			where uir.f_user = _userid and r.f_house = _house;
			
			_result = 0;
		ELSE
			
			IF _appartament_start is not null AND _appartamnt_finish is not null THEN
			
				delete from core.cd_points as p
				where p.id IN (select p.id from core.cd_points as p
					inner join dbo.cs_appartament as a ON a.id = p.f_appartament
					inner join core.cd_routes as r ON r.id = p.f_route
					inner join core.cd_userinroutes as uir ON uir.f_route = r.id
					where uir.f_user = _userid and r.f_house = _house and a.n_number >= _appartament_start and a.n_number <= _appartamnt_finish);
				
				_result = 0;
			ELSE
				_result = 2;
			END IF;
		
		END IF;
		
	ELSE
		_result = 1;
	END IF;
	
	RETURN _result;
END
$$;

ALTER FUNCTION dbo.cf_unpoints(_userid integer, _house uuid, _appartament_start integer, _appartamnt_finish integer) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_unpoints(_userid integer, _house uuid, _appartament_start integer, _appartamnt_finish integer) IS 'Отвязка маршрута и заданий';
