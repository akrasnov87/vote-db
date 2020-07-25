CREATE VIEW dbo.cv_uik AS
	SELECT DISTINCT cs_house.n_uik
   FROM dbo.cs_house
  ORDER BY cs_house.n_uik;

ALTER VIEW dbo.cv_uik OWNER TO mobnius;
