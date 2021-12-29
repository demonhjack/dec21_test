-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Дек 29 2021 г., 16:21
-- Версия сервера: 5.7.15
-- Версия PHP: 7.0.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `test_db`
--
CREATE DATABASE IF NOT EXISTS `test_db` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `test_db`;

-- --------------------------------------------------------

--
-- Структура таблицы `api_users`
--

CREATE TABLE `api_users` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `api_users`
--

INSERT INTO `api_users` (`id`, `username`, `password`) VALUES
(1, 'testuser', 'c33367701511b4f6020ec61ded352059'),
(2, 'admin', '21232f297a57a5a743894a0e4a801fc3');

-- --------------------------------------------------------

--
-- Структура таблицы `auth_tokens`
--

CREATE TABLE `auth_tokens` (
  `id` int(11) UNSIGNED NOT NULL,
  `selector` varchar(12) NOT NULL,
  `token` varchar(64) NOT NULL,
  `userid` int(11) UNSIGNED NOT NULL,
  `expires` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `students`
--

CREATE TABLE `students` (
  `id` int(11) NOT NULL,
  `login` varchar(255) NOT NULL,
  `name` varchar(1024) NOT NULL,
  `droup` varchar(255) NOT NULL DEFAULT 'Default group'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `students`
--

INSERT INTO `students` (`id`, `login`, `name`, `droup`) VALUES
(1, 'student1', 'Bernardo Santini', 'Default group'),
(2, 'student2', 'Robert Paulson', 'Default group'),
(3, 'student3', 'Sylvie Moore', 'Default group'),
(4, 'student4', 'Kirstin Hampton', 'Default group'),
(5, 'student5', 'Cheyenne Dennis', 'Default group'),
(6, 'student6', 'Mia-Rose Davie', 'Default group'),
(9, 'student7', 'Heidi Young', 'Default group'),
(10, 'student8', 'Kacey Foster', 'Default group'),
(11, 'student9', 'Kirk Vasquez', 'Default group'),
(12, 'student10', 'Saarah Maldonado', 'Default group'),
(13, 'student11', 'Libby Ridley', 'Default group'),
(14, 'student12', 'Lottie Muir', 'Default group');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `api_users`
--
ALTER TABLE `api_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Индексы таблицы `auth_tokens`
--
ALTER TABLE `auth_tokens`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `login` (`login`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `api_users`
--
ALTER TABLE `api_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT для таблицы `auth_tokens`
--
ALTER TABLE `auth_tokens`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `students`
--
ALTER TABLE `students`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
