truncate core.cd_points CASCADE;
truncate core.cd_routes CASCADE;
truncate core.cd_routes CASCADE;

insert into dbo.ed_registr_pts (id, c_subscr, c_device, jb_tel, jb_email, c_address, c_fio, n_longitude, n_latitude, f_user, f_division, f_subdivision) values
('16dc8d78-04db-45ac-ab02-2112000478c2', '111-111-111', 'ПУ-111-111', null, null, 'Россия, Чувашская Республика, Чебоксары, улица Академика А.Н. Крылова, 9', 'Артур Пирожков', '56.14010705859811', '47.229393446807734', 4, 5, 1),
('9f38e54c-c48c-4e18-8591-17e5a8e00224', '222-222-222', 'ПУ-222-222', null, null, 'Россия, Чувашская Республика, Чебоксары, улица Академика А.Н. Крылова, 1', 'Иванов Альберт', '56.14098311929222', '47.22885164058674', 4, 5, 1),
('8d85d582-fe5a-4f76-b8e3-d666db951ed0', '333-333-333', 'ПУ-333-333', null, null, 'Россия, Чувашская Республика, Чебоксары, улица Академика А.Н. Крылова, 5А', 'Высильев Василий', '56.142015723504684', '47.22915618111756', 4, 5, 1),
('40170afe-498d-4ff0-a1e7-9f29d470cf0a', '444-444-444', 'ПУ-444-444', null, null, 'Россия, Чувашская Республика, Чебоксары, улица Пирогова, 4А', 'Олег', '56.14239907700765', '47.228700205585035', 4, 5, 1),
('04be12d2-6349-49fb-a311-e7f69a3c7787', '555-555-555', 'ПУ-555-555', null, null, 'Россия, Чувашская Республика, Чебоксары, улица Б.С. Маркова, 16', 'А. Кирилл', '56.14047179397811', '47.23173034745273', 4, 5, 1),
('3943560e-f749-4ace-8f06-e402c82d2531', '666-666-666', 'ПУ-666-666', null, null, 'Россия, Чувашская Республика, Чебоксары, улица Пирогова, 4В', 'Виктор', '56.14275921615658', '47.22585046514802', 4, 5, 1),
('38e788de-1006-4fbe-bcaf-7902aebcb92f', '777-777-777', 'ПУ-777-777', null, null, 'Россия, Чувашская Республика, Чебоксары, Московский проспект, 15, корп. 1', 'Андреев Андрей Андреевич', '56.143639708414206', '47.22455474161811', 4, 5, 1),
('a77880a2-2705-4f92-b73b-7ada084ca14f', '888-888-888', 'ПУ-888-999', null, null, 'Россия, Чувашская Республика, Чебоксары, Московский проспект, 17В', 'Понкратов', '56.143807583339914', '47.22240596597085', 4, 5, 1),
('1e3caa35-ee75-4864-a906-736132912219', '999-999-999', 'ПУ-999-999', null, null, 'Россия, Чувашская Республика, Чебоксары, Московский проспект, 19, корп. 5', 'Колобков', '56.143676170841744', '47.22011654616311', 4, 5, 1),
('f391ef14-97a4-459a-98ef-e8f0607c61b9', '000-111-111', 'ПУ-000-111', null, null, 'Россия, Чувашская Республика, Чебоксары, Московский проспект, 19к2', 'Кеша', '56.143099885205984', '47.217646204724815', 4, 5, 1),
('7b1faaa7-4c63-42c2-817e-6893948fcadb', '000-222-222', 'ПУ-000-222', null, null, 'Россия, Чувашская Республика, Чебоксары, Московский проспект, 19к2', 'Аркадеев Аркадий Аркадьевич', '56.14013933242361', '47.22025473810789', 4, 5, 1),
('99f6003e-2738-44f1-91c1-aa80ea30a69f', '000-333-333', 'ПУ-000-333', null, null, 'Россия, Чувашская Республика, Чебоксары, улица Пирогова, 1Т', 'Семенов Семен Семеныч', '56.14082498395324', '47.22391288496943', 4, 5, 1),
('f60c55ec-44e1-4c0c-b1df-f7dd29239759', '000-444-444', 'ПУ-000-444', null, null, 'просп. Максима Горького, 10, стр. 1', 'Петров Петр Петрович', '56.149376', '47.196429', 4, 5, 1);

