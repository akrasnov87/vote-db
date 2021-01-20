CREATE OR REPLACE FUNCTION dbo.cf_arm_pd_users_stat(_f_main_division integer, _f_division integer, _f_subdivision integer, _f_manager integer, _f_user integer) RETURNS TABLE(id integer, c_login text, c_first_name text, c_last_name text, c_middle_name text, fn_file uuid, n_route_active bigint, d_tracking_date timestamp with time zone)
    LANGUAGE plpgsql
    AS $$
/**
* @params {integer} _f_main_division - иден. филиал. Обязателен при передаче
* @params {integer} _f_division - иден. отделение. Обязателен при передаче
* @params {integer} _f_subdivision - иден. участок. Обязателен при передаче
* @params {integer} _f_manager - иден. диспетчер. Может быть null
* @params {integer} _f_user - иден. обходчика. Может быть null
*
* @example
* [{ "action": "cf_arm_pd_users_stat", "method": "Select", "data": [{ "params": [_f_main_division, _f_division, _f_subdivision, _f_manager, _f_user] }], "type": "rpc", "tid": 0}]
*/

BEGIN
	RETURN QUERY select 
		u.*, -- общая информация о пользователе
		(select count(*) from dbo.cf_arm_cd_routes(u.id, now()::date)) as n_route_active, -- кол-во активных маршрутов
		(select a.d_date from core.ad_tracking as a where a.fn_user = u.id order by a.d_date desc limit 1) as d_tracking_date -- время последнего получения геокординаты
	from dbo.cf_arm_pd_users(_f_main_division, _f_division, _f_subdivision, _f_manager, _f_user) as u;
END
$$;

ALTER FUNCTION dbo.cf_arm_pd_users_stat(_f_main_division integer, _f_division integer, _f_subdivision integer, _f_manager integer, _f_user integer) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_arm_pd_users_stat(_f_main_division integer, _f_division integer, _f_subdivision integer, _f_manager integer, _f_user integer) IS 'Получение статистика для обходчиков по заданному фильтру';
