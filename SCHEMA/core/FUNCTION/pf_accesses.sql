CREATE OR REPLACE FUNCTION core.pf_accesses(n_user_id integer) RETURNS TABLE(operation text, table_name text, record_criteria text, catalog_path text, rpc_function text, column_name text, is_editable boolean, is_deletable boolean, is_creatable boolean, is_fullcontrol boolean, access integer)
    LANGUAGE plpgsql
    AS $$BEGIN
 RETURN QUERY select 
        '' as c_operation,
        a.c_name,
        a.c_criteria,
        a.c_path,
        a.c_function,
        a.c_columns,
        a.b_editable, 
        a.b_deletable, 
        a.b_creatable, 
        a.b_full_control, 
        core.sf_accesses(r.c_name, u.id, u.c_claims, a.f_user) as access 
    from core.pd_accesses as a
    left join core.sv_users as u on n_user_id = u.id
    left join core.pd_roles as r on a.f_role = r.id
    where a.sn_delete = false;
END; $$;

ALTER FUNCTION core.pf_accesses(n_user_id integer) OWNER TO mobnius;

COMMENT ON FUNCTION core.pf_accesses(n_user_id integer) IS 'получение прав доступа для пользователя';
