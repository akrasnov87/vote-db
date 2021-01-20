CREATE OR REPLACE FUNCTION dbo.cf_mui_ed_blanks(_fn_user integer, _c_version text) RETURNS TABLE(id uuid, f_result_type integer, c_number text, f_user integer, b_use boolean, dx_created timestamp with time zone)
    LANGUAGE plpgsql STABLE
    AS $$
DECLARE 
	_day text;
BEGIN
	select coalesce(s.c_value, '30') into _day from core.cd_settings as s
	where s.c_key = 'DB_SEAL_DAY';
	
    RETURN QUERY select 
		b.id, 
		b.f_result_type,
		coalesce(b.c_number, concat(b.c_prefix, b.n_number::text)) as c_number, 
		b.f_user, 
		b.b_use, 
		b.dx_created
	from dbo.ed_blanks as b
	where b.f_user = _fn_user and b.b_draft = false and (b.dx_created + (_day || ' day')::interval)::date >= now()::date;
END
$$;

ALTER FUNCTION dbo.cf_mui_ed_blanks(_fn_user integer, _c_version text) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_mui_ed_blanks(_fn_user integer, _c_version text) IS 'Список бланков для обходчика';
