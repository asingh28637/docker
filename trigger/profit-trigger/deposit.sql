-- INSTAL DATABASE PROFIT
CREATE DATABASE IF NOT EXISTS profit_production;
USE profit_production;

-- INSTALL TABLE TABLE
CREATE TABLE IF NOT EXISTS `deposit_tracking` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `deposit_id` bigint NOT NULL,
  `member_id` bigint NOT NULL,
  `currency_id` varchar(10) NOT NULL,
  `amount` decimal(34,18) NOT NULL,
  `fee` decimal(34,18) NOT NULL,
  `cash` decimal(34,18) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `deposit_wallet` (
  `currency_id` varchar(10) NOT NULL,
  `total` decimal(34,18) NOT NULL DEFAULT '0.000000000000000000',
  `remaining` decimal(34,18) NOT NULL DEFAULT '0.000000000000000000',
  `spent` decimal(34,18) NOT NULL DEFAULT '0.000000000000000000',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`currency_id`)
);

-- CREATE TRIGGER ON PEATIO_PRODUCTION
USE peatio_production;

DROP TRIGGER IF EXISTS deposit_fee_tracking_trigger;

DELIMITER //
CREATE TRIGGER deposit_fee_tracking_trigger
AFTER UPDATE ON peatio_production.deposits
FOR EACH ROW
BEGIN
	
	DECLARE currency VARCHAR(10);
    DECLARE cash DECIMAL(34,18);
    DECLARE has_tracking int;
    
	IF NEW.aasm_state = 'processing' AND NEW.fee > 0 THEN
		SELECT COUNT(deposit_id) INTO has_tracking FROM profit_production.deposit_tracking WHERE deposit_id = NEW.id;
        
        IF has_tracking = 0 THEN 
			SELECT parent_id INTO currency FROM wallet_production.child_currencies WHERE child_id = NEW.currency_id;

			IF currency IS NULL THEN
				SET currency = NEW.currency_id;
			END IF;

			IF NEW.fee >=1 THEN
				SET cash = NEW.fee;
			ELSE
				SET cash = (NEW.amount * NEW.fee) / (1 - NEW.fee);
			END IF;
			
			INSERT INTO profit_production.deposit_tracking (deposit_id, member_id, currency_id, amount, fee, cash)
			VALUES (NEW.id, NEW.member_id, currency, NEW.amount, NEW.fee, cash);
        END IF;
    END IF;
END //
DELIMITER ;

-- CREATE TRIGGER ON PROFIT_PRODUCTION
DROP TRIGGER IF EXISTS deposit_wallet_trigger;
USE profit_production;
DELIMITER //
CREATE TRIGGER deposit_wallet_trigger
AFTER INSERT ON profit_production.deposit_tracking
FOR EACH ROW
BEGIN
	
    DECLARE account_total DECIMAL(34,18);
    DECLARE account_remaining DECIMAL(34,18);
    DECLARE new_total DECIMAL(34,18);
    DECLARE new_remaining DECIMAL(34,18);
    
	SELECT total, remaining INTO account_total, account_remaining FROM profit_production.deposit_wallet WHERE currency_id = NEW.currency_id;
			
    IF account_total IS NULL THEN
        INSERT INTO profit_production.deposit_wallet(currency_id, total, remaining, spent, created_at, updated_at)
        VALUES(NEW.currency_id, 0, 0, 0, NOW(), NOW());
        SET account_total = 0;
        SET account_remaining = 0;
    END IF;

    SET new_total = account_total + NEW.cash;
    SET new_remaining = account_remaining + NEW.cash;

    UPDATE profit_production.deposit_wallet SET total = new_total, remaining = new_remaining WHERE currency_id = NEW.currency_id;
END //
DELIMITER ;
