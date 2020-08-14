CREATE OR REPLACE FUNCTION dbo.cf_mui_cs_house(_fn_user integer) RETURNS TABLE(id uuid, c_street text, c_number text, c_build text, jb_data text)
    LANGUAGE plpgsql STABLE
    AS $$
DECLARE
	_subdivision integer;
BEGIN
	select u.f_subdivision into _subdivision from core.pd_users as u where u.id = _fn_user;

	RETURN QUERY select h.id, concat(h.c_street_type, ' ', h.street_name) as c_street, h.c_house_num, h.c_build_num, '{}' 
	from dbo.cv_house as h
	where h.f_subdivision = _subdivision and b_private = false and b_fail = false
	order by h.street_name, h.c_house_num, h.c_build_num;
END
$$;

ALTER FUNCTION dbo.cf_mui_cs_house(_fn_user integer) OWNER TO mobnius;
