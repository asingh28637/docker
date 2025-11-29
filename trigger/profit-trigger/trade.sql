-- CREATE TRGGER
USE peatio_production;
DROP TRIGGER IF EXISTS trade_trigger;
-- CREATE TABLE
USE profit_production;

CREATE TABLE IF NOT EXISTS `trade_tracking` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `trade_id` BIGINT NOT NULL,
    `member_id` VARCHAR(45) NOT NULL,
    `type` VARCHAR(10) NOT NULL,
    `order_id` BIGINT NOT NULL,
    `currency_id` VARCHAR(10) NOT NULL,
    `value` DECIMAL(34 , 18 ) NOT NULL,
    `fee` DECIMAL(34 , 18 ) NOT NULL,
    `cash` DECIMAL(34 , 18 ) NOT NULL,
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `trade_wallet` (
  `currency_id` varchar(10) NOT NULL,
  `total` decimal(34,18) NOT NULL DEFAULT '0.000000000000000000',
  `remaining` decimal(34,18) NOT NULL DEFAULT '0.000000000000000000',
  `spent` decimal(34,18) NOT NULL DEFAULT '0.000000000000000000',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`currency_id`)
);


-- CREATE TRIGGER
USE peatio_production;
DROP TRIGGER IF EXISTS trade_trigger;
DELIMITER //
CREATE TRIGGER trade_trigger
AFTER INSERT ON peatio_production.trades
FOR EACH ROW
BEGIN
	DECLARE bid_currency VARCHAR(10);
    DECLARE i_maker_fee DECIMAL(38,14);
    DECLARE ask_currency VARCHAR(10);
    DECLARE i_taker_fee DECIMAL(38,14);

    DECLARE i_maker_cash DECIMAL(38,14);
    DECLARE i_taker_cash DECIMAL(38,14);

SELECT 
    bid, maker_fee
INTO bid_currency , i_maker_fee FROM
    peatio_production.orders
WHERE
    id = NEW.maker_order_id;
SELECT 
    ask, taker_fee
INTO ask_currency , i_taker_fee FROM
    peatio_production.orders
WHERE
    id = NEW.taker_order_id;

    IF NEW.taker_type = 'sell' THEN 
      SET i_taker_cash = NEW.total * i_taker_fee;

      IF i_taker_fee > 0 THEN 
        INSERT INTO `profit_production`.`trade_tracking` (`trade_id`, `member_id`, `type`, `order_id`, `currency_id`, `value`, `fee`, `cash`) 
      VALUES (
      NEW.id,
      NEW.taker_id,
      'sell',
      NEW.taker_order_id,
      bid_currency,
      NEW.total,
      i_taker_fee,
      i_taker_cash);

      END IF;

      SET i_maker_cash = NEW.amount * i_maker_fee;

      IF i_maker_fee > 0 THEN 
        INSERT INTO `profit_production`.`trade_tracking` (`trade_id`, `member_id`, `type`, `order_id`, `currency_id`, `value`, `fee`, `cash`) 
      VALUES (
      NEW.id,
      NEW.maker_id,
      'sell',
      NEW.maker_order_id,
      ask_currency,
      NEW.amount,
      i_maker_fee,
      i_maker_cash);
      END IF;
    END IF;

    IF NEW.taker_type = 'buy' THEN 
      SET i_taker_cash = NEW.amount * i_taker_fee;

      IF i_taker_fee > 0 THEN 
        INSERT INTO `profit_production`.`trade_tracking` (`trade_id`, `member_id`, `type`, `order_id`, `currency_id`, `value`, `fee`, `cash`) 
      VALUES (
      NEW.id,
      NEW.taker_id,
      'buy',
      NEW.taker_order_id,
      ask_currency,
      NEW.amount,
      i_taker_fee,
      i_taker_cash);
      END IF;

      SET i_maker_cash = NEW.total * i_maker_fee;

      IF i_maker_fee > 0 THEN 
        INSERT INTO `profit_production`.`trade_tracking` (`trade_id`, `member_id`, `type`, `order_id`, `currency_id`, `value`, `fee`, `cash`) 
        VALUES (
        NEW.id,
        NEW.maker_id,
        'buy',
        NEW.maker_order_id,
        bid_currency,
        NEW.total,
        i_maker_fee,
        i_maker_cash);
      END IF;
    END IF;
END //
DELIMITER ;
