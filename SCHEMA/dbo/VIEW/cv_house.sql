CREATE VIEW dbo.cv_house AS
	SELECT h.id,
    s.id AS street_id,
    s.c_type AS c_street_type,
    s.c_name AS street_name,
    h.c_house_num,
    h.c_build_num,
    h.n_uik,
    h.c_floor,
    h.c_porch,
    h.f_subdivision,
    s.f_division,
    sd.c_name AS c_subdivision,
        CASE
            WHEN ((h.n_uik IS NULL) OR (h.f_subdivision IS NULL)) THEN true
            ELSE false
        END AS b_fail,
    ( SELECT count(*) AS count
           FROM dbo.cs_appartament a
          WHERE ((a.f_house = h.id) AND (a.b_disabled = false))) AS n_appartament,
    ( SELECT (count(*) = 1)
           FROM dbo.cs_appartament a
          WHERE ((a.f_house = h.id) AND (a.b_disabled = false))) AS b_private,
    h.b_disabled,
    s.b_disabled AS street_b_disabled
   FROM ((dbo.cs_house h
     JOIN dbo.cs_street s ON ((h.f_street = s.id)))
     LEFT JOIN core.sd_subdivisions sd ON ((sd.id = h.f_subdivision)))
  ORDER BY s.c_name;

ALTER VIEW dbo.cv_house OWNER TO mobnius;

COMMENT ON VIEW dbo.cv_house IS 'Адреса';
