CREATE MATERIALIZED VIEW dbo.msv_appartament_by_vv AS
	SELECT t.id,
    t.c_area,
    t.c_street_type,
    t.c_street_name,
    t.f_street,
    t.c_house_num,
    t.c_house_build,
    t.f_house,
    t.c_appartament,
    t.n_appartament,
    t.n_uik,
    t.f_subdivision,
    t.c_subdivision,
    t.n_signature,
    t.jb_food_kit,
    t.jb_other,
    t.jb_er,
    t.jb_budget
   FROM ( SELECT a.id,
            d.c_name AS c_area,
            s.c_type AS c_street_type,
            s.c_name AS c_street_name,
            s.id AS f_street,
            h.c_house_num,
            h.c_build_num AS c_house_build,
            h.id AS f_house,
            a.c_number AS c_appartament,
            a.n_number AS n_appartament,
            h.n_uik,
            sd.id AS f_subdivision,
            sd.c_name AS c_subdivision,
            a.n_signature_2018 AS n_signature,
            ( SELECT array_to_json(array_agg(row_to_json(t_1.*))) AS array_to_json
                   FROM ( SELECT cd_people.id,
                            cd_people.c_first_name,
                            cd_people.c_last_name,
                            cd_people.c_patronymic,
                            cd_people.dx_created,
                            cd_people.n_birth_year,
                            cd_people.c_org,
                            cd_people.c_phone
                           FROM dbo.cd_people
                          WHERE ((cd_people.f_type = 2) AND (cd_people.f_appartament = a.id))) t_1) AS jb_food_kit,
            ( SELECT array_to_json(array_agg(row_to_json(t_1.*))) AS array_to_json
                   FROM ( SELECT cd_people.id,
                            cd_people.c_first_name,
                            cd_people.c_last_name,
                            cd_people.c_patronymic,
                            cd_people.dx_created,
                            cd_people.n_birth_year,
                            cd_people.c_org,
                            cd_people.c_phone
                           FROM dbo.cd_people
                          WHERE ((cd_people.f_type = 3) AND (cd_people.f_appartament = a.id))) t_1) AS jb_other,
            ( SELECT array_to_json(array_agg(row_to_json(t_1.*))) AS array_to_json
                   FROM ( SELECT cd_people.id,
                            cd_people.c_first_name,
                            cd_people.c_last_name,
                            cd_people.c_patronymic,
                            cd_people.dx_created,
                            cd_people.n_birth_year,
                            cd_people.c_org,
                            cd_people.c_phone
                           FROM dbo.cd_people
                          WHERE ((cd_people.f_type = 4) AND (cd_people.f_appartament = a.id))) t_1) AS jb_er,
            ( SELECT array_to_json(array_agg(row_to_json(t_1.*))) AS array_to_json
                   FROM ( SELECT cd_people.id,
                            cd_people.c_first_name,
                            cd_people.c_last_name,
                            cd_people.c_patronymic,
                            cd_people.dx_created,
                            cd_people.n_birth_year,
                            cd_people.c_org,
                            cd_people.c_phone
                           FROM dbo.cd_people
                          WHERE ((cd_people.f_type = 5) AND (cd_people.f_appartament = a.id))) t_1) AS jb_budget
           FROM ((((dbo.msv_appartament_vv a
             JOIN dbo.cs_house h ON ((h.id = a.f_house)))
             LEFT JOIN core.sd_subdivisions sd ON ((sd.id = h.f_subdivision)))
             JOIN dbo.cs_street s ON ((h.f_street = s.id)))
             LEFT JOIN core.sd_divisions d ON ((s.f_division = d.id)))) t
WITH DATA;

ALTER MATERIALIZED VIEW dbo.msv_appartament_by_vv OWNER TO mobnius;

COMMENT ON MATERIALIZED VIEW dbo.msv_appartament_by_vv IS 'Квартиры не в частном секторе и есть хотя бы одно из условий ';

--------------------------------------------------------------------------------

CREATE INDEX msv_appartament_by_vv_f_house_idx ON dbo.msv_appartament_by_vv USING btree (f_house);

--------------------------------------------------------------------------------

CREATE INDEX msv_appartament_by_vv_f_subdivision_idx ON dbo.msv_appartament_by_vv USING btree (f_subdivision);
