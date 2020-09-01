CREATE OR REPLACE FUNCTION dbo.cf_mui_cs_question(_fn_user integer) RETURNS TABLE(id bigint, c_title text, c_description text, c_text text, n_order integer, dx_created timestamp with time zone, sn_delete boolean, c_role text, n_priority integer)
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN

    RETURN QUERY select q.id, q.c_title, q.c_description, q.c_text, q.n_order, q.dx_created, q.sn_delete, r.c_name, q.n_priority 
	from dbo.cs_question as q
	left join core.pd_roles as r ON q.f_role = r.id
	where q.b_disabled = false;
END
$$;

ALTER FUNCTION dbo.cf_mui_cs_question(_fn_user integer) OWNER TO mobnius;
