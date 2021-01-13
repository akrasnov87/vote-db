CREATE TABLE dbo.cd_people (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	f_street uuid NOT NULL,
	f_house uuid NOT NULL,
	f_appartament uuid NOT NULL,
	c_first_name text,
	c_last_name text,
	c_patronymic text,
	f_user integer NOT NULL,
	dx_created timestamp with time zone DEFAULT now() NOT NULL,
	n_birth_year integer,
	c_org text,
	c_phone text,
	f_type integer NOT NULL,
	b_vote_2020 boolean NOT NULL
);

ALTER TABLE dbo.cd_people OWNER TO mobnius;

COMMENT ON TABLE dbo.cd_people IS 'Лояльное население';

COMMENT ON COLUMN dbo.cd_people.f_street IS 'Улица';

COMMENT ON COLUMN dbo.cd_people.f_house IS 'Дом';

COMMENT ON COLUMN dbo.cd_people.f_appartament IS 'Помещение, Квартира';

COMMENT ON COLUMN dbo.cd_people.c_first_name IS 'Имя';

COMMENT ON COLUMN dbo.cd_people.c_last_name IS 'Фамилия';

COMMENT ON COLUMN dbo.cd_people.c_patronymic IS 'Отчество';

COMMENT ON COLUMN dbo.cd_people.f_user IS 'Пользователь';

COMMENT ON COLUMN dbo.cd_people.n_birth_year IS 'Год рождения';

COMMENT ON COLUMN dbo.cd_people.c_org IS 'Наименование организации';

COMMENT ON COLUMN dbo.cd_people.c_phone IS 'Номер телефона';

COMMENT ON COLUMN dbo.cd_people.f_type IS 'Тип записи';

COMMENT ON COLUMN dbo.cd_people.b_vote_2020 IS 'Голосовавший на выборах 2020';

--------------------------------------------------------------------------------

CREATE INDEX cd_people_f_house_idx ON dbo.cd_people USING btree (f_house);

--------------------------------------------------------------------------------

CREATE INDEX cd_people_f_street_idx ON dbo.cd_people USING btree (f_street);

--------------------------------------------------------------------------------

CREATE INDEX cd_people_f_type_f_appartament_idx ON dbo.cd_people USING btree (f_type, f_appartament);

--------------------------------------------------------------------------------

CREATE INDEX cd_people_f_appartament_idx ON dbo.cd_people USING btree (f_appartament);

--------------------------------------------------------------------------------

CREATE INDEX cd_people_f_type_idx ON dbo.cd_people USING btree (f_type);

--------------------------------------------------------------------------------

ALTER TABLE dbo.cd_people
	ADD CONSTRAINT cd_people_pkey PRIMARY KEY (id);

--------------------------------------------------------------------------------

ALTER TABLE dbo.cd_people
	ADD CONSTRAINT cd_people_f_appartament FOREIGN KEY (f_appartament) REFERENCES dbo.cs_appartament(id);

--------------------------------------------------------------------------------

ALTER TABLE dbo.cd_people
	ADD CONSTRAINT cd_people_f_house FOREIGN KEY (f_house) REFERENCES dbo.cs_house(id);

--------------------------------------------------------------------------------

ALTER TABLE dbo.cd_people
	ADD CONSTRAINT cd_people_f_user FOREIGN KEY (f_user) REFERENCES core.pd_users(id);

--------------------------------------------------------------------------------

ALTER TABLE dbo.cd_people
	ADD CONSTRAINT cd_people_f_street FOREIGN KEY (f_street) REFERENCES dbo.cs_street(id);

--------------------------------------------------------------------------------

ALTER TABLE dbo.cd_people
	ADD CONSTRAINT cd_people_f_type FOREIGN KEY (f_type) REFERENCES dbo.cs_people_types(id);
