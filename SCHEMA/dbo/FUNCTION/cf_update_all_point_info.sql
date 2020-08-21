CREATE OR REPLACE FUNCTION dbo.cf_update_all_point_info() RETURNS TABLE(id integer)
    LANGUAGE plpgsql STABLE
    AS $$
DECLARE
	_result integer;
BEGIN
	RETURN QUERY select dbo.cf_update_point_info(p.id) from core.cd_userinroutes as uir
	inner join core.cd_points as p ON p.f_route = uir.f_route
	where uir.f_user IN (select u.f_user from core.pd_userinroles as u where f_role = 14 or f_role = 15);
END
$$;

ALTER FUNCTION dbo.cf_update_all_point_info() OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_update_all_point_info() IS 'Обновление информации для точек';
