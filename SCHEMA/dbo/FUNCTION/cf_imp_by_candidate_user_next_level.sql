CREATE OR REPLACE FUNCTION dbo.cf_imp_by_candidate_user_next_level(_user_to integer, _user_from integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	_subDivision integer;
	_result integer;
	_route_number text;
BEGIN
	select f_subdivision into _subDivision from core.pd_users where id = _user_to;
	
	PERFORM dbo.cf_finishroute(uir.f_route) from core.cd_userinroutes as uir
	inner join core.cd_routes as r ON uir.f_route = r.id
	where r.f_type = 1 and uir.f_user = _user_to;
	
	-- в указанном округе есть квартиры
	IF (select count(*) from dbo.msv_appartament where f_subdivision = _subDivision) > 0 THEN
		_result = ( select sum((SELECT dbo.cf_imp_candidate_points_next_level(_user_to, _user_from, t.f_house, t.route_id)))
					from (select 
					h.f_house, 
					(SELECT dbo.cf_create_route(h.f_house, _user_to, 5, now()::date, '2020-09-11')) as route_id
					from (SELECT h.id as f_house, h.f_subdivision, jsonb_array_elements(h.f_candidate_users)::text::integer as user_id
						from dbo.cs_house as h
						where h.f_candidate_users is not null and (select count(*) from jsonb_array_elements(h.f_candidate_users)) > 0) as h
					where h.user_id = _user_from) as t);
	ELSE
		_result = 0;
	END IF;
	
	PERFORM dbo.cf_update_point_info(p.id) from core.cd_userinroutes as uir
	inner join core.cd_routes as r ON r.id = uir.f_route
	inner join core.cd_points as p ON p.f_route = r.id
	where uir.f_user = _user_to and r.f_type = 5;
	
	RETURN _result;
END
$$;

ALTER FUNCTION dbo.cf_imp_by_candidate_user_next_level(_user_to integer, _user_from integer) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_imp_by_candidate_user_next_level(_user_to integer, _user_from integer) IS 'Импорт данных другому кандидату';
