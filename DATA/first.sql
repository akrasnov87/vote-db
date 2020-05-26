-- Первичное наполнение данными
insert into core.cs_point_types (n_code, c_name, c_short_name, c_const, n_order, b_default, b_disabled) values
(1, 'Стандарт', 'стд.', 'STANDART', 1000, true, false),
(2, 'Аномалия', 'анм.', 'ANOMALY', 900, false, false);

insert into core.cs_result_types (n_code, c_name, c_short_name, c_const, n_order, b_default, b_disabled) values
(1, 'Стандарт', 'стд.', 'STANDART', 1000, true, false),
(2, 'Аномалия', 'анм.', 'ANOMALY', 900, false, false);

insert into core.cs_route_statuses (n_code, c_name, c_short_name, c_const, n_order, b_disabled) values
(1000, 'Импортировано', 'Импортировано', 'IMPORT', 50, true),
(1001, 'Сформировано', 'Сформировано', 'CREATED', 100, false),
(1002, 'Передан', 'Передан', 'TRANSFERRED', 200, false),
(1003, 'Принят', 'Принят', 'RECEIVED', 300, false),
(1004, 'Выполняется', 'Выполняется', 'PROCCESS', 400, false),
(1005, 'Выполнено', 'Выполнено', 'DONED', 500, false),
(1006, 'Просрочено', 'Просрочено', 'EXPIRED', 600, false),
(1007, 'Синхронизировано', 'Синхронизировано', 'SYNCED', 700, false),
(1008, 'Подтверждено', 'Подтверждено', 'CONFIRMED', 800, false),
(1009, 'Не подтверждено', 'Не подтверждено', 'NOT_CONFIRMED', 900, false),
(1010, 'Отменено', 'Отменено', 'CANCEL', 1000, false),
(1011, 'Экспортировано', 'Экспортировано', 'EXPORT', 1100, true);

insert into core.cs_route_types (n_code, c_name, c_short_name, c_const, n_order, b_default, b_disabled) values
(1, 'Стандарт', 'стд.', 'STANDART', 1000, true, false);

insert into core.pd_roles (id, c_name, c_description, n_weight, sn_delete) values 
(-1, 'anonymous', 'Анонимный', 0, false);
insert into core.pd_roles (c_name, c_description, n_weight, sn_delete) values 
('master', 'Мастер', 1000, false), -- 1
('admin', 'Администратор', 900, false), -- 2
('user', 'Пользователь', 800, false), -- 3
('filer', 'Файловый менеджер', 700, false), -- 4
('inspector', 'Обходчик', 600, false), -- 5
('manager', 'Диспетчер', 500, false), -- 6
('trusted', 'Доверенный', 400, false), -- 7
('telemetry', 'Телеметрия', 300, false); -- 8

insert into core.pd_users (id, c_login, c_password, b_disabled, sn_delete) values(-1, 'anonymous', '',
false, false); -- -1
insert into core.pd_users (c_login, c_password, b_disabled, sn_delete) values
('root', 'root0', false, false), --1
('admin', 'admin0', false, false), --2
('user', 'user0', false, false); --3

insert into core.pd_users (c_login, c_password, c_firstname, c_lastname, c_patronymic, fn_file, c_email, c_tel, c_description, b_disabled, sn_delete) 
values('inspector', 'inspector0', 'Иванов', 'Иван', 'Иванович', null, 'ivan@mobnius.ru', '+79278888888', 'Тестовый обходчик', false, false); --4

insert into core.pd_users (c_login, c_password, c_firstname, c_lastname, c_patronymic, c_email, c_tel, c_description, b_disabled, sn_delete) 
values('manager', 'manager0', 'Петров', 'Петр', 'Петрович', 'petr@mobnius.ru', '+79279999999', 'Тестовый диспетчер', false, false); --5

insert into core.pd_users (c_login, c_password, c_firstname, c_lastname, c_patronymic, fn_file, c_email, c_tel, c_description, b_disabled, sn_delete) 
values('inspector1', 'inspector1', 'Сергеев', 'Сергей', 'Сергеевич', null, 'sergey@mobnius.ru', '+79278888889', 'Тестовый обходчик 2', false, false); --6

