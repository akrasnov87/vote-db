CREATE SEQUENCE core.auto_id_sd_digests
	START WITH 1
	INCREMENT BY 1
	NO MAXVALUE
	NO MINVALUE
	CACHE 1;

ALTER SEQUENCE core.auto_id_sd_digests OWNER TO mobnius;