insert into core.cd_routes (id, f_type, c_number, d_date, d_date_start, d_date_end, c_notice, b_extended, d_extended, n_order) values
('c68b1a77-0a13-4c05-bc3e-c2504868f0ac', 1, '[Тестовый] Обход О-1', '2019-08-30T00:00:00.511Z', '2019-08-30', '2050-08-30', '', false, null, 1),
('60d6269b-c60c-4542-9b0e-8c65768cbbae', 1, '[Тестовый] Обход О-2', '2019-08-30T00:00:00.511Z', '2019-01-30', '2019-07-30', 'Просрочено', true, '2019-08-10', 2),
('e7ded0cd-12dd-47f5-a75b-192376291e83', 1, '[Тестовый] Обход О-3', '2019-05-30T00:00:00.511Z', '2019-05-30', '2050-07-30', null, false, null, 3),
('afd42548-50f9-4d81-943d-0dc1edd31a04', 1, '[Тестовый] Обход О-4', '2019-05-30T00:00:00.511Z', '2030-05-30', '2050-07-30', 'Пустой', false, null, 4),
('778eaa53-439b-4502-abeb-f412e4ca1522', 1, '[Тестовый] Обход О-5', '2019-05-30T00:00:00.511Z', '2030-05-30', '2050-07-30', 'Пустой', false, null, 5);

truncate core.cd_route_history;
insert into core.cd_route_history (fn_route, fn_status, fn_user, d_date, c_notice) values
('c68b1a77-0a13-4c05-bc3e-c2504868f0ac', 2, 5, '2019-08-30T00:00:00.511Z', 'Автоматически создан'),
('c68b1a77-0a13-4c05-bc3e-c2504868f0ac', 3, 5, '2019-08-30T00:00:00.511Z', null),
('c68b1a77-0a13-4c05-bc3e-c2504868f0ac', 4, 4, '2019-08-30T01:00:00.511Z', ''),
('c68b1a77-0a13-4c05-bc3e-c2504868f0ac', 5, 4, '2019-08-30T01:30:00.511Z', 'начал выполнять'),
('60d6269b-c60c-4542-9b0e-8c65768cbbae', 2, 5, '2019-01-30T00:00:00.511Z', 'Автоматически создан'),
('e7ded0cd-12dd-47f5-a75b-192376291e83', 2, -1, '2019-05-30T00:00:00.511Z', null),
('afd42548-50f9-4d81-943d-0dc1edd31a04', 2, 5, '2019-08-30T00:00:00.511Z', 'Автоматически создан'),
('afd42548-50f9-4d81-943d-0dc1edd31a04', 3, 5, '2019-08-30T00:00:00.511Z', null),
('afd42548-50f9-4d81-943d-0dc1edd31a04', 4, 4, '2019-08-30T01:00:00.511Z', ''),
('778eaa53-439b-4502-abeb-f412e4ca1522', 2, 5, '2019-08-30T00:00:00.511Z', 'Автоматически создан'),
('778eaa53-439b-4502-abeb-f412e4ca1522', 3, 5, '2019-08-30T00:00:00.511Z', null),
('778eaa53-439b-4502-abeb-f412e4ca1522', 4, 4, '2019-08-30T01:00:00.511Z', '');

truncate core.cd_userinroutes;
insert into core.cd_userinroutes (f_route, f_user, b_main) values
('c68b1a77-0a13-4c05-bc3e-c2504868f0ac', 4, true),
('afd42548-50f9-4d81-943d-0dc1edd31a04', 4, true),
('778eaa53-439b-4502-abeb-f412e4ca1522', 4, true);