insert into core.sd_divisions (f_division, c_name, c_dep_code, n_code, b_disabled) values
(null, 'Главный филиал', '001', 1, false), -- 1
(1, 'Подфилиал', '011', 2, false), -- 2
(1, 'Подфилиал 2', '012', 3, false), -- 3
(1, 'Подфилиал 3', '013', 4, false), -- 4
(3, 'Подфилиал 2.1', '0121', 5, false), -- 5
(null, 'Дополнительный филиал', '002', 6, false);-- 6

insert into core.sd_subdivisions (f_division, n_code, c_name, b_disabled) values
(5, '0001', 'Отделение 1', false), -- 1
(6, '0002', 'Отделение 2', false); -- 2

-- роль master
insert into core.pd_accesses (f_role, c_name, b_deletable, b_creatable, b_editable, b_full_control, sn_delete) values 
(1, 'sd_ui_criteries', true, true, true, true, false),
(1, 'pd_navigations', true, true, true, true, false),
(1, 'sd_digests', true, true, true, true, false),
(1, 'pd_accesses', true, true, true, true, false),
(1, 'cd_sys_log', false, false, false, false, false),
(1, 'cd_action_log', false, false, false, false, false),
(1, 'cd_settings', true, true, true, true, false);

insert into core.pd_accesses (f_role, c_function, b_deletable, b_creatable, b_editable, b_full_control, sn_delete) values
(1, 'PN.*', false, false, false, false, false);

-- роль администратора
insert into core.pd_accesses (f_role, c_name, b_deletable, b_creatable, b_editable, b_full_control, sn_delete) values 
(2, 'sd_digests', false, false, false, false, false),
(2, 'pd_users', true, true, true, true, false),
(2, 'pv_users', false, false, false, false, false),
(2, 'pd_roles', true, true, true, true, false),
(2, 'pd_userinroles', true, true, true, true, false),
(2, 'sd_subdivisions', true, true, true, true, false),
(2, 'sd_divisions', true, true, true, true, false),
(2, 'cd_notifications', false, false, false, false, false),
(2, 'ss_status_schemas', true, true, true, true, false),
(2, 'cs_route_types', true, true, true, true, false),
(2, 'cs_route_statuses', true, true, true, true, false),
(2, 'cs_result_types', true, true, true, true, false),
(2, 'cs_point_types', true, true, true, true, false),
(2, 'sd_client_errors', false, false, false, false, false);

-- роль пользователь
insert into core.pd_accesses (f_role, c_name, b_deletable, b_creatable, b_editable, b_full_control, sn_delete) values 
(3, 'ad_audits', false, true, true, false, false),
(3, 'ad_mobile_devices', false, true, true, false, false),
(3, 'ad_mobile_indicators', false, true, true, false, false),
(3, 'ad_tracking', false, true, true, false, false),
(3, 'sd_client_errors', false, true, true, false, false),
(3, 'cd_points', true, true, true, false, false),
(3, 'cd_user_points', true, true, true, false, false),
(3, 'cd_results', true, true, true, false, false),
(3, 'cd_route_history', true, true, true, false, false),
(3, 'cd_routes', true, true, true, false, false),
(3, 'cd_userinroutes', true, true, true, false, false),
(3, 'ed_registr_pts', false, false, false, false, false),
(3, 'cs_point_types', false, false, false, false, false),
(3, 'cs_result_types', false, false, false, false, false),
(3, 'cs_route_statuses', false, false, false, false, false),
(3, 'cs_route_types', false, false, false, false, false),
(3, 'pd_roles', false, false, false, false, false),
(3, 'pd_userinroles', false, false, false, false, false),
(3, 'pd_users', false, false, false, false, false),
(3, 'sd_digests', false, false, false, false, false),
(3, 'sd_subdivisions', false, false, false, false, false),
(3, 'sd_divisions', false, false, false, false, false),
(3, 'pd_userindivisions', false, false, false, false, false),
(3, 'ss_status_schemas', false, false, false, false, false),
(3, 'pv_users', false, false, false, false, false);

insert into core.pd_accesses (f_role, c_function, b_deletable, b_creatable, b_editable, b_full_control, sn_delete) values
(3, 'PN.notification.*', false, false, false, false, false),
(3, 'PN.user.*', false, false, false, false, false),
(3, 'PN.setting.*', false, false, false, false, false),
(3, 'PN.shell.getServerTime', false, false, false, false, false);

-- роль обходчика
insert into core.pd_accesses (f_role, c_name, b_deletable, b_creatable, b_editable, b_full_control, sn_delete) values 
(5, 'pd_users', false, false, true, false, false);

