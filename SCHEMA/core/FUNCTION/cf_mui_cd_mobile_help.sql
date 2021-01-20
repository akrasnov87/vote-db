CREATE OR REPLACE FUNCTION core.cf_mui_cd_mobile_help(_fn_user integer, _c_version text) RETURNS TABLE(id uuid, c_key text, c_html text, d_date timestamp with time zone, c_title text)
    LANGUAGE plpgsql STABLE
    AS $$
/**
* @params {integer} _fn_user - идентификатор пользователя
* @params {text} _c_version - текущая версия приложения
*
* @example
* [{ "action": "cf_mui_cd_mobile_help", "method": "Select", "data": [{ "params": [_fn_user, _c_version] }], "type": "rpc", "tid": 0 }]
*/
BEGIN	
	RETURN QUERY select mh.id, mh.c_key, mh.c_html, mh.d_date, mh.c_title
	from core.cd_mobile_help as mh
	where mh.b_disabled = false;
END
$$;

ALTER FUNCTION core.cf_mui_cd_mobile_help(_fn_user integer, _c_version text) OWNER TO mobnius;

COMMENT ON FUNCTION core.cf_mui_cd_mobile_help(_fn_user integer, _c_version text) IS 'Справочная информация для мобильного устройства';
