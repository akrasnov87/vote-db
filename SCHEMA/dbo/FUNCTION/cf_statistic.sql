CREATE OR REPLACE FUNCTION dbo.cf_statistic(_f_user integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
	_result text;
	_c_fio text;
	_n_count integer;
	_n_result integer;
BEGIN
	select coalesce(u.c_fio, u.c_login) into _c_fio from core.pd_users as u
	where u.id = _f_user;
	select cf_mui_cd_points_count into _n_count from core.cf_mui_cd_points_count(_f_user, 0);
	select cf_mui_cd_results_count into _n_result from core.cf_mui_cd_results_count(_f_user);
	
	_result = concat('<p><b>«', _c_fio,'»</b>, доброго времени суток!<p>');
	_result = concat(_result, '<p>Кол-во квартир – ', _n_count::text, '(100%)<br />');
	_result = concat(_result, ' - кол-во пройденных квартир – ', _n_result, '(', (_n_result * 100 / _n_count), '%)');
	RETURN _result;
END
$$;

ALTER FUNCTION dbo.cf_statistic(_f_user integer) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_statistic(_f_user integer) IS 'Получение статистики';
