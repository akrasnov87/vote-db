CREATE TABLE dbo.sd_tmp_import_signature_vvp (
	id bigint NOT NULL,
	c_area text,
	n_uik integer,
	c_user_num text,
	c_user_fio text,
	c_street text,
	c_house text,
	c_appartament text,
	d_date date,
	c_status text,
	b_male boolean,
	n_age integer,
	n_signature integer,
	c_loyalty text,
	c_come text,
	c_notice text,
	b_import boolean NOT NULL,
	f_appartament uuid
);

ALTER TABLE dbo.sd_tmp_import_signature_vvp ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
	SEQUENCE NAME dbo.sd_import_signature_vvp_id_seq
	START WITH 1
	INCREMENT BY 1
	NO MAXVALUE
	NO MINVALUE
	CACHE 1
);

ALTER TABLE dbo.sd_tmp_import_signature_vvp OWNER TO mobnius;

COMMENT ON TABLE dbo.sd_tmp_import_signature_vvp IS 'Сбор подписей за ВВП';

COMMENT ON COLUMN dbo.sd_tmp_import_signature_vvp.c_area IS 'Район';

COMMENT ON COLUMN dbo.sd_tmp_import_signature_vvp.n_uik IS 'УИК';

COMMENT ON COLUMN dbo.sd_tmp_import_signature_vvp.c_user_num IS 'ID волантера';

COMMENT ON COLUMN dbo.sd_tmp_import_signature_vvp.c_user_fio IS 'ФИО волонтера';

COMMENT ON COLUMN dbo.sd_tmp_import_signature_vvp.c_street IS 'Улица';

COMMENT ON COLUMN dbo.sd_tmp_import_signature_vvp.c_house IS 'Дом';

COMMENT ON COLUMN dbo.sd_tmp_import_signature_vvp.c_appartament IS 'Квартира';

COMMENT ON COLUMN dbo.sd_tmp_import_signature_vvp.d_date IS 'Дата обхода';

COMMENT ON COLUMN dbo.sd_tmp_import_signature_vvp.c_status IS 'Статус контакта';

COMMENT ON COLUMN dbo.sd_tmp_import_signature_vvp.b_male IS 'Пол респондента';

COMMENT ON COLUMN dbo.sd_tmp_import_signature_vvp.n_age IS 'Возрастная категория респондента';

COMMENT ON COLUMN dbo.sd_tmp_import_signature_vvp.n_signature IS 'Количество подписей';

COMMENT ON COLUMN dbo.sd_tmp_import_signature_vvp.c_loyalty IS 'Лояльность';

COMMENT ON COLUMN dbo.sd_tmp_import_signature_vvp.c_come IS 'Явка';

COMMENT ON COLUMN dbo.sd_tmp_import_signature_vvp.c_notice IS 'Комментарий';

COMMENT ON COLUMN dbo.sd_tmp_import_signature_vvp.b_import IS 'Удалось импортировать или нет';

--------------------------------------------------------------------------------

CREATE INDEX sd_import_signature_vvp_b_import_idx ON dbo.sd_tmp_import_signature_vvp USING btree (b_import);

--------------------------------------------------------------------------------

ALTER TABLE dbo.sd_tmp_import_signature_vvp
	ADD CONSTRAINT sd_import_signature_vvp_pkey PRIMARY KEY (id);
