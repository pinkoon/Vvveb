DROP TABLE IF EXISTS `attribute_group`;

CREATE TABLE `attribute_group` (
  `attribute_group_id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `sort_order` INT NOT NULL DEFAULT 0
--  PRIMARY KEY (`attribute_group_id`)
);