insert into core.cd_points (id, f_registr_pts, f_route, c_notice, c_info, n_order) values
('89235ebf-64bd-4bbc-8feb-5e4ddd6684a9', '16dc8d78-04db-45ac-ab02-2112000478c2', '60d6269b-c60c-4542-9b0e-8c65768cbbae', null, '<font color=''green''>выполнялось ранее</font>', 1),
('4073b193-af8f-4371-85cf-fee220eb5b2d', '16dc8d78-04db-45ac-ab02-2112000478c2', 'c68b1a77-0a13-4c05-bc3e-c2504868f0ac', '', '<font color=''green''>выполнялось ранее</font>', 1),
('7f8d7a92-1c09-49da-b50a-5fa6bf1b57eb', '9f38e54c-c48c-4e18-8591-17e5a8e00224', 'c68b1a77-0a13-4c05-bc3e-c2504868f0ac', '', '<font color=''green''>выполнялось ранее</font>', 2),
('017556ad-ef67-4149-8c67-1e0e973289ed', 'f60c55ec-44e1-4c0c-b1df-f7dd29239759', 'c68b1a77-0a13-4c05-bc3e-c2504868f0ac', null, null, 7),
('2b5c33da-bbde-4b12-82e5-bb80bc3da677', '8d85d582-fe5a-4f76-b8e3-d666db951ed0', 'c68b1a77-0a13-4c05-bc3e-c2504868f0ac', null, null, 3),
('e9518202-ae4a-4ba8-8747-f3d3a9c85ae0', '40170afe-498d-4ff0-a1e7-9f29d470cf0a', 'c68b1a77-0a13-4c05-bc3e-c2504868f0ac', null, null, 4),
('39eff641-67f7-4099-bb11-1b794ee99acb', '40170afe-498d-4ff0-a1e7-9f29d470cf0a', 'c68b1a77-0a13-4c05-bc3e-c2504868f0ac', null, '<font color=''green''>выполнялось <b>ранее</b></font>', 5),
('3c47fef3-9f5b-4ddf-8035-7ea87fcc85d0', '04be12d2-6349-49fb-a311-e7f69a3c7787', 'c68b1a77-0a13-4c05-bc3e-c2504868f0ac', null, null, 6),
('1704e09d-d28c-4ae0-b8b1-cc51836a5a5e', '3943560e-f749-4ace-8f06-e402c82d2531', 'e7ded0cd-12dd-47f5-a75b-192376291e83', null, null, 1),
('b699a359-5c91-4f7d-a483-ae9bf1e8cf64', '38e788de-1006-4fbe-bcaf-7902aebcb92f', 'e7ded0cd-12dd-47f5-a75b-192376291e83', null, null, 2),
('b104c9eb-021a-4fd8-9b46-bae5d318d2ac', 'a77880a2-2705-4f92-b73b-7ada084ca14f', 'e7ded0cd-12dd-47f5-a75b-192376291e83', null, null, 3),
('f4f95bc1-a15b-47a9-9cb2-27b5791fa0da', '1e3caa35-ee75-4864-a906-736132912219', 'e7ded0cd-12dd-47f5-a75b-192376291e83', null, null, 4),
('2d7c95a1-9da3-4af2-b90a-608573f4116a', 'f391ef14-97a4-459a-98ef-e8f0607c61b9', 'e7ded0cd-12dd-47f5-a75b-192376291e83', null, null, 5),
('f85c3460-ce4a-42b0-aa5a-998da74c23ed', '7b1faaa7-4c63-42c2-817e-6893948fcadb', 'e7ded0cd-12dd-47f5-a75b-192376291e83', null, null, 6),
('c4fb7bda-e4c7-4b98-865f-32115dad480a', '99f6003e-2738-44f1-91c1-aa80ea30a69f', 'e7ded0cd-12dd-47f5-a75b-192376291e83', null, null, 7);

