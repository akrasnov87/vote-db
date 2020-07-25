CREATE VIEW dbo.cv_street_types AS
	SELECT cs_street.c_type,
    max(cs_street.c_short_type) AS c_short_type
   FROM dbo.cs_street
  WHERE (btrim(cs_street.c_type) <> ''::text)
  GROUP BY cs_street.c_type
  ORDER BY cs_street.c_type;

ALTER VIEW dbo.cv_street_types OWNER TO mobnius;
