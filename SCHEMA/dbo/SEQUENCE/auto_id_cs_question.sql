CREATE SEQUENCE dbo.auto_id_cs_question
	START WITH 1
	INCREMENT BY 1
	NO MAXVALUE
	NO MINVALUE
	CACHE 1;

ALTER SEQUENCE dbo.auto_id_cs_question OWNER TO mobnius;
