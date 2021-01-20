CREATE TABLE core.ad_mobile_indicators (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	fn_user integer NOT NULL,
	d_date timestamp with time zone DEFAULT now() NOT NULL,
	c_network_type text,
	b_isonline boolean DEFAULT false NOT NULL,
	n_ram bigint,
	n_used_ram bigint,
	n_phone_memory bigint,
	n_used_phone_memory bigint,
	n_sd_card_memory bigint,
	n_used_sd_card_memory bigint,
	n_battery_level integer,
	n_time integer,
	dx_created timestamp with time zone DEFAULT now()
);

ALTER TABLE core.ad_mobile_indicators OWNER TO mobnius;

COMMENT ON TABLE core.ad_mobile_indicators IS 'Показатели мобильного устройства';

COMMENT ON COLUMN core.ad_mobile_indicators.id IS 'Идентификатор';

COMMENT ON COLUMN core.ad_mobile_indicators.fn_user IS 'Пользователь';

COMMENT ON COLUMN core.ad_mobile_indicators.d_date IS 'Дата события';

COMMENT ON COLUMN core.ad_mobile_indicators.c_network_type IS 'Тип сети';

COMMENT ON COLUMN core.ad_mobile_indicators.b_isonline IS 'Состояние подключения к сети интернет';

COMMENT ON COLUMN core.ad_mobile_indicators.n_ram IS 'Размер ОЗУ';

COMMENT ON COLUMN core.ad_mobile_indicators.n_used_ram IS 'Размер используемого ОЗУ';

COMMENT ON COLUMN core.ad_mobile_indicators.n_phone_memory IS 'Размер внутренней памяти';

COMMENT ON COLUMN core.ad_mobile_indicators.n_used_phone_memory IS 'Размер используемой внутренней памяти';

COMMENT ON COLUMN core.ad_mobile_indicators.n_sd_card_memory IS 'Размер внешней памяти';

COMMENT ON COLUMN core.ad_mobile_indicators.n_used_sd_card_memory IS 'Размер используемой внешей памяти';

COMMENT ON COLUMN core.ad_mobile_indicators.n_battery_level IS 'Уровень заряда батареи';

COMMENT ON COLUMN core.ad_mobile_indicators.n_time IS 'Смещение времени';

COMMENT ON COLUMN core.ad_mobile_indicators.dx_created IS 'Создан в БД';

--------------------------------------------------------------------------------

ALTER TABLE core.ad_mobile_indicators
	ADD CONSTRAINT ad_mobile_indicators_pkey PRIMARY KEY (id);
