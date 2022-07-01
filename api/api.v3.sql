-- phpMyAdmin SQL Dump
-- version 5.1.3
-- https://www.phpmyadmin.net/
--
-- Хост: localhost
-- Время создания: Мар 26 2022 г., 20:11
-- Версия сервера: 5.7.35-38
-- Версия PHP: 7.1.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `cc38255_music`
--

-- --------------------------------------------------------

--
-- Структура таблицы `Albums`
--

CREATE TABLE IF NOT EXISTS `Albums` (
  `alid` int(9) NOT NULL AUTO_INCREMENT,
  `title` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner_id` int(9) NOT NULL,
  `aid` int(9) NOT NULL,
  `img` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `release_date` int(10) NOT NULL,
  PRIMARY KEY (`alid`),
  KEY `owner_id` (`owner_id`),
  KEY `aid` (`aid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `Albums`
--

INSERT INTO `Albums` (`alid`, `title`, `owner_id`, `aid`, `img`, `release_date`) VALUES
(1, 'Свистки и Бумажки', 1, 1, '/store/cloud/albums/alid1/img_1024.png', 1616803200);

-- --------------------------------------------------------

--
-- Структура таблицы `Applications`
--

CREATE TABLE IF NOT EXISTS `Applications` (
  `app_id` int(9) NOT NULL AUTO_INCREMENT,
  `title` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_verified` tinyint(1) NOT NULL DEFAULT '0',
  `owner_uid` int(9) NOT NULL,
  `secure_key` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_key` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` set('enabled','disabled') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'disabled',
  `access_permission` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '[]',
  `domain` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `redirect_uri` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dateRegistration` int(10) NOT NULL,
  PRIMARY KEY (`app_id`),
  KEY `owner_uid` (`owner_uid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `Applications`
--

INSERT INTO `Applications` (`app_id`, `title`, `is_verified`, `owner_uid`, `secure_key`, `access_key`, `status`, `access_permission`, `domain`, `redirect_uri`, `dateRegistration`) VALUES
(1, 'INY  Music', 1, 1, '20562d0e9406380117edb77cb0e8f3b8.6086aeb20ce4b', '25e1676f52219510a0565e3c83982ebd.6086aeb20ce55', 'enabled', '[]', 'music.iny.su', '/', 1633550090);

-- --------------------------------------------------------

--
-- Структура таблицы `Artists`
--

CREATE TABLE IF NOT EXISTS `Artists` (
  `aid` int(9) NOT NULL AUTO_INCREMENT,
  `owner_uid` int(9) NOT NULL,
  `verify` tinyint(1) NOT NULL,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `surname` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `altname` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `img` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `keywords` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `updated_at` int(10) NOT NULL,
  `created_at` int(10) NOT NULL,
  PRIMARY KEY (`aid`),
  KEY `updated_at` (`updated_at`),
  KEY `created_at` (`created_at`),
  KEY `keywords` (`keywords`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `Artists`
--

INSERT INTO `Artists` (`aid`, `owner_uid`, `verify`, `name`, `surname`, `altname`, `img`, `keywords`, `updated_at`, `created_at`) VALUES
(1, 1, 1, 'Адиль', 'Жалелов', 'скриптонит', '/store/cloud/arists/aid1.png', 'Скриптонит Адиль Жалелов', 1648311462, 1648311462),
(2, 2, 1, 'Фёдор\r\n', 'Инсаров', 'feduk', '/store/cloud/arists/aid2.png', 'FEDUK Инсаров', 1648311462, 1648311462);

-- --------------------------------------------------------

--
-- Структура таблицы `ColectionContent`
--

CREATE TABLE IF NOT EXISTS `ColectionContent` (
  `ccid` int(9) NOT NULL AUTO_INCREMENT,
  `pid` int(9) NOT NULL,
  `aid` int(9) NOT NULL,
  `alid` int(9) NOT NULL,
  `sid` int(9) NOT NULL,
  `updated_at` int(10) NOT NULL,
  `created_at` int(10) NOT NULL,
  PRIMARY KEY (`ccid`),
  KEY `pid` (`pid`),
  KEY `alid` (`alid`),
  KEY `sid` (`sid`),
  KEY `updated_at` (`updated_at`),
  KEY `created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Структура таблицы `Colections`
--

CREATE TABLE IF NOT EXISTS `Colections` (
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(9) NOT NULL,
  `type` set('custom','system','special') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ccid` int(9) NOT NULL,
  `updated_at` int(10) NOT NULL,
  `created_at` int(10) NOT NULL,
  PRIMARY KEY (`cid`),
  KEY `uid` (`uid`),
  KEY `ccid` (`ccid`),
  KEY `updated_at` (`updated_at`),
  KEY `created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Структура таблицы `Devices`
--

CREATE TABLE IF NOT EXISTS `Devices` (
  `id` int(9) NOT NULL AUTO_INCREMENT,
  `client_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `app_id` int(9) NOT NULL,
  `platform` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ip` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `uid` int(9) DEFAULT NULL,
  `time` int(10) NOT NULL,
  `permission` set('allow','deny') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'allow',
  PRIMARY KEY (`id`),
  KEY `app_id` (`app_id`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `Devices`
--

INSERT INTO `Devices` (`id`, `client_id`, `app_id`, `platform`, `ip`, `uid`, `time`, `permission`) VALUES
(1, '243225db-bd45-429e-b28c-81a98d626d0e', 1, 'Windows', '95.24.206.64', 1, 1644491909, 'allow'),
(2, '302ebd27-fc9e-4507-82e8-db362c5cc50e', 1, 'Windows', '95.24.206.64', 2, 1645213255, 'allow'),
(3, '37aacaba-a733-4d1d-a38c-c1a12a0ed3c4', 1, 'Windows', '95.24.206.64', NULL, 1644593410, 'allow'),
(4, '8e36b426-f711-4129-a979-65559c565a69', 1, 'Windows', '95.24.206.64', 1, 1645269060, 'allow'),
(5, 'c1489b09-ffe5-4bc6-9446-5022a24a1f3d', 1, 'Android', '176.59.106.211', NULL, 1644594252, 'allow'),
(6, '6cdef932-30f9-446c-a7b8-b3cf83bb3bbc', 1, 'Android', '95.24.205.161', NULL, 1644597074, 'allow'),
(7, 'b37bd846-3d26-4283-973b-205f17758a81', 1, 'Windows', '95.24.205.161', 3, 1644603431, 'allow'),
(8, 'd937a483-87ee-4f69-8e14-5b1aa93c8dd7', 1, 'Windows', '164.177.183.14', 6, 1647196659, 'allow'),
(9, '73e6f3d9-39eb-42ce-aced-91d1c6faa65e', 1, 'Android', '85.26.232.186', NULL, 1644604414, 'allow'),
(10, 'e110c85b-80e8-4fd3-9af1-219db64b1545', 1, 'Windows', '65.154.226.165', NULL, 1644646507, 'allow'),
(11, 'cead9dd5-259b-4270-880e-29d2a428aad0', 1, 'Windows', '164.177.179.25', 5, 1647037282, 'allow'),
(12, '6ee1de60-8630-403e-ac35-05295225da76', 1, 'Linux', '95.24.206.64', 1, 1645986029, 'allow'),
(13, 'dcbc1de3-6a55-44f3-b721-25fd0c127f9e', 1, 'Linux', '95.24.206.64', 2, 1645305136, 'allow'),
(14, '33cec42b-6a2e-42a8-b845-b1b2c7ad17a7', 1, 'Linux', '95.24.206.166', NULL, 1646152720, 'allow'),
(15, 'dc9268b8-4f5e-45d4-85ad-7183c1f9baf6', 1, 'Linux', '95.24.206.166', NULL, 1646154764, 'allow'),
(16, '6fb6ab65-2eac-4637-b2d7-d43bcf825dbe', 1, 'Windows', '95.24.203.243', 1, 1648224659, 'allow'),
(17, 'c4594752-e9c9-4312-b686-9684f3c68fc4', 1, 'Windows', '95.24.203.243', 6, 1648314642, 'allow'),
(18, '07e947d3-2efc-41ac-966c-e7f30ea4f915', 1, 'Linux', '109.195.198.159', NULL, 1647239344, 'allow'),
(19, 'e08186d9-8b08-43f5-9c7f-ef29596b8522', 1, 'Windows', '95.68.135.91', 6, 1647261020, 'allow'),
(20, '9f345a3a-9fdb-49b1-b392-df18f8915a64', 1, 'Windows', '95.68.135.91', 6, 1647270985, 'allow'),
(21, '20e15b9d-879c-4acf-a1bb-28346dede333', 1, 'Windows', '95.68.135.91', 7, 1647270841, 'allow');

-- --------------------------------------------------------

--
-- Структура таблицы `Feat`
--

CREATE TABLE IF NOT EXISTS `Feat` (
  `id` int(9) NOT NULL AUTO_INCREMENT,
  `fid` int(9) NOT NULL,
  `aid` int(9) NOT NULL,
  `position` int(2) NOT NULL,
  `updated_at` int(10) NOT NULL,
  `created_at` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `aid` (`aid`),
  KEY `updated_at` (`updated_at`),
  KEY `created_at` (`created_at`),
  KEY `fid` (`fid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `Feat`
--

INSERT INTO `Feat` (`id`, `fid`, `aid`, `position`, `updated_at`, `created_at`) VALUES
(1, 1, 1, 1, 1648311462, 1648311462),
(2, 1, 2, 2, 1648311462, 1648311462);

-- --------------------------------------------------------

--
-- Структура таблицы `Genre`
--

CREATE TABLE IF NOT EXISTS `Genre` (
  `gid` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`gid`)
) ENGINE=InnoDB AUTO_INCREMENT=932 DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `Genre`
--

INSERT INTO `Genre` (`gid`, `title`) VALUES
(1, 'Alternative'),
(2, 'Art Punk'),
(3, 'Alternative Rock'),
(4, 'Britpunk'),
(5, 'College Rock'),
(6, 'Crossover Thrash'),
(7, 'Crust Punk'),
(8, 'Emotional Hardcore '),
(9, 'emo / emocore'),
(10, 'Experimental Rock'),
(11, 'Folk Punk'),
(12, 'Goth / Gothic Rock'),
(13, 'Grunge'),
(14, 'Hardcore Punk'),
(15, 'Hard Rock'),
(16, 'Indie Rock'),
(17, 'Lo-fi'),
(18, 'Musique Concrète'),
(19, 'New Wave'),
(20, 'Progressive Rock'),
(21, 'Punk'),
(22, 'Shoegaze'),
(23, 'Steampunk'),
(24, 'Anime'),
(25, 'Blues'),
(26, 'Acoustic Blues'),
(27, 'African Blues'),
(28, 'Blues Rock'),
(29, 'Blues Shouter'),
(30, 'British Blues'),
(31, 'Canadian Blues'),
(32, 'Chicago Blues'),
(33, 'Classic Blues'),
(34, 'Classic Female Blues'),
(35, 'Contemporary Blues'),
(36, 'Contemporary R&B'),
(37, 'Country Blues'),
(38, 'Dark Blues'),
(39, 'Delta Blues'),
(40, 'Detroit Blues'),
(41, 'Doom Blues'),
(42, 'Electric Blues'),
(43, 'Folk Blues'),
(44, 'Gospel Blues'),
(45, 'Harmonica Blues'),
(46, 'Hill Country Blues'),
(47, 'Hokum Blues'),
(48, 'Jazz Blues'),
(49, 'Jump Blues'),
(50, 'Kansas City Blues'),
(51, 'Louisiana Blues'),
(52, 'Memphis Blues'),
(53, 'Modern Blues'),
(54, 'New Orlean Blues'),
(55, 'NY Blues'),
(56, 'Piano Blues'),
(57, 'Piedmont Blues'),
(58, 'Punk Blues'),
(59, 'Ragtime Blues'),
(60, 'Rhythm Blues'),
(61, 'Soul Blues'),
(62, 'St. Louis Blues'),
(63, 'Soul Blues'),
(64, 'Swamp Blues'),
(65, 'Texas Blues'),
(66, 'Urban Blues'),
(67, 'Vandeville'),
(68, 'West Coast Blues'),
(69, 'Zydeco'),
(70, 'Children’s Music'),
(71, 'Lullabies'),
(72, 'Sing-Along'),
(73, 'Stories'),
(74, 'Classical'),
(75, 'Avant-Garde'),
(76, 'Ballet'),
(77, 'Baroque'),
(78, 'Cantata'),
(79, 'Chamber Music'),
(80, 'String Quartet'),
(81, 'Chant'),
(82, 'Choral'),
(83, 'Classical Crossover'),
(84, 'Concerto'),
(85, 'Concerto Grosso'),
(86, 'Contemporary Classical'),
(87, 'Early Music'),
(88, 'Expressionist'),
(89, 'High Classical'),
(90, 'Impressionist'),
(91, 'Mass Requiem'),
(92, 'Medieval'),
(93, 'Minimalism'),
(94, 'Modern Composition'),
(95, 'Modern Classical'),
(96, 'Opera'),
(97, 'Oratorio'),
(98, 'Orchestral'),
(99, 'Organum'),
(100, 'Renaissance'),
(101, 'Romantic (early period)'),
(102, 'Romantic (later period)'),
(103, 'Sonata'),
(104, 'Symphonic'),
(105, 'Symphony'),
(106, 'Wedding Music'),
(107, 'Comedy'),
(108, 'Novelty'),
(109, 'Parody Music'),
(110, 'Stand-up Comedy'),
(111, 'Vaudeville'),
(112, 'Commercial'),
(113, 'Jingles'),
(114, 'TV Themes'),
(115, 'Country'),
(116, 'Alternative Country'),
(117, 'Americana'),
(118, 'Australian Country'),
(119, 'Bakersfield Sound'),
(120, 'Bluegrass'),
(121, 'Progressive Bluegrass'),
(122, 'Reactionary Bluegrass'),
(123, 'Blues Country'),
(124, 'Cajun Fiddle Tunes'),
(125, 'Christian Country'),
(126, 'Classic Country'),
(127, 'Close Harmony'),
(128, 'Contemporary Bluegrass'),
(129, 'Contemporary Country'),
(130, 'Country Gospel'),
(131, 'Country Pop'),
(132, 'Country Rap'),
(133, 'Country Rock'),
(134, 'Country Soul'),
(135, 'Cowboy'),
(136, 'Western'),
(137, 'Cowpunk'),
(138, 'Dansband'),
(139, 'Honky Tonk'),
(140, 'Franco-Country'),
(141, 'Gulf and Western'),
(142, 'Hellbilly Music'),
(143, 'Honky Tonk'),
(144, 'Instrumental Country'),
(145, 'Lubbock Sound'),
(146, 'Nashville Sound'),
(147, 'Neotraditional Country'),
(148, 'Outlaw Country'),
(149, 'Progressive'),
(150, 'Psychobilly / Punkabilly'),
(151, 'Red Dirt'),
(152, 'Sertanejo'),
(153, 'Texas County'),
(154, 'Traditional Bluegrass'),
(155, 'Traditional Country'),
(156, 'Truck-Driving Country'),
(157, 'Urban Cowboy'),
(158, 'Western Swing'),
(159, 'Zydeco'),
(160, 'Dance'),
(161, 'Club / Club Dance'),
(162, 'Breakcore'),
(163, 'Breakbeat / Breakstep'),
(164, '4-Beat'),
(165, 'Acid Breaks'),
(166, 'Baltimore Club'),
(167, 'Big Beat'),
(168, 'Breakbeat Hardcore'),
(169, 'Broken Beat'),
(170, 'Florida Breaks'),
(171, 'Nu Skool Breaks'),
(172, 'Brostep'),
(173, 'Chillstep'),
(174, 'Deep House'),
(175, 'Dubstep'),
(176, 'Electro House'),
(177, 'Electroswing'),
(178, 'Exercise'),
(179, 'Future Garage'),
(180, 'Garage'),
(181, 'Glitch Hop'),
(182, 'Glitch Pop'),
(183, 'Grime'),
(184, 'Hardcore'),
(185, 'Bouncy House'),
(186, 'Bouncy Techno'),
(187, 'Breakcore'),
(188, 'Digital Hardcore'),
(189, 'Doomcore'),
(190, 'Dubstyle'),
(191, 'Gabber'),
(192, 'Happy Hardcore'),
(193, 'Hardstyle'),
(194, 'Jumpstyle'),
(195, 'Makina'),
(196, 'Speedcore'),
(197, 'Terrorcore'),
(198, 'Uk Hardcore'),
(199, 'Hard Dance'),
(200, 'Hi-NRG / Eurodance'),
(201, 'Horrorcore'),
(202, 'House'),
(203, 'Acid House'),
(204, 'Chicago House'),
(205, 'Deep House'),
(206, 'Diva House'),
(207, 'Dutch House'),
(208, 'Electro House'),
(209, 'Freestyle House'),
(210, 'French House'),
(211, 'Funky House'),
(212, 'Ghetto House'),
(213, 'Hardbag'),
(214, 'Hip House'),
(215, 'Italo House'),
(216, 'Latin House'),
(217, 'Minimal House'),
(218, 'Progressive House'),
(219, 'Rave Music'),
(220, 'Swing House'),
(221, 'Tech HouseTribal House'),
(222, 'UK Hard House'),
(223, 'US Garage'),
(224, 'Vocal House'),
(225, 'Jackin House'),
(226, 'Jungle / Drum’n’bass'),
(227, 'Liquid Dub'),
(228, 'Regstep'),
(229, 'Speedcore'),
(230, 'Techno'),
(231, 'Acid Techno'),
(232, 'Detroit Techno'),
(233, 'Free Tekno'),
(234, 'Ghettotech'),
(235, 'Minimal'),
(236, 'Nortec'),
(237, 'Schranz'),
(238, 'Techno-Dnb'),
(239, 'Technopop'),
(240, 'Tecno Brega'),
(241, 'Toytown Techno'),
(242, 'Trance'),
(243, 'Acid Trance'),
(244, 'Classic Trance'),
(245, 'Dream Trance'),
(246, 'Goa Trance'),
(247, 'Dark Psytrance'),
(248, 'Full on'),
(249, 'Psybreaks'),
(250, 'Psyprog'),
(251, 'Suomisaundi'),
(252, 'Hard Trance'),
(253, 'Tech Trance'),
(254, 'Uplifting Trance'),
(255, 'Orchestral Uplifting'),
(256, 'Vocal Trance'),
(257, 'Trap'),
(258, 'Disney'),
(259, 'Easy Listening'),
(260, 'Background'),
(261, 'Bop'),
(262, 'Elevator'),
(263, 'Furniture'),
(264, 'Lounge'),
(265, 'Middle of the Road'),
(266, 'Swing'),
(267, 'Electronic'),
(268, '2-Step'),
(269, '8bit / 8-bit / Bitpop / Chiptune'),
(270, 'Ambient'),
(271, 'Ambient Dub'),
(272, 'Ambient House'),
(273, 'Ambient Techno'),
(274, 'Dark Ambient'),
(275, 'Drone Music'),
(276, 'Illbient'),
(277, 'Isolationism'),
(278, 'Lowercase'),
(279, 'Asian Underground'),
(280, 'Bassline'),
(281, 'Chillwave'),
(282, 'Chiptune'),
(283, 'Bitpop'),
(284, 'Game Boy'),
(285, 'Nintendocore'),
(286, 'Video Game Music'),
(287, 'Yorkshire Bleeps and Bass'),
(288, 'Crunk'),
(289, 'Downtempo'),
(290, 'Acid Jazz'),
(291, 'Balearic Beat'),
(292, 'Chill Out'),
(293, 'Dub Music'),
(294, 'Dubtronica'),
(295, 'Ethnic Electronica'),
(296, 'Moombahton'),
(297, 'Nu Jazz'),
(298, 'Trip Hop'),
(299, 'Drum & Bass / DnB'),
(300, 'Darkcore'),
(301, 'Darkstep'),
(302, 'Drumfunk'),
(303, 'Drumstep'),
(304, 'Hardstep'),
(305, 'Intelligent Drum and Bass'),
(306, 'Jump-Up'),
(307, 'Liquid Funk'),
(308, 'Neurofunk'),
(309, 'Oldschool Jungle'),
(310, 'Darkside Jungle'),
(311, 'Ragga Jungle'),
(312, 'Raggacore'),
(313, 'Sambas'),
(314, 'Techstep'),
(315, 'Electro'),
(316, 'Crunk'),
(317, 'Electro Backbeat'),
(318, 'Electro-Grime'),
(319, 'Electropop'),
(320, 'Electro-swing'),
(321, 'Electroacoustic'),
(322, 'Acousmatic Music'),
(323, 'Computer Music'),
(324, 'Electroacoustic Improvisation'),
(325, 'Field Recording'),
(326, 'Live Coding'),
(327, 'Live Electronics'),
(328, 'Soundscape Composition'),
(329, 'Tape Music'),
(330, 'Electronica'),
(331, 'Berlin School'),
(332, 'Chillwave'),
(333, 'Electronic Art Music'),
(334, 'Electronic Dance Music'),
(335, 'Folktronica'),
(336, 'Freestyle Music'),
(337, 'Glitch'),
(338, 'Idm'),
(339, 'Laptronica'),
(340, 'Skweee'),
(341, 'Sound Art'),
(342, 'Synthcore'),
(343, 'Electronic Rock'),
(344, 'Alternative Dance'),
(345, 'Baggy'),
(346, 'Madchester'),
(347, 'Dance-Punk'),
(348, 'Dance-Rock'),
(349, 'Dark Wave'),
(350, 'Electroclash'),
(351, 'Electronicore'),
(352, 'Electropunk'),
(353, 'Ethereal Wave'),
(354, 'Indietronica'),
(355, 'New Rave'),
(356, 'Space Rock'),
(357, 'Synthpop'),
(358, 'Synthpunk'),
(359, 'Eurodance'),
(360, 'Bubblegum Dance'),
(361, 'Italo Dance'),
(362, 'Turbofolk'),
(363, 'Hardstyle'),
(364, 'Hi-Nrg'),
(365, 'Eurobeat'),
(366, 'Hard Nrg'),
(367, 'New Beat'),
(368, 'IDM/Experimental'),
(369, 'Industrial'),
(370, 'Trip Hop'),
(371, 'UK Garage'),
(372, '2-Step'),
(373, '4×4'),
(374, 'Bassline'),
(375, 'Grime'),
(376, 'Speed Garage'),
(377, 'Enka'),
(378, 'French Pop'),
(379, 'Folk Music'),
(380, 'American Folk Revival'),
(381, 'Anti-Folk'),
(382, 'British Folk Revival'),
(383, 'Contemporary Folk'),
(384, 'Filk Music'),
(385, 'Freak Folk'),
(386, 'Indie Folk'),
(387, 'Industrial Folk'),
(388, 'Neofolk'),
(389, 'Progressive Folk'),
(390, 'Psychedelic Folk'),
(391, 'Sung Poetry'),
(392, 'Techno-Folk'),
(393, 'German Folk'),
(394, 'German Pop'),
(395, 'Fitness & Workout'),
(396, 'Hip-Hop / Rap'),
(397, 'Alternative Rap'),
(398, 'Avant-Garde'),
(399, 'Bounce'),
(400, 'Chap Hop'),
(401, 'Christian Hip Hop'),
(402, 'Conscious Hip Hop'),
(403, 'Country-Rap'),
(404, 'Crunkcore'),
(405, 'Cumbia Rap'),
(406, 'Dirty South'),
(407, 'East Coast'),
(408, 'Brick City Club'),
(409, 'Hardcore Hip Hop'),
(410, 'Mafioso Rap'),
(411, 'New Jersey Hip Hop'),
(412, 'Freestyle Rap'),
(413, 'G-Funk'),
(414, 'Gangsta Rap'),
(415, 'Golden Age'),
(416, 'Hardcore Rap'),
(417, 'Hip-Hop'),
(418, 'Hip Pop'),
(419, 'Hyphy'),
(420, 'Industrial Hip Hop'),
(421, 'Instrumental Hip Hop'),
(422, 'Jazz Rap'),
(423, 'Latin Rap'),
(424, 'Low Bap'),
(425, 'Lyrical Hip Hop'),
(426, 'Merenrap'),
(427, 'Midwest Hip Hop'),
(428, 'Chicago Hip Hop'),
(429, 'Detroit Hip Hop'),
(430, 'Horrorcore'),
(431, 'St. Louis Hip Hop'),
(432, 'Twin Cities Hip Hop'),
(433, 'Motswako'),
(434, 'Nerdcore'),
(435, 'New Jack Swing'),
(436, 'New School Hip Hop'),
(437, 'Old School Rap'),
(438, 'Rap'),
(439, 'Turntablism'),
(440, 'Underground Rap'),
(441, 'West Coast Rap'),
(442, 'Holiday'),
(443, 'Chanukah'),
(444, 'Christmas'),
(445, 'Christmas: Children’s'),
(446, 'Christmas: Classic'),
(447, 'Christmas: Classical'),
(448, 'Christmas: Comedy'),
(449, 'Christmas: Jazz'),
(450, 'Christmas: Modern'),
(451, 'Christmas: Pop'),
(452, 'Christmas: R&B'),
(453, 'Christmas: Religious'),
(454, 'Christmas: Rock'),
(455, 'Easter'),
(456, 'Halloween'),
(457, 'Holiday: Other'),
(458, 'Thanksgiving'),
(459, 'Indie Pop'),
(460, 'Industrial'),
(461, 'Aggrotech'),
(462, 'Coldwave'),
(463, 'Cybergrind'),
(464, 'Dark Electro'),
(465, 'Death Industrial'),
(466, 'Electro-Industrial'),
(467, 'Electronic Body Music'),
(468, 'Futurepop'),
(469, 'Industrial Metal'),
(470, 'Neue Deutsche Härte'),
(471, 'Industrial Rock'),
(472, 'Noise'),
(473, 'Japanoise'),
(474, 'Power Electronics'),
(475, 'Power Noise'),
(476, 'Witch House'),
(477, 'Inspirational – Christian & Gosp'),
(478, 'CCM'),
(479, 'Christian Metal'),
(480, 'Christian Pop'),
(481, 'Christian Rap'),
(482, 'Christian Rock'),
(483, 'Classic Christian'),
(484, 'Contemporary Gospel'),
(485, 'Gospel'),
(486, 'Christian & Gospel'),
(487, 'Praise & Worship'),
(488, 'Qawwali'),
(489, 'Southern Gospel'),
(490, 'Traditional Gospel'),
(491, 'Instrumental'),
(492, 'March'),
(493, 'J-Pop'),
(494, 'J-Rock'),
(495, 'J-Synth'),
(496, 'J-Ska'),
(497, 'J-Punk'),
(498, 'Jazz'),
(499, 'Acid Jazz'),
(500, 'Avant-Garde Jazz'),
(501, 'Bebop'),
(502, 'Big Band'),
(503, 'Blue Note'),
(504, 'Contemporary Jazz'),
(505, 'Cool'),
(506, 'Crossover Jazz'),
(507, 'Dixieland'),
(508, 'Ethio-jazz'),
(509, 'Fusion'),
(510, 'Gypsy Jazz'),
(511, 'Hard Bop'),
(512, 'Latin Jazz'),
(513, 'Mainstream Jazz'),
(514, 'Ragtime'),
(515, 'Smooth Jazz'),
(516, 'Trad Jazz'),
(517, 'Third Stream'),
(518, 'Jazz-Funk'),
(519, 'Free Jazz'),
(520, 'Modal Jazz'),
(521, 'K-Pop'),
(522, 'Karaoke'),
(523, 'Kayokyoku'),
(524, 'Latin'),
(525, 'Alternativo & Rock Latino'),
(526, 'Argentine tango'),
(527, 'Bachata'),
(528, 'Baithak Gana'),
(529, 'Baladas y Boleros'),
(530, 'Bolero'),
(531, 'Bossa Nova'),
(532, 'Brazilian'),
(533, 'Axé'),
(534, 'Bossa Nova'),
(535, 'Brazilian Rock'),
(536, 'Brega'),
(537, 'Choro'),
(538, 'Forró'),
(539, 'Frevo'),
(540, 'Funk Carioca'),
(541, 'Lambada'),
(542, 'Maracatu'),
(543, 'Música Popular Brasileira'),
(544, 'Música Sertaneja'),
(545, 'Pagode'),
(546, 'Samba'),
(547, 'Samba Rock'),
(548, 'Tecnobrega'),
(549, 'Tropicalia'),
(550, 'Zouk-Lambada'),
(551, 'Chicha'),
(552, 'Criolla'),
(553, 'Contemporary Latin'),
(554, 'Cumbia'),
(555, 'Flamenco / Spanish Flamenco'),
(556, 'Huayno'),
(557, 'Latin Jazz'),
(558, 'Mariachi'),
(559, 'Merengue Típico'),
(560, 'Nuevo Flamenco'),
(561, 'Pop Latino'),
(562, 'Portuguese fado'),
(563, 'Punta'),
(564, 'Punta Rock'),
(565, 'Ranchera'),
(566, 'Raíces'),
(567, 'Raison'),
(568, 'Reggaeton y Hip-Hop'),
(569, 'Regional Mexicano'),
(570, 'Salsa y Tropical'),
(571, 'Soca'),
(572, 'Son'),
(573, 'Tejano'),
(574, 'Timba'),
(575, 'Twoubadou'),
(576, 'Zouk'),
(577, 'Metal'),
(578, 'Heavy Metal'),
(579, 'Speed Metal'),
(580, 'Thrash Metal'),
(581, 'Power Metal'),
(582, 'Death Metal'),
(583, 'Black Metall'),
(584, 'Pagan Metal'),
(585, 'Viking Metal'),
(586, 'Folk Metal'),
(587, 'Symphonic Metal'),
(588, 'Gothic Metal'),
(589, 'Glam Metal'),
(590, 'Hair Metal'),
(591, 'Doom Metal'),
(592, 'Groove Metal'),
(593, 'Industrial Metal'),
(594, 'Modern Metal'),
(595, 'Neoclassical Metal'),
(596, 'New Wave Of British Heavy Metal'),
(597, 'Post Metal'),
(598, 'Post Rock'),
(599, 'Progressive Metal'),
(600, 'Avantgarde Metal'),
(601, 'Sludge'),
(602, 'Djent'),
(603, 'Drone'),
(604, 'Kawaii Metal'),
(605, 'Pirate Metal'),
(606, 'Nu Metal'),
(607, 'Neue Deutsche Härte'),
(608, 'Math Metal'),
(609, 'Crossover'),
(610, 'Grindcore'),
(611, 'Hardcore'),
(612, 'Metalcore'),
(613, 'Deathcore'),
(614, 'Post Hardcore'),
(615, 'Mathcore'),
(616, 'New Age'),
(617, 'Environmental'),
(618, 'Healing'),
(619, 'Meditation'),
(620, 'Nature'),
(621, 'Relaxation'),
(622, 'Travel'),
(623, 'Opera'),
(624, 'Pop'),
(625, 'Adult Contemporary'),
(626, 'Arab Pop'),
(627, 'Baroque'),
(628, 'Britpop'),
(629, 'Bubblegum Pop'),
(630, 'Chamber Pop'),
(631, 'Chanson'),
(632, 'Christian Pop'),
(633, 'Classical Crossover'),
(634, 'Europop'),
(635, 'Austropop'),
(636, 'Balkan Pop'),
(637, 'French Pop'),
(638, 'Latin Pop'),
(639, 'Laïkó'),
(640, 'Nederpop'),
(641, 'Russian Pop'),
(642, 'Dance Pop'),
(643, 'Dream Pop'),
(644, 'Electro Pop'),
(645, 'Iranian Pop'),
(646, 'Jangle Pop'),
(647, 'Latin Ballad'),
(648, 'Levenslied'),
(649, 'Louisiana Swamp Pop'),
(650, 'Mexican Pop'),
(651, 'Motorpop'),
(652, 'New Romanticism'),
(653, 'Orchestral Pop'),
(654, 'Pop Rap'),
(655, 'Popera'),
(656, 'Pop/Rock'),
(657, 'Pop Punk'),
(658, 'Power Pop'),
(659, 'Psychedelic Pop'),
(660, 'Schlager'),
(661, 'Soft Rock'),
(662, 'Sophisti-Pop'),
(663, 'Space Age Pop'),
(664, 'Sunshine Pop'),
(665, 'Surf Pop'),
(666, 'Synthpop'),
(667, 'Teen Pop'),
(668, 'Traditional Pop Music'),
(669, 'Turkish Pop'),
(670, 'Vispop'),
(671, 'Wonky Pop'),
(672, 'Post-Disco'),
(673, 'Boogie'),
(674, 'Dance-pop'),
(675, 'Progressive'),
(676, 'Progressive House / Trance'),
(677, 'Disco House'),
(678, 'Dream House'),
(679, 'Space House'),
(680, 'Japanese House'),
(681, 'Bounce / Scouse House'),
(682, 'Progressive Breaks'),
(683, 'Progressive Drum & Bass'),
(684, 'Progressive Techno'),
(685, 'R&B/Soul'),
(686, 'Contemporary R&B'),
(687, 'Disco'),
(688, 'Doo Wop'),
(689, 'Funk'),
(690, 'Modern Soul'),
(691, 'Motown'),
(692, 'Neo-Soul'),
(693, 'Northern Soul'),
(694, 'Psychedelic Soul'),
(695, 'Quiet Storm'),
(696, 'Soul'),
(697, 'Soul Blues'),
(698, 'Southern Soul'),
(699, 'Reggae'),
(700, '2-Tone'),
(701, 'Dancehall'),
(702, 'Dub'),
(703, 'Roots Reggae'),
(704, 'Reggae Fusion'),
(705, 'Reggae en Español'),
(706, 'Spanish Reggae'),
(707, 'Reggae 110'),
(708, 'Reggae Bultrón'),
(709, 'Romantic Flow'),
(710, 'Lovers Rock'),
(711, 'Raggamuffin'),
(712, 'Ragga'),
(713, 'Dancehall'),
(714, 'Ska'),
(715, '2 Tone'),
(716, 'Dub'),
(717, 'Rocksteady'),
(718, 'Rock'),
(719, 'Acid Rock'),
(720, 'Adult-Oriented Rock'),
(721, 'Afro Punk'),
(722, 'Adult Alternative'),
(723, 'Alternative Rock'),
(724, 'American Traditional Rock'),
(725, 'Anatolian Rock'),
(726, 'Arena Rock'),
(727, 'Art Rock'),
(728, 'Blues-Rock'),
(729, 'British Invasion'),
(730, 'Cock Rock'),
(731, 'Death Metal / Black Metal'),
(732, 'Doom Metal'),
(733, 'Glam Rock'),
(734, 'Gothic Metal'),
(735, 'Grind Core'),
(736, 'Hair Metal'),
(737, 'Hard Rock'),
(738, 'Math Metal'),
(739, 'Math Rock'),
(740, 'Metal'),
(741, 'Metal Core'),
(742, 'Noise Rock'),
(743, 'Jam Bands'),
(744, 'Post Punk'),
(745, 'Prog-Rock/Art Rock'),
(746, 'Progressive Metal'),
(747, 'Psychedelic'),
(748, 'Rock & Roll'),
(749, 'Rockabilly'),
(750, 'Roots Rock'),
(751, 'Singer/Songwriter'),
(752, 'Southern Rock'),
(753, 'Spazzcore'),
(754, 'Stoner Metal'),
(755, 'Surf'),
(756, 'Technical Death Metal'),
(757, 'Tex-Mex'),
(758, 'Thrash Metal'),
(759, 'Time Lord Rock'),
(760, 'Trip-hop'),
(761, 'Singer/Songwriter'),
(762, 'Alternative Folk'),
(763, 'Contemporary Folk'),
(764, 'Contemporary Singer/Songwriter'),
(765, 'Indie Folk'),
(766, 'Folk-Rock'),
(767, 'Love Song'),
(768, 'New Acoustic'),
(769, 'Traditional Folk'),
(770, 'Foreign Cinema'),
(771, 'Movie Soundtrack'),
(772, 'Musicals'),
(773, 'Score / Original Score'),
(774, 'Soundtrack'),
(775, 'TV Soundtrack'),
(776, 'Spoken Word'),
(777, 'Tex-Mex / Tejano'),
(778, 'Chicano'),
(779, 'Classic'),
(780, 'Conjunto'),
(781, 'Conjunto Progressive'),
(782, 'New Mex'),
(783, 'Tex-Mex'),
(784, 'Vocal'),
(785, 'A cappella'),
(786, 'Barbershop'),
(787, 'Cantique'),
(788, 'Doo-wop'),
(789, 'Gregorian Chant'),
(790, 'Standards'),
(791, 'Traditional Pop'),
(792, 'Vocal Jazz'),
(793, 'Vocal Pop'),
(794, 'World'),
(795, 'Africa'),
(796, 'African Heavy Metal'),
(797, 'African Hip Hop'),
(798, 'Afro-Beat'),
(799, 'Afro-Pop'),
(800, 'Apala'),
(801, 'Benga'),
(802, 'Bikutsi'),
(803, 'Bongo Flava'),
(804, 'Cape Jazz'),
(805, 'Chimurenga'),
(806, 'Coupé-Décalé'),
(807, 'Fuji Music'),
(808, 'Genge'),
(809, 'Highlife'),
(810, 'Hiplife'),
(811, 'Isicathamiya'),
(812, 'Jit'),
(813, 'Jùjú'),
(814, 'Kapuka'),
(815, 'Kizomba'),
(816, 'Kuduro'),
(817, 'Kwaito'),
(818, 'Kwela'),
(819, 'Makossa'),
(820, 'Maloya'),
(821, 'Marrabenta'),
(822, 'Mbalax'),
(823, 'Mbaqanga'),
(824, 'Mbube'),
(825, 'Morna'),
(826, 'Museve'),
(827, 'Palm-Wine'),
(828, 'Raï'),
(829, 'Sakara'),
(830, 'Sega'),
(831, 'Seggae'),
(832, 'Semba'),
(833, 'Soukous'),
(834, 'Taarab'),
(835, 'Zouglou'),
(836, 'Asia'),
(837, 'Anison'),
(838, 'C-Pop'),
(839, 'Cantopop'),
(840, 'Enka'),
(841, 'Hong Kong English Pop'),
(842, 'Fann At-Tanbura'),
(843, 'Fijiri'),
(844, 'J-Pop'),
(845, 'Japanese Pop'),
(846, 'K-Pop'),
(847, 'Khaliji'),
(848, 'Kayōkyoku'),
(849, 'Korean Pop'),
(850, 'Liwa'),
(851, 'Mandopop'),
(852, 'Onkyokei'),
(853, 'Taiwanese Pop'),
(854, 'Sawt'),
(855, 'Australia'),
(856, 'Cajun'),
(857, 'Calypso'),
(858, 'Caribbean'),
(859, 'Chutney'),
(860, 'Chutney Soca'),
(861, 'Compas'),
(862, 'Mambo'),
(863, 'Merengue'),
(864, 'Méringue'),
(865, 'Carnatic'),
(866, 'Celtic'),
(867, 'Celtic Folk'),
(868, 'Contemporary Celtic'),
(869, 'Coupé-décalé'),
(870, 'Dangdut'),
(871, 'Drinking Songs'),
(872, 'Drone'),
(873, 'Europe'),
(874, 'France'),
(875, 'Hawaii'),
(876, 'Japan'),
(877, 'Klezmer'),
(878, 'Mbalax'),
(879, 'Middle East'),
(880, 'North America'),
(881, 'Ode'),
(882, 'Piphat'),
(883, 'Polka'),
(884, 'Soca'),
(885, 'South Africa'),
(886, 'South America'),
(887, 'South / Southeast Asia'),
(888, 'Baila'),
(889, 'Bhangra'),
(890, 'Bhojpuri'),
(891, 'Dangdut'),
(892, 'Film'),
(893, 'Filmi'),
(894, 'Indian Pop'),
(895, 'Hindustani'),
(896, 'Indian Ghazal'),
(897, 'Lavani'),
(898, 'Luk Thung'),
(899, 'Luk Krung'),
(900, 'Manila Sound'),
(901, 'Morlam'),
(902, 'Pinoy Pop'),
(903, 'Pop Sunda'),
(904, 'Ragini'),
(905, 'Thai Pop'),
(906, 'Traditional Celtic'),
(907, 'Worldbeat'),
(908, 'Zydeco'),
(909, 'Natrual'),
(910, 'Future Bass'),
(911, 'Kawaii Future Bass'),
(912, 'Bubblegum Bass'),
(913, 'Slime Punk'),
(914, 'UK Bass'),
(915, 'Euro Disco'),
(916, 'Nu Disco'),
(917, 'Post Disco'),
(918, 'Synth Punk'),
(919, 'Synthwave'),
(920, 'Vaporwave'),
(921, 'Future Funk'),
(922, 'Hardvapour'),
(923, 'Mallsoft'),
(924, 'Melodic Dubstep'),
(925, 'Bigroom'),
(926, 'Future'),
(927, 'Midtempo'),
(928, 'Classical Chinese Poetry (古风词曲)'),
(929, 'Vocaloid'),
(930, 'Chinese Vocal'),
(931, 'Classical Chinese (古风)');

-- --------------------------------------------------------

--
-- Структура таблицы `Genres`
--

CREATE TABLE IF NOT EXISTS `Genres` (
  `id` int(9) NOT NULL AUTO_INCREMENT,
  `gsid` int(9) NOT NULL,
  `gid` int(9) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `gid` (`gid`),
  KEY `gsid` (`gsid`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `Genres`
--

INSERT INTO `Genres` (`id`, `gsid`, `gid`) VALUES
(1, 1, 257),
(2, 1, 396),
(3, 1, 417),
(4, 2, 257),
(5, 2, 396),
(6, 2, 417),
(7, 3, 257),
(8, 3, 396),
(9, 3, 417);

-- --------------------------------------------------------

--
-- Структура таблицы `Playlist`
--

CREATE TABLE IF NOT EXISTS `Playlist` (
  `pid` int(9) NOT NULL AUTO_INCREMENT,
  `type` set('custom','system','special') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'custom',
  `owner_id` int(9) NOT NULL,
  `title` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `img` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `updated_at` int(10) NOT NULL,
  `created_at` int(10) NOT NULL,
  PRIMARY KEY (`pid`),
  KEY `created_at` (`created_at`),
  KEY `updated_at` (`updated_at`),
  KEY `title` (`title`),
  KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Структура таблицы `PlaylistContent`
--

CREATE TABLE IF NOT EXISTS `PlaylistContent` (
  `pcid` int(9) NOT NULL AUTO_INCREMENT,
  `pid` int(9) NOT NULL,
  `sid` int(9) NOT NULL,
  `updated_at` int(10) NOT NULL,
  `created_at` int(10) NOT NULL,
  PRIMARY KEY (`pcid`),
  KEY `pid` (`pid`),
  KEY `updated_at` (`updated_at`),
  KEY `created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Структура таблицы `Song`
--

CREATE TABLE IF NOT EXISTS `Song` (
  `sid` int(9) NOT NULL AUTO_INCREMENT,
  `aid` int(9) NOT NULL,
  `fid` int(9) NOT NULL,
  `gsid` int(9) NOT NULL,
  `owner_uid` int(9) NOT NULL,
  `title` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `subtitle` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `explicit` tinyint(1) NOT NULL,
  `duration` int(5) NOT NULL,
  `uri` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `img_1024` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `img_512` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `updated_at` int(10) NOT NULL,
  `created_at` int(10) NOT NULL,
  PRIMARY KEY (`sid`),
  KEY `artist_id` (`aid`),
  KEY `feat_id` (`fid`),
  KEY `title` (`title`),
  KEY `updated_at` (`updated_at`),
  KEY `created_at` (`created_at`),
  KEY `gsid` (`gsid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `Song`
--

INSERT INTO `Song` (`sid`, `aid`, `fid`, `gsid`, `owner_uid`, `title`, `subtitle`, `explicit`, `duration`, `uri`, `img_1024`, `img_512`, `updated_at`, `created_at`) VALUES
(1, 1, 1, 1, 1, 'Рамок Нет', '', 1, 290, '/store/cloud/albums/alid1/sid1.flac', '/store/cloud/albums/alid1/img_1024.png', '/store/cloud/albums/alid1/img_512.png', 1648311462, 1648311462),
(2, 1, 0, 2, 1, 'Жить как я живу', '', 1, 217, '/store/cloud/albums/alid1/sid2.flac', '/store/cloud/albums/alid1/img_1024.png', '/store/cloud/albums/alid1/img_512.png', 1648311462, 1648311462),
(3, 1, 0, 3, 1, 'Великолепно', 'Скит', 1, 102, '/store/cloud/albums/alid1/sid3.flac', '/store/cloud/albums/alid1/img_1024.png', '/store/cloud/albums/alid1/img_512.png', 1648311462, 1648311462);

-- --------------------------------------------------------

--
-- Структура таблицы `User`
--

CREATE TABLE IF NOT EXISTS `User` (
  `uid` int(9) NOT NULL AUTO_INCREMENT,
  `domain` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `surname` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `dateRegistration` int(10) NOT NULL,
  `dateVisit` int(10) NOT NULL,
  `platformVisit` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gender` set('male','female') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `birthday` date DEFAULT NULL,
  `avatar` varchar(512) DEFAULT NULL,
  `phone` varchar(16) DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `access` set('author','developer-verfy','developer-pool','co-author','administrator','tester-verfy','tester-default','moderator','user-verfy','user-default','none') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'user-default',
  `blocking` set('none','temporarily','forever','deleted') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'none',
  `status` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`uid`),
  UNIQUE KEY `domain` (`domain`),
  UNIQUE KEY `phone` (`phone`),
  KEY `blocking` (`blocking`),
  KEY `name` (`name`),
  KEY `surname` (`surname`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `User`
--

INSERT INTO `User` (`uid`, `domain`, `password`, `name`, `surname`, `dateRegistration`, `dateVisit`, `platformVisit`, `gender`, `birthday`, `avatar`, `phone`, `email`, `access`, `blocking`, `status`) VALUES
(1, NULL, 'ecb9d4994baf737d5bf948ad73596ba3c20cab8fbaca98daaf06ebcd8a17d891769db2c158b9c0c5e59e1194b46916ef', 'Фёдор', 'Гаранин', 1644491846, 1648224659, 'Windows', 'male', '2000-06-15', NULL, NULL, 'yesfedor.go@gmail.com', 'user-default', 'none', NULL),
(2, NULL, 'ecb9d4994baf737d5bf948ad73596ba3c20cab8fbaca98daaf06ebcd8a17d891769db2c158b9c0c5e59e1194b46916ef', 'Фёдор', 'Гаранин', 1644600092, 1645305136, 'Linux', 'male', '2000-06-15', NULL, NULL, 'fedorvladis@outlook.com', 'user-default', 'none', NULL),
(3, NULL, 'add250faf88c8910b9bdfbe70e5341d4d3bbdd759b1f13dcf91554e7297688c75fc9713dd6492b70463e0f95f362cc92', 'Владислав', 'Незванов', 1644603431, 1644603431, NULL, 'male', '2000-06-15', NULL, NULL, 'vladn803@gmail.com', 'user-default', 'none', NULL),
(4, NULL, '428603cfeed38688752197ef8ade0b7053cb8e36038d4b855403c5654070ec0f0b3280ce2294bba4b9db7ce91078e5e3', 'Игорь', 'Просви', 1644873016, 1644873016, NULL, 'male', '2000-06-15', NULL, NULL, 'pr0s1k@outlook.com', 'user-default', 'none', NULL),
(5, NULL, '428603cfeed38688752197ef8ade0b7053cb8e36038d4b855403c5654070ec0f0b3280ce2294bba4b9db7ce91078e5e3', 'Igor', 'Prosik', 1645120410, 1647037282, 'Windows', 'male', '2000-06-15', NULL, NULL, 'type19790098@gmail.com', 'user-default', 'none', NULL),
(6, NULL, '428603cfeed38688752197ef8ade0b7053cb8e36038d4b855403c5654070ec0f0b3280ce2294bba4b9db7ce91078e5e3', 'Игорь', 'Просвирнин', 1647029085, 1648314642, 'Windows', 'male', '2000-06-15', NULL, NULL, 'pr0s1k@test.ru', 'user-default', 'none', NULL),
(7, NULL, '44d7b5330453edc34e4b2375aab8c9c0f835d62dcbbc4659fff4154190d00a3f48121e99f0097149e355bf11c025d185', 'Saver', 'Prosidinahyi', 1647270841, 1647270841, NULL, 'male', '2000-06-15', NULL, NULL, 'drainbar212@gmail.com', 'user-default', 'none', NULL);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