-- роль диспетчера
insert into core.pd_accesses (f_role, c_function, b_deletable, b_creatable, b_editable, b_full_control, sn_delete) values
(6, 'PN.cf_wui*', false, false, false, false, false);

-- роль телеметрии
insert into core.pd_accesses (f_role, c_name, b_deletable, b_creatable, b_editable, b_full_control, sn_delete) values 
(8, 'ad_audits', false, false, false, false, false),
(8, 'ad_mobile_devices', false, false, false, false, false),
(8, 'ad_mobile_indicators', false, false, false, false, false),
(8, 'ad_tracking', false, false, false, false, false);

-- роль файл
insert into core.pd_accesses (f_role, c_name, b_deletable, b_creatable, b_editable, b_full_control, sn_delete) values 
(4, 'filer-dataview', false, false, false, false, false);

-- общие
insert into core.pd_accesses (c_name, b_deletable, b_creatable, b_editable, b_full_control, sn_delete) values 
('cd_settings', false, false, false, false, false),
('pf_stores', false, false, false, false, false);

-- actions
insert into core.pd_accesses (f_role, f_action, b_deletable, b_creatable, b_editable, b_full_control, sn_delete) values
(2, 1, false, false, false, false, false),
(2, 2, false, false, false, false, false);

-- security
insert into core.pd_accesses (c_name, c_criteria, b_deletable, b_creatable,b_editable,b_full_control,sn_delete) values
('pd_navigations', '[{"property":"id", "operator": "<>", "value": 4}]', false, false, false, false, false);

insert into core.pd_accesses (f_user, f_role, c_name, f_action, c_criteria, c_path, c_function, c_columns, b_deletable, b_creatable,b_editable,b_full_control,sn_delete) values
(-1,null, 'login', null, null, null, null, null, false,false,false,false,false),
(null, null, 'create_access_procedure', null, null, null, null, null, false,false,false,false,false),
(null, 2, 'set_pd_userinroles', null, null, null, null, null, false,false,false,false,false),
(null, null, null, null, null, '/', null, null, true,true,true,true, false);

insert into core.pd_navigations (c_view_type, c_alias, b_leaf, c_icon_cls, f_parent, c_name, b_default_token, c_type,
b_visible, c_icon, b_selectable, b_expanded, n_sort, b_not_auth, sn_delete) values
('pd_users-listview', 'pd_users', false, 'x-fa fa-shield', NULL, 'Безопасность', false, 'NAVIGATION', true, NULL, false,
false, 100, false, false), --1
('pd_users-listview', 'pd_users', true, 'x-fa fa-users', 1, 'Пользователи', false, 'NAVIGATION', true, NULL, false,
false, 10, false, false), --2

('pd_userinroles-listview', 'pd_userinroles', true, 'x-fa fa-eye', 1, 'Пользователи в ролях', false, 'NAVIGATION', true,
NULL, false, false, 8, false, false), --3
('pd_accesses-listview', 'pd_accesses', true, 'x-fa fa-edit', 1, 'Права доступа', false, 'NAVIGATION',true, NULL, false,
false, 7, false, false), --4

('pd_navigations-listview', 'pd_navigations', false, 'x-fa fa-lock', NULL, 'Администрирование', false, 'NAVIGATION',
true, NULL, false, false, 90, false, false), --5
('pd_navigations-listview', 'pd_navigations', true, 'x-fa fa-bars', 5, 'Навигация', true, 'NAVIGATION', true, NULL,
false, false, 10, false, false), --6
('cd_settings-listview', 'cd_settings', true, 'x-fa fa-cogs', 5, 'Настройки', false, 'NAVIGATION', true, NULL, false,
false, 8, false, false), --8
('sd_digests-listview', 'sd_digests', true, 'x-fa fa-book', 5, 'Журнал версий', false, 'NAVIGATION', true, NULL, false,
false, 8, false, false), --9

('login', 'login', true, 'x-fa fa-sign-in', NULL, 'Авторизация', false, 'USER', false, NULL, true, false, 10, true,
false), --10
('ad_audits-listview', 'ad_audits', true, 'x-fa fa-list-alt', 5, 'Аудит', false, 'NAVIGATION', true, NULL, true, false,
11, false, false), --11

