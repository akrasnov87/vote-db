CREATE OR REPLACE FUNCTION dbo.cf_mui_es_work_links(_fn_user integer, _c_version text) RETURNS TABLE(id integer, f_route_type integer, f_point_type integer, f_result_type integer)
    LANGUAGE plpgsql STABLE
    AS $$
/**
* @params {integer} _fn_user - идентификатор пользователя
* @params {text} _c_version - текущая версия приложения
*
* @example
* [{ "action": "cf_mui_es_work_links", "method": "Select", "data": [{ "params": [_fn_user, _c_version] }], "type": "rpc", "tid": 0 }]
*/
BEGIN	
	RETURN QUERY select el.id, el.f_route_type, el.f_point_type, el.f_result_type
	from dbo.es_work_links as el
	where el.b_disabled = false;
END
$$;

ALTER FUNCTION dbo.cf_mui_es_work_links(_fn_user integer, _c_version text) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_mui_es_work_links(_fn_user integer, _c_version text) IS 'Сопоставление видов работ';