insert into dbo.ed_input_meter_readings(id, f_point, n_value_prev, d_date_prev, f_time_zone) values
('028d65a4-3621-408b-af0a-230242f41702', '89235ebf-64bd-4bbc-8feb-5e4ddd6684a9', 1100,  now(), 2),
('0d7b1a9c-c0f1-4ac1-917f-7c3f0a367600', '4073b193-af8f-4371-85cf-fee220eb5b2d', 1190,  now(), 2),
('30a5a027-17a2-4ce6-9e0a-124a487ebf26', '7f8d7a92-1c09-49da-b50a-5fa6bf1b57eb', 900,  now(), 2),
('394fb071-7d9f-4c13-ada6-3c45b0f1643b', '017556ad-ef67-4149-8c67-1e0e973289ed', 750,  now(), 2),
('5ce021b0-33ca-4d6e-8a7b-1e3989365712', '2b5c33da-bbde-4b12-82e5-bb80bc3da677', 2000,  now(), 2),
('96181fcb-48d1-47d1-846a-b838a2776079', 'e9518202-ae4a-4ba8-8747-f3d3a9c85ae0', 1300,  now(), 2),
('907e9a53-4f01-4800-bfa4-fbdfe1ee2d38', '39eff641-67f7-4099-bb11-1b794ee99acb', 1395,  now(), 2),
('ad49816a-dfb7-4b3b-bd95-52b1a3c68bde', '3c47fef3-9f5b-4ddf-8035-7ea87fcc85d0', 526,  now(), 2),
('05659880-f43c-43fe-a35d-ce1222ab7497', '1704e09d-d28c-4ae0-b8b1-cc51836a5a5e', 9865,  now(), 2),
('22ca7490-718d-4afe-a994-7b82b057b9b5', 'b699a359-5c91-4f7d-a483-ae9bf1e8cf64', 4215,  now(), 3),
('c285c0a3-977f-44bc-bacd-40dbac07cbe7', 'b104c9eb-021a-4fd8-9b46-bae5d318d2ac', 82131,  now(), 2),
('82b7238d-5fb5-451a-9d5f-208236e8129c', 'f4f95bc1-a15b-47a9-9cb2-27b5791fa0da', 789,  now(), 2),
('699dd388-a94b-4bff-97c3-cc70edf9f30c', '2d7c95a1-9da3-4af2-b90a-608573f4116a', 12,  now(), 2),
('ff4ccf93-a023-4114-a1f4-266d52d10329', 'f85c3460-ce4a-42b0-aa5a-998da74c23ed', 5,  now(), 2),
('626dae11-8775-47ed-a419-a6e92d2dad0a', 'c4fb7bda-e4c7-4b98-865f-32115dad480a', 836,  now(), 2);

truncate core.cd_user_points;
insert into core.cd_user_points(id, fn_point, fn_type, jb_tel, jb_email, fn_user, fn_route, n_latitude, n_longitude, d_date, c_notice, b_check, d_date_check) values
('547c39bd-d171-4cae-bf64-c30fae16210a', '89235ebf-64bd-4bbc-8feb-5e4ddd6684a9', 1, null, null, 4, '60d6269b-c60c-4542-9b0e-8c65768cbbae', '56.14010705859811', '47.229393446807734', '2019-08-30T00:00:00.511Z', '', false, null),
('1a29d44d-5f31-49f0-a4d5-8056b1d307a6', '4073b193-af8f-4371-85cf-fee220eb5b2d', 1, null, null, 4, 'c68b1a77-0a13-4c05-bc3e-c2504868f0ac', '56.14010705859811', '47.229393446807734', '2019-08-30T00:00:00.511Z', '', false, null),
('7f8d7a92-1c09-49da-b50a-5fa6bf1b57eb', '017556ad-ef67-4149-8c67-1e0e973289ed', 1, null, null, 4, 'c68b1a77-0a13-4c05-bc3e-c2504868f0ac', '56.14098311929222', '47.22885164058674', '2019-08-30T00:00:00.511Z', '', false, null);

truncate dbo.ed_output_meter_readings;
insert into dbo.ed_output_meter_readings(fn_meter_reading, fn_user_point, fn_result, fn_point, fn_route, n_value, d_date) values
('028d65a4-3621-408b-af0a-230242f41702', '547c39bd-d171-4cae-bf64-c30fae16210a', null, '89235ebf-64bd-4bbc-8feb-5e4ddd6684a9', '60d6269b-c60c-4542-9b0e-8c65768cbbae', 1190, '2019-04-30T00:00:00.511Z'),
('0d7b1a9c-c0f1-4ac1-917f-7c3f0a367600', '1a29d44d-5f31-49f0-a4d5-8056b1d307a6', null, '4073b193-af8f-4371-85cf-fee220eb5b2d', 'c68b1a77-0a13-4c05-bc3e-c2504868f0ac', 1300, '2019-08-30T00:00:00.511Z'),
('394fb071-7d9f-4c13-ada6-3c45b0f1643b', '7f8d7a92-1c09-49da-b50a-5fa6bf1b57eb', null, '017556ad-ef67-4149-8c67-1e0e973289ed', 'c68b1a77-0a13-4c05-bc3e-c2504868f0ac', 45913, '2019-08-30T00:00:00.511Z');

