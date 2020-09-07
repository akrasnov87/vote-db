CREATE OR REPLACE FUNCTION dbo.cf_mui_cs_question(_fn_user integer) RETURNS TABLE(id bigint, c_title text, c_description text, c_text text, n_order integer, dx_created timestamp with time zone, sn_delete boolean, c_role text, n_priority integer)
    LANGUAGE plpgsql STABLE
    AS $$
DECLARE
	_n_code integer;
	_c_fio text;
	_c_status text;
BEGIN
	select sd.n_code into _n_code from core.pd_users as u
	inner join core.sd_subdivisions as sd ON sd.id = u.f_subdivision
	where u.id = _fn_user;
	
	select c_fio into _c_fio from dbo.cs_main_candidate
	where n_subdivision = _n_code;
	
	select c_status into _c_status from dbo.cs_main_candidate
	where n_subdivision = _n_code;

    RETURN QUERY select q.id, q.c_title, q.c_description, REPLACE(REPLACE(q.c_text, '[c_candidate_name]', _c_fio), '[c_candidate_status]', _c_status), q.n_order, q.dx_created, q.sn_delete, r.c_name, q.n_priority 
 	from dbo.cs_question as q
	left join core.pd_roles as r ON q.f_role = r.id
	where q.b_disabled = false;
END
$$;

ALTER FUNCTION dbo.cf_mui_cs_question(_fn_user integer) OWNER TO mobnius;
