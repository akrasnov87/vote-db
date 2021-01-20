CREATE OR REPLACE FUNCTION dbo.cf_mui_ed_input_conn_seals(_fn_user integer, _c_version text, _f_point uuid) RETURNS TABLE(id uuid, f_input_conn_seal uuid, f_registr_pts uuid, f_point uuid, c_number text, c_type text, c_place text, dx_created timestamp with time zone, d_replace_date timestamp with time zone)
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    RETURN QUERY select uuid_generate_v4(), s.id, s.f_registr_pts, p.id, concat(coalesce(s.c_prefix, ''), s.n_number::text), st.c_name, s.c_location, s.dx_created, s.d_replace_date
    from core.cd_userinroutes as uir
    inner JOIN core.cd_points as p ON p.f_route = uir.f_route
    inner JOIN core.cd_routes as rt ON rt.id = uir.f_route
	inner JOIN dbo.ed_seals as s ON s.f_registr_pts = p.f_registr_pts
	inner join dbo.es_seal_types as st ON st.id = s.f_type
    left join dbo.ed_output_conn_seals as ocs ON ocs.fn_point = p.id 
	where uir.f_user = _fn_user and (s.d_replace_date is null or ocs.fn_seal = s.id) and CASE WHEN _f_point is null THEN core.sf_is_mobile_route(rt.id) ELSE p.id = _f_point END;
END
$$;

ALTER FUNCTION dbo.cf_mui_ed_input_conn_seals(_fn_user integer, _c_version text, _f_point uuid) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_mui_ed_input_conn_seals(_fn_user integer, _c_version text, _f_point uuid) IS 'Список входных пломб для обходчика';
