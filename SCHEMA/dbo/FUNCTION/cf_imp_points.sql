CREATE OR REPLACE FUNCTION dbo.cf_imp_points(_user_id integer, _route_id uuid) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	_result integer;
BEGIN
	-- _route_id = uuid_generate_v4();
	
	insert into core.cd_points(f_registr_pts, f_route, c_notice, c_info, n_order)
	select id, _route_id, 'auto', null, n_number from dbo.cs_apartament
	where f_user = _user_id;
	
	_result = (select count(*) from dbo.cs_apartament where f_user = _user_id);
	RETURN _result;
END
$$;

ALTER FUNCTION dbo.cf_imp_points(_user_id integer, _route_id uuid) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_imp_points(_user_id integer, _route_id uuid) IS 'Импорт точек маршрута';
