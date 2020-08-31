CREATE TABLE dbo.cd_tmp_people (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	f_street uuid,
	f_house uuid,
	f_appartament uuid,
	c_city text,
	n_uik integer,
	c_type text,
	c_name text,
	c_house_num text,
	c_build_num text,
	c_appartament text,
	n_appartament integer,
	c_first_name text,
	c_last_name text,
	c_patronymic text,
	f_user integer,
	dx_created timestamp with time zone DEFAULT now() NOT NULL,
	n_birth_year integer,
	c_org text,
	c_phone text,
	c_notice text,
	b_disabled boolean DEFAULT false NOT NULL
);

ALTER TABLE dbo.cd_tmp_people OWNER TO mobnius;

COMMENT ON TABLE dbo.cd_tmp_people IS 'Лояльное население';

COMMENT ON COLUMN dbo.cd_tmp_people.f_street IS 'Улица';

COMMENT ON COLUMN dbo.cd_tmp_people.f_house IS 'Дом';

COMMENT ON COLUMN dbo.cd_tmp_people.f_appartament IS 'Помещение, Квартира';

COMMENT ON COLUMN dbo.cd_tmp_people.c_first_name IS 'Имя';

COMMENT ON COLUMN dbo.cd_tmp_people.c_last_name IS 'Фамилия';

COMMENT ON COLUMN dbo.cd_tmp_people.c_patronymic IS 'Отчество';

COMMENT ON COLUMN dbo.cd_tmp_people.f_user IS 'Пользователь';

COMMENT ON COLUMN dbo.cd_tmp_people.n_birth_year IS 'Год рождения';

COMMENT ON COLUMN dbo.cd_tmp_people.c_org IS 'Наименование организации';

COMMENT ON COLUMN dbo.cd_tmp_people.c_phone IS 'Номер телефона';

--------------------------------------------------------------------------------

CREATE INDEX cd_tmp_people_f_appartament_idx ON dbo.cd_tmp_people USING btree (f_appartament);

--------------------------------------------------------------------------------

CREATE INDEX cd_tmp_people_f_house_idx ON dbo.cd_tmp_people USING btree (f_house);

--------------------------------------------------------------------------------

CREATE INDEX cd_tmp_people_f_street_idx ON dbo.cd_tmp_people USING btree (f_street);

--------------------------------------------------------------------------------

CREATE INDEX cd_tmp_people_dx_created_idx ON dbo.cd_tmp_people USING btree (dx_created);

--------------------------------------------------------------------------------

ALTER TABLE dbo.cd_tmp_people
	ADD CONSTRAINT cd_tmp_people_pkey PRIMARY KEY (id);
