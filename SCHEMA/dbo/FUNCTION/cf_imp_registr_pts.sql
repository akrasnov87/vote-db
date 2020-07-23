CREATE OR REPLACE FUNCTION dbo.cf_imp_registr_pts() RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	_result integer;
BEGIN
	ALTER TABLE core.cd_points DROP CONSTRAINT cd_points_f_registr_pts_fkey;

	truncate dbo.ed_registr_pts;

	-- далее заливаем новые строки
	insert into dbo.ed_registr_pts (id, c_appartament_num, n_appartament_num, c_house_num, c_address, f_division, f_subdivision)
	select 
		a.id, 
		a.c_number, 
		a.n_number,
		h.c_house_num,
		concat(s.c_short_type, ' ', s.c_name) as c_address,
		s.f_division,
		h.f_subdivision
	from dbo.cs_appartament as a
	inner join dbo.cs_house as h ON h.id = a.f_house
	inner join dbo.cs_street as s ON h.f_street = s.id;
	
	_result = 0;
	
	ALTER TABLE core.cd_points
	    ADD CONSTRAINT cd_points_f_registr_pts_fkey FOREIGN KEY (f_registr_pts)
	    REFERENCES dbo.ed_registr_pts (id) MATCH SIMPLE
	    ON UPDATE NO ACTION
	    ON DELETE NO ACTION;
	
	RETURN _result;
END
$$;

ALTER FUNCTION dbo.cf_imp_registr_pts() OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_imp_registr_pts() IS 'Обновление точек учета по всем пользователям';
