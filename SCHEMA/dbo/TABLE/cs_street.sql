CREATE TABLE dbo.cs_street (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	c_name text,
	c_type text,
	c_street_name text,
	c_yandex_name text,
	dx_created timestamp with time zone DEFAULT now(),
	sn_delete boolean NOT NULL DEFAULT false
);

ALTER TABLE dbo.cs_street OWNER TO mobnius;

COMMENT ON TABLE dbo.cs_street IS 'Улицы';

COMMENT ON COLUMN dbo.cs_street.id IS '[e110] Идентификатор';

COMMENT ON COLUMN dbo.cs_street.c_name IS '[e100] Наименование';

COMMENT ON COLUMN dbo.cs_street.c_type IS '[e90|d] Тип';

COMMENT ON COLUMN dbo.cs_street.c_street_name IS '[e80] Имя';

COMMENT ON COLUMN dbo.cs_street.c_yandex_name IS '[e70] Имя в yandex';

COMMENT ON COLUMN dbo.cs_street.dx_created IS '[e20] Дата создания';

COMMENT ON COLUMN dbo.cs_street.sn_delete IS '[e10] Признак удаленной записи';

--------------------------------------------------------------------------------

ALTER TABLE dbo.cs_street
	ADD CONSTRAINT cs_street_pkey PRIMARY KEY (id);
	
--------------------------------------------------------------------------------

CREATE TRIGGER cs_street_trigger
	BEFORE INSERT OR UPDATE OR DELETE ON dbo.cs_street
	FOR EACH ROW
	EXECUTE PROCEDURE core.cft_0_log_action();