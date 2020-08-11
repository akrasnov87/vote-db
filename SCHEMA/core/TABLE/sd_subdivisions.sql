CREATE TABLE core.sd_subdivisions (
	id integer DEFAULT nextval('core.auto_id_sd_subdivisions'::regclass) NOT NULL,
	f_division integer NOT NULL,
	n_code integer,
	c_name text NOT NULL,
	b_disabled boolean DEFAULT false NOT NULL,
	c_email text
);

ALTER TABLE core.sd_subdivisions OWNER TO mobnius;

COMMENT ON TABLE core.sd_subdivisions IS 'Участки';

COMMENT ON COLUMN core.sd_subdivisions.id IS '[e50] Идентификатор';

COMMENT ON COLUMN core.sd_subdivisions.f_division IS '[e40] Отделение';

COMMENT ON COLUMN core.sd_subdivisions.n_code IS '[e30] Код';

COMMENT ON COLUMN core.sd_subdivisions.c_name IS '[e20|d] Наименование';

COMMENT ON COLUMN core.sd_subdivisions.b_disabled IS '[e10] Отключено';

COMMENT ON COLUMN core.sd_subdivisions.c_email IS 'Список адресов для рассылки';

--------------------------------------------------------------------------------

CREATE TRIGGER sd_subdivisions_1
	BEFORE INSERT OR UPDATE OR DELETE ON core.sd_subdivisions
	FOR EACH ROW
	EXECUTE PROCEDURE core.cft_0_log_action();

--------------------------------------------------------------------------------

ALTER TABLE core.sd_subdivisions
	ADD CONSTRAINT sd_subdivisions_pkey PRIMARY KEY (id);

--------------------------------------------------------------------------------

ALTER TABLE core.sd_subdivisions
	ADD CONSTRAINT sd_subdivisions_f_division_fkey FOREIGN KEY (f_division) REFERENCES core.sd_divisions(id);
