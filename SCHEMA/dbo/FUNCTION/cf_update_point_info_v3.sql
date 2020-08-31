CREATE OR REPLACE FUNCTION dbo.cf_update_point_info_v3(_point_id uuid) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	_c_info text;
	_f_appartament uuid;
BEGIN
	select p.f_appartament into _f_appartament from core.cd_points as p
	where p.id = _point_id;

	select concat('Ставили подпись: ', count(*)) into _c_info from dbo.cd_people as p
	where p.f_type = 7 and p.f_appartament = _f_appartament;

	update core.cd_points as p
	set c_info = _c_info
	where p.id = _point_id;
	
	RETURN 0;
END
$$;

ALTER FUNCTION dbo.cf_update_point_info_v3(_point_id uuid) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_update_point_info_v3(_point_id uuid) IS 'Обновление информации в точке маршрута для 3 волны';
