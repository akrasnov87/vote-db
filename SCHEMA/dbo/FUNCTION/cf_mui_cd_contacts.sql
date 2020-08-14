CREATE OR REPLACE FUNCTION dbo.cf_mui_cd_contacts(_fn_user integer) RETURNS TABLE(id uuid, c_first_name text, c_last_name text, c_patronymic text, fn_house uuid, c_appartament text, n_rating integer, c_description text, d_date timestamp with time zone, fn_user integer, b_disabled boolean, jb_data text)
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
	RETURN QUERY SELECT c.id, c.c_first_name, c.c_last_name, c.c_patronymic, c.fn_house, c.c_appartament, c.n_rating, c.c_description, c.d_date, c.fn_user, c.b_disabled, c.jb_data::text
	FROM dbo.cd_contacts as c
	where c.fn_user = _fn_user and c.b_disabled = false;
END
$$;

ALTER FUNCTION dbo.cf_mui_cd_contacts(_fn_user integer) OWNER TO mobnius;
