CREATE OR REPLACE FUNCTION dbo.cf_mui_cs_street(_fn_user integer) RETURNS TABLE(id uuid, c_type text, c_name text, jb_data text)
    LANGUAGE plpgsql STABLE
    AS $$
DECLARE
	_subdivision integer;
BEGIN
	select u.f_subdivision into _subdivision from core.pd_users as u where u.id = _fn_user;

	RETURN QUERY
	select s.id, s.c_type, s.c_name, '{}' from dbo.cs_street as s
	where s.id IN (select DISTINCT f_street from dbo.cs_house as h
	where h.f_subdivision = _subdivision)
	order by s.c_name;
END
$$;

ALTER FUNCTION dbo.cf_mui_cs_street(_fn_user integer) OWNER TO mobnius;
