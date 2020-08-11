CREATE OR REPLACE FUNCTION dbo.cf_imp_by_candidate_user(_user_id integer, _route_type_id integer, _date_activate date, _date_limit date) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	_subDivision integer;
	_result integer;
	_route_number text;
BEGIN
	select f_subdivision into _subDivision from core.pd_users where id = _user_id;
	
	-- в указанном округе есть квартиры
	IF (select count(*) from dbo.msv_appartament where f_subdivision = _subDivision) > 0 THEN
		_result = ( select sum((SELECT dbo.cf_imp_candidate_points(_user_id, t.f_house, t.route_id)))
					from (select 
					h.f_house, 
					(SELECT dbo.cf_create_route(h.f_house, _user_id, _route_type_id, _date_activate, _date_limit)) as route_id

					from (SELECT h.id as f_house, h.f_subdivision, jsonb_array_elements(h.f_candidate_users)::text::integer as user_id
						from dbo.cs_house as h
						where h.f_candidate_users is not null and (select count(*) from jsonb_array_elements(h.f_candidate_users)) > 0) as h
					where h.user_id = _user_id) as t);
	ELSE
		_result = 0;
	END IF;
	
	RETURN _result;
END
$$;

ALTER FUNCTION dbo.cf_imp_by_candidate_user(_user_id integer, _route_type_id integer, _date_activate date, _date_limit date) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_imp_by_candidate_user(_user_id integer, _route_type_id integer, _date_activate date, _date_limit date) IS 'Импорт данных для пользователя-кандидат';
