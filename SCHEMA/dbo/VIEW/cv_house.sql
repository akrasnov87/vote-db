CREATE VIEW dbo.cv_house AS
	SELECT h.id,
    s.id AS street_id,
    s.c_name AS street_name,
    h.c_house_num,
    h.c_build_num,
    h.c_porch,
    h.c_floor,
    ( SELECT count(*) AS count
           FROM dbo.cs_appartament a
          WHERE (a.f_house = h.id)) AS n_appartament,
    ( SELECT (count(*) = 1)
           FROM dbo.cs_appartament a
          WHERE (a.f_house = h.id)) AS b_private
   FROM (dbo.cs_house h
     JOIN dbo.cs_street s ON ((h.f_street = s.id)));

ALTER VIEW dbo.cv_house OWNER TO mobnius;

COMMENT ON VIEW dbo.cv_house IS 'Адреса';
