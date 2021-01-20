CREATE TABLE imp.jkh_premise_types (
	link integer NOT NULL,
	c_name text,
	c_const text,
	f_premise_type integer,
	b_resident boolean NOT NULL
);

ALTER TABLE imp.jkh_premise_types OWNER TO mobnius;

COMMENT ON TABLE imp.jkh_premise_types IS 'Типы помещений';

COMMENT ON COLUMN imp.jkh_premise_types.b_resident IS 'Помещение предназначено для проживания';

--------------------------------------------------------------------------------

ALTER TABLE imp.jkh_premise_types
	ADD CONSTRAINT cs_jkh_premise_type_pkey PRIMARY KEY (link);
