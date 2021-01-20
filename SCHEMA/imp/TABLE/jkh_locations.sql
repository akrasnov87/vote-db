CREATE TABLE imp.jkh_locations (
	link integer NOT NULL,
	f_location_type integer,
	c_name text,
	f_parent integer,
	f_level_1 integer,
	f_level_2 integer,
	f_level_3 integer,
	f_level_4 integer,
	s_fias_guid uuid,
	c_name_full text
);

ALTER TABLE imp.jkh_locations OWNER TO mobnius;

COMMENT ON TABLE imp.jkh_locations IS 'ФИАС';

COMMENT ON COLUMN imp.jkh_locations.f_location_type IS 'тип';

COMMENT ON COLUMN imp.jkh_locations.c_name IS 'наименование';

COMMENT ON COLUMN imp.jkh_locations.f_parent IS 'род. запись';

COMMENT ON COLUMN imp.jkh_locations.s_fias_guid IS 'ФИАС';

COMMENT ON COLUMN imp.jkh_locations.c_name_full IS 'полное наименование';

--------------------------------------------------------------------------------

ALTER TABLE imp.jkh_locations
	ADD CONSTRAINT jkh_locations_pkey PRIMARY KEY (link);

--------------------------------------------------------------------------------

ALTER TABLE imp.jkh_locations
	ADD CONSTRAINT jkh_locations_f_location_type_fkey FOREIGN KEY (f_location_type) REFERENCES imp.jkh_location_types(link) NOT VALID;
