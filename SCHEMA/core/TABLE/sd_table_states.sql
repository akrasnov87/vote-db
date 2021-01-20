CREATE TABLE core.sd_table_states (
	id bigint NOT NULL,
	f_user integer NOT NULL,
	c_table_name text NOT NULL,
	jb_data jsonb
);

ALTER TABLE core.sd_table_states ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
	SEQUENCE NAME core.sd_table_states_id_seq
	START WITH 1
	INCREMENT BY 1
	NO MAXVALUE
	NO MINVALUE
	CACHE 1
);

ALTER TABLE core.sd_table_states OWNER TO mobnius;

COMMENT ON TABLE core.sd_table_states IS 'Состояние таблиц';

--------------------------------------------------------------------------------

ALTER TABLE core.sd_table_states
	ADD CONSTRAINT sd_table_states_pkey PRIMARY KEY (id);
