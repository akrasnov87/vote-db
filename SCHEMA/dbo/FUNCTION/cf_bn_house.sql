CREATE OR REPLACE FUNCTION dbo.cf_bn_house(_uik integer, _street uuid, _disabled boolean) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	_result integer;
BEGIN
	
	update dbo.cs_house
	set b_disabled = _disabled
	where n_uik = _uik and f_street = _street and c_house_num ilike '%БН%';
	_result = 0;
	
	RETURN _result;
END
$$;

ALTER FUNCTION dbo.cf_bn_house(_uik integer, _street uuid, _disabled boolean) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_bn_house(_uik integer, _street uuid, _disabled boolean) IS 'Включить/Отключить БН дома';
