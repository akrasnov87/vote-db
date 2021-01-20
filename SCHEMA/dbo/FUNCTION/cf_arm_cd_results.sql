CREATE OR REPLACE FUNCTION dbo.cf_arm_cd_results(_f_users json, _d_start_date date, _d_end_date date) RETURNS TABLE(d_date date, n_count bigint, fn_user integer)
    LANGUAGE plpgsql
    AS $$
/**
* @params {json} _f_users - массив пользователей, например [1, 2, 3]
* @params {date} _d_start_date - дата месяца для просмотра. По умолчанию нужно указать первый день месяца
* @params {date} _d_end_date - дата месяца для просмотра. По умолчанию нужно указать последний день месяца
*
* @returns - список дат с количеством выполненных заданий 
*
* @example
* [{ "action": "cf_arm_cd_results", "method": "Query", "data": [{ "params": [_f_users, _d_start_date, _d_end_date] }], "type": "rpc", "tid": 0}]
*/
BEGIN
	RETURN QUERY 
	select max(rr.d_date)::date, count(*), rr.fn_user from core.cd_results as rr
	where rr.fn_user IN (select t.value::integer from json_array_elements_text(_f_users) as t) and rr.d_date between _d_start_date and _d_end_date
	group by rr.fn_user, date_part('year', rr.d_date), date_part('month', rr.d_date), date_part('day', rr.d_date)
	order by max(rr.d_date);
END
$$;

ALTER FUNCTION dbo.cf_arm_cd_results(_f_users json, _d_start_date date, _d_end_date date) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_arm_cd_results(_f_users json, _d_start_date date, _d_end_date date) IS 'Подсветка дат с выполненными заданиями';
