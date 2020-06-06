CREATE OR REPLACE FUNCTION dbo.cf_deluser(_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
	delete from core.pd_userindivisions
	where f_user = _id;

	delete from core.pd_userinroles
	where f_user = _id;

	delete from core.pd_users
	where id = _id;

	RETURN _id;
END
$$;

ALTER FUNCTION dbo.cf_deluser(_id integer) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_deluser(_id integer) IS 'Удаление пользователя';
