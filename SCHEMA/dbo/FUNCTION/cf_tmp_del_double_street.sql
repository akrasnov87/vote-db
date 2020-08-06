CREATE OR REPLACE FUNCTION dbo.cf_tmp_del_double_street(_correct uuid, _del uuid) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
	update dbo.cs_house
	set f_street = _correct
	where f_street = _del;

	update dbo.cd_vote_man
	set f_street = _correct
	where f_street = _del;

	update dbo.cd_food_kit
	set f_street = _correct
	where f_street = _del;
	
	update dbo.cd_budget
	set f_street = _correct
	where f_street = _del;

	delete from dbo.cs_street
	where id = _del;
	
	RETURN 0;
END
$$;

ALTER FUNCTION dbo.cf_tmp_del_double_street(_correct uuid, _del uuid) OWNER TO mobnius;
