CREATE OR REPLACE FUNCTION dbo.cf_mui_ed_registr_pts(_fn_user integer) RETURNS TABLE(id uuid, c_subscr text, c_device text, jb_tel text, jb_email text, c_address text, c_fio text, n_longitude numeric, n_latitude numeric, f_user integer, f_division integer, f_subdivision integer, b_disabled boolean)
    LANGUAGE plpgsql STABLE
    AS $$

BEGIN
    RETURN QUERY select rp.id, rp.c_subscr, rp.c_device, rp.jb_tel::text, rp.jb_email::text, rp.c_address, rp.c_fio, rp.n_longitude, rp.n_latitude, rp.f_user, rp.f_division, rp.f_subdivision, rp.b_disabled
    from core.cd_userinroutes as uir
    LEFT JOIN core.cd_routes as rt ON rt.id = uir.f_route
    INNER JOIN core.cd_points as p ON p.f_route = rt.id
    INNER JOIN dbo.ed_registr_pts as rp ON p.f_registr_pts = rp.id
    where uir.f_user = _fn_user and core.cf_old_date(rt.d_date_end);
END
$$;

ALTER FUNCTION dbo.cf_mui_ed_registr_pts(_fn_user integer) OWNER TO mobnius;
