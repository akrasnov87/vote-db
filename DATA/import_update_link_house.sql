update dbo.sd_import as i
set f_house = (select h.id from dbo.cs_house as h
	left join dbo.cs_street as s ON h.f_street = s.id
	left join core.sd_subdivisions as sd ON h.f_subdivision = sd.id
	where i.n_district = sd.n_code and s.c_type = i.c_type and s.c_name = i.c_street and i.c_house = h.c_house_num and i.c_build = h.c_build_num)
--from dbo.sd_import as i