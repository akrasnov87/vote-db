CREATE OR REPLACE FUNCTION dbo.cf_mui_ed_input_meter_readings(_fn_user integer, _c_version text, _f_point uuid) RETURNS TABLE(id uuid, f_input_meter_reading uuid, f_point uuid, n_value_prev numeric, d_date_prev timestamp with time zone, n_digit numeric, f_scale integer, n_scale integer, c_scale text, c_energy_type text, d_replace_date timestamp with time zone)
    LANGUAGE plpgsql STABLE
    AS $$
/**
* @params {integer} _fn_user - идентификатор пользователя
* @params {text} _c_version - текущая версия приложения
*
* @example
* [{ "action": "cf_mui_ed_input_meter_readings", "method": "Select", "data": [{ "params": [_fn_user, _c_version] }], "type": "rpc", "tid": 0 }]
*/
BEGIN
    RETURN QUERY select uuid_generate_v4(), imp.id, p.id, imp.n_value_prev, imp.d_date_prev, imp.n_digit, imp.f_scale, s.n_order, s.c_name, et.c_const, imp.d_replace_date
    from core.cd_userinroutes as uir
    inner JOIN core.cd_points as p ON p.f_route = uir.f_route
    inner JOIN core.cd_routes as rt ON rt.id = uir.f_route
    inner JOIN dbo.ed_input_meter_readings as imp ON imp.f_registr_pts = p.f_registr_pts
	inner join dbo.es_energy_types as et ON et.id = imp.f_energy_type
	inner join dbo.es_scales as s on imp.f_scale = s.id 
	left join dbo.ed_output_meter_readings as omr ON omr.fn_point = p.id 
    where uir.f_user = _fn_user and (imp.d_replace_date is null or omr.fn_meter_reading = imp.id) and CASE WHEN _f_point is null THEN core.sf_is_mobile_route(rt.id) ELSE p.id = _f_point END;
END
$$;

ALTER FUNCTION dbo.cf_mui_ed_input_meter_readings(_fn_user integer, _c_version text, _f_point uuid) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_mui_ed_input_meter_readings(_fn_user integer, _c_version text, _f_point uuid) IS 'Получение входящих показаний мобильным устройством';
