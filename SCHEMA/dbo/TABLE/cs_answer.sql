CREATE TABLE dbo.cs_answer (
	id bigint DEFAULT nextval('dbo.auto_id_cs_answer'::regclass) NOT NULL,
	c_text text,
	f_question integer NOT NULL,
	f_next_question integer,
	c_action text,
	n_order integer NOT NULL DEFAULT 0,
	b_disabled boolean NOT NULL DEFAULT false,
	dx_created timestamp with time zone DEFAULT now(),
	sn_delete boolean NOT NULL DEFAULT false
);

ALTER TABLE dbo.cs_answer OWNER TO mobnius;

COMMENT ON TABLE dbo.cs_answer IS 'Речевой модуль';

COMMENT ON COLUMN dbo.cs_answer.id IS '[e90] Идентификатор';

COMMENT ON COLUMN dbo.cs_answer.c_text IS '[e80|d] Текст';

COMMENT ON COLUMN dbo.cs_answer.f_question IS '[e70] Вопрос';

COMMENT ON COLUMN dbo.cs_answer.f_next_question IS '[e60] Следующий вопрос';

COMMENT ON COLUMN dbo.cs_answer.c_action IS '[e50] Действие';

COMMENT ON COLUMN dbo.cs_answer.n_order IS '[e40] Сортировка';

COMMENT ON COLUMN dbo.cs_answer.b_disabled IS '[e30] Отключить';

COMMENT ON COLUMN dbo.cs_answer.dx_created IS '[e20] Дата создания';

COMMENT ON COLUMN dbo.cs_answer.sn_delete IS '[e10] Признак удаленной записи';

--------------------------------------------------------------------------------

ALTER TABLE dbo.cs_answer
	ADD CONSTRAINT cs_answer_pkey PRIMARY KEY (id);
	
--------------------------------------------------------------------------------

CREATE TRIGGER cs_answer_trigger
	BEFORE INSERT OR UPDATE OR DELETE ON dbo.cs_answer
	FOR EACH ROW
	EXECUTE PROCEDURE core.cft_0_log_action();

--------------------------------------------------------------------------------

ALTER TABLE dbo.cs_answer
	ADD CONSTRAINT cs_answer_f_question_fkey FOREIGN KEY (f_question) REFERENCES dbo.cs_question(id);
	
--------------------------------------------------------------------------------

ALTER TABLE dbo.cs_answer
	ADD CONSTRAINT cs_answer_f_next_question_fkey FOREIGN KEY (f_next_question) REFERENCES dbo.cs_question(id);