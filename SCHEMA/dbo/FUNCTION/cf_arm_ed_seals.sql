CREATE OR REPLACE FUNCTION dbo.cf_arm_ed_seals(_b_draft boolean) RETURNS TABLE(id uuid, c_prefix text, n_number integer, c_number text, f_type integer, c_type text, f_user integer, c_claims text, c_first_name text, c_last_name text, c_middle_name text, c_login text, jb_history json, dx_created timestamp with time zone, n_order integer)
    LANGUAGE plpgsql STABLE
    AS $$
/**
* @params {boolean} _b_draft - null - достать все, true - только забракованные, false - только нормальные
*
* @example
* [{ "action": "cf_arm_ed_seals", "method": "Select", "data": [{ "params": [_b_draft] }], "type": "rpc", "tid": 0}]
*/
BEGIN
    RETURN QUERY 
	select s.id, s.c_prefix, s.n_number, coalesce(s.c_number, concat(s.c_prefix, s.n_number::text)), st.id, st.c_name, s.f_user, u.c_claims, u.c_first_name, u.c_last_name, u.c_middle_name, u.c_login, s.jb_history, s.dx_created, s.n_order 
	from dbo.ed_seals as s
	inner join dbo.es_seal_types as st On st.id = s.f_type
	left join core.sv_users as u ON s.f_user = u.id
	where s.f_registr_pts is null and (CASE WHEN _b_draft is null THEN 1=1 ELSE s.b_draft = _b_draft END);
END
$$;

ALTER FUNCTION dbo.cf_arm_ed_seals(_b_draft boolean) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_arm_ed_seals(_b_draft boolean) IS 'Получение списка пломб АРМ-ом';
