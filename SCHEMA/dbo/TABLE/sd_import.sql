CREATE TABLE dbo.sd_import (
	id integer NOT NULL,
	c_num text,
	c_area text,
	n_district integer,
	n_uik integer,
	c_type text,
	c_street text,
	c_house text,
	c_build text,
	c_porch text,
	c_floor text,
	n_appartament_count integer,
	n_appartament_start integer,
	n_appartament_end integer,
	c_notice text,
	f_house uuid
);

ALTER TABLE dbo.sd_import ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
	SEQUENCE NAME dbo.sd_import_id_seq
	START WITH 1
	INCREMENT BY 1
	NO MAXVALUE
	NO MINVALUE
	CACHE 1
);

ALTER TABLE dbo.sd_import OWNER TO mobnius;

COMMENT ON TABLE dbo.sd_import IS 'Таблица для импорта';

COMMENT ON COLUMN dbo.sd_import.c_num IS 'ID (номер агитатора - номер участка работы)';

COMMENT ON COLUMN dbo.sd_import.c_area IS 'Район';

COMMENT ON COLUMN dbo.sd_import.n_district IS '№ округа';

COMMENT ON COLUMN dbo.sd_import.n_uik IS '№ УИК';

COMMENT ON COLUMN dbo.sd_import.c_type IS 'улица (вид)';

COMMENT ON COLUMN dbo.sd_import.c_street IS 'улица (название)';

COMMENT ON COLUMN dbo.sd_import.c_house IS 'дом №';

COMMENT ON COLUMN dbo.sd_import.c_build IS 'корп.';

COMMENT ON COLUMN dbo.sd_import.c_porch IS 'Кол-во подъездов в данном доме';

COMMENT ON COLUMN dbo.sd_import.c_floor IS 'Кол-во этажей в данном доме';

COMMENT ON COLUMN dbo.sd_import.n_appartament_count IS 'Кол-во кв-р в данном доме';

COMMENT ON COLUMN dbo.sd_import.n_appartament_start IS 'номера квартир агитатора в данном доме (с __ по __)';

COMMENT ON COLUMN dbo.sd_import.n_appartament_end IS 'номера квартир агитатора в данном доме (с __ по __)';

COMMENT ON COLUMN dbo.sd_import.c_notice IS 'ПРИМЕЧАНИЯ';

--------------------------------------------------------------------------------

ALTER TABLE dbo.sd_import
	ADD CONSTRAINT sd_import_pkey PRIMARY KEY (id);
