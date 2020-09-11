CREATE OR REPLACE FUNCTION dbo.cf_update_point_info_v5(_point_id uuid) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	_c_info text;
	_f_appartament uuid;
	_c_peoples text;
	_jb_data jsonb;
	_n_uik integer;
	_c_place text;
	_c_place_phone text;
	_f_house uuid;
BEGIN
	select p.f_appartament into _f_appartament from core.cd_points as p
	where p.id = _point_id;
	
	select a.f_house into _f_house from dbo.cs_appartament as a
	where a.id = _f_appartament;
	
	select h.n_uik into _n_uik from dbo.cs_house as h where h.id = _f_house;

	select u.c_place into _c_place from dbo.cd_uik as u
	where u.id = _n_uik;
	
	select u.c_place_phone into _c_place_phone from dbo.cd_uik as u
	where u.id = _n_uik;
	
	select concat('<p>«Здравствуйте!</p>',
'<p>Напоминаем вам, что сегодня последний день голосования на выборах Главы республики и депутатов городского Собрания. Ваш избирательный участок находится <b>', _c_place, '</b>, номер Вашей избирательной комиссии <b>', _n_uik::text, '</b>.</p>
<p><b>Скажите, пожалуйста, может быть Вы уже проголосовали или еще нет, но обязательно посетите избирательный участок?</b></p>
<p>Если еще не проголосовали:<br />
<i>Ситуация непростая. Просим Вас прийти проголосовать или вызвать на дом представителей комиссии, если вы сами не можете посетить избирательный участок (до 14.00), телефон Вашей избирательной комиссии <b>', _c_place_phone,'</b>.
<br />Приходите обязательно! Каждый голос важен!</i></p>
<p>Если уже проголосовали:<br />
<i>Благодарю Вас за активную гражданскую позицию, спасибо за уделенной внимание!».</i></p>') into _c_peoples;

	select json_build_object('c_appartament_num', a.c_number, 
					  'n_appartament_num', a.n_number,
					 'c_address', concat(s.c_short_type, ' ', s.c_name),
					 'f_division', s.f_division,
					 'f_subdivision', h.f_subdivision,
					 'c_house_num', h.c_house_num,
					 'c_build_num', h.c_build_num,
					 'n_uik', h.n_uik,
					 'n_signature', coalesce(a.n_signature_2018, 0),
					 'c_peoples', _c_peoples)::jsonb into _jb_data 
	from dbo.msv_appartament5 as a
	inner join dbo.cs_house as h ON h.id = a.f_house
	inner join dbo.cs_street as s ON s.id = h.f_street
	where a.id = _f_appartament;

	update core.cd_points as p
	set jb_data = _jb_data
	where p.id = _point_id;
	
	RETURN 0;
END
$$;

ALTER FUNCTION dbo.cf_update_point_info_v5(_point_id uuid) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_update_point_info_v5(_point_id uuid) IS 'Обновление информации в точке маршрута для 5 волны';
