CREATE TABLE dbo.cs_apartment (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	f_house uuid,
	c_prefix text,
	c_number text,
	n_number integer,
	b_custom boolean NOT NULL,
	dx_created timestamp with time zone DEFAULT now(),
	sn_delete boolean NOT NULL DEFAULT false
);

ALTER TABLE dbo.cs_apartment OWNER TO mobnius;

COMMENT ON TABLE dbo.cs_apartment IS 'Квартиры';

COMMENT ON COLUMN dbo.cs_apartment.id IS '[e60] Идентификатор';

COMMENT ON COLUMN dbo.cs_apartment.f_house IS '[e50] Дом';

COMMENT ON COLUMN dbo.cs_apartment.c_prefix IS '[e40] Префикс';

COMMENT ON COLUMN dbo.cs_apartment.c_number IS '[e30] Номер';

COMMENT ON COLUMN dbo.cs_apartment.n_number IS '[e20] Номер';

COMMENT ON COLUMN dbo.cs_apartment.b_custom IS '[e10] Собственное';

--------------------------------------------------------------------------------

ALTER TABLE dbo.cs_apartment
	ADD CONSTRAINT cs_apartment_pkey PRIMARY KEY (id);
	
--------------------------------------------------------------------------------

CREATE TRIGGER cs_apartment_trigger
	BEFORE INSERT OR UPDATE OR DELETE ON dbo.cs_apartment
	FOR EACH ROW
	EXECUTE PROCEDURE core.cft_0_log_action();
	
--------------------------------------------------------------------------------

ALTER TABLE dbo.cs_apartment
	ADD CONSTRAINT cs_apartment_f_house_fkey FOREIGN KEY (f_house) REFERENCES dbo.cs_house(id);