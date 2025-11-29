DROP TRIGGER IF EXISTS deposit_update_child_to_parent_balance_trigger;
USE peatio_production;
DELIMITER //
CREATE TRIGGER deposit_update_child_to_parent_balance_trigger
AFTER UPDATE ON deposits
FOR EACH ROW
BEGIN
	DECLARE parent VARCHAR(10);
	DEClARE parent_balance DECIMAL(38,14);
    DEClARE child_balance DECIMAL(38,14);
    DEClARE new_parent_balance DECIMAL(38,14);
    DEClARE new_child_balance DECIMAL(38,14);
    DEClARE has_deposit_tracking int;
	DEClARE has_parent_balance int;

    
    SELECT parent_id INTO parent FROM wallet_production.child_currencies WHERE child_id = NEW.currency_id;
    SELECT balance INTO child_balance FROM peatio_production.accounts WHERE member_id = NEW.member_id AND currency_id = NEW.currency_id;
    SELECT balance INTO parent_balance FROM peatio_production.accounts WHERE member_id = NEW.member_id AND currency_id = parent;
	SELECT COUNT(deposit_id) INTO has_deposit_tracking FROM wallet_production.deposit_tracking WHERE deposit_id = NEW.id;

    
	IF parent IS NULL AND child_balance IS NULL AND NEW.aasm_state = 'processing' AND has_deposit_tracking = 0 THEN
		INSERT INTO peatio_production.accounts(member_id, currency_id, balance, locked, created_at, updated_at)
		VALUES(NEW.member_id, NEW.currency_id, 0,0, NOW(), NOW());
	END IF;

	IF parent IS NOT NULL AND NEW.aasm_state = 'processing' AND has_deposit_tracking = 0 THEN
		SELECT COUNT(balance) INTO has_parent_balance FROM peatio_production.accounts WHERE member_id = NEW.member_id AND currency_id = parent;

        IF has_parent_balance = 0 THEN
			INSERT INTO peatio_production.accounts(member_id, currency_id, balance, locked, created_at, updated_at)
			VALUES(NEW.member_id, parent, 0,0, NOW(), NOW());
            SET parent_balance = 0;
            SET new_parent_balance = NEW.amount;
		ELSE
			SET new_parent_balance = (parent_balance + NEW.amount);
		END IF;
        SET new_child_balance = (child_balance - NEW.amount);
        IF child_balance < NEW.amount THEN 
			INSERT INTO wallet_production.deposit_tracking(deposit_id,member_id,amount,parent_currency,child_currency,parent_balance,child_balance,new_parent_balance,new_child_balance,status,scan_at)
			VALUES(NEW.id,NEW.member_id,NEW.amount,parent,NEW.currency_id,parent_balance,child_balance,new_parent_balance,new_child_balance,'failed | child_balance < deposit.amount',NOW());
        ELSE 
			UPDATE peatio_production.accounts SET balance = new_child_balance WHERE member_id = NEW.member_id AND currency_id = NEW.currency_id;
			UPDATE peatio_production.accounts SET balance = new_parent_balance WHERE member_id = NEW.member_id AND currency_id = parent;
   
			INSERT INTO wallet_production.deposit_tracking(deposit_id,member_id,amount,parent_currency,child_currency,parent_balance,child_balance,new_parent_balance,new_child_balance,status,scan_at)
			VALUES(NEW.id,NEW.member_id,NEW.amount,parent,NEW.currency_id,parent_balance,child_balance,new_parent_balance,new_child_balance,'success',NOW());
        END IF;
    END IF;
END //
DELIMITER ;
