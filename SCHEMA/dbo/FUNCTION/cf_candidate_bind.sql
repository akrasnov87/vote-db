CREATE OR REPLACE FUNCTION dbo.cf_candidate_bind(_user_id integer) RETURNS TABLE(id uuid, f_street uuid, c_street_name text, c_street_type text, c_house_num text, c_build_num text, n_uik integer, f_subdivision integer, f_candidate_users jsonb, b_candidate_user boolean, n_appartament_count bigint)
    LANGUAGE plpgsql
    AS $$
DECLARE
	_subdivision integer;
BEGIN
	select u.f_subdivision into _subdivision from core.pd_users as u
	where u.id = _user_id;

	return query 
	select t.id, t.f_street, s.c_name as c_street_name, s.c_type as c_street_type, t.c_house_num, t.c_build_num, t.n_uik, t.f_subdivision, t.f_candidate_users, t.b_candidate_user, t.n_appartament_count 
	from (select h.id, h.f_street, h.c_house_num, h.c_build_num, h.n_uik, h.f_subdivision, h.f_candidate_users,
	(select count(*) from (SELECT jsonb_array_elements(h.f_candidate_users)) as t(el) where t.el::text::integer = _user_id) > 0 as b_candidate_user,
	(SELECT count(*) from dbo.msv_appartament where h.id = f_house group by f_house) as n_appartament_count
	from dbo.cs_house as h
	where h.id IN (select f_house 
				   from (SELECT f_house, count(*) as n_count
								from dbo.msv_appartament
								group by f_house) as t
								where t.n_count > 1)) as t
	inner join dbo.cs_street as s ON s.id = t.f_street
	where t.f_subdivision = _subdivision;
END
$$;

ALTER FUNCTION dbo.cf_candidate_bind(_user_id integer) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_candidate_bind(_user_id integer) IS 'Список домов которые привязаны к кандидату';
