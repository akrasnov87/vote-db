CREATE MATERIALIZED VIEW dbo.msv_appartament3 AS
	SELECT a.id,
    a.f_house,
    a.c_number,
    a.n_number,
    a.dx_date,
    a.b_disabled,
    a.f_user,
    a.n_signature_2018,
    a.f_main_user
   FROM dbo.cs_appartament a
  WHERE (a.id IN ( SELECT DISTINCT a_1.id
           FROM ((dbo.cs_appartament a_1
             JOIN dbo.cs_house h ON ((h.id = a_1.f_house)))
             JOIN dbo.cd_people p ON ((p.f_appartament = a_1.id)))
          WHERE ((p.f_type = 7) AND (a_1.b_disabled = false) AND (h.b_disabled = false) AND (a_1.f_main_user IS NOT NULL))))
WITH DATA;

ALTER MATERIALIZED VIEW dbo.msv_appartament3 OWNER TO mobnius;

--------------------------------------------------------------------------------

CREATE INDEX msv_appartament3_f_main_user_f_house_b_disabled_idx ON dbo.msv_appartament3 USING btree (f_main_user, f_house, b_disabled);
