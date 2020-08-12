CREATE OR REPLACE FUNCTION dbo.cf_tracking_house(_user_id integer, _d_date date) RETURNS TABLE(f_house uuid, c_address text, d_date_begin text, d_date_end text, c_fio text, c_subdivision text, f_subdivision integer, n_latitude numeric, n_longitude numeric, n_distance numeric)
    LANGUAGE plpgsql
    AS $$
BEGIN
	return query select t.f_house,
	t.c_address,
	to_char(t.d_date_begin, 'dd.MM.YYYY HH24:MI'::text) as d_date_begin,
	to_char(t.d_date_end, 'dd.MM.YYYY HH24:MI'::text) as d_date_end,
	u.c_fio,
	u.c_subdivision,
	u.f_subdivision,
	t.n_latitude, 
	t.n_longitude,
	(select dbo.sf_distance(t.n_latitude, t.n_longitude, t.n_avg_latitude, t.n_avg_longitude)) * 100000 as n_distance
	from (select *,
		(select avg(t.n_longitude) from (select tr.n_longitude from core.ad_tracking as tr where tr.fn_user = t.f_user and tr.d_date between t.d_date_begin - interval '5 minute' and t.d_date_end + interval '5 minute'
		UNION ALL
		select up.n_longitude from core.cd_user_points as up where up.n_longitude > 1 and up.fn_user =  t.f_user and up.d_date between t.d_date_begin - interval '5 minute' and t.d_date_end + interval '5 minute') as t) as n_avg_longitude,
		(select avg(t.n_latitude) from (select tr.n_latitude from core.ad_tracking as tr where tr.fn_user = t.f_user and tr.d_date between t.d_date_begin - interval '5 minute' and t.d_date_end + interval '5 minute'
		UNION ALL
		select up.n_latitude from core.cd_user_points as up where up.n_latitude > 1 and up.fn_user =  t.f_user and up.d_date between t.d_date_begin - interval '5 minute' and t.d_date_end + interval '5 minute') as t) as n_avg_latitude
	from (select 
		r.f_house, 
		max(r.c_number) as c_address,
		min(rs.d_date) as d_date_begin,
		max(rs.d_date) as d_date_end,
		max(rs.fn_user) as f_user,
		max(h.n_longitude) as n_longitude,
		max(h.n_latitude) as n_latitude
	from core.cd_results as rs
	inner join core.cd_routes as r ON r.id = rs.fn_route
	inner join dbo.cs_house as h ON r.f_house = h.id 
	where rs.d_date::date = _d_date
	group by r.f_house) as t) as t
	inner join core.pv_users as u ON t.f_user = u.id
	where u.id = _user_id
	order by u.f_subdivision, t.c_address;
END
$$;

ALTER FUNCTION dbo.cf_tracking_house(_user_id integer, _d_date date) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_tracking_house(_user_id integer, _d_date date) IS 'Список домов которые обошел агитатор';
