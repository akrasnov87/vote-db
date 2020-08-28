CREATE TABLE core.sd_divisions (
	id integer DEFAULT nextval('core.auto_id_sd_divisions'::regclass) NOT NULL,
	f_division integer,
	c_name text NOT NULL,
	c_dep_code text,
	n_code integer,
	b_disabled boolean DEFAULT false NOT NULL,
	c_email text,
	c_email_agitator text,
	c_email_agitator_v2 text
);

ALTER TABLE core.sd_divisions OWNER TO mobnius;

COMMENT ON TABLE core.sd_divisions IS 'Отделения';

COMMENT ON COLUMN core.sd_divisions.id IS '[e60] Идентификатор';

COMMENT ON COLUMN core.sd_divisions.f_division IS '[e50] Вышестоящее отделение';

COMMENT ON COLUMN core.sd_divisions.c_name IS '[e40|d] Наименование';

COMMENT ON COLUMN core.sd_divisions.c_dep_code IS '[e30] Код отделения (филиала)';

COMMENT ON COLUMN core.sd_divisions.n_code IS '[e20] Код';

COMMENT ON COLUMN core.sd_divisions.b_disabled IS '[e10] Отключено';

COMMENT ON COLUMN core.sd_divisions.c_email IS 'Адреса для рассылки отчетов по кандидатам';

COMMENT ON COLUMN core.sd_divisions.c_email_agitator IS 'адреса почты для рассылки отчетов по агитаторам';

--------------------------------------------------------------------------------

CREATE TRIGGER sd_divisions_1
	BEFORE INSERT OR UPDATE OR DELETE ON core.sd_divisions
	FOR EACH ROW
	EXECUTE PROCEDURE core.cft_0_log_action();

--------------------------------------------------------------------------------

ALTER TABLE core.sd_divisions
	ADD CONSTRAINT sd_divisions_pkey PRIMARY KEY (id);

--------------------------------------------------------------------------------

ALTER TABLE core.sd_divisions
	ADD CONSTRAINT sd_divisions_f_division_fkey FOREIGN KEY (f_division) REFERENCES core.sd_divisions(id);
