CREATE OR REPLACE FUNCTION dbo.cf_arm_seals_edit(_seals json, _f_user integer, _b_remove boolean) RETURNS integer
    LANGUAGE plpgsql
    AS $$
/**
* @params {json} _seals - список пломб, требуется передать в виде строки '["e7ded0cd-12dd-47f5-a75b-192376291e83"]'
* @params {integer} _f_user - текущий пользователь, который работает с пломбами
* @params {boolean} _b_remove - true - удаление. Физически удаление не производиться, только update
*
* @returns {integer}
* 0 - ОК
* 1 - пользователь не найден
*
* @example
* [{ "action": "cf_arm_seals_edit", "method": "Query", "data": [{ "params": [_seals, _f_user, _b_remove] }], "type": "rpc", "tid": 0}]
*/
BEGIN
	IF _f_user is null or (select count(*) from core.pd_users as u where u.id = _f_user) = 1 THEN

		IF _b_remove THEN
			-- удаление пломб
			update dbo.ed_seals as s
			set b_draft = true, -- вместо удаления
			jb_history = dbo.sf_update_jb_history(jb_history, json_build_object('f_user', _f_user,
																				'b_draft', false,
																   				'dx_created', now()))
			where s.id IN (select t.value::uuid from json_array_elements_text(_seals) as t);
		ELSE
			-- обновление пломб
			update dbo.ed_seals as s
			set f_user = _f_user,
			jb_history = dbo.sf_update_jb_history(jb_history, json_build_object('f_user', _f_user,
																				'b_draft', false,
																   				'dx_created', now()))
			where s.id IN (select t.value::uuid from json_array_elements_text(_seals) as t);
		END IF;

		RETURN 0;
	ELSE
		RETURN 1; -- пользователь не найден
	END IF;	
END
$$;

ALTER FUNCTION dbo.cf_arm_seals_edit(_seals json, _f_user integer, _b_remove boolean) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_arm_seals_edit(_seals json, _f_user integer, _b_remove boolean) IS 'Редактирование пломб';
