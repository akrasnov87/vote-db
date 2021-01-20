CREATE OR REPLACE FUNCTION dbo.cf_arm_ed_blanks(_b_draft boolean) RETURNS TABLE(id uuid, f_result_type integer, c_result_type text, c_prefix text, n_number integer, c_number text, f_user integer, c_claims text, c_first_name text, c_last_name text, c_middle_name text, c_login text, jb_history json, dx_created timestamp with time zone, n_order integer)
    LANGUAGE plpgsql STABLE
    AS $$
/**
* @params {boolean} _b_draft - null - достать все, true - только забракованные, false - только нормальные
*
* @example
* [{ "action": "cf_arm_ed_blanks", "method": "Select", "data": [{ "params": [_b_draft] }], "type": "rpc", "tid": 0}]
*/
BEGIN
    RETURN QUERY 
	select b.id, b.f_result_type, rt.c_name as c_result_type, b.c_prefix, b.n_number, coalesce(b.c_number, concat(b.c_prefix, b.n_number::text)), b.f_user, u.c_claims, u.c_first_name, u.c_last_name, u.c_middle_name, u.c_login, b.jb_history, b.dx_created, b.n_order 
	from dbo.ed_blanks as b
	inner join core.cs_result_types as rt ON rt.id = b.f_result_type
	left join core.sv_users as u ON b.f_user = u.id
	where b.b_use = false and (CASE WHEN _b_draft is null THEN 1=1 ELSE b.b_draft = _b_draft END);
END
$$;

ALTER FUNCTION dbo.cf_arm_ed_blanks(_b_draft boolean) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_arm_ed_blanks(_b_draft boolean) IS 'Получение списка бланков АРМ-ом';
