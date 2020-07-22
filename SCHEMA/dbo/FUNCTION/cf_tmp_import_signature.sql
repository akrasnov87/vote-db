CREATE OR REPLACE FUNCTION dbo.cf_tmp_import_signature(_import_id bigint, _appartament_id uuid) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
	update dbo.sd_import_signature_vvp
	set b_import = true,
	f_appartament = _appartament_id
	where id = _import_id;
	
	RETURN 0;
END
$$;

ALTER FUNCTION dbo.cf_tmp_import_signature(_import_id bigint, _appartament_id uuid) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_tmp_import_signature(_import_id bigint, _appartament_id uuid) IS 'Потом удалить';
