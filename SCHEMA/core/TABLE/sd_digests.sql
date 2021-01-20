CREATE TABLE core.sd_digests (
	id integer DEFAULT nextval('core.auto_id_sd_digests'::regclass) NOT NULL,
	c_version text NOT NULL,
	c_description text,
	f_division integer,
	b_hidden boolean DEFAULT false NOT NULL,
	ba_file bytea NOT NULL,
	dx_created timestamp with time zone DEFAULT now() NOT NULL,
	n_version bigint
);

ALTER TABLE core.sd_digests OWNER TO mobnius;

COMMENT ON TABLE core.sd_digests IS 'Журнал версий';

COMMENT ON COLUMN core.sd_digests.id IS 'Идентификатор';

COMMENT ON COLUMN core.sd_digests.c_version IS 'Версия';

COMMENT ON COLUMN core.sd_digests.c_description IS 'Описание';

COMMENT ON COLUMN core.sd_digests.f_division IS 'Отделение';

COMMENT ON COLUMN core.sd_digests.b_hidden IS 'Скрыт';

COMMENT ON COLUMN core.sd_digests.ba_file IS 'Файл для обновления';

COMMENT ON COLUMN core.sd_digests.n_version IS 'Номер версии';

--------------------------------------------------------------------------------

CREATE TRIGGER sd_digests_trigger_iu
	BEFORE INSERT OR UPDATE ON core.sd_digests
	FOR EACH ROW
	EXECUTE PROCEDURE core.cft_sd_digest_update_version();

--------------------------------------------------------------------------------

ALTER TABLE core.sd_digests
	ADD CONSTRAINT sd_digests_pkey PRIMARY KEY (id);

--------------------------------------------------------------------------------

ALTER TABLE core.sd_digests
	ADD CONSTRAINT sd_digests_f_division FOREIGN KEY (f_division) REFERENCES core.sd_divisions(id);
