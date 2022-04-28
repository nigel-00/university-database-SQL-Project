-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema university
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `university` ;

-- -----------------------------------------------------
-- Schema university
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `university` DEFAULT CHARACTER SET utf8 ;
USE `university` ;

-- -----------------------------------------------------
-- Table `university`.`college`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`college` ;

CREATE TABLE IF NOT EXISTS `university`.`college` (
  `collegeId` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `collegeName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`collegeId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`department`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`department` ;

CREATE TABLE IF NOT EXISTS `university`.`department` (
  `departmentId` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `departmentName` VARCHAR(45) NOT NULL,
  `departmentCode` VARCHAR(15) NOT NULL,
  `collegeId` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`departmentId`),
  CONSTRAINT `fk_department_college`
    FOREIGN KEY (`collegeId`)
    REFERENCES `university`.`college` (`collegeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_department_college_idx` ON `university`.`department` (`collegeId` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `university`.`course`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`course` ;

CREATE TABLE IF NOT EXISTS `university`.`course` (
  `courseId` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `courseName` VARCHAR(45) NOT NULL,
  `courseNumber` INT UNSIGNED NOT NULL,
  `courseCredit` INT UNSIGNED NOT NULL,
  `departmentId` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`courseId`),
  CONSTRAINT `fk_course_department1`
    FOREIGN KEY (`departmentId`)
    REFERENCES `university`.`department` (`departmentId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_course_department1_idx` ON `university`.`course` (`departmentId` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `university`.`faculty`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`faculty` ;

CREATE TABLE IF NOT EXISTS `university`.`faculty` (
  `facultyId` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `facultyLastName` VARCHAR(45) NOT NULL,
  `facultyFirstName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`facultyId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`semester`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`semester` ;

CREATE TABLE IF NOT EXISTS `university`.`semester` (
  `semesterId` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `semesterName` VARCHAR(45) NOT NULL,
  `semesterYear` YEAR(4) NOT NULL,
  PRIMARY KEY (`semesterId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`section`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`section` ;

CREATE TABLE IF NOT EXISTS `university`.`section` (
  `sectionId` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `sectionNumber` INT UNSIGNED NOT NULL,
  `sectionCapacity` INT UNSIGNED NOT NULL,
  `courseId` INT UNSIGNED NOT NULL,
  `facultyId` INT UNSIGNED NOT NULL,
  `semesterId` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`sectionId`),
  CONSTRAINT `fk_section_course1`
    FOREIGN KEY (`courseId`)
    REFERENCES `university`.`course` (`courseId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_section_faculty1`
    FOREIGN KEY (`facultyId`)
    REFERENCES `university`.`faculty` (`facultyId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_section_semester1`
    FOREIGN KEY (`semesterId`)
    REFERENCES `university`.`semester` (`semesterId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_section_course1_idx` ON `university`.`section` (`courseId` ASC) VISIBLE;

CREATE INDEX `fk_section_faculty1_idx` ON `university`.`section` (`facultyId` ASC) VISIBLE;

CREATE INDEX `fk_section_semester1_idx` ON `university`.`section` (`semesterId` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `university`.`student`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`student` ;

CREATE TABLE IF NOT EXISTS `university`.`student` (
  `studentId` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `studentLastName` VARCHAR(45) NOT NULL,
  `studentFirstName` VARCHAR(45) NOT NULL,
  `studentGender` ENUM("M", "F") NOT NULL,
  `studentCity` VARCHAR(45) NOT NULL,
  `studentState` VARCHAR(45) NOT NULL,
  `studentDob` DATE NOT NULL,
  PRIMARY KEY (`studentId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`enrollment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`enrollment` ;

CREATE TABLE IF NOT EXISTS `university`.`enrollment` (
  `sectionId` INT UNSIGNED NOT NULL,
  `studentId` INT UNSIGNED NOT NULL,
  CONSTRAINT `fk_section_has_student_section1`
    FOREIGN KEY (`sectionId`)
    REFERENCES `university`.`section` (`sectionId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_section_has_student_student1`
    FOREIGN KEY (`studentId`)
    REFERENCES `university`.`student` (`studentId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_section_has_student_student1_idx` ON `university`.`enrollment` (`studentId` ASC) VISIBLE;

CREATE INDEX `fk_section_has_student_section1_idx` ON `university`.`enrollment` (`sectionId` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

USE university;
INSERT INTO college
(collegeName)
VALUES 
("College of Physical Science and Engineering"),
("College of Business and Communication"),
("College of Language and Letters");

INSERT INTO department
(departmentName, departmentCode, collegeId)
VALUES
("Computer Information Technology", "CIT", 1),
("Ecomonics", "ECON", 2),
("Humanities and Philosophy", "HUM", 3);

INSERT INTO course
(courseNumber, courseName, courseCredit, departmentId)
VALUES 
(111, "Intro to Databases", 3, 1),
(388, "Econometrics", 4, 2),
(150, "Micro Ecomonics", 3, 2),
(376, "Classical Heritage", 2, 3);

INSERT INTO faculty 
(facultyFirstName, facultyLastName)
VALUES 
("Marty","Morring"),
("Nate", "Nathan"),
("Ben", "Barrus"),
("John", "Jensen"),
("Bill", "Barney");

INSERT INTO semester
(semesterName, semesterYear)
VALUES 
("Fall", 2019),
("Winter", 2018);

INSERT INTO section
(sectionNumber, sectionCapacity, courseId, facultyId, semesterId)
VALUES 
(1, 30, 1, 1, 1),
(1, 50, 3, 2, 1),
(2, 50, 3, 2, 1),
(1, 35, 2, 3, 1),
(1, 30, 4, 4, 1),
(2, 30, 1, 1, 2),
(3, 35, 1, 5, 2),
(1, 50, 3, 2, 2),
(2, 50, 3, 2, 2),
(1, 30, 4, 4, 2);

INSERT INTO student 
(studentFirstName, studentLastName, studentGender, studentCity, studentState, studentDob)
VALUES 
("Paul", "Miller", "M", "Dallas", "TX", "1996-02-22" ),
("Katie", "Smith", "F", "Provo", "UT", "1995-07-22"),
("Kelly", "Jones", "F", "Provo", "UT", "1998-06-22"),
("Devon", "Merrill", "M", "Mesa", "AZ", "2000-07-22"),
("Mandy", "Murdock", "F", "Topeka", "KS", "1996-11-22"),
("Alece", "Adams", "F", "Rigby", "ID", "1997-05-22"),
("Bryce", "Carlson", "M", "Bozeman", "MT", "1997-11-22"),
("Preston", "Larson", "M", "Decatur", "TN", "1996-09-22"),
("Julia", "Madsen", "F", "Rexburg", "ID", "1998-09-22"),
("Susan", "Sorensen", "F", "Mesa", "AZ", "1998-08-09");

INSERT INTO enrollment
(sectionId, studentId)
VALUES 
(7, 6),
(6, 7), 
(8, 7),
(10, 7),
(5, 4),
(9, 9),
(4, 2),
(4, 3),
(4, 5),
(5, 5),
(1, 1),
(3, 1),
(9, 8),
(6, 10);

SET sql_mode="ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION";

-- Q1 
USE university;
SELECT studentFirstName, studentLastName, DATE_FORMAT(studentDob,"%M %d, %Y") AS "Sept Birthdays"
FROM student
WHERE  DATE_FORMAT(studentDob,"%M %d, %Y") LIKE "%September%"
ORDER BY studentLastName;

-- Q2
SELECT studentLastName, studentFirstName, FLOOR(DATEDIFF("2017-01-05", studentDob)/365) AS "Years", 
DATEDIFF("2017-01-05", studentDob) % 365 AS "Days", CONCAT(FLOOR(DATEDIFF("2017-01-05", studentDob)/365),"-Yrs",", ",
DATEDIFF("2017-01-05", studentDob) % 365,"-Days" ) AS "Years and Days"
FROM student
ORDER BY studentDob ASC;

-- Q3
SELECT studentFirstName, studentLastName
FROM  student s
INNER JOIN enrollment AS e
ON s.studentId = e.studentId 
INNER JOIN section AS se
ON e.sectionId = se.sectionId
INNER JOIN faculty AS f
ON se.facultyId = f.facultyId
WHERE f.facultyId = 4
ORDER BY studentLastName;

-- Q4
SELECT facultyFirstName, facultyLastName 
FROM faculty f
INNER JOIN section AS s 
ON f.facultyId = s.facultyId 
INNER JOIN semester AS se 
ON  s.semesterId = se.semesterId
INNER JOIN enrollment AS e 
ON s.sectionId = e.sectionId
INNER JOIN student AS st
ON e.studentId = st.studentId 
WHERE s.semesterId = 2 AND st.studentId = 7 
ORDER BY facultyLastName;

-- Q5
SELECT studentFirstName, studentLastName
FROM  student s
INNER JOIN enrollment AS e
ON s.studentId = e.studentId 
INNER JOIN section AS se
ON e.sectionId = se.sectionId
INNER JOIN course AS c
ON se.courseId = c.courseId 
WHERE  c.courseId = 2 AND se.semesterId = 1
ORDER BY studentLastName;

-- Q6
SELECT departmentCode, courseNumber AS courseNum, courseName
FROM  department AS d
INNER JOIN course AS c
ON  d.departmentId = c.departmentId 
INNER JOIN section AS s 
ON  c.courseId = s.courseId 
INNER JOIN enrollment AS e
ON  s.sectionId = e.sectionId 
INNER JOIN  student AS se
ON  e.studentId = se.studentId
WHERE se.studentId = 7 AND s.semesterId = 2
ORDER BY  courseName;

-- Q7
SELECT semesterName AS term, semesterYear, COUNT(s.studentId) AS Enrollment
FROM  student s
INNER JOIN enrollment AS e
ON  s.studentId = e.studentId 
INNER JOIN section AS se
ON e.sectionId = se.sectionId
INNER JOIN semester AS st
ON  se.semesterId = st.semesterId 
WHERE st.semesterId = 1;

-- Q8
SELECT collegeName AS colleges, COUNT(c.courseId) AS courses 
FROM college co
INNER JOIN  department AS d 
ON co.collegeId = d.collegeId
INNER JOIN course AS c 
ON  d.departmentId = c.departmentId
GROUP BY collegeName
ORDER BY collegeName;

-- Q9
SELECT  facultyFirstName, facultyLastName, SUM(sectionCapacity) AS TeachingCapacity
FROM section se
INNER JOIN  faculty AS f 
ON se.facultyId = f.facultyId
WHERE se.semesterId = 2
GROUP BY  facultyFirstName, facultyLastName
ORDER BY TeachingCapacity;

-- Q10
SELECT studentLastName, studentFirstName, SUM(courseCredit) AS Credit 
FROM student s 
INNER JOIN  enrollment AS e
ON  s.studentId = e.studentId
INNER JOIN  section AS se 
ON e.sectionId = se.sectionId 
INNER JOIN course AS c 
ON se.courseId = c.courseId
WHERE se.semesterId  = 1 
GROUP BY studentLastName, studentFirstName
HAVING Credit > 3
ORDER BY Credit DESC;
