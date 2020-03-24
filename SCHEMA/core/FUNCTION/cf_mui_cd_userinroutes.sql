CREATE OR REPLACE FUNCTION core.cf_mui_cd_userinroutes(_fn_user integer) RETURNS TABLE(id uuid, f_route uuid, f_user integer, b_main boolean, dx_created timestamp with time zone)
    LANGUAGE plpgsql STABLE
    AS $$

BEGIN
    RETURN QUERY select * from core.cd_userinroutes as cuir
    where cuir.f_route in (
    select r.id from core.cd_userinroutes as uir
    LEFT JOIN core.cd_routes as r ON r.id = uir.f_route
    where uir.f_user = _fn_user);
END
$$;

ALTER FUNCTION core.cf_mui_cd_userinroutes(_fn_user integer) OWNER TO mobnius;
