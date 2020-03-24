CREATE TABLE core.sd_ui_actions (
	id integer DEFAULT nextval('core.auto_id_sd_ui_actions'::regclass) NOT NULL,
	c_view_id text NOT NULL,
	c_text text NOT NULL,
	c_icon text,
	c_operation text,
	c_action_view text,
	c_xtype text NOT NULL,
	c_place text NOT NULL,
	n_sort integer,
	c_tooltip text,
	c_ui text,
	f_parent integer,
	c_selectiondependencytype text,
	c_confirmationmessage text,
	c_javascript_fn text,
	sn_delete boolean NOT NULL DEFAULT false
);

ALTER TABLE core.sd_ui_actions OWNER TO mobnius;

COMMENT ON TABLE core.sd_ui_actions IS 'Операции';

COMMENT ON COLUMN core.sd_ui_actions.id IS '[e160] Идентификатор';

COMMENT ON COLUMN core.sd_ui_actions.c_view_id IS '[e150] Идентификатор представления';

COMMENT ON COLUMN core.sd_ui_actions.c_text IS '[e140|d] Имя команды';

COMMENT ON COLUMN core.sd_ui_actions.c_icon IS '[e130] Иконка';

COMMENT ON COLUMN core.sd_ui_actions.c_operation IS '[e120] Метод';

COMMENT ON COLUMN core.sd_ui_actions.c_action_view IS '[e110] Представление';

COMMENT ON COLUMN core.sd_ui_actions.c_xtype IS '[e100] Тип операции';

COMMENT ON COLUMN core.sd_ui_actions.c_place IS '[e90] Место установки';

COMMENT ON COLUMN core.sd_ui_actions.n_sort IS '[e80] Сортировка по умолчанию';

COMMENT ON COLUMN core.sd_ui_actions.c_tooltip IS '[e70] Описание операции';

COMMENT ON COLUMN core.sd_ui_actions.c_ui IS '[e60] Стиль';

COMMENT ON COLUMN core.sd_ui_actions.f_parent IS '[e50] Родительский элемент';

COMMENT ON COLUMN core.sd_ui_actions.c_selectiondependencytype IS '[e40] Условие выполнения';

COMMENT ON COLUMN core.sd_ui_actions.c_confirmationmessage IS '[e30] Сообщение с текстом перед выполнением';

COMMENT ON COLUMN core.sd_ui_actions.c_javascript_fn IS '[e20] JavaScript-функция';

COMMENT ON COLUMN core.sd_ui_actions.sn_delete IS '[e10] Удален';

--------------------------------------------------------------------------------

CREATE TRIGGER sd_ui_actions_1
	BEFORE INSERT OR UPDATE OR DELETE ON core.sd_ui_actions
	FOR EACH ROW
	EXECUTE PROCEDURE core.cft_0_log_action();

--------------------------------------------------------------------------------

ALTER TABLE core.sd_ui_actions
	ADD CONSTRAINT sd_ui_actions_pkey PRIMARY KEY (id);

--------------------------------------------------------------------------------

ALTER TABLE core.sd_ui_actions
	ADD CONSTRAINT sd_ui_actions_f_parent FOREIGN KEY (f_parent) REFERENCES core.sd_ui_actions(id);
