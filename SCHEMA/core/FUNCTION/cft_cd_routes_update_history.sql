CREATE OR REPLACE FUNCTION core.cft_cd_routes_update_history() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	_f_route uuid;
	_f_status integer;
	_n_status_weight integer;
	_f_user integer;
BEGIN
	-- все вычисления производяться после выполнения операций
    IF (TG_OP = 'INSERT' OR TG_OP = 'UPDATE') THEN
		select NEW.fn_route into _f_route;
		select NEW.fn_user into _f_user;
	ELSE	
		select OLD.fn_route into _f_route;
    END IF;
    
    select rs.id into _f_status from core.cd_route_history as rh 
	inner join core.cs_route_statuses as rs ON rs.id = rh.fn_status
	where rh.fn_route = _f_route 
	order by rs.n_order desc limit 1;
    
    -- если это второй помощник, а не главный то статус не меняем
    update core.cd_routes as r
		set f_status = _f_status
		where r.id = _f_route;

    RETURN NULL; -- result is ignored since this is an AFTER trigger
END
$$;

ALTER FUNCTION core.cft_cd_routes_update_history() OWNER TO mobnius;

COMMENT ON FUNCTION core.cft_cd_routes_update_history() IS 'Триггер. Обновление истории в маршрутах';
