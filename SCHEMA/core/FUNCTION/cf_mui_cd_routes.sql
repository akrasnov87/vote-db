CREATE OR REPLACE FUNCTION core.cf_mui_cd_routes(_fn_user integer, _c_version text) RETURNS TABLE(id uuid, f_type integer, c_number text, d_date timestamp with time zone, d_date_start date, d_date_end date, c_notice text, b_extended boolean, d_extended date, jb_data text, dx_created timestamp with time zone, n_count bigint, n_order integer, b_draft boolean)
    LANGUAGE plpgsql STABLE
    AS $$
/**
* @params {integer} _fn_user - идентификатор пользователя
* @params {text} _c_version - текущая версия приложения
*
* @example
* [{ "action": "cf_mui_cd_routes", "method": "Select", "data": [{ "params": [_fn_user, _c_version] }], "type": "rpc", "tid": 0 }]
*/
BEGIN
    RETURN QUERY select r.id, r.f_type, r.c_number, r.d_date, r.d_date_start, r.d_date_end, r.c_notice, r.b_extended, r.d_extended, r.jb_data::text, r.dx_created,
	(select count(*) from core.cd_points as p where p.f_route = r.id) as n_count, r.n_order, r.b_draft 
    from core.cd_userinroutes as uir
    INNER JOIN core.cd_routes as r ON r.id = uir.f_route
	left join core.cs_route_statuses as rs ON r.f_status = rs.id
	where uir.f_user = _fn_user and core.sf_is_mobile_route(r.id); -- не старше текущей даты
END
$$;

ALTER FUNCTION core.cf_mui_cd_routes(_fn_user integer, _c_version text) OWNER TO mobnius;

COMMENT ON FUNCTION core.cf_mui_cd_routes(_fn_user integer, _c_version text) IS 'Получение списка "Маршрутов" мобильным приложением';
