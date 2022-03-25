-- phpMyAdmin SQL Dump
-- version 5.1.3
-- https://www.phpmyadmin.net/
--
-- Хост: localhost
-- Время создания: Мар 13 2022 г., 18:43
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
CREATE DATABASE IF NOT EXISTS `cc38255_music` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `cc38255_music`;

-- --------------------------------------------------------

--
-- Структура таблицы `Albums`
--

DROP TABLE IF EXISTS `Albums`;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Очистить таблицу перед добавлением данных `Albums`
--

TRUNCATE TABLE `Albums`;
-- --------------------------------------------------------

--
-- Структура таблицы `Applications`
--

DROP TABLE IF EXISTS `Applications`;
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
-- Очистить таблицу перед добавлением данных `Applications`
--

TRUNCATE TABLE `Applications`;
--
-- Дамп данных таблицы `Applications`
--

INSERT DELAYED IGNORE INTO `Applications` (`app_id`, `title`, `is_verified`, `owner_uid`, `secure_key`, `access_key`, `status`, `access_permission`, `domain`, `redirect_uri`, `dateRegistration`) VALUES
(1, 'INY  Music', 1, 1, '20562d0e9406380117edb77cb0e8f3b8.6086aeb20ce4b', '25e1676f52219510a0565e3c83982ebd.6086aeb20ce55', 'enabled', '[]', 'music.iny.su', '/', 1633550090);

-- --------------------------------------------------------

--
-- Структура таблицы `Artists`
--

