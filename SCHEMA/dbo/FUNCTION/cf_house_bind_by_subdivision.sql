CREATE OR REPLACE FUNCTION dbo.cf_house_bind_by_subdivision(_subdivision integer) RETURNS TABLE(id uuid, f_street uuid, c_street_name text, c_street_type text, c_house_num text, c_build_num text, n_uik integer, f_subdivision integer, n_all_appartament_count bigint, n_all_appartament_min integer, n_all_appartament_max integer, f_users json)
    LANGUAGE plpgsql
    AS $$
BEGIN
	return query 
	select * from (select
		h.id,
		h.f_street,
		s.c_name as c_street_name,
		s.c_type as c_street_type, 
		h.c_house_num,
		h.c_build_num,
		h.n_uik,
		h.f_subdivision,
		(select count(*) from dbo.cs_appartament as a where a.f_house = h.id and a.b_disabled = false) as n_all_appartament_count,
		(select min(a.n_number) from dbo.cs_appartament as a where a.f_house = h.id and a.b_disabled = false) as n_all_appartament_min,
		(select max(a.n_number) from dbo.cs_appartament as a where a.f_house = h.id and a.b_disabled = false) as n_all_appartament_max,
		(select array_to_json(array_agg(row_to_json(t))) from (
			select a.f_house, a.f_main_user, max(n_number) as n_max, min(n_number) as n_min, count(*) as n_count from dbo.cs_appartament as a
			where a.f_house = h.id and a.f_main_user is not null and a.b_disabled = false
			group by a.f_house, a.f_main_user) as t) as f_users
	from dbo.cs_house as h
	inner join dbo.cs_street as s ON h.f_street = s.id) as t
	where t.f_subdivision = _subdivision
		   order by t.c_street_name, t.c_house_num, t.c_build_num;
END
$$;

ALTER FUNCTION dbo.cf_house_bind_by_subdivision(_subdivision integer) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_house_bind_by_subdivision(_subdivision integer) IS 'Список домов которые привязан агитатор';
