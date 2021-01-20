CREATE TABLE core.cd_notifications (
	fn_user_to integer NOT NULL,
	c_title text,
	c_message text,
	d_date timestamp with time zone NOT NULL,
	d_changed timestamp with time zone,
	fn_user_from integer NOT NULL,
	b_readed boolean DEFAULT false NOT NULL,
	b_sended boolean DEFAULT false NOT NULL,
	dx_created timestamp with time zone DEFAULT now(),
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	c_group text,
	jb_data jsonb
);

ALTER TABLE core.cd_notifications OWNER TO mobnius;

COMMENT ON TABLE core.cd_notifications IS 'Уведомления';

COMMENT ON COLUMN core.cd_notifications.fn_user_to IS 'Адресат';

COMMENT ON COLUMN core.cd_notifications.c_title IS 'Заголовок';

COMMENT ON COLUMN core.cd_notifications.c_message IS 'Сообщение';

COMMENT ON COLUMN core.cd_notifications.d_date IS 'Создан';

COMMENT ON COLUMN core.cd_notifications.d_changed IS 'Изменен';

COMMENT ON COLUMN core.cd_notifications.fn_user_from IS 'От кого';

COMMENT ON COLUMN core.cd_notifications.b_readed IS 'Прочитан';

COMMENT ON COLUMN core.cd_notifications.b_sended IS 'Доставлено';

COMMENT ON COLUMN core.cd_notifications.dx_created IS 'Дата создания в БД';

COMMENT ON COLUMN core.cd_notifications.jb_data IS 'Дополнительные данные в уведомлениях';

--------------------------------------------------------------------------------

ALTER TABLE core.cd_notifications
	ADD CONSTRAINT cd_notifications_pkey PRIMARY KEY (id);
