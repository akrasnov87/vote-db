CREATE OR REPLACE FUNCTION dbo.cf_arm_sd_main_divisions(_f_current_user integer) RETURNS TABLE(id integer, c_name text, c_dep_code text, n_code integer)
    LANGUAGE plpgsql STABLE
    AS $$
/**
* @params {integer} _f_current_user - текущий пользователь
*
* @example
* [{ "action": "cf_arm_sd_main_divisions", "method": "Select", "data": [{ "params": [_f_current_user] }], "type": "rpc", "tid": 0}]
*/
BEGIN
	-- список разрешеннных отделений см. core.pd_userindivisions -> f_division
	RETURN QUERY WITH RECURSIVE tree AS (
		SELECT
			d.id,
			d.f_division,
			d.c_name,
			d.c_dep_code,
			d.n_code,
			d.b_disabled
		FROM core.sd_divisions as d
		where d.id IN (select ud.f_division
						from core.pd_userindivisions as ud
						where ud.f_user = _f_current_user)

		UNION

		SELECT
			d.id,
			d.f_division,
			d.c_name,
			d.c_dep_code,
			d.n_code,
			d.b_disabled
		FROM core.sd_divisions as d
		JOIN tree ON d.id = tree.f_division)
	select t.id, t.c_name, t.c_dep_code, t.n_code from tree as t
	where t.b_disabled = false and t.f_division is null;
END
$$;

ALTER FUNCTION dbo.cf_arm_sd_main_divisions(_f_current_user integer) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_arm_sd_main_divisions(_f_current_user integer) IS 'Список филиалов доступных для пользователя';
