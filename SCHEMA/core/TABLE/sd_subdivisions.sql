CREATE TABLE core.sd_subdivisions (
	id integer DEFAULT nextval('core.auto_id_sd_subdivisions'::regclass) NOT NULL,
	f_division integer NOT NULL,
	n_code integer,
	c_name text NOT NULL,
	b_disabled boolean DEFAULT false NOT NULL,
	c_dep_code text
);

ALTER TABLE core.sd_subdivisions OWNER TO mobnius;

COMMENT ON TABLE core.sd_subdivisions IS 'Участки';

COMMENT ON COLUMN core.sd_subdivisions.id IS 'Идентификатор';

COMMENT ON COLUMN core.sd_subdivisions.f_division IS 'Отделение';

COMMENT ON COLUMN core.sd_subdivisions.n_code IS 'Код';

COMMENT ON COLUMN core.sd_subdivisions.c_name IS 'Наименование';

COMMENT ON COLUMN core.sd_subdivisions.b_disabled IS 'Отключено';

COMMENT ON COLUMN core.sd_subdivisions.c_dep_code IS 'Текстовый код';

--------------------------------------------------------------------------------

CREATE TRIGGER sd_subdivisions_1
	BEFORE INSERT OR UPDATE OR DELETE ON core.sd_subdivisions
	FOR EACH ROW
	EXECUTE PROCEDURE core.cft_log_action();

--------------------------------------------------------------------------------

ALTER TABLE core.sd_subdivisions
	ADD CONSTRAINT sd_subdivisions_pkey PRIMARY KEY (id);

--------------------------------------------------------------------------------

ALTER TABLE core.sd_subdivisions
	ADD CONSTRAINT sd_subdivisions_f_division_fkey FOREIGN KEY (f_division) REFERENCES core.sd_divisions(id);
