CREATE TABLE dbo.cd_contacts (
	id uuid NOT NULL,
	c_first_name text,
	c_last_name text,
	c_patronymic text,
	fn_street uuid NOT NULL,
	c_appartament text NOT NULL,
	n_rating integer,
	c_description text,
	d_date timestamp with time zone NOT NULL,
	dx_created timestamp with time zone DEFAULT now() NOT NULL,
	fn_user integer NOT NULL,
	jb_data jsonb,
	c_phone text,
	b_disabled boolean NOT NULL,
	c_house_num text,
	c_house_build text,
	n_order bigint
);

ALTER TABLE dbo.cd_contacts OWNER TO mobnius;

COMMENT ON TABLE dbo.cd_contacts IS 'Контакты';

--------------------------------------------------------------------------------

ALTER TABLE dbo.cd_contacts
	ADD CONSTRAINT cd_contacts_pkey PRIMARY KEY (id);
