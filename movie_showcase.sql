-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 29, 2025 at 04:50 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `movie_showcase`
--

-- --------------------------------------------------------

--
-- Table structure for table `artists`
--

CREATE TABLE `artists` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `profile_image` varchar(255) DEFAULT NULL,
  `bio` text DEFAULT NULL,
  `tmdb_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `artists`
--

INSERT INTO `artists` (`id`, `name`, `profile_image`, `bio`, `tmdb_id`, `created_at`) VALUES
(1, 'Aaron Paul', 'uploads/profiles/aaronPaul.jpg', NULL, 84497, '2025-10-29 13:57:50'),
(2, 'Christopher Eccleston', 'uploads/profiles/cris.jpg', NULL, 20280, '2025-10-29 13:57:50'),
(3, 'David Tennant', 'uploads/profiles/davidTennant.jpg', NULL, 44071, '2025-10-29 13:57:50'),
(4, 'Matt Smith', 'uploads/profiles/mattSmith.jpg', NULL, 41439, '2025-10-29 13:57:50'),
(5, 'Michael Sheen', 'uploads/profiles/michaelSheen.jpg', NULL, 2282, '2025-10-29 13:57:50');

-- --------------------------------------------------------

--
-- Table structure for table `featured_movies`
--

CREATE TABLE `featured_movies` (
  `id` int(11) NOT NULL,
  `movie_id` int(11) NOT NULL,
  `display_order` int(11) DEFAULT 0,
  `is_active` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `featured_movies`
--

INSERT INTO `featured_movies` (`id`, `movie_id`, `display_order`, `is_active`) VALUES
(1, 1, 1, 1),
(2, 2, 2, 1),
(3, 3, 3, 1);

-- --------------------------------------------------------

--
-- Table structure for table `genres`
--

CREATE TABLE `genres` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `slug` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `genres`
--

INSERT INTO `genres` (`id`, `name`, `slug`, `created_at`) VALUES
(1, 'Adventure', 'adventure', '2025-10-29 13:57:55'),
(2, 'Crime', 'crime', '2025-10-29 13:57:55'),
(3, 'Romance', 'romance', '2025-10-29 13:57:55');

-- --------------------------------------------------------

--
-- Table structure for table `movies`
--

CREATE TABLE `movies` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `tmdb_id` int(11) DEFAULT NULL,
  `poster_url` varchar(500) DEFAULT NULL,
  `backdrop_url` varchar(500) DEFAULT NULL,
  `tmdb_url` varchar(500) DEFAULT NULL,
  `overview` text DEFAULT NULL,
  `release_date` date DEFAULT NULL,
  `rating` decimal(3,1) DEFAULT NULL CHECK (`rating` >= 0 and `rating` <= 10),
  `type` enum('movie','tv') DEFAULT 'movie',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `movies`
--

INSERT INTO `movies` (`id`, `title`, `tmdb_id`, `poster_url`, `backdrop_url`, `tmdb_url`, `overview`, `release_date`, `rating`, `type`, `created_at`) VALUES
(1, 'Doctor Who', 57243, 'pics/doctor.jpg', NULL, 'https://www.themoviedb.org/tv/57243-doctor-who', 'A British sci-fi series following the adventures of the Doctor, a Time Lord who travels through time and space to protect the universe.', '2005-03-26', 8.6, 'tv', '2025-10-29 14:47:34'),
(2, 'Doctor Who: The Day of the Doctor', 313106, 'pics/dayofthedoctor.jpg', NULL, 'https://www.themoviedb.org/movie/313106-doctor-who-the-day-of-the-doctor', 'The Doctor’s past and present collide in this 50th-anniversary special that brings together multiple incarnations of the Time Lord.', '2013-11-23', 8.3, 'movie', '2025-10-29 14:47:34'),
(3, 'Good Omens', 71915, 'pics/goodomens.jpg', NULL, 'https://www.themoviedb.org/tv/71915-good-omens', 'A demon and an angel team up to prevent the apocalypse in this fantasy comedy series based on the novel by Neil Gaiman and Terry Pratchett.', '2019-05-31', 8.1, 'tv', '2025-10-29 14:47:34'),
(8, 'Doctor Who: Season 5', NULL, 'pics/doctor5.webp', NULL, 'https://www.themoviedb.org/tv/57243-doctor-who/season/5', 'The Eleventh Doctor begins his adventures with new companion Amy Pond as they travel through time and space.', '2010-04-03', 8.5, 'tv', '2025-10-29 14:54:12'),
(9, 'Doctor Who: Season 6', NULL, 'pics/doctor6.webp', NULL, 'https://www.themoviedb.org/tv/57243-doctor-who/season/6', 'The Eleventh Doctor, Amy, and Rory face impossible mysteries and shocking revelations across time.', '2011-04-23', 8.6, 'tv', '2025-10-29 14:54:12'),
(10, 'Doctor Who: Season 7', NULL, 'pics/doctor7.webp', NULL, 'https://www.themoviedb.org/tv/57243-doctor-who/season/7', 'The Eleventh Doctor’s final adventures alongside Amy, Rory, and later Clara, leading to an epic regeneration.', '2012-09-01', 8.4, 'tv', '2025-10-29 14:54:12'),
(11, 'Breaking Bad', 1396, 'pics/bb.jpg', NULL, 'https://www.themoviedb.org/tv/1396-breaking-bad', 'A high school chemistry teacher turned methamphetamine producer partners with a former student in this acclaimed drama.', '2008-01-20', 9.5, 'tv', '2025-10-29 15:06:00'),
(12, 'El Camino: A Breaking Bad Movie', 559969, 'pics/elCamino.jpg', NULL, 'https://www.themoviedb.org/movie/559969-el-camino-a-breaking-bad-movie', 'Fugitive Jesse Pinkman runs from his captors, the law, and his past in this sequel to the Breaking Bad series.', '2019-10-11', 7.3, 'movie', '2025-10-29 15:06:00'),
(13, 'Need for Speed', 136797, 'pics/needForSpeed.jpg', NULL, 'https://www.themoviedb.org/movie/136797-need-for-speed', 'Fresh from prison, a street racer joins a cross-country race with revenge in mind against a wealthy former business partner.', '2014-03-13', 6.5, 'movie', '2025-10-29 15:06:00'),
(28, 'Doctor Who: Season 1', NULL, 'pics/doctor1.webp', NULL, 'https://www.themoviedb.org/tv/57243-doctor-who/season/1', 'The Doctor begins a new era of adventures alongside Rose Tyler as they travel across time and space.', '2005-03-26', 8.6, 'tv', '2025-10-29 15:34:35'),
(29, 'Doctor Who: Season 2', NULL, 'pics/doctor2.webp', NULL, 'https://www.themoviedb.org/tv/57243-doctor-who/season/2', 'The Tenth Doctor continues his travels with Rose Tyler, facing Daleks, Cybermen, and heartbreak.', '2006-04-15', 8.5, 'tv', '2025-10-29 15:34:35'),
(30, 'Doctor Who: Season 3', NULL, 'pics/doctor3.webp', NULL, 'https://www.themoviedb.org/tv/57243-doctor-who/season/3', 'The Doctor teams up with new companion Martha Jones as they encounter alien threats and mysteries.', '2007-03-31', 8.4, 'tv', '2025-10-29 15:34:35'),
(31, 'Doctor Who: Season 4', NULL, 'pics/doctor4.webp', NULL, 'https://www.themoviedb.org/tv/57243-doctor-who/season/4', 'Donna Noble joins the Doctor for adventures filled with laughter, danger, and emotional goodbyes.', '2008-04-05', 8.6, 'tv', '2025-10-29 15:34:35'),
(32, 'Doctor Who: Season 8', NULL, 'pics/doctor8.webp', NULL, 'https://www.themoviedb.org/tv/57243-doctor-who/season/8', 'The Twelfth Doctor begins his journey, questioning his own identity and morality with Clara at his side.', '2014-08-23', 8.2, 'tv', '2025-10-29 15:34:35'),
(33, 'Doctor Who: Season 9', NULL, 'pics/doctor9.webp', NULL, 'https://www.themoviedb.org/tv/57243-doctor-who/season/9', 'The Doctor and Clara embark on epic adventures filled with danger, sacrifice, and emotional depth.', '2015-09-19', 8.3, 'tv', '2025-10-29 15:34:35'),
(34, 'Doctor Who: Season 10', NULL, 'pics/doctor10.webp', NULL, 'https://www.themoviedb.org/tv/57243-doctor-who/season/10', 'The Doctor takes on new companion Bill Potts as they uncover secrets that will change everything.', '2017-04-15', 8.1, 'tv', '2025-10-29 15:34:35'),
(35, 'Doctor Who: Season 11', NULL, 'pics/doctor11.webp', NULL, 'https://www.themoviedb.org/tv/57243-doctor-who/season/11', 'The Thirteenth Doctor debuts with a new team of friends on thrilling journeys across time and space.', '2018-10-07', 7.9, 'tv', '2025-10-29 15:34:35'),
(36, 'Doctor Who: Season 12', NULL, 'pics/doctor12.webp', NULL, 'https://www.themoviedb.org/tv/57243-doctor-who/season/12', 'The Thirteenth Doctor and her friends face shocking revelations about the Time Lords and her own past.', '2020-01-01', 7.8, 'tv', '2025-10-29 15:34:35'),
(37, 'Doctor Who: Season 13', NULL, 'pics/doctor13.webp', NULL, 'https://www.themoviedb.org/tv/57243-doctor-who/season/13', 'The Thirteenth Doctor battles a universe-wide threat known as the Flux in her most dangerous mission yet.', '2021-10-31', 7.9, 'tv', '2025-10-29 15:34:35');

-- --------------------------------------------------------

--
-- Table structure for table `movie_artists`
--

CREATE TABLE `movie_artists` (
  `id` int(11) NOT NULL,
  `movie_id` int(11) NOT NULL,
  `artist_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `movie_artists`
