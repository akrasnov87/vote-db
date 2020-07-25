CREATE OR REPLACE FUNCTION dbo.cf_tmp_food_kit_valid(_id uuid, _street integer, _house integer, _appartament integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF _street >= 1 and _house = 1 and _appartament = 1 THEN
		update dbo.sd_tmp_import2
		set b_valid = true
		where id = _id;
	END IF;
	
	RETURN 0;
END
$$;

ALTER FUNCTION dbo.cf_tmp_food_kit_valid(_id uuid, _street integer, _house integer, _appartament integer) OWNER TO mobnius;
