CREATE OR REPLACE FUNCTION dbo.cf_mui_cs_answer(_fn_user integer) RETURNS TABLE(id bigint, c_text text, f_question integer, f_next_question integer, c_action text, n_order integer, b_disabled boolean, dx_created timestamp with time zone, sn_delete boolean, c_color text, f_role integer)
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
	RETURN QUERY SELECT a.id, a.c_text, a.f_question, a.f_next_question, a.c_action, a.n_order, a.b_disabled, a.dx_created, a.sn_delete, a.c_color, a.f_role
	FROM dbo.cs_answer as a
	where a.f_question IN (select q.id from dbo.cf_mui_cs_question(_fn_user) as q);
END
$$;

ALTER FUNCTION dbo.cf_mui_cs_answer(_fn_user integer) OWNER TO mobnius;
