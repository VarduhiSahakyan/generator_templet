/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

USE `U7G_ACS_BO`;

/*!40000 ALTER TABLE `Issuer` DISABLE KEYS */;
SET @createdBy ='A758582';
SET @issuerCode = '41001';
SET @subIssuerCode_SOBA = '83340';
SET @subIssuerCode_LUKB = '77800';
SET @subIssuerCode_BALI = '87310';
SET  @subIssuerCode_LLB = '88000';
SET @issuerId = (SELECT `id` FROM `Issuer` WHERE `code` = @issuerCode);

/* ProfileSet */
/*!40000 ALTER TABLE `ProfileSet` DISABLE KEYS */;
SET @BankB = 'SWISSKEY';
SET @BankUB_SOBA = 'SOBA';
SET @BankUB_LUKB = 'LUKB';
SET @BankUB_BALI = 'BALI';
SET @BankUB_LLB = 'LLB';

SET @ProfileSetSwisskey = (SELECT id FROM `ProfileSet` WHERE `name` = CONCAT('PS_', @BankB, '_01'));
SET @ProfileSet_SOBA = (SELECT id FROM `ProfileSet` WHERE `name` = CONCAT('PS_', @BankUB_SOBA, '_01'));
SET @ProfileSet_LUKB = (SELECT id FROM `ProfileSet` WHERE `name` = CONCAT('PS_', @BankUB_LUKB, '_01'));
SET @ProfileSet_BALI = (SELECT id FROM `ProfileSet` WHERE `name` = CONCAT('PS_', @BankUB_BALI, '_01'));
SET @ProfileSet_LLB = (SELECT id FROM `ProfileSet` WHERE `name` = CONCAT('PS_', @BankUB_LLB, '_01'));

UPDATE `BinRange` SET `fk_id_profileSet` = @ProfileSetSwisskey WHERE `fk_id_profileSet` IN (@ProfileSet_SOBA,
                                                                                            @ProfileSet_LUKB,
                                                                                            @ProfileSet_BALI,
                                                                                            @ProfileSet_LLB);


UPDATE `CustomItem` SET `ordinal` = @subIssuerCode_SOBA WHERE `value` =  @BankUB_SOBA AND `name` = 'Bank Logo';
UPDATE `CustomItem` SET `ordinal` = @subIssuerCode_LUKB WHERE `value` =  @BankUB_LUKB AND `name` = 'Bank Logo';
UPDATE `CustomItem` SET `ordinal` = @subIssuerCode_BALI WHERE `value` =  @BankUB_BALI AND `name` = 'Bank Logo';
UPDATE `CustomItem` SET `ordinal` =  @subIssuerCode_LLB WHERE `value` =  @BankUB_LLB AND `name` = 'Bank Logo';


# Update CustomItem for SOBA
SET @customItemSetREFUSALFraud = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB_SOBA, '_REFUSAL_FRAUD'));
SET @customItemSetREFUSALFraudSwisskey = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankB, '_REFUSAL_FRAUD'));
 UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetREFUSALFraudSwisskey
 WHERE `fk_id_customItemSet` =  @customItemSetREFUSALFraud
   AND `ordinal` = @subIssuerCode_SOBA
   AND `pageTypes` = 'ALL';


SET @customItemSetREFUSAL = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB_SOBA, '_DEFAULT_REFUSAL'));
SET @customItemSetREFUSALSwisskey = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankB, '_DEFAULT_REFUSAL'));
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetREFUSALSwisskey
WHERE `fk_id_customItemSet` =  @customItemSetREFUSAL
  AND `ordinal` = @subIssuerCode_SOBA
  AND `pageTypes` = 'ALL';

SET @customItemSetRefusalMissing = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankUB_SOBA, '_MISSING_AUTHENTICATION_REFUSAL'));
SET @customItemSetRefusalMissingSwisskey = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankB, '_MISSING_AUTHENTICATION_REFUSAL'));
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetRefusalMissingSwisskey
WHERE `fk_id_customItemSet` =  @customItemSetRefusalMissing
  AND `ordinal` = @subIssuerCode_SOBA
  AND `pageTypes` = 'ALL';

SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB_SOBA, '_SMS'));
SET @customItemSetSMSSwisskey = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankB, '_SMS'));
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetSMSSwisskey
WHERE `fk_id_customItemSet` =  @customItemSetSMS
  AND `ordinal` = @subIssuerCode_SOBA
  AND `pageTypes` = 'ALL';

UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetSMSSwisskey WHERE
                                                                                `value` = CONCAT(@BankUB_SOBA,'_SMALL_LOGO') AND
                                                                                `name` = 'Bank Logo' AND
                                                                                `fk_id_customItemSet` = @customItemSetSMS ;
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetSMSSwisskey WHERE `value` = CONCAT(@BankUB_SOBA,'_MEDIUM_LOGO') AND
                                                                                `name` = 'Bank Logo' AND
                                                                                `fk_id_customItemSet` = @customItemSetSMS ;
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetSMSSwisskey WHERE `value` = CONCAT(@BankUB_SOBA,'_LARGE_LOGO') AND
                                                                                `name` = 'Bank Logo' AND
                                                                                `fk_id_customItemSet` = @customItemSetSMS ;

