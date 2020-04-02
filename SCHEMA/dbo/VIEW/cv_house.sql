CREATE VIEW dbo.cv_house AS
	SELECT h.id,
    s.id AS street_id,
    s.c_name AS street_name,
    h.c_house_num,
    h.c_build_num,
    h.n_porch,
    h.n_height_num,
    h.n_appartament,
    h.c_data,
    h.b_mkd,
    h.b_private,
    h.b_self
   FROM (dbo.cs_house h
     JOIN dbo.cs_street s ON ((h.f_street = s.id)));

ALTER VIEW dbo.cv_house OWNER TO mobnius;

COMMENT ON VIEW dbo.cv_house IS 'Адреса';
