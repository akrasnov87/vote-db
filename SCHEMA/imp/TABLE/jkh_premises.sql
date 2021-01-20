CREATE TABLE imp.jkh_premises (
	link integer NOT NULL,
	f_house integer,
	f_premise_type integer,
	c_number text,
	c_address text
);

ALTER TABLE imp.jkh_premises OWNER TO mobnius;

COMMENT ON TABLE imp.jkh_premises IS 'Помещения';

--------------------------------------------------------------------------------

ALTER TABLE imp.jkh_premises
	ADD CONSTRAINT jkh_premises_pkey PRIMARY KEY (link);

--------------------------------------------------------------------------------

ALTER TABLE imp.jkh_premises
	ADD CONSTRAINT jkh_premises_f_premise_type_fkey FOREIGN KEY (f_premise_type) REFERENCES imp.jkh_premise_types(link) NOT VALID;
