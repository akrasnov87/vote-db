CREATE OR REPLACE FUNCTION dbo.cf_tmp_appartament_between_update(_id uuid) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	_result integer;
	
	_f_house uuid;
	_n_number integer;
	_max integer;
	_min integer;
	_f_main_user integer;
BEGIN
	
	-- поиск дубликата
	select a.f_house into _f_house from dbo.cs_appartament as a
	where a.id = _id;
	
	select a.n_number into _n_number from dbo.cs_appartament as a
	where a.id = _id;
	
	IF (select count(*) from dbo.cs_house as h where h.b_disabled = false and h.id = _f_house) THEN
		-- дом активен
		select max(a.n_number) into _max from dbo.cs_appartament as a where a.f_house = _f_house and a.b_disabled = false;
		select min(a.n_number) into _min from dbo.cs_appartament as a where a.f_house = _f_house and a.b_disabled = false;
		
		IF(_n_number >= _min and _n_number <= _max) THEN
			select a.f_main_user into _f_main_user 
			   from dbo.cs_appartament as a 
			   where a.f_house = _f_house and a.n_number = (_n_number - 1) 
			   limit 1;
			   
			IF(_f_main_user is null) THEN
				select a.f_main_user into _f_main_user 
				from dbo.cs_appartament as a 
				where a.f_house = _f_house and a.n_number = (_n_number + 1) 
				limit 1;
			END IF;
		
			update dbo.cs_appartament as a
			set b_disabled = false,
			f_main_user = _f_main_user
			where a.id = _id;
			
			_result = 0;		
		ELSE
			_result = 1;
		END IF;
	ELSE
		_result = 1;
	END IF;
	
	RETURN _result;
END
$$;

ALTER FUNCTION dbo.cf_tmp_appartament_between_update(_id uuid) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_tmp_appartament_between_update(_id uuid) IS 'НЕ использовать!!! Обновление списка квартир';
