CREATE TABLE core.cd_feedbacks (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	c_imei text NOT NULL,
	fn_user integer NOT NULL,
	fn_type integer NOT NULL,
	c_question text NOT NULL,
	d_date_question timestamp with time zone NOT NULL,
	fn_question_file uuid,
	c_answer text,
	d_date_answer timestamp with time zone,
	fn_answer_file uuid,
	dx_created timestamp with time zone DEFAULT now()
);

ALTER TABLE core.cd_feedbacks OWNER TO mobnius;

COMMENT ON TABLE core.cd_feedbacks IS 'Обратная связь';

COMMENT ON COLUMN core.cd_feedbacks.id IS 'Идентификатор';

COMMENT ON COLUMN core.cd_feedbacks.c_imei IS 'IMEI';

COMMENT ON COLUMN core.cd_feedbacks.fn_user IS 'Пользователь';

COMMENT ON COLUMN core.cd_feedbacks.fn_type IS 'Тип обращения';

COMMENT ON COLUMN core.cd_feedbacks.c_question IS 'Текст обращения';

COMMENT ON COLUMN core.cd_feedbacks.d_date_question IS 'Дата обращения';

COMMENT ON COLUMN core.cd_feedbacks.fn_question_file IS 'Вложение обращения';

COMMENT ON COLUMN core.cd_feedbacks.c_answer IS 'Ответ';

COMMENT ON COLUMN core.cd_feedbacks.d_date_answer IS 'Дата ответ';

COMMENT ON COLUMN core.cd_feedbacks.fn_answer_file IS 'Вложение ответа';

COMMENT ON COLUMN core.cd_feedbacks.dx_created IS 'Дата создания в БД';

--------------------------------------------------------------------------------

CREATE TRIGGER cd_feedbacks_1
	BEFORE INSERT OR UPDATE OR DELETE ON core.cd_feedbacks
	FOR EACH ROW
	EXECUTE PROCEDURE core.cft_log_action();

--------------------------------------------------------------------------------

ALTER TABLE core.cd_feedbacks
	ADD CONSTRAINT cd_feedbacks_pkey PRIMARY KEY (id);

--------------------------------------------------------------------------------

ALTER TABLE core.cd_feedbacks
	ADD CONSTRAINT cd_feedbacks_fn_user FOREIGN KEY (fn_user) REFERENCES core.pd_users(id) NOT VALID;

--------------------------------------------------------------------------------

ALTER TABLE core.cd_feedbacks
	ADD CONSTRAINT cd_feedbacks_fn_type FOREIGN KEY (fn_type) REFERENCES core.cs_feedback_types(id) NOT VALID;
