CREATE TABLE core.pd_roles (
	id integer DEFAULT nextval('core.auto_id_pd_roles'::regclass) NOT NULL,
	c_name text NOT NULL,
	c_description text,
	n_weight integer NOT NULL,
	sn_delete boolean NOT NULL DEFAULT false
);

ALTER TABLE core.pd_roles OWNER TO mobnius;

COMMENT ON TABLE core.pd_roles IS 'Роли';

COMMENT ON COLUMN core.pd_roles.id IS '[e50] Идентификатор';

COMMENT ON COLUMN core.pd_roles.c_name IS '[e40|d] Наименование';

COMMENT ON COLUMN core.pd_roles.c_description IS '[e30] Описание роли';

COMMENT ON COLUMN core.pd_roles.n_weight IS '[e20] Приоритет';

COMMENT ON COLUMN core.pd_roles.sn_delete IS '[e10] Удален';

--------------------------------------------------------------------------------

CREATE TRIGGER pd_roles_1
	BEFORE INSERT OR UPDATE OR DELETE ON core.pd_roles
	FOR EACH ROW
	EXECUTE PROCEDURE core.cft_0_log_action();

--------------------------------------------------------------------------------

ALTER TABLE core.pd_roles
	ADD CONSTRAINT pd_roles_pkey PRIMARY KEY (id);

--------------------------------------------------------------------------------

ALTER TABLE core.pd_roles
	ADD CONSTRAINT pd_roles_uniq_c_name UNIQUE (c_name);
