CREATE OR REPLACE FUNCTION dbo.cf_bindhouse(_userid integer, _street text, _house text, _build text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	_streetId uuid;
	_houseId uuid;
	_result integer;
BEGIN
	select id into _streetId from dbo.cs_street
	where c_name ilike concat('%', _street, '%');
	IF _streetId is NULL THEN
		_result = 1;
	ELSE
		_result = 0;
		
		IF _house IS NULL THEN
			update dbo.cs_house
			set f_user = _userId
			where f_street = _streetId;
		ELSE
			IF _build IS NULL THEN
				select id into _houseId from dbo.cs_house
				where f_street = _streetId and c_house_num = _house;
			ELSE
				select id into _houseId from dbo.cs_house
				where f_street = _streetId and c_house_num = _house and c_build_num = _build;
			END IF;
			IF _houseId is null THEN
				_result = 2;
			ELSE
				_result = 0;
				update dbo.cs_house
				set f_user = _userId
				where f_street = _streetId and id = _houseId;
			END IF;
		END IF;
	END IF;
	RETURN _result;
END
$$;

ALTER FUNCTION dbo.cf_bindhouse(_userid integer, _street text, _house text, _build text) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_bindhouse(_userid integer, _street text, _house text, _build text) IS 'Привязка пользователя к дому';
