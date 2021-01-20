CREATE OR REPLACE FUNCTION core.cf_mui_pd_users(_fn_user integer, _c_version text) RETURNS TABLE(id integer, f_parent integer, c_login text, fn_file uuid, c_fio text, c_description text, b_disabled boolean)
    LANGUAGE plpgsql STABLE
    AS $$
/**
* @params {integer} _fn_user - идентификатор пользователя
* @params {text} _c_version - текущая версия приложения
*
* @example
* [{ "action": "cf_mui_pd_users", "method": "Select", "data": [{ "params": [_fn_user, _c_version] }], "type": "rpc", "tid": 0 }]
*/
BEGIN
    RETURN QUERY select u.id, u.f_parent, u.c_login, u.fn_file, concat(u.c_last_name, ' ', u.c_first_name, ' ', u.c_middle_name), u.c_description, u.b_disabled 
	from core.pd_users as u
    where u.id in (
    select distinct cuir.f_user from core.cd_userinroutes as cuir
    where cuir.f_route in (
    select r.id 
    from core.cd_userinroutes as uir
    LEFT JOIN core.cd_routes as r ON r.id = uir.f_route
    where uir.f_user = _fn_user and core.sf_is_mobile_route(r.id))) OR u.id = _fn_user;
END
$$;

ALTER FUNCTION core.cf_mui_pd_users(_fn_user integer, _c_version text) OWNER TO mobnius;

COMMENT ON FUNCTION core.cf_mui_pd_users(_fn_user integer, _c_version text) IS 'Получение списка пользователей мобильным приложением';
