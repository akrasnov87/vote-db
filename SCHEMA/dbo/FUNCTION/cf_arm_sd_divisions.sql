CREATE OR REPLACE FUNCTION dbo.cf_arm_sd_divisions(_f_current_user integer, _f_main_division integer) RETURNS TABLE(id integer, f_division integer, c_name text, c_dep_code text, n_code integer)
    LANGUAGE plpgsql STABLE
    AS $$
/**
* @params {integer} _f_current_user - текущий пользователь
* @params {integer} _f_main_division - филиал
*
* @example
* [{ "action": "cf_arm_sd_divisions", "method": "Select", "data": [{ "params": [_f_current_user, _f_main_division] }], "type": "rpc", "tid": 0}]
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
	select t.id, t.f_division, t.c_name, t.c_dep_code, t.n_code from tree as t
	where t.b_disabled = false and t.f_division = _f_main_division;
END
$$;

ALTER FUNCTION dbo.cf_arm_sd_divisions(_f_current_user integer, _f_main_division integer) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_arm_sd_divisions(_f_current_user integer, _f_main_division integer) IS 'Список отделений доступных для пользователя';
