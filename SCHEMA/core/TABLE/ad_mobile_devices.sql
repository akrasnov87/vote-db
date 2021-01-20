CREATE TABLE core.ad_mobile_devices (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	fn_user integer,
	d_date timestamp with time zone,
	b_debug boolean DEFAULT false NOT NULL,
	c_architecture text,
	c_phone_model text,
	c_sdk text,
	c_os text,
	c_imei text,
	c_version text,
	dx_created timestamp with time zone DEFAULT now() NOT NULL,
	n_version bigint
);

ALTER TABLE core.ad_mobile_devices OWNER TO mobnius;

COMMENT ON TABLE core.ad_mobile_devices IS 'Информация о мобильных устройствах';

COMMENT ON COLUMN core.ad_mobile_devices.id IS 'Идентификатор';

COMMENT ON COLUMN core.ad_mobile_devices.fn_user IS 'Пользователь';

COMMENT ON COLUMN core.ad_mobile_devices.d_date IS 'Дата возникновения событий';

COMMENT ON COLUMN core.ad_mobile_devices.b_debug IS 'Режим отладки';

COMMENT ON COLUMN core.ad_mobile_devices.c_architecture IS 'Архитектура устройства';

COMMENT ON COLUMN core.ad_mobile_devices.c_phone_model IS 'Модель телефона';

COMMENT ON COLUMN core.ad_mobile_devices.c_sdk IS 'Версия sdk';

COMMENT ON COLUMN core.ad_mobile_devices.c_os IS 'Версия ОС';

COMMENT ON COLUMN core.ad_mobile_devices.c_imei IS 'IMEI';

COMMENT ON COLUMN core.ad_mobile_devices.c_version IS 'Версия приложения';

COMMENT ON COLUMN core.ad_mobile_devices.dx_created IS 'Создан в БД';

--------------------------------------------------------------------------------

CREATE TRIGGER ad_mobile_devices_trigger_iu
	BEFORE INSERT OR UPDATE ON core.ad_mobile_devices
	FOR EACH ROW
	EXECUTE PROCEDURE core.cft_sd_digest_update_version();

--------------------------------------------------------------------------------

CREATE TRIGGER ad_mobile_devices_update_version_trigger_iu
	BEFORE INSERT OR UPDATE ON core.ad_mobile_devices
	FOR EACH ROW
	EXECUTE PROCEDURE core.cft_pd_users_update_version();

--------------------------------------------------------------------------------

ALTER TABLE core.ad_mobile_devices
	ADD CONSTRAINT ad_mobile_devices_pkey PRIMARY KEY (id);
