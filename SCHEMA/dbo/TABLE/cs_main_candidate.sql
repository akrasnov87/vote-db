CREATE TABLE dbo.cs_main_candidate (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	n_subdivision integer NOT NULL,
	c_fio text NOT NULL,
	c_status text NOT NULL
);

ALTER TABLE dbo.cs_main_candidate OWNER TO mobnius;

COMMENT ON TABLE dbo.cs_main_candidate IS 'Список кандидатов со статусом отображения в речевом модуле (кандидат/депутат)';

COMMENT ON COLUMN dbo.cs_main_candidate.n_subdivision IS 'Номер округа';

COMMENT ON COLUMN dbo.cs_main_candidate.c_fio IS 'ФИО';

COMMENT ON COLUMN dbo.cs_main_candidate.c_status IS 'статус';

--------------------------------------------------------------------------------

ALTER TABLE dbo.cs_main_candidate
	ADD CONSTRAINT cs_main_candidate_pkey PRIMARY KEY (id);
