CREATE OR REPLACE FUNCTION core.cf_mui_pd_users(_fn_user integer) RETURNS TABLE(id integer, f_parent integer, c_login text, c_firstname text, c_lastname text, c_patronymic text, c_email text, c_tel text, c_description text, b_disabled boolean, f_uik integer)
    LANGUAGE plpgsql STABLE
    AS $$

BEGIN
    RETURN QUERY select u.id, u.f_parent, u.c_login, u.c_firstname, u.c_lastname, u.c_patronymic, u.c_email, u.c_tel, u.c_description, u.b_disabled, u.f_uik::integer from core.pd_users as u
    where u.id in (
    select distinct cuir.f_user from core.cd_userinroutes as cuir
    where cuir.f_route in (
    select r.id 
    from core.cd_userinroutes as uir
    LEFT JOIN core.cd_routes as r ON r.id = uir.f_route
    where uir.f_user = _fn_user));
END
$$;

ALTER FUNCTION core.cf_mui_pd_users(_fn_user integer) OWNER TO mobnius;
