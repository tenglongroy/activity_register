CREATE TABLE IF NOT EXISTS `tokenlist` (
    `user_id` int(11) NOT NULL,
    `token` varchar(512) NOT NULL,
    `IP_address` varchar(24) DEFAULT NULL,
    `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;

insert into tokenlist values(1, 'asdf', NULL, NULL), (2, 'asdfaaa', NULL, NULL);