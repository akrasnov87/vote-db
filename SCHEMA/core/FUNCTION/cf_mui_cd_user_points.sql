CREATE OR REPLACE FUNCTION core.cf_mui_cd_user_points(_fn_user integer) RETURNS TABLE(id uuid, fn_point uuid, fn_user integer, c_user text, fn_route uuid, fn_type integer, jb_tel text, jb_email text, n_longitude numeric, n_latitude numeric, c_notice text, b_check boolean, jb_data text, d_date_check timestamp with time zone, dx_created timestamp with time zone, d_date timestamp with time zone)
    LANGUAGE plpgsql STABLE
    AS $$

BEGIN
    RETURN QUERY select up.id, up.fn_point, up.fn_user, u.c_login as c_user, up.fn_route, up.fn_type, up.jb_tel::text, up.jb_email::text, up.n_longitude, up.n_latitude, up.c_notice, up.b_check, up.jb_data::text, up.d_date_check, up.dx_created, up.d_date
    from core.cd_userinroutes as uir
    LEFT JOIN core.cd_routes as rt ON rt.id = uir.f_route
    INNER JOIN core.cd_user_points as up ON up.fn_route = rt.id
    INNER JOIN core.pd_users as u ON up.fn_user = u.id
    where uir.f_user = _fn_user and core.cf_old_date(rt.d_date_end);
END
$$;

ALTER FUNCTION core.cf_mui_cd_user_points(_fn_user integer) OWNER TO mobnius;
