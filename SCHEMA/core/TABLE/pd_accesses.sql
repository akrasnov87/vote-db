CREATE TABLE core.pd_accesses (
	id integer DEFAULT nextval('core.auto_id_pd_accesses'::regclass) NOT NULL,
	f_user integer,
	f_role integer,
	c_name text,
	f_action integer,
	c_criteria text,
	c_path text,
	c_function text,
	c_columns text,
	b_deletable boolean NOT NULL DEFAULT false,
	b_creatable boolean NOT NULL DEFAULT false,
	b_editable boolean NOT NULL DEFAULT false,
	b_full_control boolean NOT NULL DEFAULT false,
	sn_delete boolean NOT NULL DEFAULT false
);

ALTER TABLE core.pd_accesses OWNER TO mobnius;

COMMENT ON TABLE core.pd_accesses IS 'Права доступа';

COMMENT ON COLUMN core.pd_accesses.id IS '[e140] Идентификатор';

COMMENT ON COLUMN core.pd_accesses.f_user IS '[e130] Пользователь';

COMMENT ON COLUMN core.pd_accesses.f_role IS '[e120] Роль';

COMMENT ON COLUMN core.pd_accesses.c_name IS '[e110] Табл./Предст./Функц.';

COMMENT ON COLUMN core.pd_accesses.f_action IS '[e100] Действие';

COMMENT ON COLUMN core.pd_accesses.c_criteria IS '[e90] Серверный фильтр';

COMMENT ON COLUMN core.pd_accesses.c_path IS '[e80] Путь в файловой системе';

COMMENT ON COLUMN core.pd_accesses.c_function IS '[e70] Функция RPC или её часть';

COMMENT ON COLUMN core.pd_accesses.c_columns IS '[e60] Запрещенные колонки';

COMMENT ON COLUMN core.pd_accesses.b_deletable IS '[e50] Разрешено удалени';

COMMENT ON COLUMN core.pd_accesses.b_creatable IS '[e40] Разрешено создание';

COMMENT ON COLUMN core.pd_accesses.b_editable IS '[e30] Разрешено редактирование';

COMMENT ON COLUMN core.pd_accesses.b_full_control IS '[e20] Дополнительный доступ';

COMMENT ON COLUMN core.pd_accesses.sn_delete IS '[e10] Удален';

--------------------------------------------------------------------------------

CREATE TRIGGER pd_accesses_1
	BEFORE INSERT OR UPDATE OR DELETE ON core.pd_accesses
	FOR EACH ROW
	EXECUTE PROCEDURE core.cft_0_log_action();

--------------------------------------------------------------------------------

ALTER TABLE core.pd_accesses
	ADD CONSTRAINT pd_accesses_pkey PRIMARY KEY (id);

--------------------------------------------------------------------------------

ALTER TABLE core.pd_accesses
	ADD CONSTRAINT pd_accesses_f_action FOREIGN KEY (f_action) REFERENCES core.sd_ui_actions(id);

--------------------------------------------------------------------------------

ALTER TABLE core.pd_accesses
	ADD CONSTRAINT pd_accesses_f_role FOREIGN KEY (f_role) REFERENCES core.pd_roles(id);

--------------------------------------------------------------------------------

ALTER TABLE core.pd_accesses
	ADD CONSTRAINT pd_accesses_f_user FOREIGN KEY (f_user) REFERENCES core.pd_users(id);
