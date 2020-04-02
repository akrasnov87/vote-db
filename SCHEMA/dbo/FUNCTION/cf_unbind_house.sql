CREATE OR REPLACE FUNCTION dbo.cf_unbind_house(_userid integer, _house uuid) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	_result integer;
BEGIN
	IF _house is NULL THEN
	
		update dbo.cs_house
		set f_user = null
		where f_user = _userId;
		
		_result = 1;
	ELSE
		update dbo.cs_house
		set f_user = null
		where id = _house and f_user = _userId;
	
		_result = 0;
	END IF;
	RETURN _result;
END
$$;

ALTER FUNCTION dbo.cf_unbind_house(_userid integer, _house uuid) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_unbind_house(_userid integer, _house uuid) IS 'Отвязать пользователя от дома';
