/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

USE `U7G_ACS_BO`;

/*!40000 ALTER TABLE `Issuer` DISABLE KEYS */;
SET @createdBy ='A758582';
SET @issuerCode = '41001';
SET @subIssuerCode_CS = '48350';
SET @subIssuerCode_NAB = '58810';
SET @subIssuerCode_SGKB = '78100';
SET @subIssuerCode_BEKB = '79000';
SET @subIssuerCode_GRKB = '77400';
SET @subIssuerCode_TGKB = '78400';
SET @issuerId = (SELECT `id` FROM `Issuer` WHERE `code` = @issuerCode);

/* ProfileSet */
/*!40000 ALTER TABLE `ProfileSet` DISABLE KEYS */;
SET @BankB = 'SWISSKEY';
SET @BankUB_CS = 'CS';
SET @BankUB_NAB = 'NAB';
SET @BankUB_SGKB = 'SGKB';
SET @BankUB_BEKB = 'BEKB';
SET @BankUB_GRKB = 'GRKB';
SET @BankUB_TGKB = 'TGKB';


SET @ProfileSetSwisskey = (SELECT id FROM `ProfileSet` WHERE `name` = CONCAT('PS_', @BankB, '_01'));
SET @ProfileSet_CS = (SELECT id FROM `ProfileSet` WHERE `name` = CONCAT('PS_', @BankUB_CS, '_01'));
SET @ProfileSet_NAB = (SELECT id FROM `ProfileSet` WHERE `name` = CONCAT('PS_', @BankUB_NAB, '_01'));
SET @ProfileSet_BEKB = (SELECT id FROM `ProfileSet` WHERE `name` = CONCAT('PS_', @BankUB_BEKB, '_01'));
SET @ProfileSet_GRKB = (SELECT id FROM `ProfileSet` WHERE `name` = CONCAT('PS_', @BankUB_GRKB, '_01'));
SET @ProfileSet_TGKB = (SELECT id FROM `ProfileSet` WHERE `name` = CONCAT('PS_', @BankUB_TGKB, '_01'));

UPDATE `BinRange` SET `fk_id_profileSet` = @ProfileSetSwisskey WHERE `fk_id_profileSet` IN (@ProfileSet_CS,
                                                                                            @ProfileSet_NAB,
                                                                                            @ProfileSet_BEKB,
                                                                                            @ProfileSet_GRKB,
                                                                                            @ProfileSet_TGKB);


UPDATE `CustomItem` SET `ordinal` = @subIssuerCode_CS WHERE `value` =  @BankUB_CS AND `name` = 'Bank Logo';
UPDATE `CustomItem` SET `ordinal` = @subIssuerCode_NAB WHERE `value` =  @BankUB_NAB AND `name` = 'Bank Logo';
UPDATE `CustomItem` SET `ordinal` = @subIssuerCode_SGKB WHERE `value` =  @BankUB_SGKB AND `name` = 'Bank Logo';
UPDATE `CustomItem` SET `ordinal` = @subIssuerCode_BEKB WHERE `value` =  @BankUB_BEKB AND `name` = 'Bank Logo';
UPDATE `CustomItem` SET `ordinal` = @subIssuerCode_GRKB WHERE `value` =  @BankUB_GRKB AND `name` = 'Bank Logo';
UPDATE `CustomItem` SET `ordinal` = @subIssuerCode_TGKB WHERE `value` =  @BankUB_TGKB AND `name` = 'Bank Logo';

#Update CustomItem for CS
SET @customItemSetREFUSALFraud = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB_CS, '_REFUSAL_FRAUD'));
SET @customItemSetREFUSALFraudSwisskey = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankB, '_REFUSAL_FRAUD'));
 UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetREFUSALFraudSwisskey
 WHERE `fk_id_customItemSet` =  @customItemSetREFUSALFraud
   AND `ordinal` = @subIssuerCode_CS
   AND `pageTypes` = 'ALL';


