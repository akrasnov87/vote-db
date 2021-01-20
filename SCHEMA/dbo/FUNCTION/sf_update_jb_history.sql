CREATE OR REPLACE FUNCTION dbo.sf_update_jb_history(items json, old_json json) RETURNS json
    LANGUAGE plv8 IMMUTABLE STRICT
    AS $$
	items.push(old_json);
	return items;
$$;

ALTER FUNCTION dbo.sf_update_jb_history(items json, old_json json) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.sf_update_jb_history(items json, old_json json) IS 'Обновление истории для специального поля jb_history';
