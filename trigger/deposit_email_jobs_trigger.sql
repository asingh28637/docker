USE wallet_production;

CREATE TABLE IF NOT EXISTS `deposit_email_jobs` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `deposit_id` bigint NOT NULL,
  `member_id` bigint NOT NULL,
  `currency_id` varchar(50) NOT NULL,
  `address` varchar(512) DEFAULT NULL,
  `amount` decimal(34,18) NOT NULL,
  `from_addresses` text,
  `txid` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `email_status` enum('pending','sent','failed') DEFAULT 'pending',
  `retry_count` int DEFAULT '0',
  `last_attempt_at` datetime(3) DEFAULT NULL,
  `error_message` varchar(1000) DEFAULT NULL,
  `created_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updated_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_deposit_id` (`deposit_id`),
  KEY `idx_status` (`email_status`),
  KEY `idx_member_id` (`member_id`)
);

USE peatio_production;

DROP TRIGGER IF EXISTS trg_after_insert_deposit;
DROP TRIGGER IF EXISTS trg_after_update_deposit_processing;

DELIMITER $$

CREATE TRIGGER trg_after_update_deposit_processing
AFTER UPDATE ON peatio_production.deposits
FOR EACH ROW
BEGIN
  DECLARE v_exists INT DEFAULT 0;

  -- Only run if state transitions into 'accepted'
  IF (OLD.aasm_state != 'accepted' AND NEW.aasm_state = 'accepted') THEN

    -- Check if the currency is allowed for deposit emails
    SELECT COUNT(*)
      INTO v_exists
    FROM wallet_production.email_currencies
    WHERE currency_id = NEW.currency_id
      AND allow_deposit_email = 1;

    -- Insert or update deposit_email_jobs
    IF v_exists > 0 THEN
      INSERT INTO wallet_production.deposit_email_jobs (
        deposit_id,
        member_id,
        currency_id,
        amount,
        address,
        from_addresses,
        txid,
        email_status,
        created_at,
        updated_at
      ) VALUES (
        NEW.id,
        NEW.member_id,
        NEW.currency_id,
        NEW.amount,
        NEW.address,
        NEW.from_addresses,
        NEW.txid,
        'pending',
        NOW(3),
        NOW(3)
      );
    END IF;

  END IF;
END$$

DELIMITER ;
