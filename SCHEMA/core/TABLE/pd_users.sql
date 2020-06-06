CREATE TABLE core.pd_users (
	id integer DEFAULT nextval('core.auto_id_pd_users'::regclass) NOT NULL,
	f_parent integer,
	c_login text NOT NULL,
	c_password text,
	s_salt text,
	s_hash text,
	c_email text,
	c_tel text,
	c_imei text,
	c_description text,
	b_disabled boolean DEFAULT false NOT NULL,
	sn_delete boolean DEFAULT false NOT NULL,
	n_uik integer
);

ALTER TABLE core.pd_users OWNER TO mobnius;

COMMENT ON TABLE core.pd_users IS 'Пользователи';

COMMENT ON COLUMN core.pd_users.id IS '[e150] Идентификатор';

COMMENT ON COLUMN core.pd_users.f_parent IS '[e140] Ответственный за УИК';

COMMENT ON COLUMN core.pd_users.c_login IS '[e130|d] Логин';

COMMENT ON COLUMN core.pd_users.c_password IS '[e120] Пароль';

COMMENT ON COLUMN core.pd_users.s_salt IS '[e100] Salt';

COMMENT ON COLUMN core.pd_users.s_hash IS '[e90] Hash';

COMMENT ON COLUMN core.pd_users.c_email IS '[e50] Адрес эл. почты';

COMMENT ON COLUMN core.pd_users.c_tel IS '[e40] Телефон';

COMMENT ON COLUMN core.pd_users.c_imei IS '[e35] IMEI';

COMMENT ON COLUMN core.pd_users.c_description IS '[e30] Описание';

COMMENT ON COLUMN core.pd_users.b_disabled IS '[e20] Отключен';

COMMENT ON COLUMN core.pd_users.sn_delete IS '[e10] Удален';

COMMENT ON COLUMN core.pd_users.n_uik IS '[e0] УИК';

--------------------------------------------------------------------------------

CREATE INDEX pd_users_n_uik_idx ON core.pd_users USING btree (n_uik);

--------------------------------------------------------------------------------

CREATE TRIGGER pd_users_1
	BEFORE INSERT OR UPDATE OR DELETE ON core.pd_users
	FOR EACH ROW
	EXECUTE PROCEDURE core.cft_0_log_action();

--------------------------------------------------------------------------------

ALTER TABLE core.pd_users
	ADD CONSTRAINT pd_users_pkey PRIMARY KEY (id);

--------------------------------------------------------------------------------

ALTER TABLE core.pd_users
	ADD CONSTRAINT pd_users_uniq_c_login UNIQUE (c_login);

--------------------------------------------------------------------------------

ALTER TABLE core.pd_users
	ADD CONSTRAINT pd_users_f_parent_fkey FOREIGN KEY (f_parent) REFERENCES core.pd_users(id);
