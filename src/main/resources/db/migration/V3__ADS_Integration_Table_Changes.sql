ALTER TABLE `assortment` ADD COLUMN `generated_on` TIMESTAMP NOT NULL after transaction_id;
ALTER TABLE `execution` CHANGE COLUMN `id` `execution_id` CHAR(36) NOT NULL;
ALTER TABLE `assortment` CHANGE COLUMN `id` `assortment_id` CHAR(36) NOT NULL;

ALTER TABLE `execution` DROP FOREIGN KEY `transaction_ibfk_3`;
ALTER TABLE `execution` DROP INDEX `transaction_id`;
ALTER TABLE `execution` CHANGE COLUMN `transaction_id` `assortment_id` CHAR(36) NOT NULL;
ALTER TABLE `execution` ADD CONSTRAINT `assortment_ibfk_3` FOREIGN KEY (assortment_id) REFERENCES assortment(assortment_id);
CREATE INDEX `assortment_id` ON `execution` (`assortment_id`);

ALTER TABLE `assortment` ADD COLUMN `errors` TEXT NULL after vendor;
ALTER TABLE `transaction` DROP COLUMN `errors`;
ALTER TABLE `execution` ADD COLUMN `status` ENUM('IN_PROGRESS','FAILED','SUCCESS') after processed_at;