CREATE TABLE core.pd_userinroles (
	id integer DEFAULT nextval('core.auto_id_pd_userinroles'::regclass) NOT NULL,
	f_user integer NOT NULL,
	f_role integer NOT NULL,
	sn_delete boolean DEFAULT false NOT NULL
);

ALTER TABLE core.pd_userinroles OWNER TO mobnius;

COMMENT ON TABLE core.pd_userinroles IS 'Пользователи в ролях';

COMMENT ON COLUMN core.pd_userinroles.id IS '[e40] Идентификатор';

COMMENT ON COLUMN core.pd_userinroles.f_user IS '[e30] Пользователь';

COMMENT ON COLUMN core.pd_userinroles.f_role IS '[e20] Роль';

COMMENT ON COLUMN core.pd_userinroles.sn_delete IS '[e10] Удален';

--------------------------------------------------------------------------------

CREATE INDEX pd_userinroles_f_role ON core.pd_userinroles USING btree (f_role);

--------------------------------------------------------------------------------

CREATE INDEX pd_userinroles_f_user ON core.pd_userinroles USING btree (f_user);

--------------------------------------------------------------------------------

CREATE TRIGGER pd_userinroles_1
	BEFORE INSERT OR UPDATE OR DELETE ON core.pd_userinroles
	FOR EACH ROW
	EXECUTE PROCEDURE core.cft_0_log_action();

--------------------------------------------------------------------------------

ALTER TABLE core.pd_userinroles
	ADD CONSTRAINT pd_userinroles_pkey PRIMARY KEY (id);

--------------------------------------------------------------------------------

ALTER TABLE core.pd_userinroles
	ADD CONSTRAINT pd_userinroles_f_role_fkey FOREIGN KEY (f_role) REFERENCES core.pd_roles(id);

--------------------------------------------------------------------------------

ALTER TABLE core.pd_userinroles
	ADD CONSTRAINT pd_userinroles_f_user_fkey FOREIGN KEY (f_user) REFERENCES core.pd_users(id);
