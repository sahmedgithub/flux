
CREATE TABLE IF NOT EXISTS transaction_group
(
	group_id                    CHAR(36) PRIMARY KEY,
	transaction_group_name      varchar(150) NOT NULL,
    transaction_group_comment   TEXT DEFAULT NULL,
	created_date                TIMESTAMP  NULL,
	last_modified_date          TIMESTAMP  NULL,
	created_by                  VARCHAR(50) NOT NULL,
	last_modified_by            VARCHAR(50) NOT NULL,
	creation_flag               ENUM('CREATING','COMPLETE','ERROR') DEFAULT NULL,
	source_system_id            varchar(50) DEFAULT NULL,
	errors                      TEXT NULL DEFAULT NULL
);

CREATE INDEX `last_modified_date`
    ON `transaction_group` (`last_modified_date`);
CREATE INDEX `created_date`
    ON `transaction_group` (`created_date`);

CREATE TABLE IF NOT EXISTS transaction
(
	transaction_id     CHAR(36) PRIMARY KEY,
	group_id           CHAR(36) NOT NULL,
	department_number  INT NOT NULL,
	class_number       INT NOT NULL,
	execution_date     TIMESTAMP NULL,
	completion_flag    ENUM('COMPLETED', 'RUNNING','FAILED', 'NOT_COMPLETED') NULL
												 DEFAULT 'NOT_COMPLETED',
	transaction_type   VARCHAR(50) NULL COMMENT 'Only used for tracking purposes',
	validation_flag    ENUM('VALID', 'NO_ACTION_NEEDED', 'INVALID', 'ERROR') NULL,
	created_date       TIMESTAMP  NULL,
	last_modified_date TIMESTAMP  NULL,
	created_by         VARCHAR(50) NOT NULL,
	last_modified_by   VARCHAR(50) NOT NULL,
	errors             TEXT NULL DEFAULT NULL,
	CONSTRAINT transaction_ibfk_1 FOREIGN KEY (group_id) REFERENCES
		transaction_group (group_id)
);

CREATE INDEX `group_id`
    ON `transaction` (`group_id`);
CREATE INDEX `department_class`
  ON `transaction` (`department_number`, `class_number`);
CREATE INDEX `execution_date`
  ON `transaction` (`execution_date`);
CREATE INDEX `last_modified_date`
    ON `transaction` (`last_modified_date`);
CREATE INDEX `created_date`
    ON `transaction` (`created_date`);

CREATE TABLE IF NOT EXISTS assortment
(
  `id`                     CHAR(36),
  `transaction_id`         CHAR(36) NOT NULL,
  `sku_number`             INT(11)  NOT NULL,
  `assorted`               BOOL NOT NULL DEFAULT FALSE,
  `replenishment`          BOOL NOT NULL DEFAULT FALSE,
  `clearance`              BOOL NOT NULL DEFAULT FALSE,
  `location`               VARCHAR(20) NOT NULL,
  `location_type`          ENUM ('STORE', 'ONLINE') NOT NULL,
  `strategy`               ENUM ('ACTIVE', 'INSEASON', 'OUTSEASON', 'INACTIVE', 'INACTIVE_PROMO', 'INACTIVE_NATURAL_DISASTER', 'INACTIVE_PENDING_BUY_BACK', 'INACTIVE_NEW_SKU', 'INACTIVE_NO_MAINTENANCE', 'INACTIVE_SKU_PENDING', 'INACTIVE_RESET', 'INACTIVE_EXITING', 'CLEARANCE', 'DELETE') NULL,
  `selling_channel`        ENUM('STORE_STOCK','SPECIAL_ORDER','QUOTE_CENTER','TOOL_RENTAL','ONLINE_HDCOM','ONLINE_TCS','ONLINE_HDPRO','INSTALL_SERVICE') DEFAULT NULL,
  `vendor`                 INT(11) NULL,

  PRIMARY KEY (`id`),
  CONSTRAINT transaction_ibfk_2 FOREIGN KEY (transaction_id) REFERENCES
        transaction (transaction_id)
);

CREATE INDEX `transaction_id`
  ON `assortment` (`transaction_id`);
CREATE INDEX `sku`
  ON `assortment` (`sku_number`);
CREATE INDEX `vendor`
  ON `assortment` (`vendor`);
CREATE INDEX `location`
  ON `assortment` (`location_type`, `location`);


CREATE TABLE IF NOT EXISTS execution
(
    id                 CHAR(36),
    request_id         CHAR(36) NOT NULL,
    transaction_id     CHAR(36) NOT NULL,
    requested_at       TIMESTAMP NULL,
    processed_at       TIMESTAMP NULL,
    errors             TEXT NULL,
    PRIMARY KEY (`id`),
    CONSTRAINT transaction_ibfk_3 FOREIGN KEY (transaction_id) REFERENCES
        transaction (transaction_id)
);

CREATE INDEX `request_id`
    ON `execution` (`request_id`);
CREATE INDEX `transaction_id`
  ON `execution` (`transaction_id`);
CREATE INDEX `requested_at`
  ON `execution` (`requested_at`);
CREATE INDEX `processed_at`
  ON `execution` (`processed_at`);
