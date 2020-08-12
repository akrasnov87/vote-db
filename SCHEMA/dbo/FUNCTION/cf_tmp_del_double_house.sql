CREATE OR REPLACE FUNCTION dbo.cf_tmp_del_double_house(_correct uuid, _del uuid) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
	update core.cd_routes 
	set f_house = _correct
	where f_house = _del;

	update dbo.cs_appartament
	set f_house = _correct
	where f_house = _del;

	update dbo.cd_tmp_vote_man
	set f_house = _correct
	where f_house = _del;

	update dbo.cd_tmp_food_kit
	set f_house = _correct
	where f_house = _del;
	
	update dbo.cd_tmp_budget
	set f_house = _correct
	where f_house = _del;
	
	update dbo.cd_people
	set f_house = _correct
	where f_house = _del;

	delete from dbo.cs_house
	where id = _del;
	
	RETURN 0;
END
$$;

ALTER FUNCTION dbo.cf_tmp_del_double_house(_correct uuid, _del uuid) OWNER TO mobnius;
