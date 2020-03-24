CREATE TABLE core.cd_action_log (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	c_table_name text,
	c_operation text,
	jb_old_value jsonb,
	jb_new_value jsonb,
	c_user text,
	d_date timestamp with time zone
);

ALTER TABLE core.cd_action_log OWNER TO mobnius;

COMMENT ON TABLE core.cd_action_log IS 'Логирование действий пользователей с данными. Полная информация';

COMMENT ON COLUMN core.cd_action_log.c_table_name IS '[e60] имя таблицы в которой произошли изменения';

COMMENT ON COLUMN core.cd_action_log.c_operation IS '[e50] тип операции, INSERT, UPDATE, DELETE';

COMMENT ON COLUMN core.cd_action_log.jb_old_value IS '[e40] предыдущие данные';

COMMENT ON COLUMN core.cd_action_log.jb_new_value IS '[e30] новые данные';

COMMENT ON COLUMN core.cd_action_log.c_user IS '[e20] учетная запись';

COMMENT ON COLUMN core.cd_action_log.d_date IS '[e10] дата события';
