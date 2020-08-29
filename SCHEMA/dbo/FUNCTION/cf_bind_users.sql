CREATE OR REPLACE FUNCTION dbo.cf_bind_users() RETURNS TABLE(c_area text, c_subdivision text, n_uik integer, c_street_name text, c_house_num text, c_build_num text, f_main_user integer, n_count bigint, n_min integer, n_max integer)
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
	RETURN QUERY select 
		d.c_name as c_area,
		sd.c_name as c_subdivision,
		h1.n_uik,
		concat(s.c_type, ' ', s.c_name) as c_street_name,
		h1.c_house_num,
		coalesce(h1.c_build_num, '') as c_build_num,
		h.f_main_user,
		h.n_count,
		h.n_min,
		h.n_max
	from (select 
		a.f_house, 
		a.f_main_user, 
		count(*) as n_count,
		max(n_number) as n_max,
		min(n_number) as n_min
	from dbo.cs_appartament as a
	inner join dbo.cs_house as h ON h.id = a.f_house
	inner join dbo.cs_street as s ON s.id = h.f_street
	inner join core.sd_subdivisions as sd ON sd.id = h.f_subdivision
	inner join core.sd_divisions as d ON d.id = sd.f_division
	where h.b_disabled = false and a.b_disabled = false
	group by a.f_house, a.f_main_user) as h
	inner join dbo.cs_house as h1 ON h1.id = h.f_house
	inner join dbo.cs_street as s ON h1.f_street = s.id
	inner join core.sd_subdivisions as sd ON sd.id = h1.f_subdivision
	inner join core.sd_divisions as d ON d.id = sd.f_division
	order by sd.id, h1.n_uik, s.c_name, h1.c_house_num, h1.c_build_num, h.f_main_user, h.n_count;
END
$$;

ALTER FUNCTION dbo.cf_bind_users() OWNER TO mobnius;
