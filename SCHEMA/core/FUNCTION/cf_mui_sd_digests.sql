CREATE OR REPLACE FUNCTION core.cf_mui_sd_digests(_fn_user integer, _c_version text) RETURNS TABLE(id integer, c_version text, c_description text, dx_created timestamp with time zone, n_version bigint)
    LANGUAGE plpgsql STABLE
    AS $$
/**
* @params {integer} _fn_user - идентификатор пользователя
* @params {text} _c_version - текущая версия приложения
*
* @example
* [{ "action": "cf_mui_sd_digests", "method": "Select", "data": [{ "params": [_fn_user, _c_version] }], "type": "rpc", "tid": 0 }]
*/
BEGIN
    RETURN QUERY select d.id, d.c_version, d.c_description, d.dx_created, d.n_version from core.sd_digests as d;
END
$$;

ALTER FUNCTION core.cf_mui_sd_digests(_fn_user integer, _c_version text) OWNER TO mobnius;

COMMENT ON FUNCTION core.cf_mui_sd_digests(_fn_user integer, _c_version text) IS 'Получение списка версий мобильным приложением';
