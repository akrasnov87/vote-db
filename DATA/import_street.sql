insert into dbo.cs_street(id, c_name, c_type, f_division)
select uuid_generate_v4(), i.c_street, i.c_type, max(d.id) from dbo.sd_import as i
inner join core.sd_divisions as d ON d.c_name = i.c_area
group by i.c_area, i.c_street, i.c_type, i.c_house, i.c_build