insert into dbo.cs_house(id, f_street, c_house_num, c_build_num, c_floor, c_porch, n_uik, f_subdivision)
select 
	uuid_generate_v4(),
	(select id from dbo.cs_street as s where s.f_division = max(d.id) and s.c_name = i.c_street and s.c_type = i.c_type) as f_street,
	i.c_house, 
	i.c_build,
	max(i.c_floor),
	max(i.c_porch),
	max(i.n_uik),
	max(sd.id)
from dbo.sd_import as i
left join core.sd_divisions as d ON d.c_name = i.c_area
left join core.sd_subdivisions as sd ON sd.n_code = i.n_district
group by i.c_area, i.n_district, i.c_street, i.c_type, i.c_house, i.c_build