SET @customItemSetMobileApp = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB_SOBA, '_MOBILE_APP'));
SET @customItemSetMobileAppSwisskey = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankB, '_MOBILE_APP'));
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetMobileAppSwisskey
WHERE `fk_id_customItemSet` =  @customItemSetMobileApp
  AND `ordinal` = @subIssuerCode_SOBA
  AND `pageTypes` = 'ALL';

UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetMobileAppSwisskey WHERE `value` = CONCAT(@BankUB_SOBA,'_SMALL_LOGO') AND
                                                                                        `name` = 'Bank Logo' AND
                                                                                        `fk_id_customItemSet` = @customItemSetMobileApp ;
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetMobileAppSwisskey WHERE `value` = CONCAT(@BankUB_SOBA,'_MEDIUM_LOGO') AND
                                                                                        `name` = 'Bank Logo' AND
                                                                                        `fk_id_customItemSet` = @customItemSetMobileApp ;
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetMobileAppSwisskey WHERE `value` = CONCAT(@BankUB_SOBA,'_LARGE_LOGO') AND
                                                                                        `name` = 'Bank Logo' AND
                                                                                        `fk_id_customItemSet` = @customItemSetMobileApp ;



# Update CustomItem for LUKB
SET @customItemSetREFUSALFraud = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB_LUKB, '_REFUSAL_FRAUD'));
 UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetREFUSALFraudSwisskey
 WHERE `fk_id_customItemSet` =  @customItemSetREFUSALFraud
   AND `ordinal` = @subIssuerCode_LUKB
   AND `pageTypes` = 'ALL';


SET @customItemSetREFUSAL = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB_LUKB, '_DEFAULT_REFUSAL'));
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetREFUSALSwisskey
WHERE `fk_id_customItemSet` =  @customItemSetREFUSAL
  AND `ordinal` = @subIssuerCode_LUKB
  AND `pageTypes` = 'ALL';

SET @customItemSetRefusalMissing = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankUB_LUKB, '_MISSING_AUTHENTICATION_REFUSAL'));
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetRefusalMissingSwisskey
WHERE `fk_id_customItemSet` =  @customItemSetRefusalMissing
  AND `ordinal` = @subIssuerCode_LUKB
  AND `pageTypes` = 'ALL';

SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB_LUKB, '_SMS'));
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetSMSSwisskey
WHERE `fk_id_customItemSet` =  @customItemSetSMS
  AND `ordinal` = @subIssuerCode_LUKB
  AND `pageTypes` = 'ALL';

UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetSMSSwisskey WHERE
                                                                                `value` = CONCAT(@BankUB_LUKB,'_SMALL_LOGO') AND
                                                                                `name` = 'Bank Logo' AND
                                                                                `fk_id_customItemSet` = @customItemSetSMS ;
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetSMSSwisskey WHERE `value` = CONCAT(@BankUB_LUKB,'_MEDIUM_LOGO') AND
                                                                                `name` = 'Bank Logo' AND
                                                                                `fk_id_customItemSet` = @customItemSetSMS ;
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetSMSSwisskey WHERE `value` = CONCAT(@BankUB_LUKB,'_LARGE_LOGO') AND
                                                                                `name` = 'Bank Logo' AND
                                                                                `fk_id_customItemSet` = @customItemSetSMS ;

SET @customItemSetMobileApp = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB_LUKB, '_MOBILE_APP'));
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetMobileAppSwisskey
WHERE `fk_id_customItemSet` =  @customItemSetMobileApp
  AND `ordinal` = @subIssuerCode_LUKB
  AND `pageTypes` = 'ALL';

UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetMobileAppSwisskey WHERE `value` = CONCAT(@BankUB_LUKB,'_SMALL_LOGO') AND
                                                                                        `name` = 'Bank Logo' AND
                                                                                        `fk_id_customItemSet` = @customItemSetMobileApp ;
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetMobileAppSwisskey WHERE `value` = CONCAT(@BankUB_LUKB,'_MEDIUM_LOGO') AND
                                                                                        `name` = 'Bank Logo' AND
                                                                                        `fk_id_customItemSet` = @customItemSetMobileApp ;
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetMobileAppSwisskey WHERE `value` = CONCAT(@BankUB_LUKB,'_LARGE_LOGO') AND
                                                                                        `name` = 'Bank Logo' AND
                                                                                        `fk_id_customItemSet` = @customItemSetMobileApp ;


# Update CustomItem for BALI
SET @customItemSetREFUSALFraud = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB_BALI, '_REFUSAL_FRAUD'));
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetREFUSALFraudSwisskey
WHERE `fk_id_customItemSet` =  @customItemSetREFUSALFraud
  AND `ordinal` = @subIssuerCode_BALI
  AND `pageTypes` = 'ALL';

