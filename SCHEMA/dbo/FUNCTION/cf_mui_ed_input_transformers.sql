CREATE OR REPLACE FUNCTION dbo.cf_mui_ed_input_transformers(_fn_user integer, _c_version text, _f_point uuid) RETURNS TABLE(id uuid, f_input_transformer uuid, f_point uuid, c_transformer_type text, b_voltage boolean, c_number text, n_year integer, n_rate numeric, c_phase text, f_registr_pts uuid, d_date_check date, dx_created timestamp with time zone, d_replace_date date)
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    RETURN QUERY select uuid_generate_v4(), tf.id, p.id, dt.c_name, tf.b_voltage, tf.c_serial_number, tf.n_manufacture_year, coalesce(dt.n_rate, tf.n_rate), tf.c_phase, tf.f_registr_pts, tf.d_check_date, tf.dx_created, tf.d_replace_date
    from core.cd_userinroutes as uir
    inner JOIN core.cd_points as p ON p.f_route = uir.f_route
    inner JOIN core.cd_routes as rt ON rt.id = uir.f_route
    inner JOIN dbo.ed_transformers as tf ON tf.f_registr_pts = p.f_registr_pts
	inner join dbo.es_device_types as dt ON dt.id = tf.f_device_type
    where uir.f_user = _fn_user and (tf.d_replace_date is null or tf.id in (select et.fn_transformer from dbo.ed_output_transformers as et where et.fn_point = p.id)) and CASE WHEN _f_point is null THEN core.sf_is_mobile_route(rt.id) ELSE p.id = _f_point END;
END
$$;

ALTER FUNCTION dbo.cf_mui_ed_input_transformers(_fn_user integer, _c_version text, _f_point uuid) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_mui_ed_input_transformers(_fn_user integer, _c_version text, _f_point uuid) IS 'Список входных трансформаторов для обходчика';
