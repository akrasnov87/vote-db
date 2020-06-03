insert into core.sd_subdivisions(f_division, n_code, c_name, b_disabled)
SELECT MAX(d.id), i.n_district, concat('Округ №', i.n_district), false 
FROM dbo.sd_import as i
inner join core.sd_divisions as d ON i.c_area = d.c_name
where i.n_district > 2
group by n_district
order by n_district;