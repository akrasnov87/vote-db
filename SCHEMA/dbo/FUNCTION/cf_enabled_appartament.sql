CREATE OR REPLACE FUNCTION dbo.cf_enabled_appartament(_userid integer, _house uuid, _appartament_start integer, _appartamnt_finish integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	_result integer;
BEGIN
	IF _house is not NULL THEN
	
		IF _appartament_start is null AND _appartamnt_finish is null THEN
			update dbo.cs_appartament
			set b_disabled = false
			where f_house = _house;
			
			_result = 0;
		ELSE
			
			IF _appartament_start is not null AND _appartamnt_finish is not null THEN
				update dbo.cs_appartament
				set b_disabled = false
				where f_house = _house and n_number >= _appartament_start and n_number <= _appartamnt_finish;

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

ALTER FUNCTION dbo.cf_enabled_appartament(_userid integer, _house uuid, _appartament_start integer, _appartamnt_finish integer) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_enabled_appartament(_userid integer, _house uuid, _appartament_start integer, _appartamnt_finish integer) IS 'Включить квартиры';
