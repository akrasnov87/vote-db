CREATE OR REPLACE FUNCTION dbo.cf_rpt_cd_results(_fn_user integer, _f_type integer) RETURNS TABLE(id uuid, fn_route uuid, fn_point uuid, fn_user_point uuid, fn_type integer, fn_user integer, fn_question integer, fn_answer integer, d_date timestamp with time zone, c_notice text, b_warning boolean, jb_data text, n_order integer, dx_created timestamp with time zone, n_rating integer)
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
	RETURN QUERY WITH items as (
		select uir.f_route from core.cd_userinroutes as uir
		INNER JOIN core.cd_routes as r ON r.id = uir.f_route
		where uir.f_user = _fn_user and r.f_type = _f_type
	)
	select r.id, r.fn_route, r.fn_point, r.fn_user_point, r.fn_type, r.fn_user, r.fn_question, r.fn_answer, r.d_date, r.c_notice, r.b_warning, r.jb_data::text, r.n_order, r.dx_created, r.n_rating
	from core.cd_results as r
	where r.fn_route IN (select i.f_route from items as i);
END
$$;

ALTER FUNCTION dbo.cf_rpt_cd_results(_fn_user integer, _f_type integer) OWNER TO mobnius;
