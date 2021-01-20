CREATE OR REPLACE FUNCTION dbo.cf_mui_ed_seals(_fn_user integer, _c_version text) RETURNS TABLE(id uuid, c_number text, f_user integer, f_type integer, c_type text, b_use boolean, dx_created timestamp with time zone)
    LANGUAGE plpgsql STABLE
    AS $$
DECLARE 
	_day text;
BEGIN
	select coalesce(s.c_value, '30') into _day from core.cd_settings as s
	where s.c_key = 'DB_SEAL_DAY';
	
    RETURN QUERY select 
		s.id, 
		coalesce(s.c_number, concat(s.c_prefix, s.n_number::text)), 
		s.f_user, 
		s.f_type,
		st.c_name,
		CASE WHEN ocs.id is null THEN false ELSE true END as b_use, 
		s.dx_created
	from dbo.ed_seals as s
	inner join dbo.es_seal_types as st ON st.id = s.f_type
	left join dbo.ed_output_conn_seals as ocs ON ocs.fn_seal_new = s.id
	where s.f_user = _fn_user and (s.dx_created + (_day || ' day')::interval)::date >= now()::date;
END
$$;

ALTER FUNCTION dbo.cf_mui_ed_seals(_fn_user integer, _c_version text) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_mui_ed_seals(_fn_user integer, _c_version text) IS 'Список пломб для обходчика';