--

INSERT INTO `movie_artists` (`id`, `movie_id`, `artist_id`) VALUES
(5, 1, 4),
(1, 2, 4),
(4, 8, 4),
(3, 9, 4),
(2, 10, 4),
(8, 11, 1),
(6, 12, 1),
(7, 13, 1);

-- --------------------------------------------------------

--
-- Table structure for table `movie_genres`
--

CREATE TABLE `movie_genres` (
  `id` int(11) NOT NULL,
  `movie_id` int(11) NOT NULL,
  `genre_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `movie_genres`
--

INSERT INTO `movie_genres` (`id`, `movie_id`, `genre_id`) VALUES
(15, 1, 1),
(16, 8, 1),
(17, 11, 2),
(18, 12, 2);

-- --------------------------------------------------------

--
-- Table structure for table `profile`
--

CREATE TABLE `profile` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `role` varchar(255) DEFAULT NULL,
  `age` int(11) DEFAULT NULL CHECK (`age` > 0),
  `education` varchar(255) DEFAULT NULL,
  `bio` text DEFAULT NULL,
  `profile_image` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `profile`
--

INSERT INTO `profile` (`id`, `name`, `role`, `age`, `education`, `bio`, `profile_image`, `created_at`) VALUES
(1, 'Hans Michael D. Gabor', 'Web Developer | Programmer', 20, 'BSIT 3A', 'I am making this portfolio to feature my favorite artists and the movies and series they are part of. Join me as I explore the captivating performances and unforgettable stories brought to life by these talented artists.\r\n\r\nThis was portfolio last year and i well reusing this to integrate with database Movie API and others.', 'uploads/profiles/me.jpg', '2025-10-29 13:57:50');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `artists`
--
ALTER TABLE `artists`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tmdb_id` (`tmdb_id`);

--
-- Indexes for table `featured_movies`
--
ALTER TABLE `featured_movies`
  ADD PRIMARY KEY (`id`),
  ADD KEY `movie_id` (`movie_id`);

--
-- Indexes for table `genres`
--
ALTER TABLE `genres`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Indexes for table `movies`
--
ALTER TABLE `movies`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tmdb_id` (`tmdb_id`);

--
-- Indexes for table `movie_artists`
--
ALTER TABLE `movie_artists`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_movie_artist` (`movie_id`,`artist_id`),
  ADD KEY `artist_id` (`artist_id`);

--
-- Indexes for table `movie_genres`
--
ALTER TABLE `movie_genres`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_movie_genre` (`movie_id`,`genre_id`),
  ADD KEY `genre_id` (`genre_id`);

--
-- Indexes for table `profile`
--
ALTER TABLE `profile`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `artists`
--
ALTER TABLE `artists`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `featured_movies`
--
ALTER TABLE `featured_movies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `genres`
--
ALTER TABLE `genres`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `movies`
--
ALTER TABLE `movies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `movie_artists`
--
ALTER TABLE `movie_artists`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `movie_genres`
--
ALTER TABLE `movie_genres`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `profile`
--
ALTER TABLE `profile`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `featured_movies`
--
ALTER TABLE `featured_movies`
  ADD CONSTRAINT `featured_movies_ibfk_1` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `movie_artists`
--
ALTER TABLE `movie_artists`
  ADD CONSTRAINT `movie_artists_ibfk_1` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `movie_artists_ibfk_2` FOREIGN KEY (`artist_id`) REFERENCES `artists` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `movie_genres`
--
ALTER TABLE `movie_genres`
  ADD CONSTRAINT `movie_genres_ibfk_1` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `movie_genres_ibfk_2` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
