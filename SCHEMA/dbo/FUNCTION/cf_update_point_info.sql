CREATE OR REPLACE FUNCTION dbo.cf_update_point_info(_point_id uuid) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	_c_info text;
	_f_appartament uuid;
BEGIN
	select p.f_appartament into _f_appartament from core.cd_points as p
	where p.id = _point_id;

	select array_to_string(array(
	select (concat('<p><b>', to_char(r.d_date, 'DD.MM.YYYY HH24:MI'), '</b> ', coalesce(u.c_fio, concat('Агитатор ', u.c_login)), '<br />', a.c_text, ' (', coalesce(r.n_rating, '0'), '★)</p>')) as c_txt
	from core.cd_results as r
	inner join core.cd_points as p ON p.id = r.fn_point
	inner join dbo.cs_answer as a ON a.id = r.fn_answer
	inner join core.pd_users as u ON u.id = r.fn_user
	where p.f_appartament = _f_appartament
	order by r.d_date desc), '<hr />') into _c_info;

	update core.cd_points as p
	set c_info = _c_info
	where p.id = _point_id;
	
	RETURN 0;
END
$$;

ALTER FUNCTION dbo.cf_update_point_info(_point_id uuid) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_update_point_info(_point_id uuid) IS 'Обновление информации в точке маршрута';
