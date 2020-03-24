CREATE TABLE core.pd_navigations (
	id integer DEFAULT nextval('core.auto_id_pd_navigations'::regclass) NOT NULL,
	c_view_type text NOT NULL,
	c_alias text NOT NULL,
	b_leaf boolean NOT NULL DEFAULT false,
	c_icon_cls text,
	f_parent integer,
	c_name text,
	b_default_token boolean NOT NULL DEFAULT false,
	c_type text NOT NULL,
	b_visible boolean NOT NULL DEFAULT false,
	c_icon text,
	b_selectable boolean NOT NULL DEFAULT false,
	b_expanded boolean NOT NULL DEFAULT false,
	n_sort integer NOT NULL,
	b_not_auth boolean NOT NULL DEFAULT false,
	sn_delete boolean NOT NULL DEFAULT false
);

ALTER TABLE core.pd_navigations OWNER TO mobnius;

COMMENT ON TABLE core.pd_navigations IS 'Навигация';

COMMENT ON COLUMN core.pd_navigations.id IS '[e160] Идентификатор';

COMMENT ON COLUMN core.pd_navigations.c_view_type IS '[e150] Тип представления';

COMMENT ON COLUMN core.pd_navigations.c_alias IS '[e140] Корневое представление';

COMMENT ON COLUMN core.pd_navigations.b_leaf IS '[e130] Без дочерних элементов';

COMMENT ON COLUMN core.pd_navigations.c_icon_cls IS '[e120] Класс иконки';

COMMENT ON COLUMN core.pd_navigations.f_parent IS '[e110] Родительская запись';

COMMENT ON COLUMN core.pd_navigations.c_name IS '[e100|d] Заголовок';

COMMENT ON COLUMN core.pd_navigations.b_default_token IS '[e90] Страница по умолчанию';

COMMENT ON COLUMN core.pd_navigations.c_type IS '[e80] Тип меню';

COMMENT ON COLUMN core.pd_navigations.b_visible IS '[e70] Видимость';

COMMENT ON COLUMN core.pd_navigations.c_icon IS '[e60] Иконка в формате base64';

COMMENT ON COLUMN core.pd_navigations.b_selectable IS '[e50] Выбираемый';

COMMENT ON COLUMN core.pd_navigations.b_expanded IS '[e40] В развернутом виде';

COMMENT ON COLUMN core.pd_navigations.n_sort IS '[e30] Сортировка';

COMMENT ON COLUMN core.pd_navigations.b_not_auth IS '[e20] Доступен без авторизации';

COMMENT ON COLUMN core.pd_navigations.sn_delete IS '[e10] Удален';

--------------------------------------------------------------------------------

CREATE TRIGGER pd_navigations_1
	BEFORE INSERT OR UPDATE OR DELETE ON core.pd_navigations
	FOR EACH ROW
	EXECUTE PROCEDURE core.cft_0_log_action();

--------------------------------------------------------------------------------

ALTER TABLE core.pd_navigations
	ADD CONSTRAINT pd_navigations_pkey PRIMARY KEY (id);

--------------------------------------------------------------------------------

ALTER TABLE core.pd_navigations
	ADD CONSTRAINT pd_navigations_f_parent FOREIGN KEY (f_parent) REFERENCES core.pd_navigations(id);
