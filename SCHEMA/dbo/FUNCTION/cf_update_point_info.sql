CREATE OR REPLACE FUNCTION dbo.cf_update_point_info(_point_id uuid) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	_c_info text;
BEGIN
	select array_to_string(array(
	select (concat('[', to_char(r.d_date, 'DD.MM.YYYY HH24:MI'), ']', ' ', coalesce(u.c_fio, concat('Агитатор ', u.c_login)), ' ', a.c_text)) as c_txt
	from core.cd_results as r
	inner join core.cd_points as p ON p.id = r.fn_point
	inner join dbo.cs_answer as a ON a.id = r.fn_answer
	inner join core.pd_users as u ON u.id = r.fn_user
	where p.id = _point_id
	order by r.d_date desc), '\n\n') into _c_info;

	update core.cd_points as p
	set c_info = _c_info
	where p.id = _point_id;
	
	RETURN 0;
END
$$;

ALTER FUNCTION dbo.cf_update_point_info(_point_id uuid) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_update_point_info(_point_id uuid) IS 'Обновление информации в точке маршрута';
