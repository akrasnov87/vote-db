CREATE OR REPLACE FUNCTION dbo.cf_mui_ed_output_conn_seals(_fn_user integer, _c_version text, _f_point uuid) RETURNS TABLE(id uuid, fn_seal uuid, fn_point uuid, fn_route uuid, fn_user_point uuid, fn_result uuid, fn_seal_new uuid, c_seal_new_name text, fn_type integer, c_type text, fn_place integer, c_place text, d_date timestamp with time zone, dx_created timestamp with time zone, d_replace_date timestamp with time zone)
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
	RETURN QUERY select s.id, s.fn_seal, s.fn_point, s.fn_route, s.fn_user_point, s.fn_result, s.fn_seal_new, concat(coalesce(ss.c_prefix, ''), ss.n_number::text), s.fn_type, st.c_name, s.fn_place, sp.c_name, s.d_date, s.dx_created, ss.d_replace_date
    from core.cd_userinroutes as uir
    LEFT JOIN core.cd_routes as r ON r.id = uir.f_route
    INNER JOIN dbo.ed_output_conn_seals as s ON s.fn_route = r.id
	inner join dbo.es_seal_places as sp ON sp.id = s.fn_place
	inner join dbo.es_seal_types as st ON st.id = s.fn_type
	inner join dbo.ed_seals as ss ON ss.id = s.fn_seal_new
    where uir.f_user = _fn_user and CASE WHEN _f_point is null THEN core.sf_is_mobile_route(r.id) ELSE s.fn_point = _f_point END;
END
$$;

ALTER FUNCTION dbo.cf_mui_ed_output_conn_seals(_fn_user integer, _c_version text, _f_point uuid) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_mui_ed_output_conn_seals(_fn_user integer, _c_version text, _f_point uuid) IS 'Выходные пломбы для обходчика';
