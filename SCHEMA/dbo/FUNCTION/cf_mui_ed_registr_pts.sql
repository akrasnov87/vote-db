CREATE OR REPLACE FUNCTION dbo.cf_mui_ed_registr_pts(_fn_user integer) RETURNS TABLE(id uuid, c_appartament_num text, n_appartament_num integer, c_house_num text, c_address text, f_division integer, f_subdivision integer)
    LANGUAGE plpgsql STABLE
    AS $$

BEGIN
    RETURN QUERY select rp.id, rp.c_appartament_num, rp.n_appartament_num, rp.c_house_num, rp.c_address, rp.f_division, rp.f_subdivision
    from core.cd_userinroutes as uir
    LEFT JOIN core.cd_routes as rt ON rt.id = uir.f_route
    INNER JOIN core.cd_points as p ON p.f_route = rt.id
    INNER JOIN dbo.ed_registr_pts as rp ON p.f_registr_pts = rp.id
    where uir.f_user = _fn_user and core.cf_old_date(rt.d_date_end) and rp.b_disabled = false;
END
$$;

ALTER FUNCTION dbo.cf_mui_ed_registr_pts(_fn_user integer) OWNER TO mobnius;