truncate core.cd_results;
insert into core.cd_results (id, fn_user_point, fn_point, fn_type, fn_user, fn_route, d_date, c_notice, b_warning) values
('7d307748-499a-4932-ac83-830c93edc7cf', '547c39bd-d171-4cae-bf64-c30fae16210a', '89235ebf-64bd-4bbc-8feb-5e4ddd6684a9', 1, 4, '60d6269b-c60c-4542-9b0e-8c65768cbbae', '2019-08-30T00:00:00.511Z', 'акт сформирован', false),
('89d0cba6-0b33-42df-8c9b-c3789cc4c4c0', '1a29d44d-5f31-49f0-a4d5-8056b1d307a6', '4073b193-af8f-4371-85cf-fee220eb5b2d', 1, 4, 'c68b1a77-0a13-4c05-bc3e-c2504868f0ac', '2019-08-30T00:00:00.511Z', 'неадекватный хозяин', false),
('6812dd61-064c-4c5e-b8ba-dfdb91d6a7de', '7f8d7a92-1c09-49da-b50a-5fa6bf1b57eb', '017556ad-ef67-4149-8c67-1e0e973289ed', 1, 4, 'c68b1a77-0a13-4c05-bc3e-c2504868f0ac', '2019-08-30T00:00:00.511Z', null, true);

truncate core.cd_files;
-- смотри папку /var/lib/postgresql/[version]/main/pg_simple_data
-- https://github.com/akrasnov87/simple-data
insert into core.cd_files (id, c_name, d_date, c_mime, ba_data, c_extension, n_size) values
('dc1beca9-1b8b-4078-be1a-3261ba0c94e0', 'doc1.jpg', '2019-08-31T00:00:00.511Z', 'image/jpeg', pg_read_binary_file('pg_simple_data/doc1.jpg'), '.jpg', 40960),
('991e2342-0d76-426f-bc95-21a99cf700a2', 'icon.jpg', '2019-08-31T00:00:00.511Z', 'image/jpeg', pg_read_binary_file('pg_simple_data/icon.jpg'), '.jpg', 28672),
('f9bba6d8-4cfb-48aa-bed7-794bddb2d7dd', 'doc1.jpg', '2019-08-31T10:00:00.511Z', 'image/jpeg', pg_read_binary_file('pg_simple_data/doc1.jpg'), '.jpg', 40960),
('eb895925-39e8-4ee7-9ad9-507a0031afba', 'doc2.jpg', '2019-08-30T00:00:00.511Z', 'image/jpeg', pg_read_binary_file('pg_simple_data/doc2.jpg'), '.jpg', 233472),
('fe917dcf-3d47-4af4-870c-8d34632dbb5f', 'pic2.jpg', '2019-08-31T00:00:00.511Z', 'image/jpeg', pg_read_binary_file('pg_simple_data/pic2.jpg'), '.jpg', 40960);

--('44370453-64ae-4138-b220-a8fd0645f1d0', 'sample_audio.mp3', '2019-08-30T00:00:00.511Z', 'audio/mpeg', pg_read_binary_file('pg_simple_data/sample_audio.mp3'), '.mp3', 442368),
--('fe852cc5-935b-4a2c-88d6-16d92cfdfec1', 'sample_video.mp4', '2019-08-30T00:00:00.511Z', 'video/mp4', pg_read_binary_file('pg_simple_data/sample_video.mp4'), '.mp4', 5251072),

