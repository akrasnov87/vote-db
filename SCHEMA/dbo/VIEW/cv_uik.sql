CREATE VIEW dbo.cv_uik AS
	SELECT t.id AS n_uik
   FROM ( SELECT cd_uik.id
           FROM dbo.cd_uik
        UNION ALL
         SELECT NULL::integer AS int4) t
  ORDER BY t.id;

ALTER VIEW dbo.cv_uik OWNER TO mobnius;
