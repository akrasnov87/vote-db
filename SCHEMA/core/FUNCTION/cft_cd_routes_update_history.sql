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
    
    select rs.id, rs.n_order into _f_status, _n_status_weight from core.cd_route_history as rh 
	inner join core.cs_route_statuses as rs ON rs.id = rh.fn_status
	where rh.fn_route = _f_route 
	order by rh.d_date desc, rs.n_order desc limit 1;
    
    IF ((_n_status_weight <= 1 OR _n_status_weight >= 1000) OR -- если статус меньше чем 1 или больше 1000, то это Диспетчер 
		(select count(*) from core.cd_userinroutes as uir
    	where uir.f_route = _f_route and uir.f_user = _f_user and uir.b_main) >= 1) THEN -- если это главный обходчик
    
		update core.cd_routes as r
		set f_status = _f_status
		where r.id = _f_route;
	
	END IF;

    RETURN NULL; -- result is ignored since this is an AFTER trigger
END
$$;

ALTER FUNCTION core.cft_cd_routes_update_history() OWNER TO mobnius;

COMMENT ON FUNCTION core.cft_cd_routes_update_history() IS 'Триггер. Обновление истории в маршрутах';
