CREATE OR REPLACE FUNCTION dbo.cf_error_house() RETURNS TABLE(c_area text, c_subdivision text, c_uik text, c_street_name text, c_house_num text, c_build_num text, c_error text)
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
	RETURN QUERY select 
		'' as c_area,
		coalesce(sd.c_name, '') as c_subdivision,
		coalesce(h.n_uik::text, '') as c_uik,
		concat(s.c_type, ' ', s.c_name) as c_street_name,
		h.c_house_num as c_house_num,
		coalesce(h.c_build_num, '') as c_build_num,
		'Дом без указанного УИК или Округа' as c_error
	from dbo.cs_house as h
	inner join dbo.cs_street as s ON h.f_street = s.id
	left join core.sd_subdivisions as sd ON sd.id = h.f_subdivision
	where h.n_uik is null or h.f_subdivision is null
	--order by s.c_name, h.c_house_num, h.c_build_num
	UNION ALL
	select 
		max(d.c_name) as c_area, 
		max(sd.c_name) as c_subdivision, 
		max(h.n_uik)::text as c_uik, 
		concat(max(s.c_type), ' ', max(s.c_name)) as c_street_name,
		max(h.c_house_num) c_house_num,
		max(coalesce(h.c_build_num, '')) as c_build_num,
		'Дом отключен' as c_error
	from dbo.cd_people as p
	inner join dbo.cs_appartament as a ON p.f_appartament = a.id
	inner join dbo.cs_house as h ON h.id = a.f_house
	inner join dbo.cs_street as s ON s.id = h.f_street
	inner join core.sd_subdivisions as sd ON sd.id = h.f_subdivision
	inner join core.sd_divisions as d ON d.id = sd.f_division
	where h.b_disabled = true
	group by a.f_house
	--order by max(sd.id), max(h.n_uik), max(s.c_name), max(h.c_house_num)
	UNION ALL
	select 
		max(d.c_name) as c_area, 
		max(sd.c_name) as c_subdivision, 
		max(h.n_uik)::text as c_uik, 
		concat(max(s.c_type), ' ', max(s.c_name)) as c_street_name,
		max(h.c_house_num) c_house_num,
		max(coalesce(h.c_build_num, '')) as c_build_num,
		concat('В доме есть квартира ', max(a.c_number), ' которая отключена, но есть в списках избирателей') as c_error
	from dbo.cd_people as p
	inner join dbo.cs_appartament as a ON p.f_appartament = a.id
	inner join dbo.cs_house as h ON h.id = a.f_house
	inner join dbo.cs_street as s ON s.id = h.f_street
	inner join core.sd_subdivisions as sd ON sd.id = h.f_subdivision
	inner join core.sd_divisions as d ON d.id = sd.f_division
	where a.b_disabled = true
	group by p.f_appartament;
--order by max(sd.id), max(h.n_uik), max(s.c_name), max(h.c_house_num), max(a.n_number);
END
$$;

ALTER FUNCTION dbo.cf_error_house() OWNER TO mobnius;
