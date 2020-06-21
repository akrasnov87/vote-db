CREATE TABLE core.sd_digests (
	id integer DEFAULT nextval('core.auto_id_sd_digests'::regclass) NOT NULL,
	c_version text NOT NULL,
	c_description text NOT NULL,
	f_division integer,
	c_app_name text NOT NULL,
	b_hidden boolean DEFAULT false NOT NULL,
	ba_file bytea NOT NULL,
	dx_created timestamp with time zone DEFAULT now() NOT NULL
);

ALTER TABLE core.sd_digests OWNER TO mobnius;

COMMENT ON TABLE core.sd_digests IS 'Журнал версий';

COMMENT ON COLUMN core.sd_digests.id IS '[e60] Идентификатор';

COMMENT ON COLUMN core.sd_digests.c_version IS '[e50|d] Версия';

COMMENT ON COLUMN core.sd_digests.c_description IS '[e40] Описание';

COMMENT ON COLUMN core.sd_digests.f_division IS '[e30] Отделение';

COMMENT ON COLUMN core.sd_digests.c_app_name IS '[e20] Имя приложения';

COMMENT ON COLUMN core.sd_digests.b_hidden IS '[e10] Скрыт';

COMMENT ON COLUMN core.sd_digests.ba_file IS '[e05] Файл для обновления';

--------------------------------------------------------------------------------

CREATE TRIGGER sd_digests_1
	BEFORE INSERT OR UPDATE OR DELETE ON core.sd_digests
	FOR EACH ROW
	EXECUTE PROCEDURE core.cft_0_log_action();

--------------------------------------------------------------------------------

ALTER TABLE core.sd_digests
	ADD CONSTRAINT sd_digests_pkey PRIMARY KEY (id);

--------------------------------------------------------------------------------

ALTER TABLE core.sd_digests
	ADD CONSTRAINT sd_digests_f_division FOREIGN KEY (f_division) REFERENCES core.sd_divisions(id);
