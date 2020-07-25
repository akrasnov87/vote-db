CREATE TABLE dbo.sd_tmp_import2 (
	id uuid NOT NULL,
	c_first_name text,
	c_last_name text,
	c_patronymic text,
	c_street text,
	c_house text,
	c_house_build text,
	c_appartament text,
	n_appartament integer,
	f_appartament uuid,
	b_valid boolean NOT NULL,
	c_type text
);

ALTER TABLE dbo.sd_tmp_import2 OWNER TO mobnius;

--------------------------------------------------------------------------------

ALTER TABLE dbo.sd_tmp_import2
	ADD CONSTRAINT sd_tmp_import2_pkey1 PRIMARY KEY (id);
