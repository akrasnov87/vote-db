CREATE TABLE dbo.es_work_links (
	id integer NOT NULL,
	f_route_type integer NOT NULL,
	f_point_type integer NOT NULL,
	f_result_type integer NOT NULL,
	b_disabled boolean DEFAULT false NOT NULL,
	dx_created timestamp with time zone DEFAULT now() NOT NULL
);

ALTER TABLE dbo.es_work_links ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
	SEQUENCE NAME dbo.es_work_links_id_seq
	START WITH 1
	INCREMENT BY 1
	NO MAXVALUE
	NO MINVALUE
	CACHE 1
);

ALTER TABLE dbo.es_work_links OWNER TO mobnius;

COMMENT ON TABLE dbo.es_work_links IS 'Сопоставление видов работ';

COMMENT ON COLUMN dbo.es_work_links.f_route_type IS 'Тип маршрута';

COMMENT ON COLUMN dbo.es_work_links.f_point_type IS 'Тип точки';

COMMENT ON COLUMN dbo.es_work_links.f_result_type IS 'Тип результата';
