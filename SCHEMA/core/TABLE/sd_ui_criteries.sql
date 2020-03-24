CREATE TABLE core.sd_ui_criteries (
	id integer DEFAULT nextval('core.auto_id_sd_ui_criteries'::regclass) NOT NULL,
	c_view_id text NOT NULL,
	c_type text NOT NULL,
	c_filter_criteria text,
	c_filter_fn text,
	c_cls text,
	c_styles text,
	c_message text,
	c_roles text,
	c_field text
);

ALTER TABLE core.sd_ui_criteries OWNER TO mobnius;

COMMENT ON TABLE core.sd_ui_criteries IS 'Критерии';

COMMENT ON COLUMN core.sd_ui_criteries.id IS '[e100] Идентификатор';

COMMENT ON COLUMN core.sd_ui_criteries.c_view_id IS '[e90|d] Идентификатор представления';

COMMENT ON COLUMN core.sd_ui_criteries.c_type IS '[e80] Тип';

COMMENT ON COLUMN core.sd_ui_criteries.c_filter_criteria IS '[e70] Фильтр';

COMMENT ON COLUMN core.sd_ui_criteries.c_filter_fn IS '[e60] JavaScript-функция';

COMMENT ON COLUMN core.sd_ui_criteries.c_cls IS '[e50] CSS класс';

COMMENT ON COLUMN core.sd_ui_criteries.c_styles IS '[e40] Стили|Свойства';

COMMENT ON COLUMN core.sd_ui_criteries.c_message IS '[e30] Сообщение';

COMMENT ON COLUMN core.sd_ui_criteries.c_roles IS '[e20] Роли';

COMMENT ON COLUMN core.sd_ui_criteries.c_field IS '[e10] Поле';

--------------------------------------------------------------------------------

CREATE TRIGGER sd_ui_criteries_1
	BEFORE INSERT OR UPDATE OR DELETE ON core.sd_ui_criteries
	FOR EACH ROW
	EXECUTE PROCEDURE core.cft_0_log_action();

--------------------------------------------------------------------------------

ALTER TABLE core.sd_ui_criteries
	ADD CONSTRAINT sd_ui_criteries_pkey PRIMARY KEY (id);
