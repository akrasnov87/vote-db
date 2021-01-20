CREATE TABLE dbo.cs_street (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	c_name text,
	c_type text,
	dx_date timestamp with time zone DEFAULT now() NOT NULL,
	b_disabled boolean DEFAULT false NOT NULL,
	f_division integer NOT NULL,
	c_short_type text,
	f_user integer,
	b_yandex boolean DEFAULT false NOT NULL,
	b_yandex_fail boolean DEFAULT false NOT NULL,
	jb_yandex_res jsonb,
	n_latitude numeric,
	n_longitude numeric,
	c_yandex_description text,
	c_yandex_name text
);

ALTER TABLE dbo.cs_street OWNER TO mobnius;

COMMENT ON TABLE dbo.cs_street IS 'Улицы';

COMMENT ON COLUMN dbo.cs_street.id IS '[e110] Идентификатор';

COMMENT ON COLUMN dbo.cs_street.c_name IS 'улица';

COMMENT ON COLUMN dbo.cs_street.c_type IS 'Тип';

--------------------------------------------------------------------------------

CREATE INDEX cs_street_f_division_idx ON dbo.cs_street USING btree (f_division);

--------------------------------------------------------------------------------

ALTER TABLE dbo.cs_street
	ADD CONSTRAINT cs_street_pkey PRIMARY KEY (id);

--------------------------------------------------------------------------------

ALTER TABLE dbo.cs_street
	ADD CONSTRAINT cs_street_f_division_fkey FOREIGN KEY (f_division) REFERENCES core.sd_divisions(id);

--------------------------------------------------------------------------------

ALTER TABLE dbo.cs_street
	ADD CONSTRAINT cs_street_f_user_fkey FOREIGN KEY (f_user) REFERENCES core.pd_users(id) NOT VALID;
