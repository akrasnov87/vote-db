CREATE OR REPLACE FUNCTION dbo.cf_mui_cd_mobile_help(_fn_user integer, _c_version text) RETURNS TABLE(id uuid, c_key text, c_html text, d_date timestamp with time zone, c_title text)
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
	RETURN QUERY SELECT h.id, h.c_key, h.c_html, h.d_date, h.c_title
	FROM dbo.cd_mobile_help as h
	where h.b_disabled = false;
END
$$;

ALTER FUNCTION dbo.cf_mui_cd_mobile_help(_fn_user integer, _c_version text) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_mui_cd_mobile_help(_fn_user integer, _c_version text) IS 'Справочная информация для мобильного телефона';
