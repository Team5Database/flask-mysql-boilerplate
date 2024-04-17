CREATE
DATABASE layoffs;
USE
layoffs;

-- Define Database:
DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users`
(
    `id`
    INT
    NOT
    NULL
    AUTO_INCREMENT, -- user id used to identify each user in the database
    `username`
    VARCHAR
(
    25
) NOT NULL, -- username used to separate one suer from another
    `first_name` TEXT NOT NULL, -- gives the user a first name allowing them to
    `middle_name` TEXT, -- optional field for the users middle name, if applicable.
    `last_name` TEXT NOT NULL, -- family name or surname required for identification and formal communication.
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- timestamp that records when the user account was created, automatically set to the current time.
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    ON UPDATE CURRENT_TIMESTAMP, -- timestamp that records when the user account was last updated, automatically updated to the current time on modifications.
    PRIMARY KEY
(
    `id`
)
    );

DROP TABLE IF EXISTS `companies`;
CREATE TABLE IF NOT EXISTS `companies`
(
    `id`
    INT
    NOT
    NULL
    AUTO_INCREMENT,    -- unique identifier for each company, automatically increments with each new company added
    `name`
    TEXT
    NOT
    NULL,              -- The official name of the company.
    `company_size`
    INT
    NOT
    NULL,              -- integer representing the number of employees in the company, required for categorization and analysis.
    `created_at`
    TIMESTAMP
    DEFAULT
    CURRENT_TIMESTAMP, -- timestamp that records when the user account was created, automatically set to the current time.
    `updated_at`
    TIMESTAMP
    DEFAULT
    CURRENT_TIMESTAMP
    ON
    UPDATE
    CURRENT_TIMESTAMP, -- timestamp that records when the user account was last updated, automatically updated to the current time on modifications.
    PRIMARY
    KEY
(
    `id`
)
    );

DROP TABLE IF EXISTS `employments`;
CREATE TABLE IF NOT EXISTS `employments`
(
    `user_id`
    INT
    NOT
    NULL,              -- foreign key linking to the id in the users table, represents which user is employed.
    `company_id`
    INT
    NOT
    NULL,              -- foreign key linking to the id in the companies table, represents which company the user is employed at.
    `employed_at`
    TIMESTAMP
    NOT
    NULL,              -- date and time when the user started their employment at the company.
    `created_at`
    TIMESTAMP
    DEFAULT
    CURRENT_TIMESTAMP, -- timestamp that records when the user account was created, automatically set to the current time.
    `updated_at`
    TIMESTAMP
    DEFAULT
    CURRENT_TIMESTAMP
    ON
    UPDATE
    CURRENT_TIMESTAMP, -- timestamp that records when the user account was last updated, automatically updated to the current time on modifications.
    FOREIGN
    KEY
(
    `user_id`
) REFERENCES `users`
(
    `id`
) ON DELETE CASCADE
  ON UPDATE CASCADE,
    FOREIGN KEY
(
    `company_id`
) REFERENCES `companies`
(
    `id`
)
  ON DELETE CASCADE
  ON UPDATE CASCADE
    );

DROP TABLE IF EXISTS `articles`;
CREATE TABLE IF NOT EXISTS `articles`
(
    `id`
    INT
    NOT
    NULL
    AUTO_INCREMENT,    -- unique identifier for each article, automatically increments with each new article added
    `title`
    TEXT
    NOT
    NULL,              -- title of the article.
    `content`
    TEXT
    NOT
    NULL,              -- full text content of the article.
    `user_id`
    INT
    NOT
    NULL,              -- foreign key linking to the id in the users table, represents the author of the article.
    `company_id`
    INT
    NOT
    NULL,              -- foreign key linking to the id in the companies table, represents the company associated with the article.
    `created_at`
    TIMESTAMP
    DEFAULT
    CURRENT_TIMESTAMP, -- timestamp that records when the user account was created, automatically set to the current time.
    `updated_at`
    TIMESTAMP
    DEFAULT
    CURRENT_TIMESTAMP
    ON
    UPDATE
    CURRENT_TIMESTAMP, -- timestamp that records when the user account was last updated, automatically updated to the current time on modifications.
    PRIMARY
    KEY
(
    `id`
),
    FOREIGN KEY
(
    `user_id`
) REFERENCES `users`
(
    `id`
) ON DELETE CASCADE
  ON UPDATE CASCADE,
    FOREIGN KEY
(
    `company_id`
) REFERENCES `companies`
(
    `id`
)
  ON DELETE CASCADE
  ON UPDATE CASCADE
    );

DROP TABLE IF EXISTS `layoffs`;
CREATE TABLE IF NOT EXISTS `layoffs`
(
    `id`
    INT
    NOT
    NULL
    AUTO_INCREMENT,    -- unique identifier for each layoff event, automatically increments with each new event added. Primary key of the table.
    `company_id`
    INT
    NOT
    NULL,              -- foreign key linking to the id in the companies table, identifies the company that initiated the layoffs.
    `employee_count`
    INT
    NOT
    NULL,              -- number of employees affected by the layoff.
    `reason`
    TEXT
    NOT
    NULL,              -- official reason or cause of the layoffs.
    `occurrence_at`
    TIMESTAMP
    NOT
    NULL,              -- date and time when the layoffs occurred.
    `created_at`
    TIMESTAMP
    DEFAULT
    CURRENT_TIMESTAMP, -- timestamp that records when the user account was created, automatically set to the current time.
    `updated_at`
    TIMESTAMP
    DEFAULT
    CURRENT_TIMESTAMP
    ON
    UPDATE
    CURRENT_TIMESTAMP, -- timestamp that records when the user account was last updated, automatically updated to the current time on modifications.
    PRIMARY
    KEY
(
    `id`
),
    FOREIGN KEY
(
    `company_id`
) REFERENCES `companies`
(
    `id`
) ON DELETE CASCADE
    );

DROP TABLE IF EXISTS `posts`;
CREATE TABLE IF NOT EXISTS `posts`
(
    `id`
    INT
    NOT
    NULL
    AUTO_INCREMENT,    -- unique identifier for each post, automatically increments with each new post added. Primary key of the table.
    `title`
    TEXT
    NULL,              -- title of the post.
    `content`
    TEXT
    NOT
    NULL,              -- full text content of the post.
    `user_id`
    INT
    NOT
    NULL,              -- foreign key linking to the id in the users table, represents the author of the post.
    `parent_post_id`
    INT
    NULL,              -- optional foreign key that links to another id in the posts table, allowing posts to be nested or categorized as responses to other posts.
    `event_id`
    INT
    NULL,              -- optional foreign key linking to the id in the layoffs table, associates the post with a specific layoff event, if relevant.
    `like_count`
    INT
    DEFAULT
    0,                 -- integer representing the number of likes the post has received. Defaults to 0.
    `created_at`
    TIMESTAMP
    DEFAULT
    CURRENT_TIMESTAMP, -- timestamp that records when the user account was created, automatically set to the current time.
    `updated_at`
    TIMESTAMP
    DEFAULT
    CURRENT_TIMESTAMP
    ON
    UPDATE
    CURRENT_TIMESTAMP, -- timestamp that records when the user account was last updated, automatically updated to the current time on modifications.
    PRIMARY
    KEY
(
    `id`
),
    FOREIGN KEY
(
    `user_id`
) REFERENCES `users`
(
    `id`
) ON DELETE CASCADE
  ON UPDATE CASCADE,
    FOREIGN KEY
(
    `parent_post_id`
) REFERENCES `posts`
(
    `id`
)
  ON DELETE CASCADE
  ON UPDATE CASCADE,
    FOREIGN KEY
(
    `event_id`
) REFERENCES `layoffs`
(
    `id`
)
  ON DELETE CASCADE
  ON UPDATE CASCADE
    );

-- Insert Fake Data
INSERT INTO `users` (`id`, `username`, `first_name`, `middle_name`, `last_name`, `created_at`, `updated_at`)
VALUES (1, 'gbayliss0', 'Guillermo', NULL, 'Bayliss', '2023-06-15 00:00:00', '2023-11-16 00:00:00'),
       (2, 'aghilardi1', 'Alexi', NULL, 'Ghilardi', '2024-03-01 00:00:00', '2023-09-06 00:00:00'),
       (3, 'abatalini2', 'Allis', NULL, 'Batalini', '2024-03-03 00:00:00', '2023-04-30 00:00:00'),
       (4, 'jdoe', 'John', 'Michael', 'Doe', '2024-03-03 00:00:00', '2023-04-30 00:00:00'),
       (5, 'eallen4', 'Evelyn', 'Marie', 'Allen', '2023-06-16 00:00:00', '2023-11-17 00:00:00'),
       (6, 'fbarrett5', 'Frank', 'Joseph', 'Barrett', '2023-06-17 00:00:00', '2023-11-18 00:00:00'),
       (7, 'gcarson6', 'Grace', 'Anne', 'Carson', '2023-06-18 00:00:00', '2023-11-19 00:00:00'),
       (8, 'hdenver7', 'Henry', 'Lee', 'Denver', '2023-06-19 00:00:00', '2023-11-20 00:00:00'),
       (9, 'iellis8', 'Isaac', 'George', 'Ellis', '2023-06-20 00:00:00', '2023-11-21 00:00:00'),
       (10, 'jfranklin9', 'Julia', 'May', 'Franklin', '2023-06-21 00:00:00', '2023-11-22 00:00:00'),
       (11, 'kgreen10', 'Kevin', 'Ray', 'Green', '2023-06-22 00:00:00', '2023-11-23 00:00:00'),
       (12, 'lharper11', 'Laura', 'Beth', 'Harper', '2023-06-23 00:00:00', '2023-11-24 00:00:00'),
       (13, 'mjenkins12', 'Molly', 'Claire', 'Jenkins', '2023-06-24 00:00:00', '2023-11-25 00:00:00'),
       (14, 'nkelley13', 'Nathan', 'Paul', 'Kelley', '2023-06-25 00:00:00', '2023-11-26 00:00:00'),
       (15, 'oanderson14', 'Olivia', 'Grace', 'Anderson', '2023-06-26 00:00:00', '2023-11-27 00:00:00'),
       (16, 'pbailey15', 'Peter', 'James', 'Bailey', '2023-06-27 00:00:00', '2023-11-28 00:00:00'),
       (17, 'qcooper16', 'Quinn', 'Alexander', 'Cooper', '2023-06-28 00:00:00', '2023-11-29 00:00:00'),
       (18, 'rdrake17', 'Rachel', 'Lynn', 'Drake', '2023-06-29 00:00:00', '2023-11-30 00:00:00'),
       (19, 'sevans18', 'Scott', 'Edward', 'Evans', '2023-06-30 00:00:00', '2023-12-01 00:00:00'),
       (20, 'tford19', 'Tina', 'Marie', 'Ford', '2023-07-01 00:00:00', '2023-12-02 00:00:00'),
       (21, 'ugriffin20', 'Ulysses', 'Grant', 'Griffin', '2023-07-02 00:00:00', '2023-12-03 00:00:00'),
       (22, 'vholt21', 'Vera', 'Catherine', 'Holt', '2023-07-03 00:00:00', '2023-12-04 00:00:00'),
       (23, 'wirwin22', 'Walter', 'Neil', 'Irwin', '2023-07-04 00:00:00', '2023-12-05 00:00:00'),
       (24, 'xjackson23', 'Xavier', 'Lee', 'Jackson', '2023-07-05 00:00:00', '2023-12-06 00:00:00'),
       (25, 'ykim24', 'Yvonne', 'Soo', 'Kim', '2023-07-06 00:00:00', '2023-12-07 00:00:00'),
       (26, 'zlawson25', 'Zachary', 'Thomas', 'Lawson', '2023-07-07 00:00:00', '2023-12-08 00:00:00'),
       (27, 'amartin26', 'Amelia', 'Rose', 'Martin', '2023-07-08 00:00:00', '2023-12-09 00:00:00'),
       (28, 'bnolan27', 'Brett', 'Michael', 'Nolan', '2023-07-09 00:00:00', '2023-12-10 00:00:00'),
       (29, 'coleman28', 'Cynthia', 'Ann', 'Coleman', '2023-07-10 00:00:00', '2023-12-11 00:00:00'),
       (30, 'dperry29', 'Dylan', 'Scott', 'Perry', '2023-07-11 00:00:00', '2023-12-12 00:00:00'),
       (31, 'equinn30', 'Ella', 'Grace', 'Quinn', '2023-07-12 00:00:00', '2023-12-13 00:00:00'),
       (32, 'froberts31', 'Fiona', 'Marie', 'Roberts', '2023-07-13 00:00:00', '2023-12-14 00:00:00'),
       (33, 'gsanders32', 'George', 'Alan', 'Sanders', '2023-07-14 00:00:00', '2023-12-15 00:00:00'),
       (34, 'htaylor33', 'Hannah', 'Joy', 'Taylor', '2023-07-15 00:00:00', '2023-12-16 00:00:00'),
       (35, 'ijones34', 'Isaac', 'David', 'Jones', '2023-07-16 00:00:00', '2023-12-17 00:00:00'),
       (46, 'tthompson45', 'Tara', 'Lynn', 'Thompson', '2023-07-27 00:00:00', '2023-12-28 00:00:00'),
       (47, 'uunderwood46', 'Uriah', 'Keith', 'Underwood', '2023-07-28 00:00:00', '2023-12-29 00:00:00'),
       (48, 'vvasquez47', 'Victor', 'Allen', 'Vasquez', '2023-07-29 00:00:00', '2023-12-30 00:00:00'),
       (49, 'wwagner48', 'Wendy', 'Beth', 'Wagner', '2023-07-30 00:00:00', '2023-12-31 00:00:00'),
       (50, 'xxu49', 'Xenia', 'Dawn', 'Xu', '2023-07-31 00:00:00', '2024-01-01 00:00:00'),
       (51, 'yyoung50', 'Yolanda', 'Faye', 'Young', '2023-08-01 00:00:00', '2024-01-02 00:00:00'),
       (52, 'zzimmerman51', 'Zach', 'Eli', 'Zimmerman', '2023-08-02 00:00:00', '2024-01-03 00:00:00'),
       (53, 'aanderson52', 'Aaron', 'Joel', 'Anderson', '2023-08-03 00:00:00', '2024-01-04 00:00:00'),
       (54, 'bbarnes53', 'Brianna', 'Kay', 'Barnes', '2023-08-04 00:00:00', '2024-01-05 00:00:00'),
       (55, 'cclark54', 'Carter', 'Lee', 'Clark', '2023-08-05 00:00:00', '2024-01-06 00:00:00'),
       (56, 'ddavis55', 'Diana', 'Marie', 'Davis', '2023-08-06 00:00:00', '2024-01-07 00:00:00'),
       (57, 'eedwards56', 'Elijah', 'James', 'Edwards', '2023-08-07 00:00:00', '2024-01-08 00:00:00'),
       (58, 'ffoster57', 'Faith', 'Ann', 'Foster', '2023-08-08 00:00:00', '2024-01-09 00:00:00'),
       (59, 'ggarcia58', 'Gabriel', 'Luis', 'Garcia', '2023-08-09 00:00:00', '2024-01-10 00:00:00'),
       (60, 'hhill59', 'Haley', 'Nicole', 'Hill', '2023-08-10 00:00:00', '2024-01-11 00:00:00');

INSERT INTO `companies` (`id`, `name`, `company_size`, `created_at`, `updated_at`)
VALUES (1, 'Yozio', 100, '2023-06-15 00:00:00', '2023-11-16 00:00:00'),
       (2, 'Yambee', 200, '2024-03-01 00:00:00', '2023-09-06 00:00:00'),
       (3, 'Yakijo', 300, '2024-03-03 00:00:00', '2023-04-30 00:00:00'),
       (4, 'Google', 10000, '2024-03-03 00:00:00', '2023-04-30 00:00:00'),
       (5, 'Zapster', 150, '2023-07-01 00:00:00', '2023-12-01 00:00:00'),
       (6, 'Twinder', 250, '2023-08-02 00:00:00', '2023-12-02 00:00:00'),
       (7, 'Kanoodle', 350, '2023-09-03 00:00:00', '2023-12-03 00:00:00'),
       (8, 'Chatterbridge', 450, '2023-10-04 00:00:00', '2023-12-04 00:00:00'),
       (9, 'Thoughtmix', 550, '2023-11-05 00:00:00', '2023-12-05 00:00:00'),
       (10, 'Wordify', 650, '2023-12-06 00:00:00', '2023-12-06 00:00:00'),
       (11, 'Buzzdog', 750, '2024-01-07 00:00:00', '2024-01-07 00:00:00'),
       (12, 'Flipopia', 850, '2024-02-08 00:00:00', '2024-02-08 00:00:00'),
       (13, 'Youtags', 950, '2024-03-09 00:00:00', '2024-03-09 00:00:00'),
       (14, 'Realpoint', 1050, '2024-04-10 00:00:00', '2024-04-10 00:00:00'),
       (15, 'Jabbercube', 1150, '2024-05-11 00:00:00', '2024-05-11 00:00:00'),
       (16, 'Browsedrive', 1250, '2024-06-12 00:00:00', '2024-06-12 00:00:00'),
       (17, 'Blognation', 1350, '2024-07-13 00:00:00', '2024-07-13 00:00:00'),
       (18, 'Zoomcast', 1450, '2024-08-14 00:00:00', '2024-08-14 00:00:00'),
       (19, 'Twitternation', 1550, '2024-09-15 00:00:00', '2024-09-15 00:00:00'),
       (20, 'Voomm', 1650, '2024-10-16 00:00:00', '2024-10-16 00:00:00'),
       (21, 'Linklinks', 1750, '2024-01-17 00:00:00', '2024-01-17 00:00:00'),
       (22, 'Skyble', 1850, '2024-01-18 00:00:00', '2024-01-18 00:00:00'),
       (23, 'Tagfeed', 1950, '2024-01-19 00:00:00', '2024-01-19 00:00:00'),
       (24, 'Realbuzz', 2050, '2024-01-20 00:00:00', '2024-01-20 00:00:00'),
       (25, 'Eimbee', 2150, '2024-01-21 00:00:00', '2024-01-21 00:00:00'),
       (26, 'Trudeo', 2250, '2024-01-22 00:00:00', '2024-01-22 00:00:00'),
       (27, 'Blogtags', 2350, '2024-01-23 00:00:00', '2024-01-23 00:00:00'),
       (28, 'Riffpedia', 2450, '2024-01-24 00:00:00', '2024-01-24 00:00:00'),
       (29, 'Quimm', 2550, '2024-01-25 00:00:00', '2024-01-25 00:00:00'),
       (30, 'Browsezoom', 2650, '2024-01-26 00:00:00', '2024-01-26 00:00:00'),
       (31, 'Yabox', 2750, '2024-01-27 00:00:00', '2024-01-27 00:00:00'),
       (32, 'Shufflebeat', 2850, '2024-01-28 00:00:00', '2024-01-28 00:00:00'),
       (33, 'Zoomzone', 2950, '2024-01-29 00:00:00', '2024-01-29 00:00:00'),
       (34, 'Feednation', 3050, '2024-01-30 00:00:00', '2024-01-30 00:00:00'),
       (35, 'Skibox', 3150, '2024-01-31 00:00:00', '2024-01-31 00:00:00'),
       (36, 'Oyoba', 3250, '2024-02-01 00:00:00', '2024-02-01 00:00:00'),
       (37, 'Vipe', 3350, '2024-02-02 00:00:00', '2024-02-02 00:00:00'),
       (38, 'Skalith', 3450, '2024-02-03 00:00:00', '2024-02-03 00:00:00'),
       (39, 'Photobug', 3550, '2024-02-04 00:00:00', '2024-02-04 00:00:00'),
       (40, 'Pixonyx', 3650, '2024-02-05 00:00:00', '2024-02-05 00:00:00');

INSERT INTO `employments` (`user_id`, `company_id`, `employed_at`, `created_at`, `updated_at`)
VALUES (1, 1, '2023-06-15 00:00:00', '2023-06-15 00:00:00', '2023-06-15 00:00:00'),
       (2, 2, '2024-03-01 00:00:00', '2024-03-01 00:00:00', '2024-03-01 00:00:00'),
       (3, 3, '2024-03-03 00:00:00', '2024-03-03 00:00:00', '2024-03-03 00:00:00'),
       (4, 10, '2023-07-01 00:00:00', '2023-07-01 00:00:00', '2023-07-01 00:00:00'),
       (5, 20, '2023-08-12 00:00:00', '2023-08-12 00:00:00', '2023-08-12 00:00:00'),
       (6, 15, '2023-09-23 00:00:00', '2023-09-23 00:00:00', '2023-09-23 00:00:00'),
       (7, 18, '2023-10-04 00:00:00', '2023-10-04 00:00:00', '2023-10-04 00:00:00'),
       (8, 22, '2023-11-15 00:00:00', '2023-11-15 00:00:00', '2023-11-15 00:00:00'),
       (9, 25, '2023-12-26 00:00:00', '2023-12-26 00:00:00', '2023-12-26 00:00:00'),
       (10, 30, '2024-01-06 00:00:00', '2024-01-06 00:00:00', '2024-01-06 00:00:00'),
       (11, 35, '2024-02-17 00:00:00', '2024-02-17 00:00:00', '2024-02-17 00:00:00'),
       (12, 28, '2024-03-29 00:00:00', '2024-03-29 00:00:00', '2024-03-29 00:00:00'),
       (13, 21, '2023-05-10 00:00:00', '2023-05-10 00:00:00', '2023-05-10 00:00:00'),
       (14, 14, '2023-06-21 00:00:00', '2023-06-21 00:00:00', '2023-06-21 00:00:00'),
       (15, 7, '2023-08-01 00:00:00', '2023-08-01 00:00:00', '2023-08-01 00:00:00'),
       (16, 33, '2023-09-12 00:00:00', '2023-09-12 00:00:00', '2023-09-12 00:00:00'),
       (17, 26, '2023-10-23 00:00:00', '2023-10-23 00:00:00', '2023-10-23 00:00:00'),
       (18, 19, '2023-12-03 00:00:00', '2023-12-03 00:00:00', '2023-12-03 00:00:00'),
       (19, 12, '2024-01-14 00:00:00', '2024-01-14 00:00:00', '2024-01-14 00:00:00'),
       (20, 5, '2024-02-24 00:00:00', '2024-02-24 00:00:00', '2024-02-24 00:00:00'),
       (21, 8, '2023-05-16 00:00:00', '2023-05-16 00:00:00', '2023-05-16 00:00:00'),
       (22, 16, '2023-06-27 00:00:00', '2023-06-27 00:00:00', '2023-06-27 00:00:00'),
       (23, 24, '2023-08-07 00:00:00', '2023-08-07 00:00:00', '2023-08-07 00:00:00'),
       (24, 32, '2023-09-18 00:00:00', '2023-09-18 00:00:00', '2023-09-18 00:00:00'),
       (25, 40, '2023-10-29 00:00:00', '2023-10-29 00:00:00', '2023-10-29 00:00:00'),
       (26, 31, '2023-12-10 00:00:00', '2023-12-10 00:00:00', '2023-12-10 00:00:00'),
       (27, 23, '2024-01-20 00:00:00', '2024-01-20 00:00:00', '2024-01-20 00:00:00'),
       (28, 15, '2024-03-02 00:00:00', '2024-03-02 00:00:00', '2024-03-02 00:00:00'),
       (29, 7, '2023-04-13 00:00:00', '2023-04-13 00:00:00', '2023-04-13 00:00:00'),
       (30, 14, '2023-05-24 00:00:00', '2023-05-24 00:00:00', '2023-05-24 00:00:00'),
       (31, 21, '2023-07-04 00:00:00', '2023-07-04 00:00:00', '2023-07-04 00:00:00'),
       (32, 28, '2023-08-14 00:00:00', '2023-08-14 00:00:00', '2023-08-14 00:00:00'),
       (33, 35, '2023-09-25 00:00:00', '2023-09-25 00:00:00', '2023-09-25 00:00:00'),
       (34, 27, '2023-11-05 00:00:00', '2023-11-05 00:00:00', '2023-11-05 00:00:00'),
       (35, 19, '2023-12-16 00:00:00', '2023-12-16 00:00:00', '2023-12-16 00:00:00'),
       (36, 11, '2024-01-26 00:00:00', '2024-01-26 00:00:00', '2024-01-26 00:00:00'),
       (37, 3, '2024-03-08 00:00:00', '2024-03-08 00:00:00', '2024-03-08 00:00:00'),
       (38, 9, '2023-04-19 00:00:00', '2023-04-19 00:00:00', '2023-04-19 00:00:00'),
       (39, 17, '2023-05-30 00:00:00', '2023-05-30 00:00:00', '2023-05-30 00:00:00'),
       (40, 25, '2023-07-10 00:00:00', '2023-07-10 00:00:00', '2023-07-10 00:00:00'),
       (41, 13, '2023-05-17 00:00:00', '2023-05-17 00:00:00', '2023-05-17 00:00:00'),
       (42, 22, '2023-06-28 00:00:00', '2023-06-28 00:00:00', '2023-06-28 00:00:00'),
       (43, 31, '2023-08-08 00:00:00', '2023-08-08 00:00:00', '2023-08-08 00:00:00'),
       (44, 20, '2023-09-19 00:00:00', '2023-09-19 00:00:00', '2023-09-19 00:00:00'),
       (45, 29, '2023-10-30 00:00:00', '2023-10-30 00:00:00', '2023-10-30 00:00:00'),
       (46, 38, '2023-12-11 00:00:00', '2023-12-11 00:00:00', '2023-12-11 00:00:00'),
       (47, 27, '2024-01-21 00:00:00', '2024-01-21 00:00:00', '2024-01-21 00:00:00'),
       (48, 16, '2024-03-03 00:00:00', '2024-03-03 00:00:00', '2024-03-03 00:00:00'),
       (49, 5, '2023-04-14 00:00:00', '2023-04-14 00:00:00', '2023-04-14 00:00:00'),
       (50, 14, '2023-05-25 00:00:00', '2023-05-25 00:00:00', '2023-05-25 00:00:00'),
       (51, 23, '2023-07-05 00:00:00', '2023-07-05 00:00:00', '2023-07-05 00:00:00'),
       (52, 32, '2023-08-15 00:00:00', '2023-08-15 00:00:00', '2023-08-15 00:00:00'),
       (53, 41, '2023-09-26 00:00:00', '2023-09-26 00:00:00', '2023-09-26 00:00:00'),
       (54, 30, '2023-11-06 00:00:00', '2023-11-06 00:00:00', '2023-11-06 00:00:00'),
       (55, 19, '2023-12-17 00:00:00', '2023-12-17 00:00:00', '2023-12-17 00:00:00'),
       (56, 8, '2024-01-27 00:00:00', '2024-01-27 00:00:00', '2024-01-27 00:00:00'),
       (57, 37, '2024-03-09 00:00:00', '2024-03-09 00:00:00', '2024-03-09 00:00:00'),
       (58, 26, '2023-04-20 00:00:00', '2023-04-20 00:00:00', '2023-04-20 00:00:00'),
       (59, 15, '2023-05-31 00:00:00', '2023-05-31 00:00:00', '2023-05-31 00:00:00'),
       (60, 24, '2023-07-11 00:00:00', '2023-07-11 00:00:00', '2023-07-11 00:00:00'),
       (81, 25, '2023-05-19 00:00:00', '2023-05-19 00:00:00', '2023-05-19 00:00:00'),
       (82, 35, '2023-06-30 00:00:00', '2023-06-30 00:00:00', '2023-06-30 00:00:00'),
       (83, 10, '2023-08-10 00:00:00', '2023-08-10 00:00:00', '2023-08-10 00:00:00'),
       (84, 20, '2023-09-21 00:00:00', '2023-09-21 00:00:00', '2023-09-21 00:00:00'),
       (85, 30, '2023-11-01 00:00:00', '2023-11-01 00:00:00', '2023-11-01 00:00:00'),
       (86, 40, '2023-12-13 00:00:00', '2023-12-13 00:00:00', '2023-12-13 00:00:00'),
       (87, 33, '2024-01-23 00:00:00', '2024-01-23 00:00:00', '2024-01-23 00:00:00'),
       (88, 23, '2024-03-05 00:00:00', '2024-03-05 00:00:00', '2024-03-05 00:00:00'),
       (89, 13, '2023-04-16 00:00:00', '2023-04-16 00:00:00', '2023-04-16 00:00:00'),
       (90, 3, '2023-05-27 00:00:00', '2023-05-27 00:00:00', '2023-05-27 00:00:00'),
       (91, 7, '2023-07-07 00:00:00', '2023-07-07 00:00:00', '2023-07-07 00:00:00'),
       (92, 17, '2023-08-17 00:00:00', '2023-08-17 00:00:00', '2023-08-17 00:00:00'),
       (93, 27, '2023-09-28 00:00:00', '2023-09-28 00:00:00', '2023-09-28 00:00:00'),
       (94, 37, '2023-11-08 00:00:00', '2023-11-08 00:00:00', '2023-11-08 00:00:00'),
       (95, 2, '2023-12-19 00:00:00', '2023-12-19 00:00:00', '2023-12-19 00:00:00'),
       (96, 12, '2024-01-29 00:00:00', '2024-01-29 00:00:00', '2024-01-29 00:00:00'),
       (97, 22, '2024-03-11 00:00:00', '2024-03-11 00:00:00', '2024-03-11 00:00:00'),
       (98, 32, '2023-04-22 00:00:00', '2023-04-22 00:00:00', '2023-04-22 00:00:00'),
       (99, 5, '2023-06-02 00:00:00', '2023-06-02 00:00:00', '2023-06-02 00:00:00'),
       (100, 15, '2023-07-13 00:00:00', '2023-07-13 00:00:00', '2023-07-13 00:00:00'),
       (101, 18, '2023-05-20 00:00:00', '2023-05-20 00:00:00', '2023-05-20 00:00:00'),
       (102, 28, '2023-07-01 00:00:00', '2023-07-01 00:00:00', '2023-07-01 00:00:00'),
       (103, 38, '2023-08-11 00:00:00', '2023-08-11 00:00:00', '2023-08-11 00:00:00'),
       (104, 1, '2023-09-22 00:00:00', '2023-09-22 00:00:00', '2023-09-22 00:00:00'),
       (105, 11, '2023-11-02 00:00:00', '2023-11-02 00:00:00', '2023-11-02 00:00:00'),
       (106, 21, '2023-12-14 00:00:00', '2023-12-14 00:00:00', '2023-12-14 00:00:00'),
       (107, 31, '2024-01-24 00:00:00', '2024-01-24 00:00:00', '2024-01-24 00:00:00'),
       (108, 41, '2024-03-06 00:00:00', '2024-03-06 00:00:00', '2024-03-06 00:00:00'),
       (109, 2, '2023-04-17 00:00:00', '2023-04-17 00:00:00', '2023-04-17 00:00:00'),
       (110, 12, '2023-05-28 00:00:00', '2023-05-28 00:00:00', '2023-05-28 00:00:00'),
       (111, 22, '2023-07-08 00:00:00', '2023-07-08 00:00:00', '2023-07-08 00:00:00'),
       (112, 32, '2023-08-18 00:00:00', '2023-08-18 00:00:00', '2023-08-18 00:00:00'),
       (113, 42, '2023-09-29 00:00:00', '2023-09-29 00:00:00', '2023-09-29 00:00:00'),
       (114, 3, '2023-11-09 00:00:00', '2023-11-09 00:00:00', '2023-11-09 00:00:00'),
       (115, 13, '2023-12-20 00:00:00', '2023-12-20 00:00:00', '2023-12-20 00:00:00'),
       (116, 23, '2024-01-30 00:00:00', '2024-01-30 00:00:00', '2024-01-30 00:00:00'),
       (117, 33, '2024-03-12 00:00:00', '2024-03-12 00:00:00', '2024-03-12 00:00:00'),
       (118, 4, '2023-04-23 00:00:00', '2023-04-23 00:00:00', '2023-04-23 00:00:00'),
       (119, 14, '2023-06-03 00:00:00', '2023-06-03 00:00:00', '2023-06-03 00:00:00'),
       (120, 24, '2023-07-14 00:00:00', '2023-07-14 00:00:00', '2023-07-14 00:00:00'),
       (121, 19, '2023-05-21 00:00:00', '2023-05-21 00:00:00', '2023-05-21 00:00:00'),
       (122, 29, '2023-07-02 00:00:00', '2023-07-02 00:00:00', '2023-07-02 00:00:00'),
       (123, 39, '2023-08-12 00:00:00', '2023-08-12 00:00:00', '2023-08-12 00:00:00'),
       (124, 2, '2023-09-23 00:00:00', '2023-09-23 00:00:00', '2023-09-23 00:00:00'),
       (125, 12, '2023-11-03 00:00:00', '2023-11-03 00:00:00', '2023-11-03 00:00:00'),
       (126, 22, '2023-12-15 00:00:00', '2023-12-15 00:00:00', '2023-12-15 00:00:00'),
       (127, 32, '2024-01-25 00:00:00', '2024-01-25 00:00:00', '2024-01-25 00:00:00'),
       (128, 6, '2024-03-07 00:00:00', '2024-03-07 00:00:00', '2024-03-07 00:00:00'),
       (129, 16, '2023-04-18 00:00:00', '2023-04-18 00:00:00', '2023-04-18 00:00:00'),
       (130, 26, '2023-05-29 00:00:00', '2023-05-29 00:00:00', '2023-05-29 00:00:00'),
       (131, 36, '2023-07-09 00:00:00', '2023-07-09 00:00:00', '2023-07-09 00:00:00'),
       (132, 1, '2023-08-19 00:00:00', '2023-08-19 00:00:00', '2023-08-19 00:00:00'),
       (133, 11, '2023-09-30 00:00:00', '2023-09-30 00:00:00', '2023-09-30 00:00:00'),
       (134, 21, '2023-11-10 00:00:00', '2023-11-10 00:00:00', '2023-11-10 00:00:00'),
       (135, 31, '2023-12-21 00:00:00', '2023-12-21 00:00:00', '2023-12-21 00:00:00'),
       (136, 41, '2024-01-31 00:00:00', '2024-01-31 00:00:00', '2024-01-31 00:00:00'),
       (137, 5, '2024-03-13 00:00:00', '2024-03-13 00:00:00', '2024-03-13 00:00:00'),
       (138, 15, '2023-04-24 00:00:00', '2023-04-24 00:00:00', '2023-04-24 00:00:00'),
       (139, 25, '2023-06-04 00:00:00', '2023-06-04 00:00:00', '2023-06-04 00:00:00'),
       (140, 35, '2023-07-15 00:00:00', '2023-07-15 00:00:00', '2023-07-15 00:00:00'),
       (141, 20, '2023-05-22 00:00:00', '2023-05-22 00:00:00', '2023-05-22 00:00:00'),
       (142, 30, '2023-07-03 00:00:00', '2023-07-03 00:00:00', '2023-07-03 00:00:00'),
       (143, 40, '2023-08-13 00:00:00', '2023-08-13 00:00:00', '2023-08-13 00:00:00'),
       (144, 10, '2023-09-24 00:00:00', '2023-09-24 00:00:00', '2023-09-24 00:00:00'),
       (145, 20, '2023-11-04 00:00:00', '2023-11-04 00:00:00', '2023-11-04 00:00:00'),
       (146, 30, '2023-12-16 00:00:00', '2023-12-16 00:00:00', '2023-12-16 00:00:00'),
       (147, 40, '2024-01-26 00:00:00', '2024-01-26 00:00:00', '2024-01-26 00:00:00'),
       (148, 7, '2024-03-08 00:00:00', '2024-03-08 00:00:00', '2024-03-08 00:00:00'),
       (149, 17, '2023-04-19 00:00:00', '2023-04-19 00:00:00', '2023-04-19 00:00:00'),
       (150, 27, '2023-05-30 00:00:00', '2023-05-30 00:00:00', '2023-05-30 00:00:00'),
       (151, 37, '2023-07-10 00:00:00', '2023-07-10 00:00:00', '2023-07-10 00:00:00'),
       (152, 2, '2023-08-20 00:00:00', '2023-08-20 00:00:00', '2023-08-20 00:00:00'),
       (153, 12, '2023-10-01 00:00:00', '2023-10-01 00:00:00', '2023-10-01 00:00:00'),
       (154, 22, '2023-11-11 00:00:00', '2023-11-11 00:00:00', '2023-11-11 00:00:00'),
       (155, 32, '2023-12-22 00:00:00', '2023-12-22 00:00:00', '2023-12-22 00:00:00'),
       (156, 8, '2024-02-01 00:00:00', '2024-02-01 00:00:00', '2024-02-01 00:00:00'),
       (157, 18, '2024-03-14 00:00:00', '2024-03-14 00:00:00', '2024-03-14 00:00:00'),
       (158, 28, '2023-04-25 00:00:00', '2023-04-25 00:00:00', '2023-04-25 00:00:00'),
       (159, 38, '2023-06-05 00:00:00', '2023-06-05 00:00:00', '2023-06-05 00:00:00'),
       (160, 4, '2023-07-16 00:00:00', '2023-07-16 00:00:00', '2023-07-16 00:00:00'),
       (161, 9, '2023-05-23 00:00:00', '2023-05-23 00:00:00', '2023-05-23 00:00:00'),
       (162, 19, '2023-07-04 00:00:00', '2023-07-04 00:00:00', '2023-07-04 00:00:00'),
       (163, 29, '2023-08-14 00:00:00', '2023-08-14 00:00:00', '2023-08-14 00:00:00'),
       (164, 39, '2023-09-25 00:00:00', '2023-09-25 00:00:00', '2023-09-25 00:00:00'),
       (165, 5, '2023-11-05 00:00:00', '2023-11-05 00:00:00', '2023-11-05 00:00:00'),
       (166, 15, '2023-12-17 00:00:00', '2023-12-17 00:00:00', '2023-12-17 00:00:00'),
       (167, 25, '2024-01-27 00:00:00', '2024-01-27 00:00:00', '2024-01-27 00:00:00'),
       (168, 35, '2024-03-09 00:00:00', '2024-03-09 00:00:00', '2024-03-09 00:00:00'),
       (169, 10, '2023-04-20 00:00:00', '2023-04-20 00:00:00', '2023-04-20 00:00:00'),
       (170, 20, '2023-05-31 00:00:00', '2023-05-31 00:00:00', '2023-05-31 00:00:00'),
       (171, 30, '2023-07-11 00:00:00', '2023-07-11 00:00:00', '2023-07-11 00:00:00'),
       (172, 40, '2023-08-21 00:00:00', '2023-08-21 00:00:00', '2023-08-21 00:00:00'),
       (173, 6, '2023-10-02 00:00:00', '2023-10-02 00:00:00', '2023-10-02 00:00:00'),
       (174, 16, '2023-11-12 00:00:00', '2023-11-12 00:00:00', '2023-11-12 00:00:00'),
       (175, 26, '2023-12-23 00:00:00', '2023-12-23 00:00:00', '2023-12-23 00:00:00'),
       (176, 36, '2024-02-02 00:00:00', '2024-02-02 00:00:00', '2024-02-02 00:00:00'),
       (177, 3, '2024-03-15 00:00:00', '2024-03-15 00:00:00', '2024-03-15 00:00:00'),
       (178, 13, '2023-04-26 00:00:00', '2023-04-26 00:00:00', '2023-04-26 00:00:00'),
       (179, 23, '2023-06-06 00:00:00', '2023-06-06 00:00:00', '2023-06-06 00:00:00'),
       (180, 33, '2023-07-17 00:00:00', '2023-07-17 00:00:00', '2023-07-17 00:00:00'),
       (181, 14, '2023-05-24 00:00:00', '2023-05-24 00:00:00', '2023-05-24 00:00:00'),
       (182, 24, '2023-07-05 00:00:00', '2023-07-05 00:00:00', '2023-07-05 00:00:00'),
       (183, 34, '2023-08-15 00:00:00', '2023-08-15 00:00:00', '2023-08-15 00:00:00'),
       (184, 4, '2023-09-26 00:00:00', '2023-09-26 00:00:00', '2023-09-26 00:00:00'),
       (185, 14, '2023-11-06 00:00:00', '2023-11-06 00:00:00', '2023-11-06 00:00:00'),
       (186, 24, '2023-12-18 00:00:00', '2023-12-18 00:00:00', '2023-12-18 00:00:00'),
       (187, 34, '2024-01-28 00:00:00', '2024-01-28 00:00:00', '2024-01-28 00:00:00'),
       (188, 8, '2024-03-10 00:00:00', '2024-03-10 00:00:00', '2024-03-10 00:00:00'),
       (189, 18, '2023-04-21 00:00:00', '2023-04-21 00:00:00', '2023-04-21 00:00:00'),
       (190, 28, '2023-06-01 00:00:00', '2023-06-01 00:00:00', '2023-06-01 00:00:00'),
       (191, 38, '2023-07-12 00:00:00', '2023-07-12 00:00:00', '2023-07-12 00:00:00'),
       (192, 1, '2023-08-22 00:00:00', '2023-08-22 00:00:00', '2023-08-22 00:00:00'),
       (193, 11, '2023-10-03 00:00:00', '2023-10-03 00:00:00', '2023-10-03 00:00:00'),
       (194, 21, '2023-11-13 00:00:00', '2023-11-13 00:00:00', '2023-11-13 00:00:00'),
       (195, 31, '2023-12-24 00:00:00', '2023-12-24 00:00:00', '2023-12-24 00:00:00'),
       (196, 7, '2024-02-03 00:00:00', '2024-02-03 00:00:00', '2024-02-03 00:00:00'),
       (197, 17, '2024-03-16 00:00:00', '2024-03-16 00:00:00', '2024-03-16 00:00:00'),
       (198, 27, '2023-04-27 00:00:00', '2023-04-27 00:00:00', '2023-04-27 00:00:00'),
       (199, 37, '2023-06-07 00:00:00', '2023-06-07 00:00:00', '2023-06-07 00:00:00'),
       (200, 2, '2023-07-18 00:00:00', '2023-07-18 00:00:00', '2023-07-18 00:00:00');

INSERT INTO `articles` (`id`, `title`, `content`, `user_id`, `company_id`, `created_at`, `updated_at`)
VALUES (1, 'Layoffs at Yozio', '<p>Yozio announces layoffs affecting 20% of workforce.</p>', 1, 1,
        '2023-06-15 00:00:00', '2023-06-15 00:00:00'),
       (2, 'Yambee Expansion', '<p>Yambee plans to open new offices in Europe.</p>', 2, 2, '2024-03-01 00:00:00',
        '2024-03-01 00:00:00'),
       (3, 'Yakijo Acquires Competitor', '<p>Yakijo completes acquisition of rival company.</p>', 3, 3,
        '2024-03-03 00:00:00', '2024-03-03 00:00:00'),
       (4, 'Zimbiotics Breakthrough', '<p>Zimbiotics achieves a milestone in biotech research.</p>', 4, 4,
        '2024-01-10 00:00:00', '2024-01-10 00:00:00'),
       (5, 'Xenoplore Space Mission', '<p>Xenoplore announces successful satellite deployment.</p>', 5, 5,
        '2024-02-20 00:00:00', '2024-02-20 00:00:00'),
       (6, 'Wavestream Mobile Launch', '<p>Wavestream releases its newest mobile device to market.</p>', 6, 6,
        '2024-01-29 00:00:00', '2024-01-29 00:00:00'),
       (7, 'Virtucon Annual Report', '<p>Virtucon exceeds market expectations in annual earnings.</p>', 7, 7,
        '2024-03-15 00:00:00', '2024-03-15 00:00:00'),
       (8, 'Uptrend Social Growth', '<p>Uptrend Social reports user growth surpassing projections.</p>', 8, 8,
        '2024-03-30 00:00:00', '2024-03-30 00:00:00'),
       (9, 'Techtron AI Advancement', '<p>Techtron AI unveils its latest machine learning algorithms.</p>', 9, 9,
        '2024-02-11 00:00:00', '2024-02-11 00:00:00'),
       (10, 'SustainaCorp Green Initiative', '<p>SustainaCorp launches a new campaign for environmental awareness.</p>',
        10, 10, '2024-04-01 00:00:00', '2024-04-01 00:00:00'),
       (11, 'RapidBuild Infrastructure Plans', '<p>RapidBuild announces plans for new sustainable buildings.</p>', 11,
        11, '2024-01-18 00:00:00', '2024-01-18 00:00:00'),
       (12, 'Quantech Encryption Tech', '<p>Quantech introduces groundbreaking encryption technology.</p>', 12, 12,
        '2024-03-22 00:00:00', '2024-03-22 00:00:00'),
       (13, 'Proxima Space Exploration', '<p>Proxima sets a new record for longest manned spaceflight.</p>', 13, 13,
        '2024-01-25 00:00:00', '2024-01-25 00:00:00'),
       (14, 'NextGen Gaming Console Release', '<p>NextGen''s new gaming console hits record sales.</p>', 14, 14,
        '2024-03-05 00:00:00', '2024-03-05 00:00:00'),
       (15, 'MediTech Health Solutions', '<p>MediTech revolutionizes patient care with telemedicine.</p>', 15, 15,
        '2024-02-15 00:00:00', '2024-02-15 00:00:00'),
       (16, 'Logiware Supply Chain Automation', '<p>Logiware streamlines logistics with AI-driven solutions.</p>', 16,
        16, '2024-03-10 00:00:00', '2024-03-10 00:00:00'),
       (17, 'KryptoBank Currency Exchange', '<p>KryptoBank announces new cryptocurrency exchange platform.</p>', 17, 17,
        '2024-03-17 00:00:00', '2024-03-17 00:00:00'),
       (18, 'JovianTech Planetary Research', '<p>JovianTech makes new discoveries in planetary science.</p>', 18, 18,
        '2024-02-05 00:00:00', '2024-02-05 00:00:00'),
       (19, 'iStream Streaming Service Expansion', '<p>iStream expands its service to over 50 countries.</p>', 19, 19,
        '2024-03-25 00:00:00', '2024-03-25 00:00:00'),
       (20, 'HomeTech Smart Home Integration', '<p>HomeTech unveils new smart home integration systems.</p>', 20, 20,
        '2024-01-30 00:00:00', '2024-01-30 00:00:00'),
       (21, 'GreenTech Innovations', '<p>GreenTech leads the way in renewable energy solutions.</p>', 21, 21,
        '2024-01-05 00:00:00', '2024-01-05 00:00:00'),
       (22, 'FinTech Revolution', '<p>FinTech introduces a new era of digital banking services.</p>', 22, 22,
        '2024-02-10 00:00:00', '2024-02-10 00:00:00'),
       (23, 'EduTech Online Learning', '<p>EduTech expands its online learning platform to new subjects.</p>', 23, 23,
        '2024-03-20 00:00:00', '2024-03-20 00:00:00'),
       (24, 'DigiMark Digital Marketing', '<p>DigiMark''s new campaign triples online engagement.</p>', 24, 24,
        '2024-04-15 00:00:00', '2024-04-15 00:00:00'),
       (25, 'CyberSafe Security Update',
        '<p>CyberSafe releases an update patching recent security vulnerabilities.</p>', 25, 25, '2024-03-28 00:00:00',
        '2024-03-28 00:00:00'),
       (26, 'BioHealth New Drug', '<p>BioHealth''s new drug passes clinical trials with promising results.</p>', 26, 26,
        '2024-02-25 00:00:00', '2024-02-25 00:00:00'),
       (27, 'AstroTech Telescope', '<p>AstroTech''s new telescope model offers unprecedented clarity.</p>', 27, 27,
        '2024-01-22 00:00:00', '2024-01-22 00:00:00'),
       (28, 'SmartMove Transportation', '<p>SmartMove revolutionizes urban transport with its smart vehicles.</p>', 28,
        28, '2024-03-11 00:00:00', '2024-03-11 00:00:00'),
       (29, 'QuantumComputing Breakthrough',
        '<p>QuantumComputing achieves a significant milestone in quantum processing speed.</p>', 29, 29,
        '2024-01-16 00:00:00', '2024-01-16 00:00:00'),
       (30, 'NextWave Wireless Tech', '<p>NextWave unveils its next-gen wireless communication technology.</p>', 30, 30,
        '2024-03-05 00:00:00', '2024-03-05 00:00:00'),
       (31, 'MediCare Health Plan', '<p>MediCare introduces a comprehensive health plan for seniors.</p>', 31, 31,
        '2024-02-18 00:00:00', '2024-02-18 00:00:00'),
       (32, 'LifeStream Clean Water', '<p>LifeStream''s new technology purifies water with high efficiency.</p>', 32,
        32, '2024-04-08 00:00:00', '2024-04-08 00:00:00'),
       (33, 'InfoTech Data Analytics', '<p>InfoTech''s data analytics services offer deeper business insights.</p>', 33,
        33, '2024-01-30 00:00:00', '2024-01-30 00:00:00'),
       (34, 'HomeSecure Safety Systems', '<p>HomeSecure launches a new line of advanced home security systems.</p>', 34,
        34, '2024-03-21 00:00:00', '2024-03-21 00:00:00'),
       (35, 'GenomeLab Genetic Research',
        '<p>GenomeLab''s research leads to a breakthrough in genetic disease treatment.</p>', 35, 35,
        '2024-02-05 00:00:00', '2024-02-05 00:00:00'),
       (36, 'FoodieGoodie Organic Range', '<p>FoodieGoodie introduces a new range of organic food products.</p>', 36,
        36, '2024-03-14 00:00:00', '2024-03-14 00:00:00'),
       (37, 'EcoBuild Sustainable Materials',
        '<p>EcoBuild''s sustainable materials are a hit in the construction industry.</p>', 37, 37,
        '2024-01-19 00:00:00', '2024-01-19 00:00:00'),
       (38, 'DroneTech Aerial Innovation',
        '<p>DroneTech''s new drone models enhance aerial photography capabilities.</p>', 38, 38, '2024-03-27 00:00:00',
        '2024-03-27 00:00:00'),
       (39, 'CryptoChain Ledger Tech',
        '<p>CryptoChain introduces a new secure ledger technology for cryptocurrencies.</p>', 39, 39,
        '2024-02-22 00:00:00', '2024-02-22 00:00:00'),
       (40, 'BeaconAI Artificial Intelligence',
        '<p>BeaconAI''s new AI system learns and adapts at an unprecedented rate.</p>', 40, 40, '2024-04-14 00:00:00',
        '2024-04-14 00:00:00'),
       (41, 'Virtuality VR Experiences', '<p>Virtuality launches a new range of immersive VR experiences.</p>', 41, 1,
        '2024-01-12 00:00:00', '2024-01-12 00:00:00'),
       (42, 'OceanClean Initiative',
        '<p>OceanClean''s initiative leads to a significant reduction in ocean pollution.</p>', 42, 2,
        '2024-02-14 00:00:00', '2024-02-14 00:00:00'),
       (43, 'NanoMed Medical Nanobots', '<p>NanoMed''s medical nanobots show promise in targeted drug delivery.</p>',
        43, 3, '2024-03-23 00:00:00', '2024-03-23 00:00:00'),
       (44, 'MegaFoods Nutrition', '<p>MegaFoods introduces a new line of superfoods boosting nutrition.</p>', 44, 4,
        '2024-04-10 00:00:00', '2024-04-10 00:00:00'),
       (45, 'LunarHab Moon Habitat', '<p>LunarHab unveils designs for sustainable moon habitats.</p>', 45, 5,
        '2024-03-29 00:00:00', '2024-03-29 00:00:00'),
       (46, 'KinetiTech Motion Sensors', '<p>KinetiTech''s new motion sensors enhance automation in manufacturing.</p>',
        46, 6, '2024-02-28 00:00:00', '2024-02-28 00:00:00'),
       (47, 'JupiterMining Asteroid Mining',
        '<p>JupiterMining begins asteroid mining operations with new technology.</p>', 47, 7, '2024-01-24 00:00:00',
        '2024-01-24 00:00:00'),
       (48, 'IntelliCar Autonomous Vehicles',
        '<p>IntelliCar''s autonomous vehicles pass safety tests with flying colors.</p>', 48, 8, '2024-03-18 00:00:00',
        '2024-03-18 00:00:00'),
       (49, 'HealthTrack Fitness Monitors',
        '<p>HealthTrack''s new fitness monitors offer personalized health insights.</p>', 49, 9, '2024-02-08 00:00:00',
        '2024-02-08 00:00:00'),
       (50, 'GreenBuild Eco-Friendly Construction',
        '<p>GreenBuild''s eco-friendly construction methods gain industry recognition.</p>', 50, 10,
        '2024-04-05 00:00:00', '2024-04-05 00:00:00'),
       (51, 'FutureNet Internet Technology',
        '<p>FutureNet''s new internet technology promises faster global connectivity.</p>', 51, 11,
        '2024-03-07 00:00:00', '2024-03-07 00:00:00'),
       (52, 'EcoTravel Green Transportation', '<p>EcoTravel expands its fleet of green transportation options.</p>', 52,
        12, '2024-01-31 00:00:00', '2024-01-31 00:00:00'),
       (53, 'DroneDeliver Package Delivery', '<p>DroneDeliver''s package delivery drones become more efficient.</p>',
        53, 13, '2024-03-26 00:00:00', '2024-03-26 00:00:00'),
       (54, 'CryptoSecure Blockchain Security', '<p>CryptoSecure enhances blockchain security with new algorithms.</p>',
        54, 14, '2024-02-23 00:00:00', '2024-02-23 00:00:00'),
       (55, 'BioGrow Agricultural Innovation', '<p>BioGrow''s agricultural innovations lead to higher crop yields.</p>',
        55, 15, '2024-01-20 00:00:00', '2024-01-20 00:00:00'),
       (56, 'AquaPurify Water Treatment', '<p>AquaPurify''s water treatment systems set new purity standards.</p>', 56,
        16, '2024-03-15 00:00:00', '2024-03-15 00:00:00'),
       (57, 'NanoCraft Precision Tools',
        '<p>NanoCraft''s precision tools enable advancements in micro-manufacturing.</p>', 57, 17,
        '2024-02-12 00:00:00', '2024-02-12 00:00:00'),
       (58, 'LumenLight Smart Lighting', '<p>LumenLight''s smart lighting systems adapt to user preferences.</p>', 58,
        18, '2024-04-02 00:00:00', '2024-04-02 00:00:00'),
       (59, 'IntelliDrone Advanced Drones',
        '<p>IntelliDrone''s advanced drones set new standards for aerial photography.</p>', 59, 19,
        '2024-03-19 00:00:00', '2024-03-19 00:00:00'),
       (60, 'HyperLoop Transportation',
        '<p>HyperLoop''s new transportation system promises to revolutionize travel.</p>', 60, 20,
        '2024-02-27 00:00:00', '2024-02-27 00:00:00');

INSERT INTO `layoffs` (`id`, `company_id`, `employee_count`, `reason`, `occurrence_at`, `created_at`, `updated_at`)
VALUES (1, 1, 20, 'Restructuring for efficiency', '2023-06-15 00:00:00', '2023-06-15 00:00:00', '2023-06-15 00:00:00'),
       (2, 2, 10, 'Market downturn', '2024-03-01 00:00:00', '2024-03-01 00:00:00', '2024-03-01 00:00:00'),
       (3, 3, 30, 'Strategic realignment', '2024-03-03 00:00:00', '2024-03-03 00:00:00', '2024-03-03 00:00:00'),
       (4, 4, 15, 'Cost optimization', '2024-01-04 00:00:00', '2024-01-04 00:00:00', '2024-01-04 00:00:00'),
       (5, 5, 12, 'Budget cuts', '2024-01-05 00:00:00', '2024-01-05 00:00:00', '2024-01-05 00:00:00'),
       (6, 6, 25, 'Outsourcing', '2024-01-06 00:00:00', '2024-01-06 00:00:00', '2024-01-06 00:00:00'),
       (7, 7, 18, 'Automation', '2024-01-07 00:00:00', '2024-01-07 00:00:00', '2024-01-07 00:00:00'),
       (8, 8, 20, 'Merger', '2024-01-08 00:00:00', '2024-01-08 00:00:00', '2024-01-08 00:00:00'),
       (9, 9, 22, 'Acquisition', '2024-01-09 00:00:00', '2024-01-09 00:00:00', '2024-01-09 00:00:00'),
       (10, 10, 19, 'Downsizing', '2024-01-10 00:00:00', '2024-01-10 00:00:00', '2024-01-10 00:00:00'),
       (11, 11, 30, 'Economic challenges', '2024-01-11 00:00:00', '2024-01-11 00:00:00', '2024-01-11 00:00:00'),
       (12, 12, 28, 'Revenue shortfall', '2024-01-12 00:00:00', '2024-01-12 00:00:00', '2024-01-12 00:00:00'),
       (13, 13, 14, 'Product discontinuation', '2024-01-13 00:00:00', '2024-01-13 00:00:00', '2024-01-13 00:00:00'),
       (14, 14, 16, 'Shift in business focus', '2024-01-14 00:00:00', '2024-01-14 00:00:00', '2024-01-14 00:00:00'),
       (15, 15, 21, 'Market competition', '2024-01-15 00:00:00', '2024-01-15 00:00:00', '2024-01-15 00:00:00'),
       (16, 16, 23, 'Financial restructuring', '2024-01-16 00:00:00', '2024-01-16 00:00:00', '2024-01-16 00:00:00'),
       (17, 17, 17, 'Change in leadership', '2024-01-17 00:00:00', '2024-01-17 00:00:00', '2024-01-17 00:00:00'),
       (18, 18, 26, 'Regulatory changes', '2024-01-18 00:00:00', '2024-01-18 00:00:00', '2024-01-18 00:00:00'),
       (19, 19, 29, 'Legal issues', '2024-01-19 00:00:00', '2024-01-19 00:00:00', '2024-01-19 00:00:00'),
       (20, 20, 24, 'Operational efficiency', '2024-01-20 00:00:00', '2024-01-20 00:00:00', '2024-01-20 00:00:00'),
       (21, 21, 11, 'Cost reduction', '2024-01-21 00:00:00', '2024-01-21 00:00:00', '2024-01-21 00:00:00'),
       (22, 22, 13, 'Relocation', '2024-01-22 00:00:00', '2024-01-22 00:00:00', '2024-01-22 00:00:00'),
       (23, 23, 9, 'Divestiture', '2024-01-23 00:00:00', '2024-01-23 00:00:00', '2024-01-23 00:00:00'),
       (24, 24, 14, 'Bankruptcy', '2024-01-24 00:00:00', '2024-01-24 00:00:00', '2024-01-24 00:00:00'),
       (25, 25, 8, 'Company closure', '2024-01-25 00:00:00', '2024-01-25 00:00:00', '2024-01-25 00:00:00'),
       (26, 26, 15, 'Acquisition and merger', '2024-01-26 00:00:00', '2024-01-26 00:00:00', '2024-01-26 00:00:00'),
       (27, 27, 7, 'Insolvency', '2024-01-27 00:00:00', '2024-01-27 00:00:00', '2024-01-27 00:00:00'),
       (28, 28, 10, 'Management change', '2024-01-28 00:00:00', '2024-01-28 00:00:00', '2024-01-28 00:00:00'),
       (29, 29, 12, 'Economic downturn', '2024-01-29 00:00:00', '2024-01-29 00:00:00', '2024-01-29 00:00:00'),
       (30, 30, 6, 'Industry disruption', '2024-01-30 00:00:00', '2024-01-30 00:00:00', '2024-01-30 00:00:00'),
       (31, 31, 16, 'Technological changes', '2024-01-31 00:00:00', '2024-01-31 00:00:00', '2024-01-31 00:00:00'),
       (32, 32, 5, 'Environmental regulations', '2024-02-01 00:00:00', '2024-02-01 00:00:00', '2024-02-01 00:00:00'),
       (33, 33, 17, 'Loss of major client', '2024-02-02 00:00:00', '2024-02-02 00:00:00', '2024-02-02 00:00:00'),
       (34, 34, 4, 'Corporate restructuring', '2024-02-03 00:00:00', '2024-02-03 00:00:00', '2024-02-03 00:00:00'),
       (35, 35, 18, 'Legal restructuring', '2024-02-04 00:00:00', '2024-02-04 00:00:00', '2024-02-04 00:00:00'),
       (36, 36, 3, 'Shift in market demand', '2024-02-05 00:00:00', '2024-02-05 00:00:00', '2024-02-05 00:00:00'),
       (37, 37, 19, 'Compliance issues', '2024-02-06 00:00:00', '2024-02-06 00:00:00', '2024-02-06 00:00:00'),
       (38, 38, 2, 'Organizational realignment', '2024-02-07 00:00:00', '2024-02-07 00:00:00', '2024-02-07 00:00:00'),
       (39, 39, 20, 'Product phase-out', '2024-02-08 00:00:00', '2024-02-08 00:00:00', '2024-02-08 00:00:00'),
       (40, 40, 1, 'Strategic shift', '2024-02-09 00:00:00', '2024-02-09 00:00:00', '2024-02-09 00:00:00'),
       (41, 1, 5, 'Cost cutting', '2024-02-10 00:00:00', '2024-02-10 00:00:00', '2024-02-10 00:00:00'),
       (42, 2, 7, 'Reduction in force', '2024-02-11 00:00:00', '2024-02-11 00:00:00', '2024-02-11 00:00:00'),
       (43, 3, 9, 'Discontinuation of division', '2024-02-12 00:00:00', '2024-02-12 00:00:00', '2024-02-12 00:00:00'),
       (44, 4, 6, 'Reorganization', '2024-02-13 00:00:00', '2024-02-13 00:00:00', '2024-02-13 00:00:00'),
       (45, 5, 8, 'Liquidation', '2024-02-14 00:00:00', '2024-02-14 00:00:00', '2024-02-14 00:00:00'),
       (46, 6, 10, 'Business model change', '2024-02-15 00:00:00', '2024-02-15 00:00:00', '2024-02-15 00:00:00'),
       (47, 7, 12, 'Funding cut', '2024-02-16 00:00:00', '2024-02-16 00:00:00', '2024-02-16 00:00:00'),
       (48, 8, 14, 'Loss of funding', '2024-02-17 00:00:00', '2024-02-17 00:00:00', '2024-02-17 00:00:00'),
       (49, 9, 16, 'Market exit', '2024-02-18 00:00:00', '2024-02-18 00:00:00', '2024-02-18 00:00:00'),
       (50, 10, 18, 'Strategic decision', '2024-02-19 00:00:00', '2024-02-19 00:00:00', '2024-02-19 00:00:00'),
       (51, 11, 20, 'Economic sanctions', '2024-02-20 00:00:00', '2024-02-20 00:00:00', '2024-02-20 00:00:00'),
       (52, 12, 22, 'Contract termination', '2024-02-21 00:00:00', '2024-02-21 00:00:00', '2024-02-21 00:00:00'),
       (53, 13, 24, 'Operational downsizing', '2024-02-22 00:00:00', '2024-02-22 00:00:00', '2024-02-22 00:00:00'),
       (54, 14, 26, 'Merger and acquisition', '2024-02-23 00:00:00', '2024-02-23 00:00:00', '2024-02-23 00:00:00'),
       (55, 15, 28, 'Shift in strategic direction', '2024-02-24 00:00:00', '2024-02-24 00:00:00',
        '2024-02-24 00:00:00'),
       (56, 16, 30, 'Change in market strategy', '2024-02-25 00:00:00', '2024-02-25 00:00:00', '2024-02-25 00:00:00'),
       (57, 17, 32, 'New regulations', '2024-02-26 00:00:00', '2024-02-26 00:00:00', '2024-02-26 00:00:00'),
       (58, 18, 34, 'Change in industry trends', '2024-02-27 00:00:00', '2024-02-27 00:00:00', '2024-02-27 00:00:00'),
       (59, 19, 36, 'Shift in consumer demand', '2024-02-28 00:00:00', '2024-02-28 00:00:00', '2024-02-28 00:00:00'),
       (60, 20, 38, 'Technological advancement', '2024-02-29 00:00:00', '2024-02-29 00:00:00', '2024-02-29 00:00:00');

INSERT INTO `posts` (`id`, `title`, `content`, `user_id`, `parent_post_id`, `event_id`, `like_count`, `created_at`,
                     `updated_at`)
VALUES (1, 'Response to Yozio Layoffs', '<p>As an employee at Yozio, I am deeply saddened by the recent layoffs.</p>',
        1, NULL, 1, 5, '2023-06-15 00:00:00', '2023-06-15 00:00:00'),
       (2, NULL, '<p>I share your sentiments, it is a difficult time for all of us.</p>', 2, 1, 1, 3,
        '2023-06-15 00:00:00', '2023-06-15 00:00:00'),
       (3, 'Yambee Expansion Discussion',
        '<p>Exciting news about the expansion, looking forward to new opportunities.</p>', 2, NULL, NULL, 10,
        '2024-03-01 00:00:00', '2024-03-01 00:00:00'),
       (4, 'Cost Optimization Measures',
        '<p>Our company is undergoing cost optimization, which unfortunately includes layoffs.</p>', 4, NULL, 4, 2,
        '2024-01-04 00:00:00', '2024-01-04 00:00:00'),
       (5, 'Budget Cuts Impact', '<p>It''s a tough day for us with the budget cuts leading to layoffs.</p>', 5, NULL, 5,
        1, '2024-01-05 00:00:00', '2024-01-05 00:00:00'),
       (6, 'Outsourcing Decision',
        '<p>The decision to outsource has been made, impacting several of our colleagues.</p>', 6, NULL, 6, 0,
        '2024-01-06 00:00:00', '2024-01-06 00:00:00'),
       (7, 'Automation and Job Loss', '<p>Automation is the future, but it''s also costing jobs right now.</p>', 7,
        NULL, 7, 4, '2024-01-07 00:00:00', '2024-01-07 00:00:00'),
       (8, 'Merger Layoffs', '<p>The merger has led to overlapping positions and, sadly, layoffs.</p>', 8, NULL, 8, 3,
        '2024-01-08 00:00:00', '2024-01-08 00:00:00'),
       (9, 'Acquisition Changes',
        '<p>Post-acquisition, our workforce is being restructured, which includes layoffs.</p>', 9, NULL, 9, 5,
        '2024-01-09 00:00:00', '2024-01-09 00:00:00'),
       (10, 'Downsizing Reality',
        '<p>Downsizing is never easy, and today we had to say goodbye to valued team members.</p>', 10, NULL, 10, 6,
        '2024-01-10 00:00:00', '2024-01-10 00:00:00'),
       (11, 'Economic Challenges Ahead', '<p>The economic challenges have forced our hand into layoffs.</p>', 11, NULL,
        11, 7, '2024-01-11 00:00:00', '2024-01-11 00:00:00'),
       (12, 'Revenue Shortfall and Layoffs', '<p>Due to a significant revenue shortfall, layoffs were unavoidable.</p>',
        12, NULL, 12, 8, '2024-01-12 00:00:00', '2024-01-12 00:00:00'),
       (13, 'Product Line Discontinued',
        '<p>With the discontinuation of one of our product lines, layoffs were announced.</p>', 13, NULL, 13, 9,
        '2024-01-13 00:00:00', '2024-01-13 00:00:00'),
       (14, 'Business Focus Shift',
        '<p>As our business focus shifts, it has resulted in the difficult decision of layoffs.</p>', 14, NULL, 14, 10,
        '2024-01-14 00:00:00', '2024-01-14 00:00:00'),
       (15, 'Competitive Market Layoffs',
        '<p>The competitive market has led to strategic layoffs to keep the company agile.</p>', 15, NULL, 15, 11,
        '2024-01-15 00:00:00', '2024-01-15 00:00:00'),
       (16, 'Financial Restructuring Effects',
        '<p>Financial restructuring has had a direct effect on our workforce.</p>', 16, NULL, 16, 12,
        '2024-01-16 00:00:00', '2024-01-16 00:00:00'),
       (17, 'Leadership Change and Layoffs',
        '<p>A change in leadership has led to a reevaluation of our staffing needs.</p>', 17, NULL, 17, 13,
        '2024-01-17 00:00:00', '2024-01-17 00:00:00'),
       (18, 'Regulatory Changes Impact', '<p>New regulatory changes have impacted our operations and staffing.</p>', 18,
        NULL, 18, 14, '2024-01-18 00:00:00', '2024-01-18 00:00:00'),
       (19, 'Legal Issues and Downsizing', '<p>Due to ongoing legal issues, the company has had to downsize.</p>', 19,
        NULL, 19, 15, '2024-01-19 00:00:00', '2024-01-19 00:00:00'),
       (20, 'Operational Efficiency Drive',
        '<p>Our drive for operational efficiency has unfortunately led to layoffs.</p>', 20, NULL, 20, 16,
        '2024-01-20 00:00:00', '2024-01-20 00:00:00'),
       (21, NULL, '<p>It''s a difficult transition for everyone affected by the cost optimization.</p>', 21, 4, 4, 0,
        '2024-01-04 00:00:00', '2024-01-04 00:00:00'),
       (22, NULL, '<p>Supporting each other is key during these budget cut times.</p>', 22, 5, 5, 0,
        '2024-01-05 00:00:00', '2024-01-05 00:00:00'),
       (23, NULL, '<p>Outsourcing may be beneficial long-term, but it''s hard to see colleagues go.</p>', 23, 6, 6, 0,
        '2024-01-06 00:00:00', '2024-01-06 00:00:00'),
       (24, NULL, '<p>Automation is essential, but the human cost is high.</p>', 24, 7, 7, 0, '2024-01-07 00:00:00',
        '2024-01-07 00:00:00'),
       (25, NULL, '<p>Mergers are complex, and the job losses are unfortunate.</p>', 25, 8, 8, 0, '2024-01-08 00:00:00',
        '2024-01-08 00:00:00'),
       (26, NULL, '<p>Restructuring after acquisition is tough. Hope everyone lands on their feet.</p>', 26, 9, 9, 0,
        '2024-01-09 00:00:00', '2024-01-09 00:00:00'),
       (27, NULL, '<p>Downsizing affects us all, directly or indirectly.</p>', 27, 10, 10, 0, '2024-01-10 00:00:00',
        '2024-01-10 00:00:00'),
       (28, NULL, '<p>The economic challenges are real and painful for those laid off.</p>', 28, 11, 11, 0,
        '2024-01-11 00:00:00', '2024-01-11 00:00:00'),
       (29, NULL, '<p>Revenue issues are tough. Wishing the best for all affected.</p>', 29, 12, 12, 0,
        '2024-01-12 00:00:00', '2024-01-12 00:00:00'),
       (30, NULL, '<p>Product discontinuation is always hard. Thoughts with those who lost their jobs.</p>', 30, 13, 13,
        0, '2024-01-13 00:00:00', '2024-01-13 00:00:00'),
       (31, NULL, '<p>Shifts in business focus can be abrupt. Hope there''s a plan for the laid-off staff.</p>', 31, 14,
        14, 0, '2024-01-14 00:00:00', '2024-01-14 00:00:00'),
       (32, NULL, '<p>Market competition is fierce. It''s sad to see colleagues leave.</p>', 32, 15, 15, 0,
        '2024-01-15 00:00:00', '2024-01-15 00:00:00'),
       (33, NULL, '<p>Financial restructuring is a sign of the times. Solidarity with those affected.</p>', 33, 16, 16,
        0, '2024-01-16 00:00:00', '2024-01-16 00:00:00'),
       (34, NULL, '<p>Leadership changes bring uncertainty. Hoping for a smooth transition for all.</p>', 34, 17, 17, 0,
        '2024-01-17 00:00:00', '2024-01-17 00:00:00'),
       (35, NULL, '<p>Regulatory changes are challenging. Let''s support our former colleagues.</p>', 35, 18, 18, 0,
        '2024-01-18 00:00:00', '2024-01-18 00:00:00'),
       (36, NULL, '<p>Legal issues are daunting. Wishing strength to those who were laid off.</p>', 36, 19, 19, 0,
        '2024-01-19 00:00:00', '2024-01-19 00:00:00'),
       (37, NULL, '<p>Operational efficiency is important, but so are the people behind the operations.</p>', 37, 20,
        20, 0, '2024-01-20 00:00:00', '2024-01-20 00:00:00'),
       (38, NULL, '<p>Cost cutting is never easy. Hope we can all pull through this together.</p>', 38, 21, 4, 0,
        '2024-01-04 00:00:00', '2024-01-04 00:00:00'),
       (39, NULL, '<p>Times like these remind us of the importance of community and support.</p>', 39, 22, 5, 0,
        '2024-01-05 00:00:00', '2024-01-05 00:00:00'),
       (40, NULL, '<p>Outsourcing has its benefits, but the immediate effects are hard to bear.</p>', 40, 23, 6, 0,
        '2024-01-06 00:00:00', '2024-01-06 00:00:00'),
       (41, NULL, '<p>Automation may be the way forward, but we must consider its impact on our workforce.</p>', 41, 24,
        7, 0, '2024-01-07 00:00:00', '2024-01-07 00:00:00'),
       (42, NULL, '<p>Job security is a major concern during mergers. Let''s hope for the best.</p>', 42, 25, 8, 0,
        '2024-01-08 00:00:00', '2024-01-08 00:00:00'),
       (43, NULL, '<p>Change is constant, but it''s still hard to say goodbye to our coworkers.</p>', 43, 26, 9, 0,
        '2024-01-09 00:00:00', '2024-01-09 00:00:00'),
       (44, NULL, '<p>Downsizing is a harsh reality of business. Wishing the best for all affected.</p>', 44, 27, 10, 0,
        '2024-01-10 00:00:00', '2024-01-10 00:00:00'),
       (45, NULL, '<p>It''s a tough market, and these layoffs are a testament to that.</p>', 45, 28, 11, 0,
        '2024-01-11 00:00:00', '2024-01-11 00:00:00'),
       (46, NULL, '<p>Revenue shortfalls have real consequences. It''s a sad day for us.</p>', 46, 29, 12, 0,
        '2024-01-12 00:00:00', '2024-01-12 00:00:00'),
       (47, NULL, '<p>Discontinuing a product is tough, especially when it leads to layoffs.</p>', 47, 30, 13, 0,
        '2024-01-13 00:00:00', '2024-01-13 00:00:00'),
       (48, NULL, '<p>Business focus shifts can be sudden. Let''s stay strong and support each other.</p>', 48, 31, 14,
        0, '2024-01-14 00:00:00', '2024-01-14 00:00:00'),
       (49, NULL, '<p>The competitive nature of our market makes these layoffs particularly challenging.</p>', 49, 32,
        15, 0, '2024-01-15 00:00:00', '2024-01-15 00:00:00'),
       (50, NULL, '<p>Financial restructuring is difficult, but necessary for our company''s future.</p>', 50, 33, 16,
        0, '2024-01-16 00:00:00', '2024-01-16 00:00:00'),
       (51, NULL, '<p>Leadership changes can be unsettling. Hoping for a positive outcome for all.</p>', 51, 34, 17, 0,
        '2024-01-17 00:00:00', '2024-01-17 00:00:00'),
       (52, NULL, '<p>Regulatory changes are tough to navigate. We''re all in this together.</p>', 52, 35, 18, 0,
        '2024-01-18 00:00:00', '2024-01-18 00:00:00'),
       (53, NULL, '<p>Legal issues are never easy. Solidarity with those who are leaving.</p>', 53, 36, 19, 0,
        '2024-01-19 00:00:00', '2024-01-19 00:00:00'),
       (54, NULL, '<p>Operational efficiency is crucial, but it''s hard to see team members go.</p>', 54, 37, 20, 0,
        '2024-01-20 00:00:00', '2024-01-20 00:00:00'),
       (55, NULL, '<p>These cost-cutting measures are a sign of the times. Wishing everyone the best.</p>', 55, 38, 4,
        0, '2024-01-21 00:00:00', '2024-01-21 00:00:00'),
       (56, NULL, '<p>Community support is essential during these times of reduction in force.</p>', 56, 39, 5, 0,
        '2024-01-22 00:00:00', '2024-01-22 00:00:00'),
       (57, NULL, '<p>Division discontinuation is always hard. Let''s keep our heads up.</p>', 57, 40, 6, 0,
        '2024-01-23 00:00:00', '2024-01-23 00:00:00'),
       (58, NULL, '<p>Reorganization brings uncertainty, but also opportunity. Stay positive.</p>', 58, 41, 7, 0,
        '2024-01-24 00:00:00', '2024-01-24 00:00:00'),
       (59, NULL, '<p>Liquidation is the end of an era. Hoping for new beginnings for all.</p>', 59, 42, 8, 0,
        '2024-01-25 00:00:00', '2024-01-25 00:00:00'),
       (60, NULL, '<p>Business model changes are tough. Let''s adapt and overcome.</p>', 60, 43, 9, 0,
        '2024-01-26 00:00:00', '2024-01-26 00:00:00');
