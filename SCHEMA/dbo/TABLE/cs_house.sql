CREATE TABLE dbo.cs_house (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	f_street uuid,
	dx_date timestamp with time zone DEFAULT now() NOT NULL,
	b_disabled boolean DEFAULT false NOT NULL,
	n_uik integer,
	f_subdivision integer,
	f_user integer,
	f_candidate_users jsonb,
	n_latitude numeric,
	n_longitude numeric,
	n_building_year smallint,
	n_lift_count smallint,
	c_entrance_count text,
	n_appart_count smallint,
	s_fias_guid uuid,
	c_house_corp text,
	c_house_number text,
	c_house_litera text,
	n_count_floor_min text,
	n_count_floor_max text,
	jkh_house_link integer,
	c_full_number text
);

ALTER TABLE dbo.cs_house OWNER TO mobnius;

COMMENT ON TABLE dbo.cs_house IS 'Улицы';

COMMENT ON COLUMN dbo.cs_house.id IS 'Идентификатор';

COMMENT ON COLUMN dbo.cs_house.f_street IS 'Улица';

COMMENT ON COLUMN dbo.cs_house.f_candidate_users IS 'Кандидаты';

COMMENT ON COLUMN dbo.cs_house.n_latitude IS 'широта';

COMMENT ON COLUMN dbo.cs_house.n_longitude IS 'долгота';

COMMENT ON COLUMN dbo.cs_house.n_building_year IS 'год строения';

COMMENT ON COLUMN dbo.cs_house.n_lift_count IS 'количество лифтов';

COMMENT ON COLUMN dbo.cs_house.c_entrance_count IS 'кол-во подъездов';

COMMENT ON COLUMN dbo.cs_house.n_appart_count IS 'кол-во квартир';

COMMENT ON COLUMN dbo.cs_house.s_fias_guid IS 'ФИАС';

COMMENT ON COLUMN dbo.cs_house.c_house_corp IS 'корпус';

COMMENT ON COLUMN dbo.cs_house.c_house_litera IS 'литерала';

COMMENT ON COLUMN dbo.cs_house.n_count_floor_min IS 'мин. кол-во этажей';

COMMENT ON COLUMN dbo.cs_house.n_count_floor_max IS 'макс. кол-во этажей';

COMMENT ON COLUMN dbo.cs_house.jkh_house_link IS 'Идентификатор дома в ГИС ЖКХ';

COMMENT ON COLUMN dbo.cs_house.c_full_number IS 'Полный номер дома';

--------------------------------------------------------------------------------

CREATE INDEX cs_house_f_street_idx ON dbo.cs_house USING btree (f_street);

--------------------------------------------------------------------------------

CREATE INDEX cs_house_f_subdivision_idx ON dbo.cs_house USING btree (f_subdivision);

--------------------------------------------------------------------------------

CREATE TRIGGER cs_house_1
	BEFORE INSERT OR UPDATE OR DELETE ON dbo.cs_house
	FOR EACH ROW
	EXECUTE PROCEDURE core.cft_log_action();

--------------------------------------------------------------------------------

ALTER TABLE dbo.cs_house
	ADD CONSTRAINT cs_house_pkey PRIMARY KEY (id);

--------------------------------------------------------------------------------

ALTER TABLE dbo.cs_house
	ADD CONSTRAINT cs_house_f_street_fkey FOREIGN KEY (f_street) REFERENCES dbo.cs_street(id);

--------------------------------------------------------------------------------

ALTER TABLE dbo.cs_house
	ADD CONSTRAINT cs_house_f_subdivision_fkey FOREIGN KEY (f_subdivision) REFERENCES core.sd_subdivisions(id);

--------------------------------------------------------------------------------

ALTER TABLE dbo.cs_house
	ADD CONSTRAINT cs_house_f_user_fkey FOREIGN KEY (f_user) REFERENCES core.pd_users(id) NOT VALID;
