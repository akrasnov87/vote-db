CREATE TABLE dbo.cs_question (
	id bigint DEFAULT nextval('dbo.auto_id_cs_question'::regclass) NOT NULL,
	c_title text NOT NULL,
	c_description text NOT NULL,
	c_text text NOT NULL,
	n_order integer DEFAULT 0 NOT NULL,
	b_disabled boolean DEFAULT false NOT NULL,
	dx_created timestamp with time zone DEFAULT now() NOT NULL,
	sn_delete boolean DEFAULT false NOT NULL,
	f_role integer,
	n_priority integer
);

ALTER TABLE dbo.cs_question OWNER TO mobnius;

COMMENT ON TABLE dbo.cs_question IS 'Речевой модуль';

COMMENT ON COLUMN dbo.cs_question.id IS '[e80] Идентификатор';

COMMENT ON COLUMN dbo.cs_question.c_title IS '[e70|d] Заголовок';

COMMENT ON COLUMN dbo.cs_question.c_description IS '[e60] Описание';

COMMENT ON COLUMN dbo.cs_question.c_text IS '[e50] Текст';

COMMENT ON COLUMN dbo.cs_question.n_order IS '[e40] Сортировка';

COMMENT ON COLUMN dbo.cs_question.b_disabled IS '[e30] Отключить';

COMMENT ON COLUMN dbo.cs_question.dx_created IS '[e20] Дата создания';

COMMENT ON COLUMN dbo.cs_question.sn_delete IS '[e10] Признак удаленной записи';

COMMENT ON COLUMN dbo.cs_question.f_role IS 'Конкретно для указанной роли';

--------------------------------------------------------------------------------

ALTER TABLE dbo.cs_question
	ADD CONSTRAINT cs_question_pkey PRIMARY KEY (id);

--------------------------------------------------------------------------------

ALTER TABLE dbo.cs_question
	ADD CONSTRAINT cs_question_f_role_fkey FOREIGN KEY (f_role) REFERENCES core.pd_roles(id) NOT VALID;
