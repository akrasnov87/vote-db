CREATE OR REPLACE FUNCTION core.cft_cd_results_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF (TG_OP = 'INSERT') THEN
		UPDATE core.cd_results
		set b_disabled = true
		where fn_route = NEW.fn_route and fn_point = NEW.fn_point and id != NEW.id;
      RETURN NEW;
    END IF;

    RETURN NEW;
END
$$;

ALTER FUNCTION core.cft_cd_results_trigger() OWNER TO mobnius;