('sd_ui_criteries-listview', 'sd_ui_criteries', true, 'x-fa fa-filter', 5, 'Критерии', false, 'NAVIGATION', true, NULL,
false, false, 6, false, false), --12
('filer-dataview', 'filer-dataview', true, 'x-fa fa-file', 5, 'Файловый менеджер', false, 'NAVIGATION', true, NULL,
false, false, 5, false, false), --13
('pd_roles-listview', 'pd_roles', false, 'x-fa fa-question', NULL, 'Справочник', false, 'NAVIGATION', true, NULL, false,
false, 80, false, false), --14
('cd_notifications-listview', 'cd_notifications', true, 'x-fa fa-comments', 5, 'Уведомления', false, 'NAVIGATION', true,
NULL, false, false, 6, false, false), --15
('pd_roles-listview', 'pd_roles', true, 'x-fa fa-user-secret', 14, 'Роли', false, 'NAVIGATION', true, NULL, false,
false, 9, false, false),--16
('sd_client_errors-listview', 'sd_client_errors', false, 'x-fa fa-exclamation', NULL, 'Телеметрия', false, 'NAVIGATION', true, NULL, false,
false, 70, false, false), --17
('sd_client_errors-listview', 'sd_client_errors', true, 'x-fa fa-mobile', 17, 'Ошибки моб. приложения', false, 'NAVIGATION', true, NULL, false,
false, 10, false, false); --18 

insert into core.pd_userindivisions (f_user, f_division, f_subdivision, sn_delete) values 
(4, 5, 1, false),
(6, 5, 1, false),
(5, 1, null, false),
(5, 6, null, false);

insert into core.pd_userinroles (f_user, f_role, sn_delete) values 
(1, 1, false),
(1, 2, false),
(1, 8, false),
(1, 4, false); -- файловый менеджер

insert into core.pd_userinroles (id, f_user, f_role, sn_delete) values (-1, -1, -1, false); -- анонимный
insert into core.pd_userinroles (f_user, f_role, sn_delete) values 
(2, 2, false),
(3, 3, false),
(4, 5, false),
(4, 6, false),
(4, 3, false),
(6, 5, false),
(6, 6, false),
(6, 3, false);
-- роли диспетчера
insert into core.pd_userinroles (f_user, f_role, sn_delete) values 
(5, 7, false),
(5, 6, false),
(5, 3, false);

insert into core.sd_digests (c_version, c_description, c_app_name, b_hidden)
values('0.0.0.0', 'Стартовая версия', 'android', false);

insert into core.ss_status_schemas (f_start, f_end, b_disabled) values 
(1, 3, false),
(1, 7, false), -- просрочено
(1, 11, false), -- отмена
(2, 3, false),
(2, 7, false), -- просрочено
(2, 11, false), -- отмена
(3, 4, false),
(3, 7, false), -- просрочено
(3, 11, false), -- отмена
(4, 5, false),
(4, 6, false),
(4, 7, false), -- просрочено
(4, 11, false), -- отмена
(5, 6, false),
(5, 7, false), -- просрочено
(5, 11, false), -- отмена
(6, 7, false), -- просрочено
(6, 8, false),
(6, 9, false),
(6, 10, false),
(6, 11, false), -- отмена
(7, 11, false), -- отмена
(8, 7, false), -- просрочено
(8, 9, false),
(8, 10, false),
(8, 11, false), -- отмена
(9, 11, false), -- отмена
(9, 12, false),
(10, 3, false),
(10, 7, false), -- просрочено
(10, 11, false); -- отмена

insert into core.cs_setting_types (n_code, c_name, c_short_name, c_const, n_order, b_default, b_disabled) values
(1, 'Строка', 'стр.', 'TEXT', 1000, true, false),
(2, 'Число', 'чсл.', 'INTEGER', 900, false, false),
(3, 'Логическое', 'лог.', 'BOOLEAN', 800, false, false),
(4, 'Числа с запятой', 'чслз.', 'REAL', 700, false, false);

insert into core.cd_settings (c_key, c_value, f_type, c_label, c_summary, f_division, f_user, sn_delete) values
('home_page', 'login', 1, 'Домашняя страница', null, null, null, false),
('DB_VERSION', '1.39.0.504', 1, 'Версия БД', null, null, null, false),
('MBL_IMAGE_FORMAT', 'webp', 1, 'Формат изображений', 'Формат изображения после фотографирования', null, null, false);