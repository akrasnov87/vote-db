CREATE MATERIALIZED VIEW dbo.msv_appartament4 AS
	SELECT a.id,
    a.f_house,
    a.c_number,
    a.n_number,
    a.dx_date,
    a.b_disabled,
    a.f_user,
    a.n_signature_2018,
    a.f_main_user
   FROM (dbo.cs_appartament a
     JOIN dbo.cs_house h ON ((a.f_house = h.id)))
  WHERE ((h.b_disabled = false) AND (a.id IN ( SELECT msv_union_appartament.f_appartament
           FROM dbo.msv_union_appartament
          GROUP BY msv_union_appartament.f_appartament)))
WITH DATA;

ALTER MATERIALIZED VIEW dbo.msv_appartament4 OWNER TO mobnius;

--------------------------------------------------------------------------------

CREATE INDEX msv_appartament4_b_disabled_f_house_c_numer_idx ON dbo.msv_appartament4 USING btree (b_disabled, f_house, c_number);

--------------------------------------------------------------------------------

CREATE INDEX msv_appartament4_b_disabled_idx ON dbo.msv_appartament4 USING btree (b_disabled);

--------------------------------------------------------------------------------

CREATE INDEX msv_appartament4_f_house_idx ON dbo.msv_appartament4 USING btree (f_house);

--------------------------------------------------------------------------------

CREATE INDEX msv_appartament4_f_user_idx ON dbo.msv_appartament4 USING btree (f_user);
