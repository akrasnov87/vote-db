CREATE OR REPLACE FUNCTION dbo.cf_statistic(_f_user integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
	_result text;
	_c_fio text;
	_n_count integer;
	_n_result integer;
	_not_count integer;
	_not_open_count integer;
	_open1_count integer;
	_open2_count integer;
	_other_count integer;
BEGIN
	select coalesce(u.c_fio, u.c_login) into _c_fio from core.pd_users as u
	where u.id = _f_user;
	select cf_mui_cd_points_count into _n_count from core.cf_mui_cd_points_count(_f_user, 0);
	
	select cf_mui_cd_results_count into _n_result from core.cf_mui_cd_results_count(_f_user);
	
	select count(*) into _not_count from core.cf_mui_cd_results(_f_user) as r
	inner join dbo.cs_answer as a ON r.fn_answer = a.id
	where a.c_color = '#000000';
	
	select count(*) into _not_open_count from core.cf_mui_cd_results(_f_user) as r
	inner join dbo.cs_answer as a ON r.fn_answer = a.id
	where a.c_color = '#8b0000';
	
	select count(*) into _open1_count from core.cf_mui_cd_results(_f_user) as r
	inner join dbo.cs_answer as a ON r.fn_answer = a.id
	where a.c_color = '#00008b,#0000ff,#00ffff';
	
	select count(*) into _open2_count from core.cf_mui_cd_results(_f_user) as r
	inner join dbo.cs_answer as a ON r.fn_answer = a.id
	where a.c_color = '#808000,#006400,#00ff00';
	
	select count(*) into _other_count from core.cf_mui_cd_results(_f_user) as r
	inner join dbo.cs_answer as a ON r.fn_answer = a.id
	where a.c_color = '#F57F17';
	
	_result = concat('<p><b>«', _c_fio,'»</b>, доброго времени суток!<p>');
	_result = concat(_result, '<p>Кол-во квартир – ', _n_count::text, ' (100%)<br />');
	_result = concat(_result, '<br /> - кол-во пройденных квартир – ', _n_result, ' (', (_n_result * 100 / _n_count), '%)');
	_result = concat(_result, '<br /> - никого нет дома – ', _not_count, ' (', (_not_count * 100 / CASE WHEN _n_result = 0 THEN 1 ELSE _n_result END), '%)');
	_result = concat(_result, '<br /> - отказ открывать дверь – ', _not_open_count, ' (', (_not_open_count * 100 / CASE WHEN _n_result = 0 THEN 1 ELSE _n_result END), '%)');
	_result = concat(_result, '<br /> - открыли – АПМ НЕ вручен в руки – ', _open1_count, ' (', (_open1_count * 100 / CASE WHEN _n_result = 0 THEN 1 ELSE _n_result END), '%)');
	_result = concat(_result, '<br /> - открыли – АПМ вручен в руки – ', _open2_count, ' (', (_open2_count * 100 / CASE WHEN _n_result = 0 THEN 1 ELSE _n_result END), '%)');
	_result = concat(_result, '<br /> - другое – ', _other_count, ' (', (_other_count * 100 / CASE WHEN _n_result = 0 THEN 1 ELSE _n_result END), '%)</p>');
	RETURN _result;
END
$$;

ALTER FUNCTION dbo.cf_statistic(_f_user integer) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_statistic(_f_user integer) IS 'Получение статистики';
