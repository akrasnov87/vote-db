CREATE TABLE dbo.cs_uik (
	id bigint DEFAULT nextval('dbo.auto_id_cs_uik'::regclass) NOT NULL,
	c_area text,
	c_name text,
	c_address text,
	c_phone text,
	n_count integer,
	c_boundary text,
	f_user integer,
	dx_created timestamp with time zone DEFAULT now(),
	sn_delete boolean NOT NULL DEFAULT false
);

ALTER TABLE dbo.cs_uik OWNER TO mobnius;

COMMENT ON TABLE dbo.cs_uik IS 'Избирательный участок';

COMMENT ON COLUMN dbo.cs_uik.id IS '[e110] Идентификатор';

COMMENT ON COLUMN dbo.cs_uik.c_area IS '[e100] Район';

COMMENT ON COLUMN dbo.cs_uik.c_name IS '[e90|d] Наименование';

COMMENT ON COLUMN dbo.cs_uik.c_address IS '[e80] Адрес';

COMMENT ON COLUMN dbo.cs_uik.c_phone IS '[e70] Телефон';

COMMENT ON COLUMN dbo.cs_uik.n_count IS '[60] Количество избирателей';

COMMENT ON COLUMN dbo.cs_uik.c_boundary IS '[50] ФИО потребителя';

COMMENT ON COLUMN dbo.cs_uik.f_user IS '[e40] Куратор';

COMMENT ON COLUMN dbo.cs_uik.dx_created IS '[e20] Дата создания';

COMMENT ON COLUMN dbo.cs_uik.sn_delete IS '[e10] Признак удаленной записи';

--------------------------------------------------------------------------------

ALTER TABLE dbo.cs_uik
	ADD CONSTRAINT cs_uik_pkey PRIMARY KEY (id);
	
--------------------------------------------------------------------------------

CREATE TRIGGER cs_uik_trigger
	BEFORE INSERT OR UPDATE OR DELETE ON dbo.cs_uik
	FOR EACH ROW
	EXECUTE PROCEDURE core.cft_0_log_action();

--------------------------------------------------------------------------------

ALTER TABLE dbo.cs_uik
	ADD CONSTRAINT cs_uik_f_user_fkey FOREIGN KEY (f_user) REFERENCES core.pd_users(id);