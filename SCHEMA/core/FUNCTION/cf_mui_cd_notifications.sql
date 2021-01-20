CREATE OR REPLACE FUNCTION core.cf_mui_cd_notifications(_fn_user integer, _c_version text) RETURNS TABLE(id uuid, c_title text, c_message text, d_date timestamp with time zone)
    LANGUAGE plpgsql STABLE
    AS $$
/**
* @params {integer} _fn_user - идентификатор пользователя
* @params {text} _c_version - текущая версия приложения
*
* @example
* [{ "action": "cf_mui_cd_notifications", "method": "Select", "data": [{ "params": [_fn_user, _c_version] }], "type": "rpc", "tid": 0 }]
*/
BEGIN
    RETURN QUERY 
	select n.id, n.c_title, n.c_message, n.d_date
	from core.cd_notifications as n
    where n.fn_user_to = _fn_user or n.fn_user_from = _fn_user
	order by n.d_date desc;
END
$$;

ALTER FUNCTION core.cf_mui_cd_notifications(_fn_user integer, _c_version text) OWNER TO mobnius;

COMMENT ON FUNCTION core.cf_mui_cd_notifications(_fn_user integer, _c_version text) IS 'Получение списка "Уведомлений" мобильным приложением';