SET @customItemSetREFUSAL = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB_BALI, '_DEFAULT_REFUSAL'));
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetREFUSALSwisskey
WHERE `fk_id_customItemSet` =  @customItemSetREFUSAL
  AND `ordinal` = @subIssuerCode_BALI
  AND `pageTypes` = 'ALL';

SET @customItemSetRefusalMissing = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankUB_BALI, '_MISSING_AUTHENTICATION_REFUSAL'));
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetRefusalMissingSwisskey
WHERE `fk_id_customItemSet` =  @customItemSetRefusalMissing
  AND `ordinal` = @subIssuerCode_BALI
  AND `pageTypes` = 'ALL';

SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB_BALI, '_SMS'));
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetSMSSwisskey
WHERE `fk_id_customItemSet` =  @customItemSetSMS
  AND `ordinal` = @subIssuerCode_BALI
  AND `pageTypes` = 'ALL';

UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetSMSSwisskey WHERE
                                                                                `value` = CONCAT(@BankUB_BALI,'_SMALL_LOGO') AND
                                                                                `name` = 'Bank Logo' AND
                                                                                `fk_id_customItemSet` = @customItemSetSMS ;
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetSMSSwisskey WHERE `value` = CONCAT(@BankUB_BALI,'_MEDIUM_LOGO') AND
                                                                                `name` = 'Bank Logo' AND
                                                                                `fk_id_customItemSet` = @customItemSetSMS ;
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetSMSSwisskey WHERE `value` = CONCAT(@BankUB_BALI,'_LARGE_LOGO') AND
                                                                                `name` = 'Bank Logo' AND
                                                                                `fk_id_customItemSet` = @customItemSetSMS ;

# Update CustomItem for LLB
SET @customItemSetREFUSALFraud = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB_LLB, '_REFUSAL_FRAUD'));
 UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetREFUSALFraudSwisskey
 WHERE `fk_id_customItemSet` =  @customItemSetREFUSALFraud
   AND `ordinal` =  @subIssuerCode_LLB
   AND `pageTypes` = 'ALL';

SET @customItemSetREFUSAL = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB_LLB, '_DEFAULT_REFUSAL'));
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetREFUSALSwisskey
WHERE `fk_id_customItemSet` =  @customItemSetREFUSAL
  AND `ordinal` =  @subIssuerCode_LLB
  AND `pageTypes` = 'ALL';

SET @customItemSetRefusalMissing = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankUB_LLB, '_MISSING_AUTHENTICATION_REFUSAL'));
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetRefusalMissingSwisskey
WHERE `fk_id_customItemSet` =  @customItemSetRefusalMissing
  AND `ordinal` =  @subIssuerCode_LLB
  AND `pageTypes` = 'ALL';

SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB_LLB, '_OVERRIDE'));
SET @customItemSetSMSSwisskey = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankB, '_OVERRIDE'));
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetSMSSwisskey
WHERE `fk_id_customItemSet` =  @customItemSetSMS
  AND `ordinal` =  @subIssuerCode_LLB
  AND `pageTypes` = 'ALL';

UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetSMSSwisskey WHERE
                                                                                `value` = CONCAT(@BankUB_LLB,'_SMALL_LOGO') AND
                                                                                `name` = 'Bank Logo' AND
                                                                                `fk_id_customItemSet` = @customItemSetSMS ;
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetSMSSwisskey WHERE `value` = CONCAT(@BankUB_LLB,'_MEDIUM_LOGO') AND
                                                                                `name` = 'Bank Logo' AND
                                                                                `fk_id_customItemSet` = @customItemSetSMS ;
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetSMSSwisskey WHERE `value` = CONCAT(@BankUB_LLB,'_LARGE_LOGO') AND
                                                                                `name` = 'Bank Logo' AND
                                                                                `fk_id_customItemSet` = @customItemSetSMS ;

SET @customItemSetPassword = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB_LLB, '_PASSWORD'));
SET @customItemSetPasswordSwisskey = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankB, '_PASSWORD'));
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetPasswordSwisskey
WHERE `fk_id_customItemSet` =  @customItemSetPassword
  AND `ordinal` =  @subIssuerCode_LLB
  AND `pageTypes` = 'ALL';

UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetPasswordSwisskey WHERE `value` = CONCAT(@BankUB_LLB,'_SMALL_LOGO') AND
                                                                                        `name` = 'Bank Logo' AND
                                                                                        `fk_id_customItemSet` = @customItemSetPassword ;
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetPasswordSwisskey WHERE `value` = CONCAT(@BankUB_LLB,'_MEDIUM_LOGO') AND
                                                                                        `name` = 'Bank Logo' AND
                                                                                        `fk_id_customItemSet` = @customItemSetPassword ;
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetPasswordSwisskey WHERE `value` = CONCAT(@BankUB_LLB,'_LARGE_LOGO') AND
                                                                                        `name` = 'Bank Logo' AND
                                                                                        `fk_id_customItemSet` = @customItemSetPassword ;



/*!40000 ALTER TABLE `CustomItem` ENABLE KEYS */;
