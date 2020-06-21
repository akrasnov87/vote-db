CREATE TABLE dbo.cs_street (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	c_name text,
	c_type text,
	dx_date timestamp with time zone DEFAULT now() NOT NULL,
	b_disabled boolean DEFAULT false NOT NULL,
	f_division integer NOT NULL
);

ALTER TABLE dbo.cs_street OWNER TO mobnius;

COMMENT ON TABLE dbo.cs_street IS 'Улицы';

COMMENT ON COLUMN dbo.cs_street.id IS '[e110] Идентификатор';

COMMENT ON COLUMN dbo.cs_street.c_name IS 'улица';

COMMENT ON COLUMN dbo.cs_street.c_type IS 'Тип';

--------------------------------------------------------------------------------

CREATE INDEX cs_street_f_division_idx ON dbo.cs_street USING btree (f_division);

--------------------------------------------------------------------------------

CREATE TRIGGER cs_street_trigger
	BEFORE INSERT OR UPDATE OR DELETE ON dbo.cs_street
	FOR EACH ROW
	EXECUTE PROCEDURE core.cft_0_log_action();

--------------------------------------------------------------------------------

ALTER TABLE dbo.cs_street
	ADD CONSTRAINT cs_street_pkey PRIMARY KEY (id);

--------------------------------------------------------------------------------

ALTER TABLE dbo.cs_street
	ADD CONSTRAINT cs_street_f_division_fkey FOREIGN KEY (f_division) REFERENCES core.sd_divisions(id);
