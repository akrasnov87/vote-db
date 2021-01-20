CREATE OR REPLACE FUNCTION core.cf_finish_route(_id uuid) RETURNS integer
    LANGUAGE plpgsql
    AS $$
/**
 * Принудительное завершение маршрута
 * @params {uuid} _id идентификатор маршрута
 * @returns {integer} 0 - все выполнено
 */
BEGIN
	update core.cd_routes as r
	set d_date_end = now()::date - interval '1 day' 
	where r.id = _id;
	
	insert into core.cd_route_history(fn_route, fn_status, fn_user, d_date, c_notice, dx_created)
	values(_id, 6, 1, now(), 'Завершено принудительно', now());
	
	RETURN 0;
END
$$;

ALTER FUNCTION core.cf_finish_route(_id uuid) OWNER TO mobnius;

COMMENT ON FUNCTION core.cf_finish_route(_id uuid) IS 'Завершение маршрута';
