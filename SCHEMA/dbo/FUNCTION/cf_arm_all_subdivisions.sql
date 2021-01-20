CREATE OR REPLACE FUNCTION dbo.cf_arm_all_subdivisions(_f_user integer) RETURNS TABLE(id integer, f_division integer, n_code integer, c_name text, b_subdivision boolean)
    LANGUAGE plpgsql STABLE
    AS $$
/**
* @params {integer} _f_user - пользователь
* 
* @example
* [{ "action": "cf_arm_all_subdivisions", "method": "Select", "data": [{ "params": [_f_user] }], "type": "rpc", "tid": 0 }]
*/
BEGIN
	RETURN QUERY 
	-- поиск subdivisions
	select sd.id, sd.f_division, sd.n_code, sd.c_name, true as b_subdivision
	from core.pd_userindivisions as ud
	inner join core.sd_subdivisions as sd ON ud.f_subdivision = sd.id
	where ud.f_user = _f_user and ud.f_subdivision is not null and b_disabled = false
	UNION
	-- поиск через divisions
	select sd.id, sd.f_division, sd.n_code, sd.c_name, false as b_subdivision from core.sd_subdivisions as sd
	where sd.b_disabled = false and sd.f_division IN (WITH RECURSIVE tree AS (
		SELECT
			d.id,
			d.f_division
		FROM core.sd_divisions as d
		where d.id IN (select ud.f_division
						from core.pd_userindivisions as ud
						where ud.f_user = _f_user and ud.f_division is not null and ud.f_subdivision is null)

		UNION

		SELECT
			d.id,
			d.f_division
		FROM core.sd_divisions as d
		JOIN tree ON d.id = tree.f_division)
	select t.id from tree as t);
END
$$;

ALTER FUNCTION dbo.cf_arm_all_subdivisions(_f_user integer) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_arm_all_subdivisions(_f_user integer) IS 'Получение дерева подразделений для пользователя';
