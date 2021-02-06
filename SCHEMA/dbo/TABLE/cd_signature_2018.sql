CREATE TABLE dbo.cd_signature_2018 (
	id integer NOT NULL,
	d_date date NOT NULL,
	n_signature smallint,
	f_appartament uuid NOT NULL,
	f_friend_type smallint NOT NULL
);

ALTER TABLE dbo.cd_signature_2018 ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
	SEQUENCE NAME dbo.cs_signature_id_seq
	START WITH 1
	INCREMENT BY 1
	NO MAXVALUE
	NO MINVALUE
	CACHE 1
);

ALTER TABLE dbo.cd_signature_2018 OWNER TO mobnius;

COMMENT ON TABLE dbo.cd_signature_2018 IS 'Результат голосования 2018';

COMMENT ON COLUMN dbo.cd_signature_2018.f_friend_type IS 'Тип лояльности';

--------------------------------------------------------------------------------

CREATE INDEX cd_signature_2018_f_friend_type_idx ON dbo.cd_signature_2018 USING btree (f_friend_type);

--------------------------------------------------------------------------------

CREATE INDEX cd_signature_2018_f_appartament_idx ON dbo.cd_signature_2018 USING btree (f_appartament);

--------------------------------------------------------------------------------

ALTER TABLE dbo.cd_signature_2018
	ADD CONSTRAINT cs_signature_pkey PRIMARY KEY (id);

--------------------------------------------------------------------------------

ALTER TABLE dbo.cd_signature_2018
	ADD CONSTRAINT cs_signature_f_appartament_fkey FOREIGN KEY (f_appartament) REFERENCES dbo.cs_appartament(id) NOT VALID;

--------------------------------------------------------------------------------

ALTER TABLE dbo.cd_signature_2018
	ADD CONSTRAINT cs_signature_f_friend_type_fkey FOREIGN KEY (f_friend_type) REFERENCES dbo.sf_friend_types(id) NOT VALID;
