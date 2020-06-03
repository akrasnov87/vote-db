CREATE TABLE dbo.cs_house (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	f_street uuid,
	c_house_num text,
	c_build_num text,
	dx_date timestamp with time zone DEFAULT now(),
	b_disabled boolean DEFAULT false NOT NULL,
	n_uik integer NOT NULL,
	c_floor text,
	c_porch text,
	f_subdivision integer
);

ALTER TABLE dbo.cs_house OWNER TO mobnius;

COMMENT ON TABLE dbo.cs_house IS 'Улицы';

COMMENT ON COLUMN dbo.cs_house.id IS 'Идентификатор';

COMMENT ON COLUMN dbo.cs_house.f_street IS 'Улица';

COMMENT ON COLUMN dbo.cs_house.c_house_num IS 'Номер дома';

COMMENT ON COLUMN dbo.cs_house.c_build_num IS 'Корпус';

COMMENT ON COLUMN dbo.cs_house.c_floor IS 'Кол-во этажей';

COMMENT ON COLUMN dbo.cs_house.c_porch IS 'Кол-во подъездов в доме';

--------------------------------------------------------------------------------

CREATE INDEX cs_house_f_street_idx ON dbo.cs_house USING btree (f_street);

--------------------------------------------------------------------------------

CREATE INDEX cs_house_f_subdivision_idx ON dbo.cs_house USING btree (f_subdivision);

--------------------------------------------------------------------------------

CREATE TRIGGER cs_house_trigger
	BEFORE INSERT OR UPDATE OR DELETE ON dbo.cs_house
	FOR EACH ROW
	EXECUTE PROCEDURE core.cft_0_log_action();

--------------------------------------------------------------------------------

ALTER TABLE dbo.cs_house
	ADD CONSTRAINT cs_house_pkey PRIMARY KEY (id);

--------------------------------------------------------------------------------

ALTER TABLE dbo.cs_house
	ADD CONSTRAINT cs_house_f_street_fkey FOREIGN KEY (f_street) REFERENCES dbo.cs_street(id);

--------------------------------------------------------------------------------

ALTER TABLE dbo.cs_house
	ADD CONSTRAINT cs_house_f_subdivision_fkey FOREIGN KEY (f_subdivision) REFERENCES core.sd_subdivisions(id);
