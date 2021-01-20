CREATE OR REPLACE FUNCTION dbo.cf_arm_blanks_generate(_f_user integer, _f_result_type integer, _c_prefix text, _start integer, _end integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
/**
* @params {integer} _f_user - текущий пользователь
* @params {integer} _f_result_type - Тип акта
* @params {text} _c_prefix - префикс
* @params {integer} _start - начальное заначение
* @params {integer} _end - конечное значение
*
* @returns {integer}
* 0 - ОК
* 1 - пользователь не найден
*
* @example
* [{ "action": "cf_arm_blanks_generate", "method": "Query", "data": [{ "params": [_f_user, _f_result_type, _c_prefix, _start, _end] }], "type": "rpc", "tid": 0}]
*/
BEGIN
	IF _f_user is null or (select count(*) from core.pd_users as u where u.id = _f_user) = 1 THEN
		
		IF (select count(*) from dbo.ed_blanks as b where b.c_prefix = _c_prefix and b.n_number between _start and _end) > 0 THEN
			RETURN 2;
		ELSE
		
			insert into dbo.ed_blanks(id, f_result_type, n_number, c_prefix, c_number, f_user, b_use, dx_created, fn_result, jb_history, b_draft, n_order)
			select 
				uuid_generate_v4(), 
				_f_result_type, 
				generate_series, 
				_c_prefix,
				concat(coalesce(_c_prefix, ''), generate_series::text),
				_f_user, 
				false, 
				now(), 
				null, 
				dbo.sf_update_jb_history('[]'::json, json_build_object('f_user', _f_user,
																	   'b_draft', false,
																	   'dx_created', now())), 
				false,
				generate_series
			from generate_series(_start, _end, 1);
		
		END IF;

		RETURN 0;
	ELSE
		RETURN 1; -- пользователь не найден
	END IF;	
END
$$;

ALTER FUNCTION dbo.cf_arm_blanks_generate(_f_user integer, _f_result_type integer, _c_prefix text, _start integer, _end integer) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_arm_blanks_generate(_f_user integer, _f_result_type integer, _c_prefix text, _start integer, _end integer) IS 'Генерация бланков';
