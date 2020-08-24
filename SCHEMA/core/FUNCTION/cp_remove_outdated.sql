CREATE OR REPLACE FUNCTION core.cp_remove_outdated() RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    _n_val      int = 100;
    _d_data     timestamptz = date_trunc('day', now()) + '1 day'::interval; -- начало следующего дня
	_dg_cnt		int; --diagnostic
	_dg_text	text = '';
BEGIN

    --опрос настройки
    BEGIN
        select
            c_value::int
        into _n_val
        from core.cd_settings
        where c_key = 'ALL_DEL_AFTER';

    --в любых непонятных ситуациях берем 100 дней
    EXCEPTION
        WHEN OTHERS
        THEN _n_val = 100;
    END;

    _d_data  = _d_data - _n_val * '1 day'::interval;

    delete from core.ad_audits where d_date < _d_data;
	get diagnostics _dg_cnt = row_count;
	_dg_text = _dg_text || ' core.ad_audits: удалено '|| _dg_cnt::text || E'\n';

    delete from core.ad_mobile_devices where d_date < _d_data;
	get diagnostics _dg_cnt = row_count;
	_dg_text = _dg_text || ' core.ad_mobile_devices: удалено '|| _dg_cnt::text || E'\n';

    delete from core.ad_mobile_indicators where d_date < _d_data;
	get diagnostics _dg_cnt = row_count;
	_dg_text = _dg_text || ' core.ad_mobile_indicators: удалено '|| _dg_cnt::text || E'\n';

    delete from core.ad_tracking where d_date < _d_data;
	get diagnostics _dg_cnt = row_count;
	_dg_text = _dg_text || ' core.ad_tracking: удалено '|| _dg_cnt::text || E'\n';
	
	delete from core.sd_client_errors where d_created < _d_data;
	get diagnostics _dg_cnt = row_count;
	_dg_text = _dg_text || ' core.sd_client_errors: удалено '|| _dg_cnt::text || E'\n';

	delete from core.cd_action_log where d_date < _d_data;
	get diagnostics _dg_cnt = row_count;
	_dg_text = _dg_text || ' core.cd_action_log: удалено '|| _dg_cnt::text || E'\n';
	
	delete from core.cd_feedbacks where d_date_question < _d_data;
	get diagnostics _dg_cnt = row_count;
	_dg_text = _dg_text || ' core.cd_feedbacks: удалено '|| _dg_cnt::text || E'\n';

	insert into core.cd_sys_log(d_timestamp, c_descr)
	values(clock_timestamp(), 'Очистка таблиц выполнена. ' || E'\n' || _dg_text);

EXCEPTION
	WHEN OTHERS
    THEN
		insert into core.cd_sys_log(d_timestamp, c_descr)
		values(clock_timestamp(), 'Непредвиденная ошибка очистки таблиц');

END;
$$;

ALTER FUNCTION core.cp_remove_outdated() OWNER TO mobnius;

COMMENT ON FUNCTION core.cp_remove_outdated() IS 'Процедура очистки устаревших данных';
