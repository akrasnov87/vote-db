CREATE TABLE dbo.cs_house (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	f_street uuid,
	c_number text,
	c_house_num text,
	c_build_num text,
	c_struc_num text,
	n_number integer,
	f_user integer,
	n_longitude numeric(20,15) NOT NULL,
	n_latitude numeric(20,15) NOT NULL,
	c_data text,
	b_student_hostel boolean NOT NULL,
	dx_created timestamp with time zone DEFAULT now(),
	sn_delete boolean NOT NULL DEFAULT false
);

ALTER TABLE dbo.cs_house OWNER TO mobnius;

COMMENT ON TABLE dbo.cs_house IS 'Улицы';

COMMENT ON COLUMN dbo.cs_house.id IS '[e70] Идентификатор';

COMMENT ON COLUMN dbo.cs_house.f_street IS '[e60] Улица';

COMMENT ON COLUMN dbo.cs_house.c_house_num IS '[e50] Номер дома';

COMMENT ON COLUMN dbo.cs_house.c_build_num IS '[e40] Корпус';

COMMENT ON COLUMN dbo.cs_house.c_struc_num IS '[e30] Строение';

COMMENT ON COLUMN dbo.cs_house.c_data IS '[e20] Дома/квартиры через запятую';

COMMENT ON COLUMN dbo.cs_house.b_student_hostel IS '[e10] Студенческое общежитие';

--------------------------------------------------------------------------------

ALTER TABLE dbo.cs_house
	ADD CONSTRAINT cs_house_pkey PRIMARY KEY (id);
	
--------------------------------------------------------------------------------

CREATE TRIGGER cs_house_trigger
	BEFORE INSERT OR UPDATE OR DELETE ON dbo.cs_house
	FOR EACH ROW
	EXECUTE PROCEDURE core.cft_0_log_action();
	
--------------------------------------------------------------------------------

ALTER TABLE dbo.cs_house
	ADD CONSTRAINT cs_house_f_user_fkey FOREIGN KEY (f_user) REFERENCES core.pd_users(id);
	
--------------------------------------------------------------------------------

ALTER TABLE dbo.cs_house
	ADD CONSTRAINT cs_house_f_street_fkey FOREIGN KEY (f_street) REFERENCES dbo.cs_street(id);