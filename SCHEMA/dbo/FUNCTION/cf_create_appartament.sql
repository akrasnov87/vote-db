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
			
				insert into dbo.cs_appartament(f_house, c_number, n_number)
				SELECT _house, s.a::text, s.a  FROM generate_series(_appartament_start, _appartamnt_finish) AS s(a);
		
				_result = 10;
			ELSE
				IF _appartament_start is not null AND _appartamnt_finish is null THEN
					insert into dbo.cs_appartament(f_house, c_number, n_number)
					SELECT _house, _appartament_start::text, _appartament_start;
		
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
