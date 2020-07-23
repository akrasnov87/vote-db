CREATE TABLE dbo.ed_registr_pts (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	c_appartament_num text,
	n_appartament_num integer,
	c_house_num text,
	c_address text NOT NULL,
	f_division integer NOT NULL,
	f_subdivision integer,
	b_disabled boolean DEFAULT false NOT NULL,
	dx_created timestamp with time zone DEFAULT now() NOT NULL,
	sn_delete boolean DEFAULT false NOT NULL
);

ALTER TABLE dbo.ed_registr_pts OWNER TO mobnius;

COMMENT ON TABLE dbo.ed_registr_pts IS 'Учетный показатель';

COMMENT ON COLUMN dbo.ed_registr_pts.id IS '[e180] Идентификатор';

COMMENT ON COLUMN dbo.ed_registr_pts.c_appartament_num IS '[e170] Номер квартиры (строковая)';

COMMENT ON COLUMN dbo.ed_registr_pts.n_appartament_num IS '[e160] Номер квартиры';

COMMENT ON COLUMN dbo.ed_registr_pts.c_house_num IS '[e150] Номер дома (строковая)';

COMMENT ON COLUMN dbo.ed_registr_pts.c_address IS '[110|d] Адрес';

COMMENT ON COLUMN dbo.ed_registr_pts.f_division IS '[e60] Отделение';

COMMENT ON COLUMN dbo.ed_registr_pts.f_subdivision IS '[e50] Участок';

COMMENT ON COLUMN dbo.ed_registr_pts.b_disabled IS '[e40] Отлючено';

COMMENT ON COLUMN dbo.ed_registr_pts.dx_created IS '[e20] Дата создания';

COMMENT ON COLUMN dbo.ed_registr_pts.sn_delete IS '[e10] Признак удаленной записи';

--------------------------------------------------------------------------------

CREATE TRIGGER ed_registr_pts_trigger
	BEFORE INSERT OR UPDATE OR DELETE ON dbo.ed_registr_pts
	FOR EACH ROW
	EXECUTE PROCEDURE core.cft_0_log_action();

--------------------------------------------------------------------------------

ALTER TABLE dbo.ed_registr_pts
	ADD CONSTRAINT ed_registr_pts_pkey PRIMARY KEY (id);

--------------------------------------------------------------------------------

ALTER TABLE dbo.ed_registr_pts
	ADD CONSTRAINT ed_registr_pts_f_division_fkey FOREIGN KEY (f_division) REFERENCES core.sd_divisions(id);

--------------------------------------------------------------------------------

ALTER TABLE dbo.ed_registr_pts
	ADD CONSTRAINT ed_registr_pts_f_subdivision_fkey FOREIGN KEY (f_subdivision) REFERENCES core.sd_subdivisions(id);
