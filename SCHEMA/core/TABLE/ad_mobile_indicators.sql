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
	dx_created timestamp with time zone DEFAULT now() NOT NULL
);

ALTER TABLE core.ad_mobile_indicators OWNER TO mobnius;

COMMENT ON TABLE core.ad_mobile_indicators IS 'Показатели мобильного устройства';

COMMENT ON COLUMN core.ad_mobile_indicators.id IS '[e140] Идентификатор';

COMMENT ON COLUMN core.ad_mobile_indicators.fn_user IS '[e130] Пользователь';

COMMENT ON COLUMN core.ad_mobile_indicators.d_date IS '[e120] Дата события';

COMMENT ON COLUMN core.ad_mobile_indicators.c_network_type IS '[e110] Тип сети';

COMMENT ON COLUMN core.ad_mobile_indicators.b_isonline IS '[e100] Состояние подключения к сети интернет';

COMMENT ON COLUMN core.ad_mobile_indicators.n_ram IS '[e90] Размер ОЗУ';

COMMENT ON COLUMN core.ad_mobile_indicators.n_used_ram IS '[e80] Размер используемого ОЗУ';

COMMENT ON COLUMN core.ad_mobile_indicators.n_phone_memory IS '[e70] Размер внутренней памяти';

COMMENT ON COLUMN core.ad_mobile_indicators.n_used_phone_memory IS '[e60] Размер используемой внутренней памяти';

COMMENT ON COLUMN core.ad_mobile_indicators.n_sd_card_memory IS '[e50] Размер внешней памяти';

COMMENT ON COLUMN core.ad_mobile_indicators.n_used_sd_card_memory IS '[e40] Размер используемой внешей памяти';

COMMENT ON COLUMN core.ad_mobile_indicators.n_battery_level IS '[e30] Уровень заряда батареи';

COMMENT ON COLUMN core.ad_mobile_indicators.n_time IS '[e20] Смещение времени';

COMMENT ON COLUMN core.ad_mobile_indicators.dx_created IS '[e10] Создан в БД';

--------------------------------------------------------------------------------

CREATE INDEX ad_mobile_indicators_d_date_index ON core.ad_mobile_indicators USING btree (d_date);

--------------------------------------------------------------------------------

ALTER TABLE core.ad_mobile_indicators
	ADD CONSTRAINT ad_mobile_indicators_pkey PRIMARY KEY (id);
