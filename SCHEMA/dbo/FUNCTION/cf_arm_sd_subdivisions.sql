CREATE OR REPLACE FUNCTION dbo.cf_arm_sd_subdivisions(_f_current_user integer, _f_division integer) RETURNS TABLE(id integer, f_division integer, c_name text, n_code integer, b_subdivision boolean)
    LANGUAGE plpgsql STABLE
    AS $$
/**
* @params {integer} _f_current_user - текущий пользователь
* @params {integer} _f_division - отделение
*
* @example
* [{ "action": "cf_arm_sd_subdivisions", "method": "Select", "data": [{ "params": [_f_current_user, _f_division] }], "type": "rpc", "tid": 0}]
*/
BEGIN
	-- список разрешеннных отделений см. core.pd_userindivisions -> f_subdivision
	RETURN QUERY 
	-- поиск subdivisions
	select sd.id, sd.f_division, sd.c_name, sd.n_code, true as b_subdivision -- b_subdivision прямой доступ к участку
	from core.pd_userindivisions as ud
	inner join core.sd_subdivisions as sd ON ud.f_subdivision = sd.id
	where ud.f_user = _f_current_user and ud.f_subdivision is not null and b_disabled = false
	UNION
	-- поиск через divisions
	select sd.id, sd.f_division, sd.c_name, sd.n_code, false as b_subdivision 
	from core.sd_subdivisions as sd
	where sd.b_disabled = false and sd.f_division IN (WITH RECURSIVE tree AS (
		SELECT
			d.id,
			d.f_division
		FROM core.sd_divisions as d
		where d.id IN (select ud.f_division
						from core.pd_userindivisions as ud
						where ud.f_user = _f_current_user and ud.f_division is not null and ud.f_subdivision is null)

		UNION

		SELECT
			d.id,
			d.f_division
		FROM core.sd_divisions as d
		JOIN tree ON d.id = tree.f_division)
	select t.id from tree as t);
END
$$;

ALTER FUNCTION dbo.cf_arm_sd_subdivisions(_f_current_user integer, _f_division integer) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_arm_sd_subdivisions(_f_current_user integer, _f_division integer) IS 'Список участков доступных для пользователя';
