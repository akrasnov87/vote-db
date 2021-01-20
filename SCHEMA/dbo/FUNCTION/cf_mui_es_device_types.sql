CREATE OR REPLACE FUNCTION dbo.cf_mui_es_device_types(_fn_user integer, _c_version text) RETURNS TABLE(id integer, b_meter boolean, c_name text, n_check_cycle integer)
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    RETURN QUERY select 
		dt.id, 
		dc.b_meter, 
		dt.c_name,  
		dt.n_check_cycle
	from dbo.es_device_types as dt
	inner join dbo.es_device_categories as dc ON dc.id = dt.f_device_categories;
END
$$;

ALTER FUNCTION dbo.cf_mui_es_device_types(_fn_user integer, _c_version text) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_mui_es_device_types(_fn_user integer, _c_version text) IS 'Типы устройств';
