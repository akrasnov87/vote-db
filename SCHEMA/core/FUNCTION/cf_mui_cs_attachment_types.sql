CREATE OR REPLACE FUNCTION core.cf_mui_cs_attachment_types(_fn_user integer, _c_version text) RETURNS TABLE(id integer, c_name text, c_const text, n_order integer, b_default boolean)
    LANGUAGE plpgsql STABLE
    AS $$
/**
* @params {integer} _fn_user - идентификатор пользователя
* @params {text} _c_version - текущая версия приложения
*
* @example
* [{ "action": "cf_mui_cd_attachment_types", "method": "Select", "data": [{ "params": [_fn_user, _c_version] }], "type": "rpc", "tid": 0 }]
*/
BEGIN	
	RETURN QUERY select at.id, at.c_name, at.c_const, at.n_order, at.b_default
	from core.cs_attachment_types as at
	where at.b_disabled = false;
END
$$;

ALTER FUNCTION core.cf_mui_cs_attachment_types(_fn_user integer, _c_version text) OWNER TO mobnius;

COMMENT ON FUNCTION core.cf_mui_cs_attachment_types(_fn_user integer, _c_version text) IS 'Типы вложений';
