CREATE OR REPLACE FUNCTION dbo.cf_mui_ed_output_transformers(_fn_user integer, _c_version text, _f_point uuid) RETURNS TABLE(id uuid, fn_route uuid, fn_point uuid, fn_user_point uuid, fn_result uuid, fn_transformer uuid, fn_device_type integer, c_device_type text, c_number text, n_year integer, d_date timestamp with time zone, n_rate numeric, fn_phase integer, c_phase text, b_voltage boolean, d_date_check timestamp with time zone)
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
	RETURN QUERY select t.id, t.fn_route, t.fn_point, t.fn_user_point, t.fn_result, t.fn_transformer, t.fn_device_type, dt.c_name, t.c_number, t.n_year, t.d_date, t.n_rate, t.fn_phase, ph.c_name, t.b_voltage, t.d_date_check
    from core.cd_userinroutes as uir
    LEFT JOIN core.cd_routes as r ON r.id = uir.f_route
    INNER JOIN dbo.ed_output_transformers as t ON t.fn_route = r.id
	inner join dbo.es_device_types as dt ON dt.id = t.fn_device_type
	inner join dbo.es_phase as ph ON t.fn_phase = ph.id
    where uir.f_user = _fn_user and CASE WHEN _f_point is null THEN core.sf_is_mobile_route(r.id) ELSE t.fn_point = _f_point END;
END
$$;

ALTER FUNCTION dbo.cf_mui_ed_output_transformers(_fn_user integer, _c_version text, _f_point uuid) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_mui_ed_output_transformers(_fn_user integer, _c_version text, _f_point uuid) IS 'Исходящая информация о трансформаторах для обходчика';
