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