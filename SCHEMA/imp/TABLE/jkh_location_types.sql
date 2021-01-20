CREATE TABLE imp.jkh_location_types (
	link integer NOT NULL,
	c_name text,
	c_prefix text,
	c_suffix text,
	n_level integer,
	b_skip_level boolean NOT NULL
);

ALTER TABLE imp.jkh_location_types OWNER TO mobnius;

COMMENT ON TABLE imp.jkh_location_types IS 'Типы элементов ФИАС';

COMMENT ON COLUMN imp.jkh_location_types.n_level IS 'Уровень';

COMMENT ON COLUMN imp.jkh_location_types.b_skip_level IS 'Не выводить уровень в иерархии адресного классификатора';

--------------------------------------------------------------------------------

ALTER TABLE imp.jkh_location_types
	ADD CONSTRAINT ss_jkh_location_type_pkey PRIMARY KEY (link);
