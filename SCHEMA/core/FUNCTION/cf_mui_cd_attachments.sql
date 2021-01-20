CREATE OR REPLACE FUNCTION core.cf_mui_cd_attachments(_fn_user integer, _c_version text) RETURNS TABLE(id uuid, c_name text, c_mime text, fn_type integer, fn_result uuid, fn_route uuid, fn_point uuid, d_date timestamp with time zone, n_longitude numeric, n_latitude numeric, fn_file uuid, c_notice text, jb_data text, dx_created timestamp with time zone, ba_data bytea, n_size integer, ba_file bytea, n_file_size integer)
    LANGUAGE plpgsql STABLE
    AS $$
/**
* @params {integer} _fn_user - идентификатор пользователя
* @params {text} _c_version - текущая версия приложения
*
* @example
* [{ "action": "cf_mui_cd_attachments", "method": "Select", "data": [{ "params": [_fn_user, _c_version] }], "type": "rpc", "tid": 0 }]
*/
BEGIN
	IF _fn_user IS NOT NULL THEN	
		RETURN QUERY select a.id, f.c_name, f.c_mime, a.fn_type, a.fn_result, a.fn_route, a.fn_point, a.d_date, a.n_longitude, a.n_latitude, a.fn_file, a.c_notice, a.jb_data::text, a.dx_created, a.ba_data, a.n_size, null::bytea as ba_file, f.n_size as n_file_size
		from core.cd_userinroutes as uir
		INNER JOIN core.cd_attachments as a ON a.fn_route = uir.f_route
		INNER JOIN core.cd_files as f ON f.id = a.fn_file
		where uir.f_user = _fn_user and core.sf_is_mobile_route(uir.f_route);	
	ELSE
		RETURN QUERY select a.id, f.c_name, f.c_mime, a.fn_type, a.fn_result, a.fn_route, a.fn_point, a.d_date, a.n_longitude, a.n_latitude, a.fn_file, a.c_notice, a.jb_data::text, a.dx_created, a.ba_data, a.n_size, null::bytea as ba_file, f.n_size as n_file_size
		from core.cd_attachments as a
		INNER JOIN core.cd_files as f ON f.id = a.fn_file;
	END IF;
END
$$;

ALTER FUNCTION core.cf_mui_cd_attachments(_fn_user integer, _c_version text) OWNER TO mobnius;

COMMENT ON FUNCTION core.cf_mui_cd_attachments(_fn_user integer, _c_version text) IS 'Получение списка "Вложений" мобильным приложением';
