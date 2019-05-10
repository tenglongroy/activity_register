/**
Python file activity_model.py will execute this file and initialise the database.
*/
DROP DATABASE IF EXISTS activity_register;
CREATE DATABASE activity_register CHARACTER SET 'utf8';
USE activity_register;


/**
create activity table if not exists
insert dummy data if table is empty
*/
CREATE TABLE IF NOT EXISTS `userlist` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(24) DEFAULT NULL,
  `password` varchar(24) DEFAULT NULL,
  `nickname` varchar(48) DEFAULT NULL,
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;

insert into userlist values(NULL, 'tenglongroy', 'tenglong', 'Roy', NULL), (NULL, 'someoneA', 'someone', 'asdf', NULL), 
                    (NULL, 'roytenglong', 'tenglong', 'roytenglong', NULL), (NULL, 'tenglong', 'tenglong', 'tenglong', NULL);
insert into userlist (user_id, username, password, nickname, create_time)
(select NULL, 'tenglongroy', 'tenglong', 'Roy', now() 
  where not exists (select * from userlist)
) UNION ALL 
(select NULL, 'someoneA', 'someone', 'asdf', now()
where not exists (select * from userlist)
) UNION ALL 
(select NULL, 'roytenglong', 'tenglong', 'roytenglong', now()
where not exists (select * from userlist)
) UNION ALL 
(select NULL, 'tenglong', 'tenglong', 'tenglong', now()
where not exists (select * from userlist));


/**
create activity table if not exists
insert dummy data if table is empty
*/
CREATE TABLE IF NOT EXISTS `activitylist` (
  `act_id` int(11) NOT NULL AUTO_INCREMENT,
  `maker_id` int(11) NOT NULL,
  `title` varchar(128) NOT NULL,
  `min_participant` int(4) NOT NULL COMMENT 'minimun population to make this activity happen',
  `current_number` int(4) NOT NULL DEFAULT 0,
  `start_time` datetime,
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `activity_type` varchar(128) NOT NULL DEFAULT 'board game',
  `description_added` LONGTEXT,
  PRIMARY KEY (`act_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

insert into activitylist (act_id, maker_id, title, min_participant, current_number, start_time, create_time, activity_type)
(select 1, 1, 'Texas Holdem', 12, 3, now() + interval 7 day, now(), 'board game'
  where not exists (select * from activitylist)
) UNION ALL 
(select 2, 2, 'Moore Park basketball', 8, 0, now() + interval 7 day, now(), 'Sports'
where not exists (select * from activitylist));


/**
create activity table if not exists
insert dummy data if table is empty
*/
CREATE TABLE IF NOT EXISTS `joinlist` (
  `transac_id` int(11) NOT NULL AUTO_INCREMENT,
  `act_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT 0,
  `nickname` varchar(48) NOT NULL,
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`transac_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

insert into joinlist values(NULL, 1, 1, 'Roy', NULL), (NULL, 1, NULL, 'wtf', NULL), (NULL, 1, 4, 'tenglong', NULL);
insert into joinlist (transac_id, act_id, user_id, nickname, create_time)
(select NULL, 1, 1, 'Roy', now()
  where not exists (select * from joinlist)
) UNION ALL
(select NULL, 1, NULL, 'wtf', now()
  where not exists (select * from joinlist)
) UNION ALL
(select NULL, 1, 4, 'tenglong', now()
  where not exists (select * from joinlist));


/**
TO-DO
to modify insert following the syntax of activitylist
test in database
*/
CREATE TABLE IF NOT EXISTS `tokenlist` (
    `user_id` int(11) NOT NULL,
    `token` varchar(512) NOT NULL,
    `IP_address` varchar(24) DEFAULT NULL,
    `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;

insert into tokenlist (user_id, token, IP_address, create_time)
(select 1, 'asdf', NULL, now()
  where not exists (select * from tokenlist)
) UNION ALL 
(select 2, 'asdfaaa', NULL, now()
where not exists (select * from tokenlist));




/**
TO-DO
to modify insert following the syntax of activitylist
test in database
*/
--disgarded due to intergration into joinlist
CREATE TABLE IF NOT EXISTS `joinvisitorlist` (
  `act_id` int(11) NOT NULL,
  `nickname` varchar(48) NOT NULL,
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`act_id`, `nickname`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

insert into joinvisitorlist values(1, 'wtf', NULL);