SET @customItemSetREFUSAL = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB_CS, '_DEFAULT_REFUSAL'));
SET @customItemSetREFUSALSwisskey = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankB, '_DEFAULT_REFUSAL'));
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetREFUSALSwisskey
WHERE `fk_id_customItemSet` =  @customItemSetREFUSAL
  AND `ordinal` = @subIssuerCode_CS
  AND `pageTypes` = 'ALL';

SET @customItemSetRefusalMissing = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankUB_CS, '_MISSING_AUTHENTICATION_REFUSAL'));
SET @customItemSetRefusalMissingSwisskey = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankB, '_MISSING_AUTHENTICATION_REFUSAL'));
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetRefusalMissingSwisskey
WHERE `fk_id_customItemSet` =  @customItemSetRefusalMissing
  AND `ordinal` = @subIssuerCode_CS
  AND `pageTypes` = 'ALL';

SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB_CS, '_SMS'));
SET @customItemSetSMSSwisskey = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankB, '_SMS'));
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetSMSSwisskey
WHERE `fk_id_customItemSet` =  @customItemSetSMS
  AND `ordinal` = @subIssuerCode_CS
  AND `pageTypes` = 'ALL';

UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetSMSSwisskey WHERE
                                                                                `value` = CONCAT(@BankUB_CS,'_SMALL_LOGO') AND
                                                                                `name` = 'Bank Logo' AND
                                                                                `fk_id_customItemSet` = @customItemSetSMS ;
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetSMSSwisskey WHERE `value` = CONCAT(@BankUB_CS,'_MEDIUM_LOGO') AND
                                                                                `name` = 'Bank Logo' AND
                                                                                `fk_id_customItemSet` = @customItemSetSMS ;
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetSMSSwisskey WHERE `value` = CONCAT(@BankUB_CS,'_LARGE_LOGO') AND
                                                                                `name` = 'Bank Logo' AND
                                                                                `fk_id_customItemSet` = @customItemSetSMS ;

SET @customItemSetMobileApp = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB_CS, '_MOBILE_APP'));
SET @customItemSetMobileAppSwisskey = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankB, '_MOBILE_APP'));
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetMobileAppSwisskey
WHERE `fk_id_customItemSet` =  @customItemSetMobileApp
  AND `ordinal` = @subIssuerCode_CS
  AND `pageTypes` = 'ALL';

UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetMobileAppSwisskey WHERE `value` = CONCAT(@BankUB_CS,'_SMALL_LOGO') AND
                                                                                        `name` = 'Bank Logo' AND
                                                                                        `fk_id_customItemSet` = @customItemSetMobileApp ;
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetMobileAppSwisskey WHERE `value` = CONCAT(@BankUB_CS,'_MEDIUM_LOGO') AND
                                                                                        `name` = 'Bank Logo' AND
                                                                                        `fk_id_customItemSet` = @customItemSetMobileApp ;
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetMobileAppSwisskey WHERE `value` = CONCAT(@BankUB_CS,'_LARGE_LOGO') AND
                                                                                        `name` = 'Bank Logo' AND
                                                                                        `fk_id_customItemSet` = @customItemSetMobileApp ;


#Update CustomItem for CS
SET @customItemSetREFUSALFraud = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB_NAB, '_REFUSAL_FRAUD'));
 UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetREFUSALFraudSwisskey
 WHERE `fk_id_customItemSet` =  @customItemSetREFUSALFraud
   AND `ordinal` = @subIssuerCode_NAB
   AND `pageTypes` = 'ALL';


SET @customItemSetREFUSAL = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB_NAB, '_DEFAULT_REFUSAL'));
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetREFUSALSwisskey
WHERE `fk_id_customItemSet` =  @customItemSetREFUSAL
  AND `ordinal` = @subIssuerCode_NAB
  AND `pageTypes` = 'ALL';

SET @customItemSetRefusalMissing = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankUB_NAB, '_MISSING_AUTHENTICATION_REFUSAL'));
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetRefusalMissingSwisskey
WHERE `fk_id_customItemSet` =  @customItemSetRefusalMissing
  AND `ordinal` = @subIssuerCode_NAB
  AND `pageTypes` = 'ALL';

SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB_NAB, '_SMS'));
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetSMSSwisskey
WHERE `fk_id_customItemSet` =  @customItemSetSMS
  AND `ordinal` = @subIssuerCode_NAB
  AND `pageTypes` = 'ALL';

UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetSMSSwisskey WHERE
                                                                                `value` = CONCAT(@BankUB_NAB,'_SMALL_LOGO') AND
                                                                                `name` = 'Bank Logo' AND
                                                                                `fk_id_customItemSet` = @customItemSetSMS ;
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetSMSSwisskey WHERE `value` = CONCAT(@BankUB_NAB,'_MEDIUM_LOGO') AND
                                                                                `name` = 'Bank Logo' AND
                                                                                `fk_id_customItemSet` = @customItemSetSMS ;
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetSMSSwisskey WHERE `value` = CONCAT(@BankUB_NAB,'_LARGE_LOGO') AND
                                                                                `name` = 'Bank Logo' AND
                                                                                `fk_id_customItemSet` = @customItemSetSMS ;

SET @customItemSetMobileApp = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB_NAB, '_MOBILE_APP'));
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetMobileAppSwisskey
WHERE `fk_id_customItemSet` =  @customItemSetMobileApp
  AND `ordinal` = @subIssuerCode_NAB
  AND `pageTypes` = 'ALL';

UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetMobileAppSwisskey WHERE `value` = CONCAT(@BankUB_NAB,'_SMALL_LOGO') AND
                                                                                        `name` = 'Bank Logo' AND
                                                                                        `fk_id_customItemSet` = @customItemSetMobileApp ;
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetMobileAppSwisskey WHERE `value` = CONCAT(@BankUB_NAB,'_MEDIUM_LOGO') AND
                                                                                        `name` = 'Bank Logo' AND
                                                                                        `fk_id_customItemSet` = @customItemSetMobileApp ;
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetMobileAppSwisskey WHERE `value` = CONCAT(@BankUB_NAB,'_LARGE_LOGO') AND
                                                                                        `name` = 'Bank Logo' AND
                                                                                        `fk_id_customItemSet` = @customItemSetMobileApp ;


#Update CustomItem for BEKB
SET @customItemSetREFUSALFraud = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB_BEKB, '_REFUSAL_FRAUD'));
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetREFUSALFraudSwisskey
WHERE `fk_id_customItemSet` =  @customItemSetREFUSALFraud
  AND `ordinal` = @subIssuerCode_BEKB
  AND `pageTypes` = 'ALL';

SET @customItemSetREFUSAL = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB_BEKB, '_DEFAULT_REFUSAL'));
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetREFUSALSwisskey
WHERE `fk_id_customItemSet` =  @customItemSetREFUSAL
  AND `ordinal` = @subIssuerCode_BEKB
  AND `pageTypes` = 'ALL';

SET @customItemSetRefusalMissing = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankUB_BEKB, '_MISSING_AUTHENTICATION_REFUSAL'));
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetRefusalMissingSwisskey
WHERE `fk_id_customItemSet` =  @customItemSetRefusalMissing
  AND `ordinal` = @subIssuerCode_BEKB
  AND `pageTypes` = 'ALL';

SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB_BEKB, '_SMS'));
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetSMSSwisskey
WHERE `fk_id_customItemSet` =  @customItemSetSMS
  AND `ordinal` = @subIssuerCode_BEKB
  AND `pageTypes` = 'ALL';

UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetSMSSwisskey WHERE
                                                                                `value` = CONCAT(@BankUB_BEKB,'_SMALL_LOGO') AND
                                                                                `name` = 'Bank Logo' AND
                                                                                `fk_id_customItemSet` = @customItemSetSMS ;
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetSMSSwisskey WHERE `value` = CONCAT(@BankUB_BEKB,'_MEDIUM_LOGO') AND
                                                                                `name` = 'Bank Logo' AND
                                                                                `fk_id_customItemSet` = @customItemSetSMS ;
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetSMSSwisskey WHERE `value` = CONCAT(@BankUB_BEKB,'_LARGE_LOGO') AND
                                                                                `name` = 'Bank Logo' AND
                                                                                `fk_id_customItemSet` = @customItemSetSMS ;