truncate core.cd_attachments;
insert into core.cd_attachments (id, fn_result, fn_route, fn_type, n_latitude, n_longitude, d_date, c_notice, fn_file) values
('82fda821-601d-4499-aa23-adcbc2e6c01e', '7d307748-499a-4932-ac83-830c93edc7cf', '60d6269b-c60c-4542-9b0e-8c65768cbbae', 2, '56.14010705859811', '47.229393446807734', '2019-08-31T00:00:00.511Z', 'это документ', 'dc1beca9-1b8b-4078-be1a-3261ba0c94e0'),
('b5acd5fc-046d-4abb-a64b-d6bb70793527', '89d0cba6-0b33-42df-8c9b-c3789cc4c4c0', 'c68b1a77-0a13-4c05-bc3e-c2504868f0ac', 1, '56.14010705859811', '47.229393446807734', '2019-08-31T00:00:00.511Z', 'это изображение', '991e2342-0d76-426f-bc95-21a99cf700a2'),
('c29da08c-7478-427e-8c15-9da924812689', '89d0cba6-0b33-42df-8c9b-c3789cc4c4c0', 'c68b1a77-0a13-4c05-bc3e-c2504868f0ac', 2, '56.14010705859811', '47.229393446807734', '2019-08-31T10:00:00.511Z', 'это документ', 'f9bba6d8-4cfb-48aa-bed7-794bddb2d7dd'),
('f57a1625-a57d-4825-b3d3-86a475d5ab6d', '6812dd61-064c-4c5e-b8ba-dfdb91d6a7de', 'c68b1a77-0a13-4c05-bc3e-c2504868f0ac', 2, '56.14098311929222', '47.22885164058674', '2019-08-30T00:00:00.511Z', 'это документ...', 'eb895925-39e8-4ee7-9ad9-507a0031afba'),
('d53d5a20-9587-488a-b2ca-a192989d4a8d', '6812dd61-064c-4c5e-b8ba-dfdb91d6a7de', 'c68b1a77-0a13-4c05-bc3e-c2504868f0ac', 1, '56.14010705859811', '47.229393446807734', '2019-08-31T10:00:00.511Z', 'это изображение...', 'fe917dcf-3d47-4af4-870c-8d34632dbb5f');

truncate core.cd_notifications;
insert into core.cd_notifications (fn_user_to, c_title, c_message, d_date, fn_user_from, b_readed, b_sended) values
(4, 'Приветствие!', 'Добро пожаловать в Мобильные сервисы', '2019-08-30T00:00:00.511Z', 2, false, false),
(5, 'Приветствие!', 'Добро пожаловать в Мобильные сервисы', '2019-08-30T00:00:00.511Z', 2, false, false);

truncate core.cd_feedbacks;
insert into core.cd_feedbacks (id, c_imei, fn_user, fn_type, c_question, d_date_question, fn_question_file, c_answer, d_date_answer, fn_answer_file) values
('15311408-da0a-4c2a-90c1-91038785577f', '351756051523999', 4, 2, 'Хочу видео вложение, а не фото.', '2019-10-28T00:00:00.511Z', '4a6d72fd-8c34-4c54-9d24-a39d9dc7a5ef', '<font color=''green''>будет</font>', '2019-10-29T00:00:00.511Z', '95359ae4-8e6e-44ad-bc98-6bae613eeb7d');

update core.pd_users
set fn_file = '697167b7-b5af-4578-839f-6ebbd4e24663'
where id = 4;

truncate core.ad_tracking;
insert into core.ad_tracking (id, fn_user, d_date, n_latitude, n_longitude, c_network_status) values
('7de5c49b-5479-421d-9a60-a603fbea90bc', 4, '2019-08-30T01:00:00.511Z', '56.14031102276747', '47.23131754848073', 'LTE'),
('ce20d31e-8cb0-4574-8963-da57ba048736', 4, '2019-08-30T01:10:00.511Z', '56.13979885765043', '47.230663089481105', 'LTE'),
('a2329bb4-85cc-4329-bfb9-1ab54634c9a0', 4, '2019-08-30T01:20:00.511Z', '56.13979885765043', '47.230663089481105', 'LTE'),
('6b0d3d31-4d47-41bd-badb-cb2064ea614f', 4, '2019-08-30T01:25:00.511Z', '56.13983057759536', '47.228522039494294', 'LTE');

