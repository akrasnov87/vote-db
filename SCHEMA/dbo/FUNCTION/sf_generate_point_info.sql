CREATE OR REPLACE FUNCTION dbo.sf_generate_point_info(_f_registr_pts uuid) RETURNS text
    LANGUAGE plpgsql
    AS $$
/**
* @params {uuid} _f_registr_pts - идентификатор точки учета
*
* @returns {jsonb}
*
* @example
* [{ "action": "sf_generate_point_info", "method": "Query", "data": [{ "params": [_f_registr_pts] }], "type": "rpc", "tid": 0}]
*/
DECLARE
	_c_seals_info text;
	_c_transformers_info text;
BEGIN
	IF (select count(*) from dbo.ed_registr_pts as rp where rp.id = _f_registr_pts) = 1 THEN
		
		select string_agg(concat(
			'<div><b>Тип</b>: ', s.c_type, '<br />', 
			'<b>Номер</b>: ', coalesce(s.c_number, concat(s.c_prefix, s.n_number::text)), '<br />', 
			'<b>Место установки</b>: ', s.c_location, '</div>'), '' order by s.c_type, s.c_location) into _c_seals_info 
		from dbo.ed_seals as s
		where s.f_registr_pts = _f_registr_pts and s.d_replace_date is null;
		
		select string_agg(concat(
			'<div><b>Тип трансформатора</b>: ', CASE WHEN t.b_voltage THEN 'напряжение' ELSE 'ток' END, '<br />', 
			'<b>Номер</b>: ', t.c_serial_number, '<br />', 
			'<b>Тип</b>: ', dt.c_name, '<br />', 
			'<b>Год выпуска</b>: ', t.n_manufacture_year::text, '<br />', 
			'<b>Коэффициент трансформации</b>: ', dt.n_rate::text, '<br />', 
			'<b>Фаза</b>: ', t.c_phase, '<br />', 
			'<b>Дата поверки</b>: ', to_char(t.d_check_date, 'DD.MM.YYYY'), '<br />', 
			'<b>Дата след. поверки</b>: ', to_char(t.d_replace_before, 'DD.MM.YYYY'), '<br />', 
			'<b>Межповерочный интервал</b>: ', dt.n_check_cycle::text, '</div>'), '' order by t.b_voltage, t.c_phase) into _c_transformers_info 
		from dbo.ed_transformers as t
		inner join dbo.es_device_types as dt ON dt.id = t.f_device_type
		where t.f_registr_pts = _f_registr_pts and t.d_replace_date is null;
		
		RETURN concat('<p style="text-align: center">Пломбы</p>', CASE WHEN _c_seals_info is null THEN '<div>информация отсутствует</div>' ELSE _c_seals_info END, '<p style="text-align: center">Трансформаторы</p>', CASE WHEN _c_transformers_info is null THEN '<div>информация отсутствует</div>' ELSE _c_transformers_info END);
	ELSE
		RETURN '';
	END IF;
END
$$;

ALTER FUNCTION dbo.sf_generate_point_info(_f_registr_pts uuid) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.sf_generate_point_info(_f_registr_pts uuid) IS 'Генерация информации для точки учета';
