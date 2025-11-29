# Code Readme

This readme provides information on how to the `update_child_to_parent_balance_trigger` for `processing deposit` in `peatio_production`.

## Requirements

To install the `deposit_tracking` table in `wallet_production`, you must:

- Have access to the `wallet_production` database.
- Run the trigger setup by executing `trigger.sql`.

## Installation Steps

1. Log in to the `wallet_production` database.

2. Create the `deposit_tracking` table by executing the following SQL code:

```
USE wallet_production;

CREATE TABLE `deposit_tracking` (
  `deposit_id` bigint(20) NOT NULL,
  `member_id` int(11) NOT NULL,
  `amount` decimal(34,18) NOT NULL,
  `parent_currency` varchar(10) NOT NULL,
  `child_currency` varchar(10) NOT NULL,
  `parent_balance` decimal(34,18) NOT NULL,
  `child_balance` decimal(34,18) NOT NULL,
  `new_parent_balance` decimal(34,18) NOT NULL,
  `new_child_balance` decimal(34,18) NOT NULL,
  `status` varchar(45) DEFAULT NULL,
  `scan_at` datetime NOT NULL,
  PRIMARY KEY (`deposit_id`)
);
```

3. Run the trigger setup by executing the `update_child_to_parent_balance_trigger.sql` file.

## Conclusion

This readme provides a guide on how to install the `update_child_to_parent_balance_trigger` for `processing deposit` in `peatio_production`. If you encounter any issues during installation, please contact your administrator for assistance.
