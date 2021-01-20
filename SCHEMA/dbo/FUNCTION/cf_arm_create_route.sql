CREATE OR REPLACE FUNCTION dbo.cf_arm_create_route(_f_current_user integer, _registr_pts json, _d_start date, _d_end date, _c_number text, _users json, _f_route_type integer, _b_draft boolean) RETURNS TABLE(id uuid, n_status integer)
    LANGUAGE plpgsql
    AS $$
/**
* @params {integer} _f_current_user - текущий пользователь
* @params {json} _registr_pts - идент-ры точек учета, передавать в виде строку иден-ров, например '[{"id": "40170afe-498d-4ff0-a1e7-9f29d470cf0a", "f_type": 1}, {"id": "16dc8d78-04db-45ac-ab02-2112000478c2", "f_type": 2}]'
* @params {date} _d_start - дата начала, например 2020-10-07
* @params {date} _d_end - дата завершения, например 2020-10-30
* @params {text} _c_number - номер маршрута
* @params {json} _users - список исполнителей, передается в виде строки '[{"id": 4, "b_main": true}, {"id": 23, "b_main": false}]'
* @params {integer} _f_route_type - тип маршрута
* @params {boolean} _b_draft - является черновиком, предназначена для указания демонстрационного маршрута. По умолчанию передать false
*
* @returns
* 0 - OK
* 1 - нет пользователя
* 2 - точки учета не переданы
*
* @example
* [{ "action": "cf_arm_create_route", "method": "Query", "data": [{ "params": [_f_current_user, _registr_pts, _d_start, _d_end, _c_number, _users, _f_route_type, _b_draft] }], "type": "rpc", "tid": 0}]
*/
DECLARE
	_status_id integer; -- статус "Сформирован"
	_route_id uuid;
	_status_create_id integer;
BEGIN
	IF (select count(*) from core.pd_users as u where u.id = _f_current_user) = 1 THEN
		IF (select count(*) from json_array_elements(_registr_pts)) > 0 THEN
			select uuid_generate_v4() into _route_id;

			insert into core.cd_routes (id, f_type, c_number, d_date, d_date_start, d_date_end, c_notice, b_extended, d_extended, n_order, b_draft)
			values (_route_id, _f_route_type, _c_number, now(), _d_start, _d_end, '', false, null, 1, _b_draft);

			select rs.id into _status_create_id 
			from core.cs_route_statuses as rs
			where rs.c_const = 'CREATE';

			insert into core.cd_route_history (fn_route, fn_status, fn_user, d_date, c_notice)
			values (_route_id, _status_create_id, _f_current_user, now(), '');

			IF _users is not null and (select count(*) from json_array_elements(_users::json)) > 0 THEN
				-- ищем статус "Сформирован"
				select rs.id into _status_id 
				from core.cs_route_statuses as rs
				where rs.c_const = 'CREATED';

				-- создаем привязку
				insert into core.cd_userinroutes(f_route, f_user, b_main)
				select 
					_route_id, 
					(t.value #>> '{id}')::integer, 
					(t.value #>> '{b_main}')::boolean 
				from json_array_elements(_users::json) as t;

				-- создаем новый статус
				insert into core.cd_route_history (fn_route, fn_status, fn_user, d_date, c_notice)
				values (_route_id, _status_id, _f_current_user, now(), '');
			END IF;

			-- f_type = 1 задание для снятия показаний 
			insert into core.cd_points (f_registr_pts, f_route, f_type, c_notice, c_info, jb_data, n_order, sn_delete)
			select (t.value #>> '{id}')::uuid, _route_id, (t.value #>> '{f_type}')::integer, null, dbo.sf_generate_point_info(rp.id), dbo.sf_generate_point_jb_data(rp.id), 1, false
			from json_array_elements(_registr_pts) as t
			inner join dbo.ed_registr_pts as rp ON rp.id = (t.value #>> '{id}')::uuid
			left join dbo.ss_address as ad ON ad.id = rp.f_address
			order by ad.c_name;

			RETURN QUERY select _route_id, 0;
		ELSE
			RETURN QUERY select null::uuid, 2; -- точки не переданы
		END IF;
	ELSE
		RETURN QUERY select null::uuid, 1; -- нет пользователя
	END IF;
END
$$;

ALTER FUNCTION dbo.cf_arm_create_route(_f_current_user integer, _registr_pts json, _d_start date, _d_end date, _c_number text, _users json, _f_route_type integer, _b_draft boolean) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_arm_create_route(_f_current_user integer, _registr_pts json, _d_start date, _d_end date, _c_number text, _users json, _f_route_type integer, _b_draft boolean) IS 'Создание маршрута на основе точек учета';
