insert into core.pd_userindivisions(f_user, f_division, f_subdivision)
select dbo.sf_convert_number(c_num), max(d.id), max(sd.id) from dbo.sd_import as i
inner join core.sd_divisions as d ON d.c_name = i.c_area
inner join core.sd_subdivisions as sd ON sd.n_code = i.n_district
group by c_num