SET @customItemSetMobileApp = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB_BEKB, '_MOBILE_APP'));
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetMobileAppSwisskey
WHERE `fk_id_customItemSet` =  @customItemSetMobileApp
  AND `ordinal` = @subIssuerCode_BEKB
  AND `pageTypes` = 'ALL';

UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetMobileAppSwisskey WHERE `value` = CONCAT(@BankUB_BEKB,'_SMALL_LOGO') AND
                                                                                        `name` = 'Bank Logo' AND
                                                                                        `fk_id_customItemSet` = @customItemSetMobileApp ;
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetMobileAppSwisskey WHERE `value` = CONCAT(@BankUB_BEKB,'_MEDIUM_LOGO') AND
                                                                                        `name` = 'Bank Logo' AND
                                                                                        `fk_id_customItemSet` = @customItemSetMobileApp ;
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetMobileAppSwisskey WHERE `value` = CONCAT(@BankUB_BEKB,'_LARGE_LOGO') AND
                                                                                        `name` = 'Bank Logo' AND
                                                                                        `fk_id_customItemSet` = @customItemSetMobileApp ;

#Update CustomItem for GRKB
SET @customItemSetREFUSALFraud = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB_GRKB, '_REFUSAL_FRAUD'));
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetREFUSALFraudSwisskey
WHERE `fk_id_customItemSet` =  @customItemSetREFUSALFraud
  AND `ordinal` = @subIssuerCode_GRKB
  AND `pageTypes` = 'ALL';

SET @customItemSetREFUSAL = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB_GRKB, '_DEFAULT_REFUSAL'));
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetREFUSALSwisskey
WHERE `fk_id_customItemSet` =  @customItemSetREFUSAL
  AND `ordinal` = @subIssuerCode_GRKB
  AND `pageTypes` = 'ALL';

SET @customItemSetRefusalMissing = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankUB_GRKB, '_MISSING_AUTHENTICATION_REFUSAL'));
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetRefusalMissingSwisskey
WHERE `fk_id_customItemSet` =  @customItemSetRefusalMissing
  AND `ordinal` = @subIssuerCode_GRKB
  AND `pageTypes` = 'ALL';

SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB_GRKB, '_SMS'));
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetSMSSwisskey
WHERE `fk_id_customItemSet` =  @customItemSetSMS
  AND `ordinal` = @subIssuerCode_GRKB
  AND `pageTypes` = 'ALL';

UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetSMSSwisskey WHERE
                                                                                `value` = CONCAT(@BankUB_GRKB,'_SMALL_LOGO') AND
                                                                                `name` = 'Bank Logo' AND
                                                                                `fk_id_customItemSet` = @customItemSetSMS ;
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetSMSSwisskey WHERE `value` = CONCAT(@BankUB_GRKB,'_MEDIUM_LOGO') AND
                                                                                `name` = 'Bank Logo' AND
                                                                                `fk_id_customItemSet` = @customItemSetSMS ;
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetSMSSwisskey WHERE `value` = CONCAT(@BankUB_GRKB,'_LARGE_LOGO') AND
                                                                                `name` = 'Bank Logo' AND
                                                                                `fk_id_customItemSet` = @customItemSetSMS ;

SET @customItemSetMobileApp = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB_GRKB, '_MOBILE_APP'));
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetMobileAppSwisskey
WHERE `fk_id_customItemSet` =  @customItemSetMobileApp
  AND `ordinal` = @subIssuerCode_GRKB
  AND `pageTypes` = 'ALL';

UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetMobileAppSwisskey WHERE `value` = CONCAT(@BankUB_GRKB,'_SMALL_LOGO') AND
                                                                                        `name` = 'Bank Logo' AND
                                                                                        `fk_id_customItemSet` = @customItemSetMobileApp ;
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetMobileAppSwisskey WHERE `value` = CONCAT(@BankUB_GRKB,'_MEDIUM_LOGO') AND
                                                                                        `name` = 'Bank Logo' AND
                                                                                        `fk_id_customItemSet` = @customItemSetMobileApp ;
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetMobileAppSwisskey WHERE `value` = CONCAT(@BankUB_GRKB,'_LARGE_LOGO') AND
                                                                                        `name` = 'Bank Logo' AND
                                                                                        `fk_id_customItemSet` = @customItemSetMobileApp ;


#Update CustomItem for TGKB
SET @customItemSetREFUSALFraud = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB_TGKB, '_REFUSAL_FRAUD'));
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetREFUSALFraudSwisskey
WHERE `fk_id_customItemSet` =  @customItemSetREFUSALFraud
  AND `ordinal` = @subIssuerCode_TGKB
  AND `pageTypes` = 'ALL';

SET @customItemSetREFUSAL = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB_TGKB, '_DEFAULT_REFUSAL'));
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetREFUSALSwisskey
WHERE `fk_id_customItemSet` =  @customItemSetREFUSAL
  AND `ordinal` = @subIssuerCode_TGKB
  AND `pageTypes` = 'ALL';

SET @customItemSetRefusalMissing = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@BankUB_TGKB, '_MISSING_AUTHENTICATION_REFUSAL'));
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetRefusalMissingSwisskey
WHERE `fk_id_customItemSet` =  @customItemSetRefusalMissing
  AND `ordinal` = @subIssuerCode_TGKB
  AND `pageTypes` = 'ALL';

SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB_TGKB, '_SMS'));
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetSMSSwisskey
WHERE `fk_id_customItemSet` =  @customItemSetSMS
  AND `ordinal` = @subIssuerCode_TGKB
  AND `pageTypes` = 'ALL';

UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetSMSSwisskey WHERE
                                                                                `value` = CONCAT(@BankUB_TGKB,'_SMALL_LOGO') AND
                                                                                `name` = 'Bank Logo' AND
                                                                                `fk_id_customItemSet` = @customItemSetSMS ;
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetSMSSwisskey WHERE `value` = CONCAT(@BankUB_TGKB,'_MEDIUM_LOGO') AND
                                                                                `name` = 'Bank Logo' AND
                                                                                `fk_id_customItemSet` = @customItemSetSMS ;
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetSMSSwisskey WHERE `value` = CONCAT(@BankUB_TGKB,'_LARGE_LOGO') AND
                                                                                `name` = 'Bank Logo' AND
                                                                                `fk_id_customItemSet` = @customItemSetSMS ;

SET @customItemSetMobileApp = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB_TGKB, '_MOBILE_APP'));
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetMobileAppSwisskey
WHERE `fk_id_customItemSet` =  @customItemSetMobileApp
  AND `ordinal` = @subIssuerCode_TGKB
  AND `pageTypes` = 'ALL';

UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetMobileAppSwisskey WHERE `value` = CONCAT(@BankUB_TGKB,'_SMALL_LOGO') AND
                                                                                        `name` = 'Bank Logo' AND
                                                                                        `fk_id_customItemSet` = @customItemSetMobileApp ;
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetMobileAppSwisskey WHERE `value` = CONCAT(@BankUB_TGKB,'_MEDIUM_LOGO') AND
                                                                                        `name` = 'Bank Logo' AND
                                                                                        `fk_id_customItemSet` = @customItemSetMobileApp ;
UPDATE `CustomItem` SET `fk_id_customItemSet` = @customItemSetMobileAppSwisskey WHERE `value` = CONCAT(@BankUB_TGKB,'_LARGE_LOGO') AND
                                                                                        `name` = 'Bank Logo' AND
                                                                                        `fk_id_customItemSet` = @customItemSetMobileApp ;


/*!40000 ALTER TABLE `CustomItem` ENABLE KEYS */;
