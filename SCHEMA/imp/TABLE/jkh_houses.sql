CREATE TABLE imp.jkh_houses (
	link integer NOT NULL,
	f_street integer,
	c_house_number text,
	c_address text,
	n_building_year integer,
	n_lift_count integer,
	c_floor text,
	n_entrance_count integer,
	n_appart_count integer,
	s_fias_guid uuid,
	c_house_num text,
	c_house_corp text,
	c_house_litera text,
	n_count_floor_min text,
	n_count_floor_max text
);

ALTER TABLE imp.jkh_houses OWNER TO mobnius;

COMMENT ON TABLE imp.jkh_houses IS 'Реестр домов';

COMMENT ON COLUMN imp.jkh_houses.f_street IS 'Улица';

COMMENT ON COLUMN imp.jkh_houses.c_house_number IS 'номер дома - полностью';

COMMENT ON COLUMN imp.jkh_houses.c_address IS 'адрес';

COMMENT ON COLUMN imp.jkh_houses.n_building_year IS 'год строения';

COMMENT ON COLUMN imp.jkh_houses.n_lift_count IS 'количество лифтов';

COMMENT ON COLUMN imp.jkh_houses.c_floor IS 'Количество этажей';

COMMENT ON COLUMN imp.jkh_houses.n_entrance_count IS 'кол-во подъездов';

COMMENT ON COLUMN imp.jkh_houses.n_appart_count IS 'кол-во квартир';

COMMENT ON COLUMN imp.jkh_houses.s_fias_guid IS 'ФИАС';

COMMENT ON COLUMN imp.jkh_houses.c_house_num IS 'номер дома';

COMMENT ON COLUMN imp.jkh_houses.c_house_corp IS 'корпус';

COMMENT ON COLUMN imp.jkh_houses.c_house_litera IS 'литерала';

COMMENT ON COLUMN imp.jkh_houses.n_count_floor_min IS 'мин. кол-во этажей';

COMMENT ON COLUMN imp.jkh_houses.n_count_floor_max IS 'макс. кол-во этажей';

--------------------------------------------------------------------------------

ALTER TABLE imp.jkh_houses
	ADD CONSTRAINT jkh_houses_pkey PRIMARY KEY (link);

--------------------------------------------------------------------------------

ALTER TABLE imp.jkh_houses
	ADD CONSTRAINT jkh_houses_f_house_fkey FOREIGN KEY (f_street) REFERENCES imp.jkh_locations(link) NOT VALID;
