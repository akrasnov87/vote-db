CREATE TABLE dbo.sf_friend_types (
	id smallint DEFAULT nextval('dbo.sf_friend_types_id_seq'::regclass) NOT NULL,
	c_name character varying(30) NOT NULL,
	c_const character varying(20) NOT NULL,
	b_disabled boolean DEFAULT false NOT NULL,
	b_default boolean DEFAULT false NOT NULL
);

ALTER TABLE dbo.sf_friend_types OWNER TO mobnius;

COMMENT ON TABLE dbo.sf_friend_types IS 'Статус сторонника';

--------------------------------------------------------------------------------

ALTER TABLE dbo.sf_friend_types
	ADD CONSTRAINT sf_friend_types_pkey PRIMARY KEY (id);
