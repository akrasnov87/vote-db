CREATE TABLE dbo.cd_tmp_budget (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	f_street uuid NOT NULL,
	f_house uuid NOT NULL,
	f_appartament uuid NOT NULL,
	c_first_name text,
	c_last_name text,
	c_patronymic text,
	f_user integer NOT NULL,
	dx_created timestamp with time zone DEFAULT now() NOT NULL,
	c_org text,
	c_phone text
);

ALTER TABLE dbo.cd_tmp_budget OWNER TO mobnius;

COMMENT ON TABLE dbo.cd_tmp_budget IS 'Форма базы данных городских бюджетников, подавших заявку на участие в предварительном голосовании Единой России';

COMMENT ON COLUMN dbo.cd_tmp_budget.f_street IS 'Улица';

COMMENT ON COLUMN dbo.cd_tmp_budget.f_house IS 'Дом';

COMMENT ON COLUMN dbo.cd_tmp_budget.f_appartament IS 'Помещение, Квартира';

COMMENT ON COLUMN dbo.cd_tmp_budget.c_first_name IS 'Имя';

COMMENT ON COLUMN dbo.cd_tmp_budget.c_last_name IS 'Фамилия';

COMMENT ON COLUMN dbo.cd_tmp_budget.c_patronymic IS 'Отчество';

COMMENT ON COLUMN dbo.cd_tmp_budget.f_user IS 'Пользователь';

COMMENT ON COLUMN dbo.cd_tmp_budget.c_org IS 'Название организации';

COMMENT ON COLUMN dbo.cd_tmp_budget.c_phone IS 'Телефон';

--------------------------------------------------------------------------------

CREATE INDEX cd_budget_f_appartament_idx ON dbo.cd_tmp_budget USING btree (f_appartament);

--------------------------------------------------------------------------------

ALTER TABLE dbo.cd_tmp_budget
	ADD CONSTRAINT cd_budget_pkey PRIMARY KEY (id);

--------------------------------------------------------------------------------

ALTER TABLE dbo.cd_tmp_budget
	ADD CONSTRAINT cd_budget_f_appartament FOREIGN KEY (f_appartament) REFERENCES dbo.cs_appartament(id);

--------------------------------------------------------------------------------

ALTER TABLE dbo.cd_tmp_budget
	ADD CONSTRAINT cd_budget_f_house FOREIGN KEY (f_house) REFERENCES dbo.cs_house(id);

--------------------------------------------------------------------------------

ALTER TABLE dbo.cd_tmp_budget
	ADD CONSTRAINT cd_budget_f_user FOREIGN KEY (f_user) REFERENCES core.pd_users(id);

--------------------------------------------------------------------------------

ALTER TABLE dbo.cd_tmp_budget
	ADD CONSTRAINT cd_budget_street FOREIGN KEY (f_street) REFERENCES dbo.cs_street(id);
