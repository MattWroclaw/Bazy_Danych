-- Drop function My_Sum if it already exists.
-- (To enable Recreate)
DROP function  if Exists `My_Sum`;
 
-- When programming the function / procedure you need to use semicolon
-- to separate the different commands.
-- Use DELIMITER $$ to allow use of semicolons.

DELIMITER $$
Create Function My_Sum(a Float, b Float) returns Float
Begin 
 
 -- Declare a variable Float
  Declare output Float;
  
  -- Assigning value to variable v_C
  Set output = a+b;
  
  -- The return value of the function.
  return output;
 
End;

SELECT
    acc.account_id,
    acc.cust_id,
    acc.avail_balance,
    acc.pending_balance,
    My_Sum(acc.avail_balance, acc.pending_balance) balance
FROM
    account acc;