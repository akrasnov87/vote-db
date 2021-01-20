CREATE OR REPLACE FUNCTION core.cf_mui_cd_attachment(_id uuid) RETURNS TABLE(c_address text, c_mime text, d_date timestamp with time zone, n_longitude numeric, n_latitude numeric, ba_data bytea, ba_file bytea)
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
	RETURN QUERY select ad.c_name, f.c_mime, a.d_date, a.n_longitude, a.n_latitude, a.ba_data, f.ba_data as ba_file
	from core.cd_attachments as a
	INNER JOIN core.cd_files as f ON f.id = a.fn_file
	inner join core.cd_results as r ON a.fn_result = r.id
	inner join core.cd_points as p on r.fn_point = p.id
	inner join dbo.ed_registr_pts as rp ON rp.id = p.f_registr_pts
	inner join dbo.ss_address as ad ON ad.id = rp.f_address
	where a.id = _id;
END
$$;

ALTER FUNCTION core.cf_mui_cd_attachment(_id uuid) OWNER TO mobnius;

COMMENT ON FUNCTION core.cf_mui_cd_attachment(_id uuid) IS 'Получение "Вложения" мобильным приложением';
