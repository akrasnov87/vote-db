CREATE OR REPLACE FUNCTION core.cf_mui_cd_results(_fn_user integer) RETURNS TABLE(id uuid, fn_route uuid, fn_point uuid, fn_user_point uuid, fn_type integer, fn_user integer, fn_question integer, fn_answer integer, d_date timestamp with time zone, c_notice text, b_warning boolean, jb_data text, n_order integer, dx_created timestamp with time zone, n_rating integer)
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
	RETURN QUERY WITH results as (select * from core.cd_results as r
		where r.id IN (
		select max(r.id::text)::uuid from core.cd_results as r
		where r.fn_user = _fn_user
		group by r.fn_point
		order by max(r.d_date) desc)
	)
	select r.id, r.fn_route, r.fn_point, r.fn_user_point, r.fn_type, r.fn_user, r.fn_question, r.fn_answer, r.d_date, r.c_notice, r.b_warning, r.jb_data::text, r.n_order, r.dx_created, r.n_rating
		from core.cd_userinroutes as uir
		INNER JOIN results as r ON r.fn_route = uir.f_route
		LEFT JOIN core.cd_routes as rt ON uir.f_route = rt.id
		where dbo.cf_old_date(rt.d_date_end);
END
$$;

ALTER FUNCTION core.cf_mui_cd_results(_fn_user integer) OWNER TO mobnius;
