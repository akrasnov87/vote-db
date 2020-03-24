CREATE OR REPLACE FUNCTION core.cftiu_coordinates_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF (TG_OP = 'INSERT') THEN
      NEW.gx_geodata = ST_SetSRID(ST_MakePoint(NEW.n_longitude,NEW.n_latitude),4326)::geography;
      RETURN NEW;
    END IF;

    IF (TG_OP = 'UPDATE') THEN
      IF ((OLD.n_longitude IS DISTINCT FROM NEW.n_longitude) OR (OLD.n_latitude IS DISTINCT FROM NEW.n_latitude)) THEN
        NEW.gx_geodata = ST_SetSRID(ST_MakePoint(NEW.n_longitude,NEW.n_latitude),4326)::geography;
        RETURN NEW;
      END IF;
    END IF;

    RETURN NEW;
END
$$;

ALTER FUNCTION core.cftiu_coordinates_trigger() OWNER TO mobnius;
