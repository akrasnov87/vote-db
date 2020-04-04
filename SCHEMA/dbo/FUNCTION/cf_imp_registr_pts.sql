CREATE OR REPLACE FUNCTION dbo.cf_imp_registr_pts() RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	_result integer;
BEGIN
	delete from dbo.ed_registr_pts
	where f_subdivision is null;

	insert into dbo.ed_registr_pts (id, c_subscr, c_device, c_address, n_longitude, n_latitude, f_division, b_disabled)
	select 
		a.id, 
		a.c_number, 
		a.n_number::text,
		s.c_name,
		h.n_longitude,
		h.n_latitude,
		1,
		false
	from dbo.cs_apartament as a
	inner join dbo.cs_house as h ON h.id = a.f_house
	inner join dbo.cs_street as s ON h.f_street = s.id;
	
	_result = 0;
	RETURN _result;
END
$$;

ALTER FUNCTION dbo.cf_imp_registr_pts() OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_imp_registr_pts() IS 'Обновление точек учета по всем пользователям';
