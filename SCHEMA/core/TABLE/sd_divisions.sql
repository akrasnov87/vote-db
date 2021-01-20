CREATE TABLE core.sd_divisions (
	id integer DEFAULT nextval('core.auto_id_sd_divisions'::regclass) NOT NULL,
	f_division integer,
	c_name text NOT NULL,
	c_dep_code text,
	n_code integer,
	b_disabled boolean DEFAULT false NOT NULL
);

ALTER TABLE core.sd_divisions OWNER TO mobnius;

COMMENT ON TABLE core.sd_divisions IS 'Отделения';

COMMENT ON COLUMN core.sd_divisions.id IS 'Идентификатор';

COMMENT ON COLUMN core.sd_divisions.f_division IS 'Вышестоящее отделение';

COMMENT ON COLUMN core.sd_divisions.c_name IS 'Наименование';

COMMENT ON COLUMN core.sd_divisions.c_dep_code IS 'Код отделения (филиала)';

COMMENT ON COLUMN core.sd_divisions.n_code IS 'Код';

COMMENT ON COLUMN core.sd_divisions.b_disabled IS 'Отключено';

--------------------------------------------------------------------------------

CREATE TRIGGER sd_divisions_1
	BEFORE INSERT OR UPDATE OR DELETE ON core.sd_divisions
	FOR EACH ROW
	EXECUTE PROCEDURE core.cft_log_action();

--------------------------------------------------------------------------------

ALTER TABLE core.sd_divisions
	ADD CONSTRAINT sd_divisions_pkey PRIMARY KEY (id);

--------------------------------------------------------------------------------

ALTER TABLE core.sd_divisions
	ADD CONSTRAINT sd_divisions_f_division_fkey FOREIGN KEY (f_division) REFERENCES core.sd_divisions(id);
