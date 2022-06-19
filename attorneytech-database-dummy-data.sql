INSERT INTO users (role, username, password, first_name, last_name, email,
    phone, street_name, district, city, zip_code)
VALUES
    ('client', 'client_1', 'password_1', '青竹', '林', 'abc@gmail.com', '0912345678',
    '博愛路 356 號', '中正區', '台北市', '100'),
    ('client', 'client_2', 'password_2', '啟方', '吳', 'def@gmail.com', '0912345879',
    '西園路一段 200 號 8 樓', '萬華區', '台北市', '108'),
    ('client', 'client_3', 'password_3', '俊文', '陳', 'def@gmail.com', '0955323879',
    '工業路 12 號', '大里區', '台中市', '412'),
    ('client', 'client_4', 'password_4', '至山', '黃', 'weqwek232@gmail.com', '0993345879',
    '中和路三段 483 號 12 樓之 3', '中和區', '新北市', '235'),
    ('agent', 'agent_1', 'password_1a', '律師', '謝', 'lawyear1@gmail.com', '0924345678',
    '敦化南路一段 345 號 18 樓', '大安區', '台北市', '106');


INSERT INTO opposite_clients (name, first_name, last_name, street_name, district, city, zip_code)
VALUES
    (NULL, '紀雯', '劉', '木柵路二段 12 號 3 樓', '文山區', '臺北市', '116'),
    (NULL, '佩君', '張', '英專路一段 231 巷 18 號 2 樓', '淡水區', '臺北市', '251'),
    ('臺北市政府', NULL, NULL, '市府路1號', '信義區', '臺北市', '110'),
    ('臺北地方檢察署檢察官', NULL, NULL, '博愛路 131 號', '中正區', '臺北市', '100');


INSERT INTO opposite_agents (first_name, last_name, email, phone, street_name, district, city, zip_code)
VALUES
    ('律師', '江', 'lawyerc@gmail.com', '0233451234','松仁路 2 號 20 樓', '信義區', '臺北市', '110'),
    ('律師', '盧', 'lawyerlu@gmail.com', '0223567542', '南京東路二段 12 號 7 樓', '中山區', '臺北市', '104');


INSERT INTO courts (name, phone, street_name, district, city, zip_code)
VALUES
    ('臺灣臺北地方法院民事庭','0223146871', '博愛路 131 號', '中正區', '臺北市', '100'),
    ('臺灣臺北地方法院刑事庭','0223146871', '博愛路 131 號', '中正區', '臺北市', '100'),
    ('臺灣士林地方法院民事庭', '0227911521', '民權東路六段 91 號', '內湖區', '臺北市', '114'),
    ('臺灣士林地方法院刑事庭', '0228312321', '士東路 190 號', '士林區', '臺北市', '110'),
    ('臺北高等行政法院', '0228333822', '福國路 101 號', '士林區', '臺北市', '110'),
    ('臺灣高等法院民事庭', '0223713261', '貴陽街一段 233 號', '中正區', '臺北市', '100');


INSERT INTO section_in_charges (name, clerk_first_name, clerk_last_name, extension_number, court_id)
VALUES
    ('亮股', '嬿舒', '陳', '6713', 2),
    ('乙股', '雪華', '吳', '6752', 5),
    ('青股', '琬真', '曾', '2578', 8),
    ('天股', '定宜', '江', '1227', 11),
    ('荒股', '承翰', '李', '656', 14),
    ('亥股', '青菁', '崔', '2470', 17);


INSERT INTO events (name, client_id, opposite_client_id)
VALUES
    ('林青竹與劉紀雯間臺北市羅斯福路房地拆屋還地事件', 2, 2),
    ('吳啟方與張佩君間車禍侵權行為損害賠償事件', 5, 5),
    ('陳俊文與臺北市政府間萬華區土地確認公用地役關係不存在事件', 8, 8),
    ('黃至山被訴違反證券交易法事件', 11, 11);


INSERT INTO cases (
    category, year, type, number, cause_of_action, event_id, section_in_charge_id,
    court_id, client_id, agent_id, opposite_client_id, opposite_agent_id
)
VALUES
    ('民事', '111', '訴', '1101', '拆屋還地', 2, 2, 2, 2, 14, 2, 2),
    ('民事', '109', '訴', '1231', '侵權行為損害賠償', 5, 8, 8, 5, 14, 5, 5),
    ('民事', '110', '上易', '12', '侵權行為損害賠償', 5, 17, 17, 5, 14, 5, 5),
    ('行政', '110', '訴', '379', '巷道爭議', 8, 14, 14, 8, 14, 8, NULL),
    ('刑事', '111', '金重訴', '38', '證券交易法等', 11, 5, 5, 11, 14, 11, NULL);


INSERT INTO papers (
    category, title, subject, sent_date, arrival_date, received_date,
    deadline_date, court_date, paper_type, case_id
)
VALUES
    ('paper_sent', '民事起訴狀', '林青竹與劉紀雯間羅斯福路房地拆屋還地事件起訴狀',
    '2022-05-01', '2022-05-02', NULL, NULL, NULL, '起訴狀', 2),
    ('paper_received', '民事答辯狀', '被告劉紀雯針對起訴狀論點之答辯',
    NULL, NULL, '2022-06-10', NULL, NULL, '答辯狀', 2),
    ('paper_received', '臺灣臺北地方法院民事庭函', '林青竹與劉紀雯拆屋還地案開庭通知',
    NULL, NULL, '2022-06-18', NULL, '2022-07-31 15:30:00', '法院開庭通知', 2),
    ('paper_received', '民事起訴狀', '原告張佩君寄發之民事起訴狀',
    NULL, NULL, '2020-02-04', NULL, NULL, '起訴狀', 5),
    ('paper_received', '臺灣士林地方法院民事庭函', '請 7 日內針對原告主張提出答辯狀',
    NULL, NULL, '2020-02-04', '2020-02-11', NULL, '法院補正通知', 5),
    ('paper_sent', '民事答辯狀', '針對原告起訴狀提出答辯狀', '2020-02-10', '2020-02-11',
    NULL, NULL, NULL, '答辯狀', 5),
    ('paper_received', '民事準備狀', '對造即原告補充理由', NULL, NULL,
    '2020-03-15', NULL, NULL, '準備狀', 5),
    ('paper_received', '臺灣士林地方法院民事庭函', '開庭通知', NULL, NULL,
    '2020-04-03', NULL, '2020-05-05 09:30:00', '法院開庭通知', 5),
    ('paper_sent', '民事答辯二狀', '針對原告準備狀內容補充答辯', '2020-04-10',
    '2020-04-11', NULL, NULL, NULL, '答辯狀', 5),
    ('paper_sent', '民事調查證據聲請狀', '聲請法院調閱原告之勞保投保資料', '2020-07-01',
    '2020-07-02', NULL, NULL, NULL, '調查證據聲請狀', 5),
    ('paper_sent', '民事綜合辯論意旨狀', '答辯重點整理', '2020-10-11', 
    '2020-10-12', NULL, NULL, NULL, '綜合辯論意旨狀', 5),
    ('paper_received', '民事綜合辯論意旨狀', '原告之重點整理', NULL, NULL,
    '2020-11-01', NULL, NULL, '綜合辯論意旨狀', 5),
    ('paper_received', '臺灣士林地方法院民事判決', '被告即當事人應賠償原告，上訴期間 30 日',
    NULL, NULL, '2020-12-20', '2021-01-11', NULL, '法院判決書', 5);
