-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 03, 2024 at 08:28 AM
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
-- Database: `dt3`
--
CREATE DATABASE IF NOT EXISTS `dt3` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `dt3`;

-- --------------------------------------------------------

--
-- Table structure for table `answer`
--

CREATE TABLE `answer` (
  `Answer_ID` int(11) NOT NULL,
  `Question_ID` int(11) DEFAULT NULL,
  `Answer_Text` text DEFAULT NULL,
  `Answer_Number` varchar(255) DEFAULT NULL,
  `Answer_Choice` varchar(255) DEFAULT NULL,
  `Answer_StartDate` datetime DEFAULT NULL,
  `Answer_EndDate` datetime DEFAULT NULL,
  `Answer_StartTime` time DEFAULT NULL,
  `Answer_EndTime` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `answer`
--

INSERT INTO `answer` (`Answer_ID`, `Question_ID`, `Answer_Text`, `Answer_Number`, `Answer_Choice`, `Answer_StartDate`, `Answer_EndDate`, `Answer_StartTime`, `Answer_EndTime`) VALUES
(1, 1, NULL, NULL, 'Red', NULL, NULL, NULL, NULL),
(2, 1, NULL, NULL, 'Blue', NULL, NULL, NULL, NULL),
(3, 1, NULL, NULL, 'Green', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `question`
--

CREATE TABLE `question` (
  `Question_ID` int(11) NOT NULL,
  `Question_Text` text DEFAULT NULL,
  `Question_Type` varchar(255) DEFAULT NULL,
  `Question_Order` varchar(255) DEFAULT NULL,
  `Question_Requirement` varchar(255) DEFAULT NULL,
  `Question_Instructions` varchar(255) DEFAULT NULL,
  `Question_AnswerChoices` varchar(255) DEFAULT NULL,
  `Question_DefaultAnswer` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `question`
--

INSERT INTO `question` (`Question_ID`, `Question_Text`, `Question_Type`, `Question_Order`, `Question_Requirement`, `Question_Instructions`, `Question_AnswerChoices`, `Question_DefaultAnswer`) VALUES
(1, 'What is your favorite color?', NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `rule`
--

CREATE TABLE `rule` (
  `Rule_ID` int(11) NOT NULL,
  `Question_ID` int(11) DEFAULT NULL,
  `Rule_Description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `survey`
--

CREATE TABLE `survey` (
  `Survey_ID` int(11) NOT NULL,
  `Survey_Name` varchar(255) DEFAULT NULL,
  `Survey_Description` varchar(255) DEFAULT NULL,
  `Survey_Status` varchar(255) DEFAULT NULL,
  `Survey_Target_Audience` varchar(255) DEFAULT NULL,
  `Survey_EstimatedCompletionTime` time DEFAULT NULL,
  `Surevy_Language` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `survey_answer_question`
--

CREATE TABLE `survey_answer_question` (
  `Survey_ID` int(11) NOT NULL,
  `Question_ID` int(11) NOT NULL,
  `Survey_StartDate` datetime DEFAULT NULL,
  `Survey_EndDate` datetime DEFAULT NULL,
  `Survey_StartTime` time DEFAULT NULL,
  `Survey_EndTime` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `answer`
--
ALTER TABLE `answer`
  ADD PRIMARY KEY (`Answer_ID`),
  ADD KEY `Question_ID` (`Question_ID`);

--
-- Indexes for table `question`
--
ALTER TABLE `question`
  ADD PRIMARY KEY (`Question_ID`);

--
-- Indexes for table `rule`
--
ALTER TABLE `rule`
  ADD PRIMARY KEY (`Rule_ID`),
  ADD KEY `Question_ID` (`Question_ID`);

--
-- Indexes for table `survey`
--
ALTER TABLE `survey`
  ADD PRIMARY KEY (`Survey_ID`);

--
-- Indexes for table `survey_answer_question`
--
ALTER TABLE `survey_answer_question`
  ADD PRIMARY KEY (`Survey_ID`,`Question_ID`),
  ADD KEY `Question_ID` (`Question_ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `answer`
--
ALTER TABLE `answer`
  MODIFY `Answer_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `question`
--
ALTER TABLE `question`
  MODIFY `Question_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `rule`
--
ALTER TABLE `rule`
  MODIFY `Rule_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `survey`
--
ALTER TABLE `survey`
  MODIFY `Survey_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `answer`
--
ALTER TABLE `answer`
  ADD CONSTRAINT `answer_ibfk_1` FOREIGN KEY (`Question_ID`) REFERENCES `question` (`Question_ID`);

--
-- Constraints for table `rule`
--
ALTER TABLE `rule`
  ADD CONSTRAINT `rule_ibfk_1` FOREIGN KEY (`Question_ID`) REFERENCES `question` (`Question_ID`);

--
-- Constraints for table `survey_answer_question`
--
ALTER TABLE `survey_answer_question`
  ADD CONSTRAINT `survey_answer_question_ibfk_1` FOREIGN KEY (`Survey_ID`) REFERENCES `survey` (`Survey_ID`),
  ADD CONSTRAINT `survey_answer_question_ibfk_2` FOREIGN KEY (`Question_ID`) REFERENCES `question` (`Question_ID`);
COMMIT;

-- Add new table for survey question rules
CREATE TABLE `survey_question_rule` (
 `Rule_ID` int(11) NOT NULL,
 `Question_ID` int(11) NOT NULL,
 `Next_Question_ID_If_Yes` int(11) DEFAULT NULL,
 `Next_Question_ID_If_No` int(11) DEFAULT NULL,
 PRIMARY KEY (`Rule_ID`),
 FOREIGN KEY (`Question_ID`) REFERENCES `question` (`Question_ID`),
 FOREIGN KEY (`Next_Question_ID_If_Yes`) REFERENCES `question` (`Question_ID`),
 FOREIGN KEY (`Next_Question_ID_If_No`) REFERENCES `question` (`Question_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Modify existing rule table to include Next_Question_ID
ALTER TABLE `rule`
 ADD COLUMN `Next_Question_ID` int(11) DEFAULT NULL,
 ADD FOREIGN KEY (`Next_Question_ID`) REFERENCES `question` (`Question_ID`);

-- Insert rules for survey questions
INSERT INTO `survey_question_rule` (`Rule_ID`, `Question_ID`, `Next_Question_ID_If_Yes`, `Next_Question_ID_If_No`)
VALUES
(1, 1, 2, 3); -- If answer to Question 1 is Yes, go to Question 2, else go to Question 3

-- Update existing rules in the `rule` table with Next_Question_ID
UPDATE `rule` SET `Next_Question_ID` = 0 WHERE `Rule_ID` = 1; -- No next question for the existing rule


/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
