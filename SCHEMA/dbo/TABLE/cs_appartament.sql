CREATE TABLE dbo.cs_appartament (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	f_house uuid,
	c_number text,
	n_number integer,
	dx_created timestamp with time zone DEFAULT now(),
	sn_delete boolean DEFAULT false NOT NULL,
	f_user integer
);

ALTER TABLE dbo.cs_appartament OWNER TO mobnius;

COMMENT ON TABLE dbo.cs_appartament IS 'Квартиры';

COMMENT ON COLUMN dbo.cs_appartament.id IS '[e60] Идентификатор';

COMMENT ON COLUMN dbo.cs_appartament.f_house IS '[e50] Дом';

COMMENT ON COLUMN dbo.cs_appartament.c_number IS '[e30] Номер';

COMMENT ON COLUMN dbo.cs_appartament.n_number IS '[e20] Номер';

--------------------------------------------------------------------------------

CREATE TRIGGER cs_apartment_trigger
	BEFORE INSERT OR UPDATE OR DELETE ON dbo.cs_appartament
	FOR EACH ROW
	EXECUTE PROCEDURE core.cft_0_log_action();

--------------------------------------------------------------------------------

ALTER TABLE dbo.cs_appartament
	ADD CONSTRAINT cs_apartment_pkey PRIMARY KEY (id);

--------------------------------------------------------------------------------

ALTER TABLE dbo.cs_appartament
	ADD CONSTRAINT cs_apartment_f_house_fkey FOREIGN KEY (f_house) REFERENCES dbo.cs_house(id);

--------------------------------------------------------------------------------

ALTER TABLE dbo.cs_appartament
	ADD CONSTRAINT cs_apartment_f_user_fkey FOREIGN KEY (f_user) REFERENCES core.pd_users(id) NOT VALID;
