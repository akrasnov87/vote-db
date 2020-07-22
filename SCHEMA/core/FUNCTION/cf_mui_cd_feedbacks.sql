CREATE OR REPLACE FUNCTION core.cf_mui_cd_feedbacks(_fn_user integer) RETURNS TABLE(id uuid, c_imei text, fn_user integer, fn_type integer, c_question text, d_date_question timestamp with time zone, c_answer text, d_date_answer timestamp with time zone, dx_created timestamp with time zone, jb_data text)
    LANGUAGE plpgsql STABLE
    AS $$

BEGIN
    RETURN QUERY select f.id, f.c_imei, f.fn_user, f.fn_type, f.c_question, f.d_date_question, f.c_answer, f.d_date_answer, f.dx_created, f.jb_data::text 
    from core.cd_feedbacks as f
    where f.fn_user = _fn_user and core.cf_old_date(f.dx_created::date);
END
$$;

ALTER FUNCTION core.cf_mui_cd_feedbacks(_fn_user integer) OWNER TO mobnius;
