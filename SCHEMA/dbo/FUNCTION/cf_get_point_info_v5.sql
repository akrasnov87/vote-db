CREATE OR REPLACE FUNCTION dbo.cf_get_point_info_v5(_f_appartament uuid) RETURNS text
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

	
	RETURN _c_peoples;
END
$$;

ALTER FUNCTION dbo.cf_get_point_info_v5(_f_appartament uuid) OWNER TO mobnius;

COMMENT ON FUNCTION dbo.cf_get_point_info_v5(_f_appartament uuid) IS 'Обновление информации в точке маршрута для 5 волны';
