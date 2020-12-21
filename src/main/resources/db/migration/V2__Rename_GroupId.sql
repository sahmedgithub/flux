ALTER TABLE `transaction_group` CHANGE COLUMN `group_id` `transaction_group_id` CHAR(36) NOT NULL;
ALTER TABLE `transaction` CHANGE COLUMN `group_id` `transaction_group_id` CHAR(36) NOT NULL;
