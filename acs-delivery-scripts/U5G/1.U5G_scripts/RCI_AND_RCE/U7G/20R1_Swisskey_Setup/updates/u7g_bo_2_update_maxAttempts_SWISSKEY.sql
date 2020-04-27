USE U7G_ACS_BO;

SET @BankCS = 'CS';
SET @BankNAB = 'NAB';
SET @BankSGKB = 'SGKB';


Update `Profile` SET `maxAttempts` = 4
WHERE `name` = CONCAT(@BankCS,'_TA_01') 
   or `name` = CONCAT(@BankNAB,'_TA_01') 
   or `name` = CONCAT(@BankSGKB,'_TA_01') 
   or`name` = CONCAT(@BankCS,'_SMS_01') 
   or`name` = CONCAT(@BankNAB,'_SMS_01') 
   or`name` = CONCAT(@BankSGKB,'_SMS_01');