DROP TABLE IF EXISTS `Artists`;
CREATE TABLE IF NOT EXISTS `Artists` (
  `aid` int(9) NOT NULL AUTO_INCREMENT,
  `owner_uid` int(9) NOT NULL,
  `verify` tinyint(1) NOT NULL,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `suranme` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `altname` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `img` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `keywords` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `updated_at` int(10) NOT NULL,
  `created_at` int(10) NOT NULL,
  PRIMARY KEY (`aid`),
  KEY `updated_at` (`updated_at`),
  KEY `created_at` (`created_at`),
  KEY `keywords` (`keywords`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Очистить таблицу перед добавлением данных `Artists`
--

TRUNCATE TABLE `Artists`;
-- --------------------------------------------------------

--
-- Структура таблицы `ColectionContent`
--

DROP TABLE IF EXISTS `ColectionContent`;
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

--
-- Очистить таблицу перед добавлением данных `ColectionContent`
--

TRUNCATE TABLE `ColectionContent`;
-- --------------------------------------------------------

--
-- Структура таблицы `Colections`
--

DROP TABLE IF EXISTS `Colections`;
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

--
-- Очистить таблицу перед добавлением данных `Colections`
--

TRUNCATE TABLE `Colections`;
-- --------------------------------------------------------

--
-- Структура таблицы `Devices`
--

DROP TABLE IF EXISTS `Devices`;
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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4;

--
-- Очистить таблицу перед добавлением данных `Devices`
--

TRUNCATE TABLE `Devices`;
--
-- Дамп данных таблицы `Devices`
--

INSERT DELAYED IGNORE INTO `Devices` (`id`, `client_id`, `app_id`, `platform`, `ip`, `uid`, `time`, `permission`) VALUES
(1, '243225db-bd45-429e-b28c-81a98d626d0e', 1, 'Windows', '95.24.206.64', 1, 1644491909, 'allow'),
(2, '302ebd27-fc9e-4507-82e8-db362c5cc50e', 1, 'Windows', '95.24.206.64', 2, 1645213255, 'allow'),
(3, '37aacaba-a733-4d1d-a38c-c1a12a0ed3c4', 1, 'Windows', '95.24.206.64', NULL, 1644593410, 'allow'),
(4, '8e36b426-f711-4129-a979-65559c565a69', 1, 'Windows', '95.24.206.64', 1, 1645269060, 'allow'),
(5, 'c1489b09-ffe5-4bc6-9446-5022a24a1f3d', 1, 'Android', '176.59.106.211', NULL, 1644594252, 'allow'),
(6, '6cdef932-30f9-446c-a7b8-b3cf83bb3bbc', 1, 'Android', '95.24.205.161', NULL, 1644597074, 'allow'),
(7, 'b37bd846-3d26-4283-973b-205f17758a81', 1, 'Windows', '95.24.205.161', 3, 1644603431, 'allow'),
(8, 'd937a483-87ee-4f69-8e14-5b1aa93c8dd7', 1, 'Windows', '164.177.183.14', 6, 1647037273, 'allow'),
(9, '73e6f3d9-39eb-42ce-aced-91d1c6faa65e', 1, 'Android', '85.26.232.186', NULL, 1644604414, 'allow'),
(10, 'e110c85b-80e8-4fd3-9af1-219db64b1545', 1, 'Windows', '65.154.226.165', NULL, 1644646507, 'allow'),
(11, 'cead9dd5-259b-4270-880e-29d2a428aad0', 1, 'Windows', '164.177.179.25', 5, 1647037282, 'allow'),
(12, '6ee1de60-8630-403e-ac35-05295225da76', 1, 'Linux', '95.24.206.64', 1, 1645986029, 'allow'),
(13, 'dcbc1de3-6a55-44f3-b721-25fd0c127f9e', 1, 'Linux', '95.24.206.64', 2, 1645305136, 'allow'),
(14, '33cec42b-6a2e-42a8-b845-b1b2c7ad17a7', 1, 'Linux', '95.24.206.166', NULL, 1646152720, 'allow'),
(15, 'dc9268b8-4f5e-45d4-85ad-7183c1f9baf6', 1, 'Linux', '95.24.206.166', NULL, 1646154764, 'allow'),
(16, '6fb6ab65-2eac-4637-b2d7-d43bcf825dbe', 1, 'Windows', '95.24.203.243', 1, 1647183638, 'allow'),
(17, 'c4594752-e9c9-4312-b686-9684f3c68fc4', 1, 'Windows', '95.24.203.243', 6, 1647116962, 'allow');

-- --------------------------------------------------------

--
-- Структура таблицы `Feat`
--

DROP TABLE IF EXISTS `Feat`;
CREATE TABLE IF NOT EXISTS `Feat` (
  `fid` int(9) NOT NULL AUTO_INCREMENT,
  `aid` int(9) NOT NULL,
  `position` int(2) NOT NULL,
  `updated_at` int(10) NOT NULL,
  `created_at` int(10) NOT NULL,
  PRIMARY KEY (`fid`),
  KEY `aid` (`aid`),
  KEY `updated_at` (`updated_at`),
  KEY `created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Очистить таблицу перед добавлением данных `Feat`
--

TRUNCATE TABLE `Feat`;
-- --------------------------------------------------------

--
-- Структура таблицы `Genre`
--

DROP TABLE IF EXISTS `Genre`;
CREATE TABLE IF NOT EXISTS `Genre` (
  `gid` int(11) NOT NULL AUTO_INCREMENT,
  `owner_gid` int(9) DEFAULT NULL,
  `title` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`gid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Очистить таблицу перед добавлением данных `Genre`
--

TRUNCATE TABLE `Genre`;
-- --------------------------------------------------------

--
-- Структура таблицы `Genres`
--

DROP TABLE IF EXISTS `Genres`;
CREATE TABLE IF NOT EXISTS `Genres` (
  `gsid` int(9) NOT NULL AUTO_INCREMENT,
  `gid` int(9) NOT NULL,
  PRIMARY KEY (`gsid`),
  KEY `gid` (`gid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Очистить таблицу перед добавлением данных `Genres`
--

TRUNCATE TABLE `Genres`;
-- --------------------------------------------------------

--
-- Структура таблицы `Playlist`
--

DROP TABLE IF EXISTS `Playlist`;
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

--
-- Очистить таблицу перед добавлением данных `Playlist`
--

TRUNCATE TABLE `Playlist`;
-- --------------------------------------------------------

--
-- Структура таблицы `PlaylistContent`
--

DROP TABLE IF EXISTS `PlaylistContent`;
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

--
-- Очистить таблицу перед добавлением данных `PlaylistContent`
--

TRUNCATE TABLE `PlaylistContent`;
-- --------------------------------------------------------

--
-- Структура таблицы `Song`
--

DROP TABLE IF EXISTS `Song`;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Очистить таблицу перед добавлением данных `Song`
--

TRUNCATE TABLE `Song`;
-- --------------------------------------------------------

--
-- Структура таблицы `User`
--

DROP TABLE IF EXISTS `User`;
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

--
-- Очистить таблицу перед добавлением данных `User`
--

TRUNCATE TABLE `User`;
--
-- Дамп данных таблицы `User`
--

INSERT DELAYED IGNORE INTO `User` (`uid`, `domain`, `password`, `name`, `surname`, `dateRegistration`, `dateVisit`, `platformVisit`, `gender`, `birthday`, `avatar`, `phone`, `email`, `access`, `blocking`, `status`) VALUES
(1, NULL, 'ecb9d4994baf737d5bf948ad73596ba3c20cab8fbaca98daaf06ebcd8a17d891769db2c158b9c0c5e59e1194b46916ef', 'Фёдор', 'Гаранин', 1644491846, 1647183638, 'Windows', 'male', '2000-06-15', NULL, NULL, 'yesfedor.go@gmail.com', 'user-default', 'none', NULL),
(2, NULL, 'ecb9d4994baf737d5bf948ad73596ba3c20cab8fbaca98daaf06ebcd8a17d891769db2c158b9c0c5e59e1194b46916ef', 'Фёдор', 'Гаранин', 1644600092, 1645305136, 'Linux', 'male', '2000-06-15', NULL, NULL, 'fedorvladis@outlook.com', 'user-default', 'none', NULL),
(3, NULL, 'add250faf88c8910b9bdfbe70e5341d4d3bbdd759b1f13dcf91554e7297688c75fc9713dd6492b70463e0f95f362cc92', 'Владислав', 'Незванов', 1644603431, 1644603431, NULL, 'male', '2000-06-15', NULL, NULL, 'vladn803@gmail.com', 'user-default', 'none', NULL),
(4, NULL, '428603cfeed38688752197ef8ade0b7053cb8e36038d4b855403c5654070ec0f0b3280ce2294bba4b9db7ce91078e5e3', 'Игорь', 'Просви', 1644873016, 1644873016, NULL, 'male', '2000-06-15', NULL, NULL, 'pr0s1k@outlook.com', 'user-default', 'none', NULL),
(5, NULL, '428603cfeed38688752197ef8ade0b7053cb8e36038d4b855403c5654070ec0f0b3280ce2294bba4b9db7ce91078e5e3', 'Igor', 'Prosik', 1645120410, 1647037282, 'Windows', 'male', '2000-06-15', NULL, NULL, 'type19790098@gmail.com', 'user-default', 'none', NULL),
(6, NULL, '428603cfeed38688752197ef8ade0b7053cb8e36038d4b855403c5654070ec0f0b3280ce2294bba4b9db7ce91078e5e3', 'Игорь', 'Просвирнин', 1647029085, 1647116962, 'Windows', 'male', '2000-06-15', NULL, NULL, 'pr0s1k@test.ru', 'user-default', 'none', NULL);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
