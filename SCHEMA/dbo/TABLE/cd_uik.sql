CREATE TABLE dbo.cd_uik (
	id integer DEFAULT nextval('dbo.auto_id_cs_uik'::regclass) NOT NULL,
	c_fio text,
	c_email text,
	c_work_place text,
	c_job text,
	c_phone text,
	c_place text,
	c_place_phone text
);

ALTER TABLE dbo.cd_uik OWNER TO mobnius;

COMMENT ON TABLE dbo.cd_uik IS 'УИК';

COMMENT ON COLUMN dbo.cd_uik.id IS 'Идентификатор';

COMMENT ON COLUMN dbo.cd_uik.c_fio IS 'ФИО';

COMMENT ON COLUMN dbo.cd_uik.c_email IS 'Email';

COMMENT ON COLUMN dbo.cd_uik.c_place IS 'указывается адрес и место голосования';

COMMENT ON COLUMN dbo.cd_uik.c_place_phone IS 'указываются телефоны УИКа';

--------------------------------------------------------------------------------

CREATE TRIGGER cd_uik_1
	BEFORE INSERT OR UPDATE OR DELETE ON dbo.cd_uik
	FOR EACH ROW
	EXECUTE PROCEDURE core.cft_log_action();

--------------------------------------------------------------------------------

ALTER TABLE dbo.cd_uik
	ADD CONSTRAINT cd_uik_pkey PRIMARY KEY (id);
