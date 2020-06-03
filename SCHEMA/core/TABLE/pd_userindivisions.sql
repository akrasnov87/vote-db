CREATE TABLE core.pd_userindivisions (
	id integer DEFAULT nextval('core.auto_id_pd_userindivisions'::regclass) NOT NULL,
	f_user integer NOT NULL,
	f_division integer NOT NULL,
	f_subdivision integer,
	sn_delete boolean DEFAULT false NOT NULL
);

ALTER TABLE core.pd_userindivisions OWNER TO mobnius;

COMMENT ON TABLE core.pd_userindivisions IS 'Привязка пользователей к отделению или участку';

COMMENT ON COLUMN core.pd_userindivisions.id IS '[e50] Идентификатор';

COMMENT ON COLUMN core.pd_userindivisions.f_user IS '[e40] Пользователь';

COMMENT ON COLUMN core.pd_userindivisions.f_division IS '[e30] Отделение';

COMMENT ON COLUMN core.pd_userindivisions.f_subdivision IS '[e20] Участок';

COMMENT ON COLUMN core.pd_userindivisions.sn_delete IS '[e10] Признак удаленной записи';

--------------------------------------------------------------------------------

CREATE INDEX pd_userindivisions_f_user_idx ON core.pd_userindivisions USING btree (f_user);

--------------------------------------------------------------------------------

CREATE TRIGGER pd_userindivisions_1
	BEFORE INSERT OR UPDATE OR DELETE ON core.pd_userindivisions
	FOR EACH ROW
	EXECUTE PROCEDURE core.cft_0_log_action();

--------------------------------------------------------------------------------

ALTER TABLE core.pd_userindivisions
	ADD CONSTRAINT pd_userindivisions_pkey PRIMARY KEY (id);

--------------------------------------------------------------------------------

ALTER TABLE core.pd_userindivisions
	ADD CONSTRAINT pd_userindivisions_f_division_fkey FOREIGN KEY (f_division) REFERENCES core.sd_divisions(id);

--------------------------------------------------------------------------------

ALTER TABLE core.pd_userindivisions
	ADD CONSTRAINT pd_userindivisions_f_subdivision_fkey FOREIGN KEY (f_subdivision) REFERENCES core.sd_subdivisions(id);

--------------------------------------------------------------------------------

ALTER TABLE core.pd_userindivisions
	ADD CONSTRAINT pd_userindivisions_f_user_fkey FOREIGN KEY (f_user) REFERENCES core.pd_users(id);
