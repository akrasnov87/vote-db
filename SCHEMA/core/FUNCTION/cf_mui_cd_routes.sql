CREATE OR REPLACE FUNCTION core.cf_mui_cd_routes(_fn_user integer) RETURNS TABLE(id uuid, f_type integer, c_number text, d_date timestamp with time zone, d_date_start date, d_date_end date, c_notice text, b_extended boolean, d_extended date, jb_data text, dx_created timestamp with time zone, n_count bigint, n_order integer)
    LANGUAGE plpgsql STABLE
    AS $$

BEGIN
    RETURN QUERY select r.id, r.f_type, r.c_number, r.d_date, r.d_date_start, r.d_date_end, r.c_notice, r.b_extended, r.d_extended, r.jb_data::text, r.dx_created, (select count(*) from core.cd_points as p where p.f_route = r.id) as n_count, r.n_order 
    from core.cd_userinroutes as uir
    LEFT JOIN core.cd_routes as r ON r.id = uir.f_route
    where uir.f_user = _fn_user and core.cf_old_date(r.d_date_end); -- не старше текущей даты
END
$$;

ALTER FUNCTION core.cf_mui_cd_routes(_fn_user integer) OWNER TO mobnius;
