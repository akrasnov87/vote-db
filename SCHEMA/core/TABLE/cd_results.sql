CREATE TABLE core.cd_results (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	fn_user_point uuid NOT NULL,
	fn_point uuid NOT NULL,
	fn_type integer NOT NULL,
	fn_user integer NOT NULL,
	fn_route uuid NOT NULL,
	d_date timestamp with time zone NOT NULL,
	c_notice text,
	b_warning boolean NOT NULL DEFAULT false,
	f_question integer,
	f_answer integer,
	jb_data jsonb,
	dx_created timestamp with time zone DEFAULT now()
);

ALTER TABLE core.cd_results OWNER TO mobnius;

COMMENT ON TABLE core.cd_results IS 'Результат выполнения';

COMMENT ON COLUMN core.cd_results.id IS '[e110] Идентификатор';

COMMENT ON COLUMN core.cd_results.fn_user_point IS '[e100|d] Пользовательская точка';

COMMENT ON COLUMN core.cd_results.fn_point IS '[e90|d] Точка маршрута';

COMMENT ON COLUMN core.cd_results.fn_type IS '[e80] Тип результат';

COMMENT ON COLUMN core.cd_results.fn_user IS '[e70] Пользователь';

COMMENT ON COLUMN core.cd_results.fn_route IS '[e60] Маршрут';

COMMENT ON COLUMN core.cd_results.d_date IS '[e50] Дата создания';

COMMENT ON COLUMN core.cd_results.c_notice IS '[e40] Примечание';

COMMENT ON COLUMN core.cd_results.b_warning IS '[e30] Предупреждение';

COMMENT ON COLUMN core.cd_results.f_question IS '[e30] Вопрос';

COMMENT ON COLUMN core.cd_results.f_answer IS '[e30] Ответ';

COMMENT ON COLUMN core.cd_results.jb_data IS '[e20] JSON данные';

COMMENT ON COLUMN core.cd_results.dx_created IS '[e10] Дата создания в БД';

--------------------------------------------------------------------------------

CREATE TRIGGER cd_results_1
	BEFORE INSERT OR UPDATE OR DELETE ON core.cd_results
	FOR EACH ROW
	EXECUTE PROCEDURE core.cft_0_log_action();

--------------------------------------------------------------------------------

ALTER TABLE core.cd_results
	ADD CONSTRAINT cd_results_pkey PRIMARY KEY (id);
