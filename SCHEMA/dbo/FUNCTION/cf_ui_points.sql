CREATE OR REPLACE FUNCTION dbo.cf_ui_points(_user_id integer) RETURNS TABLE(f_route uuid, f_point uuid, c_address text, b_done boolean, d_done_date timestamp with time zone, n_longitude numeric, n_latitude numeric)
    LANGUAGE plpgsql STABLE
    AS $$

BEGIN
    RETURN QUERY  
	select
		r.id as f_route,
		p.id as f_point,
		concat(r.c_number, ' кв. ', p.jb_data->>'c_appartament_num') as c_address,
		(select count(*) from core.cd_user_points where fn_point = p.id) > 0 as b_done,
		(select up.d_date from core.cd_user_points as up where fn_point = p.id LIMIT 1) as d_done_date,
		coalesce((select up.n_longitude from core.cd_user_points as up where up.fn_point = p.id LIMIT 1), 0.0) as n_longitude,
		coalesce((select up.n_latitude from core.cd_user_points as up where up.fn_point = p.id LIMIT 1), 0.0) as n_latitude
	from core.cd_points as p
	inner join core.cd_routes as r ON r.id = p.f_route
	where p.f_route IN (select uir.f_route from core.cd_userinroutes as uir
	where uir.f_user = _user_id) and CURRENT_DATE <= r.d_date_end;
END
$$;

ALTER FUNCTION dbo.cf_ui_points(_user_id integer) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_ui_points(_user_id integer) IS 'Список точек в маршрутах пользователя';
