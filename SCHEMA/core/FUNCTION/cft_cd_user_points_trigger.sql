CREATE OR REPLACE FUNCTION core.cft_cd_user_points_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF (TG_OP = 'INSERT') THEN
		UPDATE core.cd_user_points
		set b_disabled = true
		where fn_point = NEW.fn_point and id != NEW.id;
      RETURN NEW;
    END IF;

    RETURN NEW;
END
$$;

ALTER FUNCTION core.cft_cd_user_points_trigger() OWNER TO mobnius;
