CREATE SEQUENCE dbo.sf_friend_types_id_seq
	AS smallint
	START WITH 1
	INCREMENT BY 1
	NO MAXVALUE
	NO MINVALUE
	CACHE 1;

ALTER SEQUENCE dbo.sf_friend_types_id_seq OWNER TO mobnius;

ALTER SEQUENCE dbo.sf_friend_types_id_seq
	OWNED BY dbo.sf_friend_types.id;
