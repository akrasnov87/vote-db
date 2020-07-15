CREATE TABLE dbo.cd_manual_edit_info (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	f_street uuid NOT NULL,
	f_house uuid NOT NULL,
	f_appartament uuid NOT NULL,
	f_user integer NOT NULL,
	dx_created timestamp with time zone DEFAULT now() NOT NULL
);

ALTER TABLE dbo.cd_manual_edit_info OWNER TO mobnius;

COMMENT ON TABLE dbo.cd_manual_edit_info IS 'таблица для хранения информации предоставленной заказчиком';

COMMENT ON COLUMN dbo.cd_manual_edit_info.f_street IS 'Улица';

COMMENT ON COLUMN dbo.cd_manual_edit_info.f_house IS 'Дом';

COMMENT ON COLUMN dbo.cd_manual_edit_info.f_appartament IS 'Помещение, Квартира';

COMMENT ON COLUMN dbo.cd_manual_edit_info.f_user IS 'Пользователь';

--------------------------------------------------------------------------------

ALTER TABLE dbo.cd_manual_edit_info
	ADD CONSTRAINT cd_manual_edit_info_pkey PRIMARY KEY (id);

--------------------------------------------------------------------------------

ALTER TABLE dbo.cd_manual_edit_info
	ADD CONSTRAINT cd_manual_edit_info_street FOREIGN KEY (f_street) REFERENCES dbo.cs_street(id) NOT VALID;

--------------------------------------------------------------------------------

ALTER TABLE dbo.cd_manual_edit_info
	ADD CONSTRAINT cd_manual_edit_info_f_house FOREIGN KEY (f_house) REFERENCES dbo.cs_house(id) NOT VALID;

--------------------------------------------------------------------------------

ALTER TABLE dbo.cd_manual_edit_info
	ADD CONSTRAINT cd_manual_edit_info_f_appartament FOREIGN KEY (f_appartament) REFERENCES dbo.cs_appartament(id) NOT VALID;

--------------------------------------------------------------------------------

ALTER TABLE dbo.cd_manual_edit_info
	ADD CONSTRAINT cd_manual_edit_info_f_user FOREIGN KEY (f_user) REFERENCES core.pd_users(id) NOT VALID;
