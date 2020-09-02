CREATE TABLE dbo.cs_appartament (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	f_house uuid NOT NULL,
	c_number text,
	n_number integer,
	dx_date timestamp with time zone DEFAULT now() NOT NULL,
	b_disabled boolean DEFAULT false NOT NULL,
	f_user integer,
	n_signature_2018 integer DEFAULT 0 NOT NULL,
	f_main_user integer
);

ALTER TABLE dbo.cs_appartament OWNER TO mobnius;

COMMENT ON TABLE dbo.cs_appartament IS 'Квартиры';

COMMENT ON COLUMN dbo.cs_appartament.id IS 'Идентификатор';

COMMENT ON COLUMN dbo.cs_appartament.f_house IS 'Дом';

COMMENT ON COLUMN dbo.cs_appartament.c_number IS 'Строковый номер';

COMMENT ON COLUMN dbo.cs_appartament.n_number IS 'Номер';

COMMENT ON COLUMN dbo.cs_appartament.f_user IS 'Агитатор';

COMMENT ON COLUMN dbo.cs_appartament.n_signature_2018 IS 'Подписи в 2018';

COMMENT ON COLUMN dbo.cs_appartament.f_main_user IS 'Ответственный';

--------------------------------------------------------------------------------

CREATE INDEX cs_appartament_f_house_idx ON dbo.cs_appartament USING btree (f_house);

--------------------------------------------------------------------------------

CREATE INDEX cs_appartament_f_user_idx ON dbo.cs_appartament USING btree (f_user);

--------------------------------------------------------------------------------

CREATE INDEX cs_appartament_b_disabled_f_house_c_numer_idx ON dbo.cs_appartament USING btree (b_disabled, f_house, c_number);

--------------------------------------------------------------------------------

CREATE INDEX cs_appartament_b_disabled_idx ON dbo.cs_appartament USING btree (b_disabled);

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

--------------------------------------------------------------------------------

ALTER TABLE dbo.cs_appartament
	ADD CONSTRAINT cs_apartment_f_main_user_fkey FOREIGN KEY (f_main_user) REFERENCES core.pd_users(id) NOT VALID;
