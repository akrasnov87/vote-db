CREATE OR REPLACE FUNCTION core.cf_mui_cd_route_history(_fn_user integer) RETURNS TABLE(id uuid, fn_route uuid, fn_status integer, fn_user integer, d_date timestamp with time zone, c_notice text, dx_created timestamp with time zone)
    LANGUAGE plpgsql STABLE
    AS $$

BEGIN
    RETURN QUERY select rh.id, rh.fn_route, rh.fn_status, rh.fn_user, rh.d_date, rh.c_notice, rh.dx_created
    from core.cd_userinroutes as uir
    LEFT JOIN core.cd_route_history as rh ON rh.fn_route = uir.f_route
    INNER JOIN core.cd_routes as rt ON rt.id = uir.f_route
    where uir.f_user = _fn_user and core.cf_old_date(rt.d_date_end);
END
$$;

ALTER FUNCTION core.cf_mui_cd_route_history(_fn_user integer) OWNER TO mobnius;
