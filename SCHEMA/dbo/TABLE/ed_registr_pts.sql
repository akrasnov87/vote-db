CREATE TABLE dbo.ed_registr_pts (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	c_subscr text,
	c_device text,
	jb_tel jsonb,
	jb_email jsonb,
	c_address text NOT NULL,
	c_fio text,
	n_longitude numeric(20,15) NOT NULL,
	n_latitude numeric(20,15) NOT NULL,
	f_user integer NOT NULL,
	f_division integer NOT NULL,
	f_subdivision integer,
    b_disabled boolean NOT NULL DEFAULT false,
    gx_geodata public.geography,
	dx_created timestamp with time zone DEFAULT now(),
	sn_delete boolean NOT NULL DEFAULT false
);

ALTER TABLE dbo.ed_registr_pts OWNER TO mobnius;

COMMENT ON TABLE dbo.ed_registr_pts IS 'Учетный показатель';

COMMENT ON COLUMN dbo.ed_registr_pts.id IS '[e160] Идентификатор';

COMMENT ON COLUMN dbo.ed_registr_pts.c_subscr IS '[e150] Номер ЛС';

COMMENT ON COLUMN dbo.ed_registr_pts.c_device IS '[e140] Номер ПУ';

COMMENT ON COLUMN dbo.ed_registr_pts.jb_tel IS '[e130] Номер телефона';

COMMENT ON COLUMN dbo.ed_registr_pts.jb_email IS '[e120] Эл. почта';

COMMENT ON COLUMN dbo.ed_registr_pts.c_address IS '[110|d] Адрес';

COMMENT ON COLUMN dbo.ed_registr_pts.c_fio IS '[100|d] ФИО потребителя';

COMMENT ON COLUMN dbo.ed_registr_pts.n_longitude IS '[e90] Долгота';

COMMENT ON COLUMN dbo.ed_registr_pts.n_latitude IS '[e80] Широта';

COMMENT ON COLUMN dbo.ed_registr_pts.f_user IS '[e70] Пользователь';

COMMENT ON COLUMN dbo.ed_registr_pts.f_division IS '[e60] Отделение';

COMMENT ON COLUMN dbo.ed_registr_pts.f_subdivision IS '[e50] Участок';

COMMENT ON COLUMN dbo.ed_registr_pts.b_disabled IS '[e40] Отлючено';

COMMENT ON COLUMN dbo.ed_registr_pts.gx_geodata IS '[e30] Вычисляемое поле';

COMMENT ON COLUMN dbo.ed_registr_pts.dx_created IS '[e20] Дата создания';

COMMENT ON COLUMN dbo.ed_registr_pts.sn_delete IS '[e10] Признак удаленной записи';

--------------------------------------------------------------------------------

ALTER TABLE dbo.ed_registr_pts
	ADD CONSTRAINT ed_registr_pts_pkey PRIMARY KEY (id);
	
--------------------------------------------------------------------------------

CREATE TRIGGER ed_registr_pts_coordinates_trigger_iu
	BEFORE INSERT OR UPDATE ON dbo.ed_registr_pts
	FOR EACH ROW
	EXECUTE PROCEDURE core.cftiu_coordinates_trigger();

--------------------------------------------------------------------------------

CREATE TRIGGER ed_registr_pts_trigger
	BEFORE INSERT OR UPDATE OR DELETE ON dbo.ed_registr_pts
	FOR EACH ROW
	EXECUTE PROCEDURE core.cft_0_log_action();

--------------------------------------------------------------------------------

ALTER TABLE dbo.ed_registr_pts
	ADD CONSTRAINT ed_registr_pts_f_division_fkey FOREIGN KEY (f_division) REFERENCES core.sd_divisions(id);

--------------------------------------------------------------------------------

ALTER TABLE dbo.ed_registr_pts
	ADD CONSTRAINT ed_registr_pts_f_subdivision_fkey FOREIGN KEY (f_subdivision) REFERENCES core.sd_divisions(id);

--------------------------------------------------------------------------------

ALTER TABLE dbo.ed_registr_pts
	ADD CONSTRAINT ed_registr_pts_f_user_fkey FOREIGN KEY (f_user) REFERENCES core.pd_users(id);