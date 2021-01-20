CREATE OR REPLACE FUNCTION dbo.cf_mui_ed_output_meter_readings(_fn_user integer, _c_version text, _f_point uuid) RETURNS TABLE(id uuid, fn_meter_reading uuid, fn_route uuid, fn_point uuid, fn_user_point uuid, n_value numeric, d_date timestamp with time zone)
    LANGUAGE plpgsql STABLE
    AS $$
/**
* @params {integer} _fn_user - идентификатор пользователя
* @params {text} _c_version - текущая версия приложения
*
* @example
* [{ "action": "cf_mui_ed_output_meter_readings", "method": "Select", "data": [{ "params": [_fn_user, _c_version] }], "type": "rpc", "tid": 0 }]
*/
BEGIN
    RETURN QUERY select omr.id, omr.fn_meter_reading, omr.fn_route, omr.fn_point, omr.fn_user_point, omr.n_value, omr.d_date
    from core.cd_userinroutes as uir
    LEFT JOIN core.cd_routes as r ON r.id = uir.f_route
    INNER JOIN dbo.ed_output_meter_readings as omr ON omr.fn_route = r.id
    where uir.f_user = _fn_user and CASE WHEN _f_point is null THEN core.sf_is_mobile_route(r.id) ELSE omr.fn_point = _f_point END;
END
$$;

ALTER FUNCTION dbo.cf_mui_ed_output_meter_readings(_fn_user integer, _c_version text, _f_point uuid) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_mui_ed_output_meter_readings(_fn_user integer, _c_version text, _f_point uuid) IS 'Получение исходящих показаний мобильным устройством';
