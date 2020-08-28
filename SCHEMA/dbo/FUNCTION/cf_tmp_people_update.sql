CREATE OR REPLACE FUNCTION dbo.cf_tmp_people_update(_id uuid) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	_result integer;
	_f_house uuid;
	_c_number text;
	_f_appartament uuid;
BEGIN
	IF (select count(*) from dbo.cd_people as p
	   	inner join dbo.cs_appartament as a ON p.f_appartament = a.id
	   	where a.b_disabled = true and p.id = _id) > 0 
	THEN
		-- нашли что квартира отключена
		select p.f_house into _f_house 
		from dbo.cd_people as p
		where p.id = _id;
		
		select a.c_number into _c_number 
		from dbo.cd_people as p
		inner join dbo.cs_appartament as a ON p.f_appartament = a.id
		where p.id = _id;
		
		IF (select count(*) from dbo.cs_appartament as a where a.b_disabled = false and a.f_house = _f_house and a.c_number = _c_number) = 1 THEN
			-- тут одно совпадение и нужно переключить
			select a.id into _f_appartament from dbo.cs_appartament as a 
			where a.b_disabled = false and a.f_house = _f_house and a.c_number = _c_number;
			
			update dbo.cd_people
			set f_appartament = _f_appartament
			where id = _id;
			
			_result = 0;
		ELSE
			_result = 2;
		END IF;
	   	
	ELSE
		_result = 1;
	END IF;
	
	RETURN _result;
END
$$;

ALTER FUNCTION dbo.cf_tmp_people_update(_id uuid) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_tmp_people_update(_id uuid) IS 'Обновление привязки';
