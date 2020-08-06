CREATE TABLE dbo.cd_food_kit (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	f_street uuid NOT NULL,
	f_house uuid NOT NULL,
	f_appartament uuid NOT NULL,
	c_first_name text,
	c_last_name text,
	c_patronymic text,
	f_user integer NOT NULL,
	dx_created timestamp with time zone DEFAULT now() NOT NULL,
	c_phone text,
	f_type integer NOT NULL
);

ALTER TABLE dbo.cd_food_kit OWNER TO mobnius;

COMMENT ON TABLE dbo.cd_food_kit IS 'Продовольственный набор';

COMMENT ON COLUMN dbo.cd_food_kit.f_street IS 'Улица';

COMMENT ON COLUMN dbo.cd_food_kit.f_house IS 'Дом';

COMMENT ON COLUMN dbo.cd_food_kit.f_appartament IS 'Помещение, Квартира';

COMMENT ON COLUMN dbo.cd_food_kit.c_first_name IS 'Имя';

COMMENT ON COLUMN dbo.cd_food_kit.c_last_name IS 'Фамилия';

COMMENT ON COLUMN dbo.cd_food_kit.c_patronymic IS 'Отчество';

COMMENT ON COLUMN dbo.cd_food_kit.f_user IS 'Пользователь';

--------------------------------------------------------------------------------

CREATE INDEX cd_food_kit_f_appartament_idx ON dbo.cd_food_kit USING btree (f_appartament);

--------------------------------------------------------------------------------

ALTER TABLE dbo.cd_food_kit
	ADD CONSTRAINT cd_food_kit_pkey PRIMARY KEY (id);
