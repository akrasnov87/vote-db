CREATE TABLE core.cd_results (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	fn_user_point uuid NOT NULL,
	fn_point uuid NOT NULL,
	fn_type integer NOT NULL,
	fn_user integer NOT NULL,
	fn_route uuid NOT NULL,
	d_date timestamp with time zone NOT NULL,
	c_notice text,
	b_warning boolean DEFAULT false NOT NULL,
	jb_data jsonb,
	dx_created timestamp with time zone DEFAULT now()
);

ALTER TABLE core.cd_results OWNER TO mobnius;

COMMENT ON TABLE core.cd_results IS 'Результат выполнения';

COMMENT ON COLUMN core.cd_results.id IS 'Идентификатор';

COMMENT ON COLUMN core.cd_results.fn_user_point IS 'Пользовательская точка';

COMMENT ON COLUMN core.cd_results.fn_point IS 'Точка маршрута';

COMMENT ON COLUMN core.cd_results.fn_type IS 'Тип результат';

COMMENT ON COLUMN core.cd_results.fn_user IS 'Пользователь';

COMMENT ON COLUMN core.cd_results.fn_route IS 'Маршрут';

COMMENT ON COLUMN core.cd_results.d_date IS 'Дата создания';

COMMENT ON COLUMN core.cd_results.c_notice IS 'Примечание';

COMMENT ON COLUMN core.cd_results.b_warning IS 'Предупреждение Дост./Недост.';

COMMENT ON COLUMN core.cd_results.jb_data IS 'JSON данные';

COMMENT ON COLUMN core.cd_results.dx_created IS 'Дата создания в БД';

--------------------------------------------------------------------------------

CREATE TRIGGER cd_results_1
	BEFORE INSERT OR UPDATE OR DELETE ON core.cd_results
	FOR EACH ROW
	EXECUTE PROCEDURE core.cft_log_action();

--------------------------------------------------------------------------------

ALTER TABLE core.cd_results
	ADD CONSTRAINT cd_results_pkey PRIMARY KEY (id);
