CREATE MATERIALIZED VIEW dbo.msv_rating AS
	SELECT u.id AS user_id,
    COALESCE(u.c_fio, u.c_login) AS c_login,
    u.f_subdivision,
    sd.c_name AS c_subdivision,
    u.n_uik,
    u.c_claims,
    ( SELECT core.cf_mui_cd_points_count(u.id, 0) AS cf_mui_cd_points_count) AS n_all,
    ( SELECT core.cf_mui_cd_results_count(u.id) AS cf_mui_cd_results_count) AS n_count,
    ( SELECT core.cf_mui_cd_results_count(u.id, CURRENT_DATE) AS cf_mui_cd_results_count) AS n_today_count
   FROM (core.pv_users u
     LEFT JOIN core.sd_subdivisions sd ON ((sd.id = u.f_subdivision)))
  WHERE (u.c_claims ~~* '%.inspector.%'::text)
WITH DATA;

ALTER MATERIALIZED VIEW dbo.msv_rating OWNER TO mobnius;

--------------------------------------------------------------------------------

CREATE INDEX msv_rating_c_claims ON dbo.msv_rating USING btree (c_claims);

--------------------------------------------------------------------------------

CREATE INDEX msv_rating_n_uik ON dbo.msv_rating USING btree (n_uik);

--------------------------------------------------------------------------------

CREATE INDEX msv_rating_f_subdivision ON dbo.msv_rating USING btree (f_subdivision);
