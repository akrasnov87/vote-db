CREATE OR REPLACE FUNCTION dbo.cf_tmp_house_update(_id uuid) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	_result integer;
	
	_f_house uuid;
	_c_number text;
	_c_build text;
	_f_street uuid;
BEGIN
	select trim(h.c_house_num) into _c_number from dbo.cs_house as h where h.id = _id;
	select trim(coalesce(h.c_build_num, '')) into _c_build from dbo.cs_house as h where h.id = _id;
	select h.f_street into _f_street from dbo.cs_house as h where h.id = _id;

	-- проверяем на дубликат
	IF (select count(*) from dbo.cs_house as h where h.f_street = _f_street and trim(h.c_house_num) = _c_number and trim(coalesce(h.c_build_num, '')) = _c_build) > 1 THEN
		-- есть дубликат, выполняем поиск основного дома
		
		select h.id into _f_house from dbo.cv_house as h 
		where h.street_id = _f_street and trim(h.c_house_num) = _c_number and trim(coalesce(h.c_build_num, '')) = _c_build and h.f_subdivision is not null and h.n_uik is not null and h.b_disabled = false
		order by h.n_appartament desc
		limit 1;
		
		IF (_f_house is null) THEN
			-- если основной дом не нашли, то берем тот у которого больше квартир
			select h.id into _f_house from dbo.cv_house as h 
			where h.street_id = _f_street and trim(h.c_house_num) = _c_number and trim(coalesce(h.c_build_num, '')) = _c_build and h.f_subdivision is not null and h.n_uik is not null
			order by h.n_appartament desc
			limit 1;
		END IF;
		
		IF (_f_house is null) THEN
			select h.id into _f_house from dbo.cv_house as h 
			where h.street_id = _f_street and trim(h.c_house_num) = _c_number and trim(coalesce(h.c_build_num, '')) = _c_build
			order by h.n_appartament desc
			limit 1;
		END IF;
		
		-- теперь обновляем информацию в квартирах
		IF (_f_house is not null) THEN
			update dbo.cs_appartament
			set f_house = _f_house
			where f_house IN (select h.id from dbo.cs_house as h where h.f_street = _f_street and trim(h.c_house_num) = _c_number and trim(coalesce(h.c_build_num, '')) = _c_build and h.id != _f_house);
	
			update dbo.cd_people
			set f_house = _f_house
			where f_house IN (select h.id from dbo.cs_house as h where h.f_street = _f_street and trim(h.c_house_num) = _c_number and trim(coalesce(h.c_build_num, '')) = _c_build and h.id != _f_house);
	
			update core.cd_routes
			set f_house = _f_house
			where f_house IN (select h.id from dbo.cs_house as h where h.f_street = _f_street and trim(h.c_house_num) = _c_number and trim(coalesce(h.c_build_num, '')) = _c_build and h.id != _f_house);
			
			delete from dbo.cs_house as h
			where h.id IN (select h.id from dbo.cs_house as h where h.f_street = _f_street and trim(h.c_house_num) = _c_number and trim(coalesce(h.c_build_num, '')) = _c_build and h.id != _f_house);
		END IF;
		
		_result = 0;
	ELSE
		_result = 1;
	END IF;

	RETURN _result;
END
$$;

ALTER FUNCTION dbo.cf_tmp_house_update(_id uuid) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_tmp_house_update(_id uuid) IS 'Обновление списка домов';
