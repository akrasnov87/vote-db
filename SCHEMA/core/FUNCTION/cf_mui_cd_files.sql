CREATE OR REPLACE FUNCTION core.cf_mui_cd_files(_fn_user integer, _c_version text) RETURNS TABLE(id uuid, c_name text, d_date timestamp with time zone, c_mime text, c_extension text, jb_data text, ba_data bytea, n_size integer, dx_created timestamp with time zone)
    LANGUAGE plpgsql STABLE
    AS $$
/**
* @params {integer} _fn_user - идентификатор пользователя
* @params {text} _c_version - текущая версия приложения
*
* @example
* [{ "action": "cf_mui_cd_files", "method": "Select", "data": [{ "params": [_fn_user, _c_version] }], "type": "rpc", "tid": 0 }]
*/
BEGIN
	IF _fn_user IS NOT NULL THEN
		-- для файла специально указываем null, чтобы телефон не обрабатывал данные 
		RETURN QUERY select f.id, f.c_name, f.d_date, f.c_mime, f.c_extension, f.jb_data::text, null::bytea, f.n_size, f.dx_created 
		from core.cd_userinroutes as uir
		INNER JOIN core.cd_attachments as a ON a.fn_route = uir.f_route
		INNER JOIN core.cd_files as f ON f.id = a.fn_file
		where uir.f_user = _fn_user and core.sf_is_mobile_route(uir.f_route);
		
		--RETURN QUERY select f.id, f.c_name, f.d_date, f.c_mime, f.c_extension, f.jb_data::text, null::bytea, f.n_size, f.dx_created 
		--from core.cd_files as f
		--inner join core.cd_attachments as a ON a.fn_file = f.id
		--inner join core.cd_routes as r ON a.fn_route = r.id
		--inner join core.cd_results as rr ON rr.id = a.fn_result
		--where rr.fn_user = _fn_user or core.sf_is_mobile_route(r.id);
		
		--UNION
		
		--select f.id, f.c_name, f.d_date, f.c_mime, f.c_extension, f.jb_data::text, f.ba_data, f.n_size, f.dx_created 
		--from core.cd_files as f
		--where f.id in (select u.fn_file from core.pd_users as u where u.id = _fn_user) or 
			 --f.id in (select fb.fn_question_file from core.cd_feedbacks as fb where fb.fn_user = _fn_user and fb.fn_question_file is not null)
			--or f.id in (select fb.fn_answer_file from core.cd_feedbacks as fb where fb.fn_user = _fn_user and fb.fn_answer_file is not null);
	ELSE
		RETURN QUERY select f.id, f.c_name, f.d_date, f.c_mime, f.c_extension, f.jb_data::text, null::bytea, f.n_size, f.dx_created 
		from core.cd_files as f;
	END IF;
END
$$;

ALTER FUNCTION core.cf_mui_cd_files(_fn_user integer, _c_version text) OWNER TO mobnius;

COMMENT ON FUNCTION core.cf_mui_cd_files(_fn_user integer, _c_version text) IS 'Получение списка "Файлов" мобильным приложением';
