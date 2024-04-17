CREATE DATABASE layoffs;
USE layoffs;

-- Define Database:
DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users`
(
    `id`          INT         NOT NULL AUTO_INCREMENT,                             -- user id used to identify each user in the database
    `username`    VARCHAR(25) NOT NULL,                                            -- username used to separate one suer from another
    `first_name`  TEXT        NOT NULL,                                            -- gives the user a first name allowing them to
    `middle_name` TEXT,                                                            -- optional field for the users middle name, if applicable.
    `last_name`   TEXT        NOT NULL,                                            -- family name or surname required for identification and formal communication.
    `created_at`  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,                             -- timestamp that records when the user account was created, automatically set to the current time.
    `updated_at`  TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- timestamp that records when the user account was last updated, automatically updated to the current time on modifications.
    PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `companies`;
CREATE TABLE IF NOT EXISTS `companies`
(
    `id`           INT  NOT NULL AUTO_INCREMENT,                                    -- unique identifier for each company, automatically increments with each new company added
    `name`         TEXT NOT NULL,                                                   -- The official name of the company.
    `company_size` INT  NOT NULL,                                                   -- integer representing the number of employees in the company, required for categorization and analysis.
    `created_at`   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,                             -- timestamp that records when the user account was created, automatically set to the current time.
    `updated_at`   TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- timestamp that records when the user account was last updated, automatically updated to the current time on modifications.
    PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `employments`;
CREATE TABLE IF NOT EXISTS `employments`
(
    `user_id`     INT       NOT NULL,                                              -- foreign key linking to the id in the users table, represents which user is employed.
    `company_id`  INT       NOT NULL,                                              -- foreign key linking to the id in the companies table, represents which company the user is employed at.
    `employed_at` TIMESTAMP NOT NULL,                                              -- date and time when the user started their employment at the company.
    `created_at`  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,                             -- timestamp that records when the user account was created, automatically set to the current time.
    `updated_at`  TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- timestamp that records when the user account was last updated, automatically updated to the current time on modifications.
    FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS `articles`;
CREATE TABLE IF NOT EXISTS `articles`
(
    `id`         INT  NOT NULL AUTO_INCREMENT,                                    -- unique identifier for each article, automatically increments with each new article added
    `title`      TEXT NOT NULL,                                                   -- title of the article.
    `content`    TEXT NOT NULL,                                                   -- full text content of the article.
    `user_id`    INT  NOT NULL,                                                   -- foreign key linking to the id in the users table, represents the author of the article.
    `company_id` INT  NOT NULL,                                                   -- foreign key linking to the id in the companies table, represents the company associated with the article.
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,                             -- timestamp that records when the user account was created, automatically set to the current time.
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- timestamp that records when the user account was last updated, automatically updated to the current time on modifications.
    PRIMARY KEY (`id`),
    FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS `layoffs`;
CREATE TABLE IF NOT EXISTS `layoffs`
(
    `id`             INT       NOT NULL AUTO_INCREMENT,                               -- unique identifier for each layoff event, automatically increments with each new event added. Primary key of the table.
    `company_id`     INT       NOT NULL,                                              -- foreign key linking to the id in the companies table, identifies the company that initiated the layoffs.
    `employee_count` INT       NOT NULL,                                              -- number of employees affected by the layoff.
    `reason`         TEXT      NOT NULL,                                              -- official reason or cause of the layoffs.
    `occurrence_at`  TIMESTAMP NOT NULL,                                              -- date and time when the layoffs occurred.
    `created_at`     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,                             -- timestamp that records when the user account was created, automatically set to the current time.
    `updated_at`     TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- timestamp that records when the user account was last updated, automatically updated to the current time on modifications.
    PRIMARY KEY (`id`),
    FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE
);

DROP TABLE IF EXISTS `posts`;
CREATE TABLE IF NOT EXISTS `posts`
(
    `id`             INT  NOT NULL AUTO_INCREMENT,                                    -- unique identifier for each post, automatically increments with each new post added. Primary key of the table.
    `title`          TEXT NULL,                                                       -- title of the post.
    `content`        TEXT NOT NULL,                                                   -- full text content of the post.
    `user_id`        INT  NOT NULL,                                                   -- foreign key linking to the id in the users table, represents the author of the post.
    `parent_post_id` INT  NULL,                                                       -- optional foreign key that links to another id in the posts table, allowing posts to be nested or categorized as responses to other posts.
    `event_id`       INT  NULL,                                                       -- optional foreign key linking to the id in the layoffs table, associates the post with a specific layoff event, if relevant.
    `like_count`     INT       DEFAULT 0,                                             -- integer representing the number of likes the post has received. Defaults to 0.
    `created_at`     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,                             -- timestamp that records when the user account was created, automatically set to the current time.
    `updated_at`     TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- timestamp that records when the user account was last updated, automatically updated to the current time on modifications.
    PRIMARY KEY (`id`),
    FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`parent_post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`event_id`) REFERENCES `layoffs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Insert Fake Data
INSERT INTO `users` (`id`, `username`, `first_name`, `middle_name`, `last_name`, `created_at`, `updated_at`)
VALUES (1, 'gbayliss0', 'Guillermo', NULL, 'Bayliss', '2023-06-15 00:00:00', '2023-11-16 00:00:00'),
       (2, 'aghilardi1', 'Alexi', NULL, 'Ghilardi', '2024-03-01 00:00:00', '2023-09-06 00:00:00'),
       (3, 'abatalini2', 'Allis', NULL, 'Batalini', '2024-03-03 00:00:00', '2023-04-30 00:00:00');

INSERT INTO `companies` (`id`, `name`, `company_size`, `created_at`, `updated_at`)
VALUES (1, 'Yozio', 100, '2023-06-15 00:00:00', '2023-11-16 00:00:00'),
       (2, 'Yambee', 200, '2024-03-01 00:00:00', '2023-09-06 00:00:00'),
       (3, 'Yakijo', 300, '2024-03-03 00:00:00', '2023-04-30 00:00:00'),
       (4, 'Google', 10000, '2024-03-03 00:00:00', '2023-04-30 00:00:00');

INSERT INTO `employments` (`user_id`, `company_id`, `employed_at`, `created_at`, `updated_at`)
VALUES (1, 1, '2023-06-15 00:00:00', '2023-06-15 00:00:00', '2023-06-15 00:00:00'),
       (2, 2, '2024-03-01 00:00:00', '2024-03-01 00:00:00', '2024-03-01 00:00:00'),
       (3, 3, '2024-03-03 00:00:00', '2024-03-03 00:00:00', '2024-03-03 00:00:00');

INSERT INTO `articles` (`id`, `title`, `content`, `user_id`, `company_id`, `created_at`, `updated_at`)
VALUES (1, 'Layoffs at Yozio', '<p>Yozio announces layoffs affecting 20% of workforce.</p>', 1, 1,
        '2023-06-15 00:00:00', '2023-06-15 00:00:00'),
       (2, 'Yambee Expansion', '<p>Yambee plans to open new offices in Europe.</p>', 2, 2, '2024-03-01 00:00:00',
        '2024-03-01 00:00:00'),
       (3, 'Yakijo Acquires Competitor', '<p>Yakijo completes acquisition of rival company.</p>', 3, 3,
        '2024-03-03 00:00:00', '2024-03-03 00:00:00');

INSERT INTO `layoffs` (`id`, `company_id`, `employee_count`, `reason`, `occurrence_at`, `created_at`, `updated_at`)
VALUES (1, 1, 20, 'Restructuring for efficiency', '2023-06-15 00:00:00', '2023-06-15 00:00:00', '2023-06-15 00:00:00'),
       (2, 2, 10, 'Market downturn', '2024-03-01 00:00:00', '2024-03-01 00:00:00', '2024-03-01 00:00:00'),
       (3, 3, 30, 'Strategic realignment', '2024-03-03 00:00:00', '2024-03-03 00:00:00', '2024-03-03 00:00:00');

INSERT INTO `posts` (`id`, `title`, `content`, `user_id`, `parent_post_id`, `event_id`, `like_count`, `created_at`,
                     `updated_at`)
VALUES (1, 'Response to Yozio Layoffs', '<p>As an employee at Yozio, I am deeply saddened by the recent layoffs.</p>',
        1, NULL, 1, 5, '2023-06-15 00:00:00', '2023-06-15 00:00:00'),
       (2, NULL, '<p>I share your sentiments, it is a difficult time for all of us.</p>', 2, 1, 1, 3,
        '2023-06-15 00:00:00', '2023-06-15 00:00:00'),
       (3, 'Yambee Expansion Discussion',
        '<p>Exciting news about the expansion, looking forward to new opportunities.</p>', 2, NULL, NULL, 10,
        '2024-03-01 00:00:00', '2024-03-01 00:00:00');

-- CRUD Example:

-- Persona 1:

-- Real-time layoff tracker
SELECT `id`, `name`
FROM `companies`
WHERE `name` LIKE '%Google%';

SELECT `companies`.`name`, `layoffs`.`employee_count`, `layoffs`.`reason`, `layoffs`.`occurrence_at`
FROM `companies`
JOIN `layoffs` ON `companies`.`id` = `layoffs`.`company_id`
WHERE `companies`.`id` = 4;

-- Analysis & trends
SELECT `companies`.`name`, `layoffs`.`employee_count`, `layoffs`.`reason`, `layoffs`.`occurrence_at`
FROM `companies`
JOIN `layoffs` ON `companies`.`id` = `layoffs`.`company_id`
WHERE `companies`.`id` = 4;

-- Company profiles
SELECT `id`, `name`, `company_size`
FROM `companies`
WHERE `id` = 4;

-- Community forum
CREATE VIEW `community_forum` AS
SELECT `posts`.`id`, `posts`.`title`, `posts`.`content`, `posts`.`user_id`, `posts`.`parent_post_id`, `posts`.`event_id`,
       `posts`.`like_count`, `posts`.`updated_at`
FROM `posts`
WHERE `parent_post_id` IS NULL;

-- Resource center
SELECT `id`, `title`, `content`
FROM `articles`
WHERE `company_id` = 4;

-- Persona 2:

-- Real-time layoff tracker
SELECT `companies`.`name`, `layoffs`.`employee_count`, `layoffs`.`reason`, `layoffs`.`occurrence_at`
FROM `companies`
JOIN `layoffs` ON `companies`.`id` = `layoffs`.`company_id`
ORDER BY `layoffs`.`occurrence_at` DESC
LIMIT 10;

-- Analysis & trends
SELECT `companies`.`name`, `layoffs`.`employee_count`, `layoffs`.`reason`, `layoffs`.`occurrence_at`
FROM `companies`
JOIN `layoffs` ON `companies`.`id` = `layoffs`.`company_id`
ORDER BY `layoffs`.`occurrence_at` DESC
LIMIT 10;

-- Company profiles
SELECT `id`, `name`, `company_size`
FROM `companies`
WHERE `company_size` > 1000;

-- Community forum
SELECT `id`, `title`, `content`, `user_id`, `parent_post_id`, `event_id`, `like_count`, `updated_at`
FROM `posts`
WHERE `parent_post_id` IS NULL;

-- Resource center
SELECT `id`, `title`, `content`
FROM `articles`
WHERE `company_id` = 4;

-- Persona 3:

-- Real-time layoff tracker
SELECT `companies`.`name`, `layoffs`.`employee_count`, `layoffs`.`reason`, `layoffs`.`occurrence_at`
FROM `companies`
JOIN `layoffs` ON `companies`.`id` = `layoffs`.`company_id`
ORDER BY `layoffs`.`occurrence_at` DESC
LIMIT 10;

-- Analysis & trends
SELECT `companies`.`name`, `layoffs`.`employee_count`, `layoffs`.`reason`, `layoffs`.`occurrence_at`
FROM `companies`
JOIN `layoffs` ON `companies`.`id` = `layoffs`.`company_id`
ORDER BY `layoffs`.`occurrence_at` DESC
LIMIT 10;

-- Company profiles
SELECT `id`, `name`, `company_size`
FROM `companies`
WHERE `name` = 'Google';

-- Community forum
SELECT `id`, `title`, `content`, `user_id`, `parent_post_id`, `event_id`, `like_count`, `updated_at`
FROM `posts`
WHERE `company_id` = 4;

-- Resource center
SELECT `id`, `title`, `content`
FROM `articles`
WHERE `company_id` = 4;

-- Persona 4:

-- Real-time layoff tracker
SELECT `companies`.`name`, `layoffs`.`employee_count`, `layoffs`.`reason`, `layoffs`.`occurrence_at`
FROM `companies`
JOIN `layoffs` ON `companies`.`id` = `layoffs`.`company_id`
ORDER BY `layoffs`.`occurrence_at` DESC
LIMIT 10;

-- Analysis & trends
SELECT `companies`.`name`, `layoffs`.`employee_count`, `layoffs`.`reason`, `layoffs`.`occurrence_at`
FROM `companies`
JOIN `layoffs` ON `companies`.`id` = `layoffs`.`company_id`
ORDER BY `layoffs`.`occurrence_at` DESC
LIMIT 10;

-- Company profiles
SELECT `id`, `name`, `company_size`
FROM `companies`
WHERE `name` = 'Google';

-- Community forum
SELECT `id`, `title`, `content`, `user_id`, `parent_post_id`, `event_id`, `like_count`, `updated_at`
FROM `posts`
WHERE `company_id` = 4;

-- Resource center
SELECT `id`, `title`, `content`, `updated_at`
FROM `articles`
WHERE `company_id` = 4;


-- CREATE:

-- Create a new user
INSERT INTO `users` (`username`, `first_name`, `middle_name`, `last_name`)
VALUES ('jdoe', 'John', 'Michael', 'Doe');

-- Create a new post
INSERT INTO `posts` (`title`, `content`, `user_id`, `parent_post_id`, `event_id`)
VALUES ('Response to Yakijo Acquisition',
        '<p>Exciting news for the industry, looking forward to the impact of the acquisition.</p>', 3, NULL, 3);

-- READ:

-- Read latest 10 articles
SELECT `id`, `title`, `content`, `user_id`, `company_id`, `updated_at`
FROM `articles`
ORDER BY `updated_at` DESC
LIMIT 10;

-- Search companies by name
SELECT `id`, `name`
FROM `companies`
WHERE `name` LIKE '%Y%';

-- UPDATE:

-- Update username for user 1
UPDATE `users`
SET `username` = 'johndoe'
WHERE `id` = 4;

-- DELETE:

-- Delete post with id 1
DELETE
FROM `posts`
WHERE `id` = 1;
