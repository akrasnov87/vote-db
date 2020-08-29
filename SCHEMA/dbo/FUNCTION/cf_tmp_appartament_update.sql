CREATE OR REPLACE FUNCTION dbo.cf_tmp_appartament_update(_id uuid) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	_result integer;
	
	_f_house uuid;
	_c_number text;
	_f_appartament uuid;
	_f_main_user integer;
BEGIN
	-- поиск дуюликата
	select a.f_house into _f_house from dbo.cs_appartament as a
	where a.id = _id;
	
	select trim(a.c_number) into _c_number from dbo.cs_appartament as a
	where a.id = _id;
	
	-- находим такую же квартиру в доме
	IF(select count(*) from dbo.cs_appartament as a where a.f_house = _f_house and trim(a.c_number) = trim(_c_number)) > 1 THEN
		-- нашли дубликат квартиры выбираем первую
		select a.id into _f_appartament from dbo.cs_appartament as a where a.f_house = _f_house and trim(a.c_number) = trim(_c_number)
		order by a.dx_date asc
		limit 1;
		
		-- обновляем информацию в cd_people
		update dbo.cd_people
		set f_appartament = _f_appartament,
		f_house = _f_house
		where f_appartament IN (select a.id from dbo.cs_appartament as a where a.f_house = _f_house and trim(a.c_number) = trim(_c_number) and a.id != _f_appartament);
		
		-- обновляем cd_points
		update core.cd_points
		set f_appartament = _f_appartament
		where f_appartament IN (select a.id from dbo.cs_appartament as a where a.f_house = _f_house and trim(a.c_number) = trim(_c_number) and a.id != _f_appartament);
		
		-- обновляем привязку к пользователю, берем последнюю запись
		select a.f_main_user into _f_main_user from dbo.cs_appartament as a 
		where a.f_house = _f_house and trim(a.c_number) = trim(_c_number) and a.f_main_user is not null
		order by a.dx_date desc
		limit 1;
		
		 -- обновляем привязку к пользователю
		update dbo.cs_appartament as a
		set f_main_user = _f_main_user
		where a.id = _f_appartament;
		
		delete from dbo.cs_appartament as a
		where a.f_house = _f_house and trim(a.c_number) = trim(_c_number) and a.id != _f_appartament;
		
		-- нужно ли включить квартиру
		IF (select count(*) from dbo.cs_appartament as a where a.f_house = _f_house and trim(a.c_number) = trim(_c_number) and a.b_disabled = false) > 0 THEN
			update dbo.cs_appartament as a
			set b_disabled = false
			where a.id = _f_appartament;
		END IF;
		
		_result = 0;
	ELSE
		_result = 1;
	END IF;
	
	RETURN _result;
END
$$;

ALTER FUNCTION dbo.cf_tmp_appartament_update(_id uuid) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_tmp_appartament_update(_id uuid) IS 'Обновление списка квартир';
