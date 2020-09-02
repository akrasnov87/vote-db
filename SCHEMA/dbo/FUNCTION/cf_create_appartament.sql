CREATE OR REPLACE FUNCTION dbo.cf_create_appartament(_house uuid, _appartament_start integer, _appartamnt_finish integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	_result integer;
BEGIN
	IF _house is not NULL THEN
	
		IF _appartament_start is null AND _appartamnt_finish is null THEN
			_result = 2;
		ELSE
			
			IF _appartament_start is not null AND _appartamnt_finish is not null THEN
			
				insert into dbo.cs_appartament(f_house, c_number, n_number, n_signature_2018)
				SELECT _house, s.a::text, s.a, 0 FROM generate_series(_appartament_start, _appartamnt_finish) AS s(a)
				where s.a::text not IN (select a.c_number from dbo.cs_appartament as a where a.f_house = _house);
				PERFORM dbo.cf_enabled_appartament(null, _house, _appartament_start, _appartamnt_finish);
				_result = 10;
			ELSE
				IF _appartament_start is not null AND _appartamnt_finish is null THEN
					insert into dbo.cs_appartament(f_house, c_number, n_number, n_signature_2018)
					SELECT _house, _appartament_start::text, _appartament_start, 0
					where _appartament_start::text not IN (select a.c_number from dbo.cs_appartament as a where a.f_house = _house);
					
					PERFORM dbo.cf_enabled_appartament(null, _house, _appartament_start, null);
		
					_result = 20;
				ELSE
					_result = 3;
				END IF;
				
			END IF;
		
		END IF;
		
	ELSE
		_result = 1;
	END IF;
	
	RETURN _result;
END
$$;

ALTER FUNCTION dbo.cf_create_appartament(_house uuid, _appartament_start integer, _appartamnt_finish integer) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_create_appartament(_house uuid, _appartament_start integer, _appartamnt_finish integer) IS 'Создание квартир';
