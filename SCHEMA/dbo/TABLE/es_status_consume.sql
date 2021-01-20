CREATE TABLE dbo.es_status_consume (
	id integer NOT NULL,
	n_code integer,
	c_name text NOT NULL,
	c_const text,
	n_order integer DEFAULT 0,
	b_default boolean DEFAULT false NOT NULL,
	b_disabled boolean DEFAULT false NOT NULL
);

ALTER TABLE dbo.es_status_consume ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
	SEQUENCE NAME dbo.es_status_consume_id_seq
	START WITH 1
	INCREMENT BY 1
	NO MAXVALUE
	NO MINVALUE
	CACHE 1
);

ALTER TABLE dbo.es_status_consume OWNER TO mobnius;
