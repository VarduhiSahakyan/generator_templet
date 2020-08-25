/*!40101 SET @OLD_CHARACTER_SET_CLIENT = @@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40101 SET @OLD_SQL_MODE = @@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

USE `U5G_ACS_BO`;

SET @issuerCode = '16950';
SET @bankName = 'Spardabank';
SET @sharedIssuerName = 'SPB_sharedBIN';
SET @createdBy = 'A707825';

/* SubIssuer */

SET @issuerId = (SELECT `id` FROM `Issuer` WHERE `code` = @issuerCode);
SET @subIssuerCode = '16950';

SET @authMeanRefusal = (SELECT id FROM `AuthentMeans` WHERE `name` = 'REFUSAL');
SET @authMeanACCEPT = (SELECT id FROM `AuthentMeans` WHERE `name` = 'ACCEPT');
SET @authMeanPassword = (SELECT id FROM `AuthentMeans` WHERE `name` = 'EXT_PASSWORD');
SET @authMeanUndefined = (SELECT id FROM `AuthentMeans` WHERE `name` = 'UNDEFINED');
SET @authMeanOTPsms = (SELECT id FROM `AuthentMeans` WHERE `name` = 'OTP_SMS_EXT_MESSAGE');
SET @authMeanOTPchiptan = (SELECT id FROM `AuthentMeans` WHERE `name` = 'CHIP_TAN');
SET @authentMeansMobileApp = (SELECT id FROM `AuthentMeans`  WHERE `name` = 'MOBILE_APP_EXT');
SET @MaestroVID = NULL;
SET @subIssuerID = (SELECT id FROM `SubIssuer` WHERE `code` = @subIssuerCode);

INSERT INTO `CustomItemSet` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                             `updateState`, `status`, `versionNumber`, `validationDate`, `deploymentDate`, `fk_id_subIssuer`)
VALUES
(@createdBy, NOW(), CONCAT('customitemset_', @sharedIssuerName, '_DEFAULT_REFUSAL_Current'), NULL, NULL,
 CONCAT('customitemset_', @sharedIssuerName, '_DEFAULT_REFUSAL'), 'PUSHED_TO_CONFIG', 'DEPLOYED_IN_PRODUCTION', 1, NULL, NULL, @subIssuerID),
(@createdBy, NOW(), CONCAT('customitemset_', @sharedIssuerName, '_TE_REFUSAL_Current'), NULL, NULL,
 CONCAT('customitemset_', @sharedIssuerName, '_TE_REFUSAL'), 'PUSHED_TO_CONFIG', 'DEPLOYED_IN_PRODUCTION', 1, NULL, NULL, @subIssuerID),
(@createdBy, NOW(), CONCAT('customitemset_', @sharedIssuerName, '_FE_REFUSAL_Current'), NULL, NULL,
 CONCAT('customitemset_', @sharedIssuerName, '_FE_REFUSAL'), 'PUSHED_TO_CONFIG', 'DEPLOYED_IN_PRODUCTION', 1, NULL, NULL, @subIssuerID),
(@createdBy, NOW(), CONCAT('customitemset_', @sharedIssuerName, '_RBADECLINE_Current'), NULL, NULL,
 CONCAT('customitemset_', @sharedIssuerName, '_RBADECLINE'), 'PUSHED_TO_CONFIG', 'DEPLOYED_IN_PRODUCTION', 1, NULL, NULL, @subIssuerID),
(@createdBy, NOW(), CONCAT('customitemset_', @sharedIssuerName, '_RBAACCEPT_Current'), NULL, NULL,
 CONCAT('customitemset_', @sharedIssuerName, '_RBAACCEPT'), 'PUSHED_TO_CONFIG', 'DEPLOYED_IN_PRODUCTION', 1, NULL, NULL, @subIssuerID),
(@createdBy, NOW(), CONCAT('customitemset_', @sharedIssuerName, '_PASSWORD_Current'), NULL, NULL,
 CONCAT('customitemset_', @sharedIssuerName, '_PASSWORD'), 'PUSHED_TO_CONFIG', 'DEPLOYED_IN_PRODUCTION', 1, NULL, NULL, @subIssuerID),
(@createdBy, NOW(), CONCAT('customitemset_', @sharedIssuerName, '_CHOICE_ALL_Current'), NULL, NULL,
 CONCAT('customitemset_', @sharedIssuerName, '_CHOICE_ALL'), 'PUSHED_TO_CONFIG', 'DEPLOYED_IN_PRODUCTION', 1, NULL, NULL, @subIssuerID),
(@createdBy, NOW(), CONCAT('customitemset_', @sharedIssuerName, '_SMS_CHIP_Current'), NULL, NULL,
 CONCAT('customitemset_', @sharedIssuerName, '_SMS_CHIP'), 'PUSHED_TO_CONFIG', 'DEPLOYED_IN_PRODUCTION', 1, NULL, NULL, @subIssuerID),
(@createdBy, NOW(), CONCAT('customitemset_', @sharedIssuerName, '_CHIP_APP_Current'), NULL, NULL,
 CONCAT('customitemset_', @sharedIssuerName, '_CHIP_APP'), 'PUSHED_TO_CONFIG', 'DEPLOYED_IN_PRODUCTION', 1, NULL, NULL, @subIssuerID),
(@createdBy, NOW(), CONCAT('customitemset_', @sharedIssuerName, '_SMS_APP_Current'), NULL, NULL,
 CONCAT('customitemset_', @sharedIssuerName, '_SMS_APP'), 'PUSHED_TO_CONFIG', 'DEPLOYED_IN_PRODUCTION', 1, NULL, NULL, @subIssuerID),
(@createdBy, NOW(), CONCAT('customitemset_', @sharedIssuerName, '_SMS_Current'), NULL, NULL,
 CONCAT('customitemset_', @sharedIssuerName, '_SMS'), 'PUSHED_TO_CONFIG', 'DEPLOYED_IN_PRODUCTION', 1, NULL, NULL, @subIssuerID),
(@createdBy, NOW(), CONCAT('customitemset_', @sharedIssuerName, '_CHIP_TAN'), NULL, NULL,
 CONCAT('customitemset_', @sharedIssuerName, '_CHIP_TAN'), 'PUSHED_TO_CONFIG', 'DEPLOYED_IN_PRODUCTION', 1, NULL, NULL, @subIssuerID),
(@createdBy, NOW(), CONCAT('customitemset_', @sharedIssuerName, '_MOBILE_APP_EXT_Current'), NULL, NULL,
 CONCAT('customitemset_', @sharedIssuerName, '_MOBILE_APP_EXT'), 'PUSHED_TO_CONFIG', 'DEPLOYED_IN_PRODUCTION', 1, NULL, NULL, @subIssuerID),
(@createdBy, NOW(), CONCAT('customitemset_', @sharedIssuerName, '_SMS_CHOICE_Current'), NULL, NULL,
 CONCAT('customitemset_', @sharedIssuerName, '_SMS_CHOICE'), 'PUSHED_TO_CONFIG', 'DEPLOYED_IN_PRODUCTION', 1, NULL, NULL, @subIssuerID),
(@createdBy, NOW(), CONCAT('customitemset_', @sharedIssuerName, '_CHIP_TAN_CHOICE_Current'), NULL, NULL,
 CONCAT('customitemset_', @sharedIssuerName, '_CHIP_TAN_CHOICE'), 'PUSHED_TO_CONFIG', 'DEPLOYED_IN_PRODUCTION', 1, NULL, NULL, @subIssuerID),
(@createdBy, NOW(), CONCAT('customitemset_', @sharedIssuerName, '_MOBILE_APP_EXT_CHOICE_Current'), NULL, NULL,
 CONCAT('customitemset_', @sharedIssuerName, '_MOBILE_APP_EXT_CHOICE'), 'PUSHED_TO_CONFIG', 'DEPLOYED_IN_PRODUCTION', 1, NULL, NULL, @subIssuerID);

SET @customItemSetDefaultRefusal = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@sharedIssuerName,'_DEFAULT_REFUSAL'));
SET @customItemSetTERefusal = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@sharedIssuerName,'_TE_REFUSAL'));
SET @customItemSetFERefusal = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@sharedIssuerName,'_FE_REFUSAL'));
SET @customItemSetRBADECLINE = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@sharedIssuerName,'_RBADECLINE'));
SET @customItemSetRBAACCEPT = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@sharedIssuerName,'_RBAACCEPT'));
SET @customItemSetPassword = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@sharedIssuerName,'_PASSWORD'));
-- SET @customItemSetUndefined = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@sharedIssuerName,'_UNDEFINED'));
SET @customItemSetUndefinedAll = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@sharedIssuerName,'_CHOICE_ALL'));
SET @customItemSetUndefinedSMSChip = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@sharedIssuerName,'_SMS_CHIP'));
SET @customItemSetUndefinedChipApp = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@sharedIssuerName,'_CHIP_APP'));
SET @customItemSetUndefinedSMSApp = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@sharedIssuerName,'_SMS_APP'));
SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@sharedIssuerName,'_SMS'));
SET @customItemSetCHIPTAN = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @sharedIssuerName, '_CHIP_TAN'));
SET @customItemSetMobileApp = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @sharedIssuerName, '_MOBILE_APP_EXT'));
SET @customItemSetSMSChoice = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_',@sharedIssuerName,'_SMS_CHOICE'));
SET @customItemSetCHIPTANChoice = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @sharedIssuerName, '_CHIP_TAN_CHOICE'));
SET @customItemSetMobileAppChoice = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @sharedIssuerName, '_MOBILE_APP_EXT_CHOICE'));


SET @currentAuthentMean = 'REFUSAL';

INSERT INTO `Image` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, relativePath, `binaryData`)
VALUES (@createdBy, NOW(), CONCAT(@sharedIssuerName,' Logo'), NULL, NULL, @sharedIssuerName, 'PUSHED_TO_CONFIG', '<placeholder>' , 'iVBORw0KGgoAAAANSUhEUgAAAfcAAABkCAMAAACsLolMAAAAwFBMVEUAWav////wYwAAVqoAT6fvWACkv97/+/j60r/wYADq8vg1dLjyeioAUagATKYAVKnD1OiEqtMAW6wiaLLa5/MASKXK3O309vptmcp2oM1Ac7aRsdZhhr/S4vAARqSvwNz3r4QKYbCwyeMAZLHe6vRCgL680edaisKmw+BTf7s5eruGoMucuNm+y+K1zOTQ4O9ejsUAQKIjbrV4nMtskcSLrdRKhcH5u5TydBv828rvUAD95tr+8uyitdZSjsYAO6AQg/SHAAAPTklEQVR4nO2dD3uqOBaHcZPpzuCGICBonXoXoVq9VL3+29nZvbPf/1ttAiQnCdjWyq29D/yeeWamFJOcvOQk5yRSq9epjbJu3YBON1HHvZ3i3CO7U5skuGe7fqf2yA9L7gOMOrVHQ1dwJ1an9sjpuLdSHfd2quPeTnXc26mOezvVcW+nOu7tVMe9neq4t1Md93aq495OddzbqR/AHSHKhFBT5XX6AWqYO6KO1z8tmB53FNPiGlcThV/cGFW3aMA1+sGNb5Q7ov52ndpRLjuYbT1WKPK5ri/8Ynm+qviaks6L8SHkB3CJtcY3X36D3JGzeor0A1zBkRLM/yfymmjsZc1Zak0Z03eXlMzCs3Ln6y9fTxg3jB4/q21339/2c2qOO4qfao7uBcsT/499A+732kM4enffIT89dzBRyL7rN7ss/nm4I8+t7ZIo+Pm5B69xZwaOnSYb/9NwR7EtWhk8H4/ZF1frrJtw18D8YO693rpJOD8P93XZxodFgjEhmPoLxQHcgrufZRkQu4b7hq9TFQ6RlEona9DV09FdNpOlf17uZFA2cUZoucRhId1W+oAbcLcQYQ+gnJrfz50tWIfDqTcGwtNhIccfzxXw2wbxUIyno8/P3SkJh566sCX5Ke1bcc/bJdzQNdxzoWEoAUsbWQy3V9xxo1O8MlF9Wu7osWzhV6xdp759W+541hR3C0O4oj7bjjKbNRvMwcL003LHYlg9GqaT7Xu5N5OoeoH7pRXgu1q+9ATcV+ovLim/9s6fgLslfODWLAWHL3CnBHncWZpmUWLFCc9TJbGHXsuGIYqNjBn7iOdZlJd6hjv73dsrEJbUc0c+cJcT/GUGEIvnEz1q3Pj5uUOkMzeNJAfBna+OQMwSQk/ZPAzn6+xEFcNYN2xZFGhzo+00XB93juZX1VLYrEK80ffv30+QMKP4ccKKDWcj1vt13BH2DryCnqggcd5C/g3cyzoIWnyZFwZEaTg/9rXy1fY7fNHYz1x2qx3Ojp7GwODuVHSNN2yIu1w2z3w9ZYmKGd722LMRKToQNJCr/V56gqVSrFzPFbnK7OFopWTYGhWdE6xKrmgh22KPkFPljpKJkU2O1v03DKhz3HdQUN5O5JkG9Nyl8gm1/a5HkwzuswdqO3TueOPqCsP7K8A3PN4ZwsluimUwZ1lxKLhrvXGgM/XH3rFcC6O4Ju0XjeRKeaiVMv4me8328yqHd+rv7/5X4Y68mixMtNDXo3U6N7//BcUUBsyr5ffAAKReDqkXavdlquPTuDvVQpe35m7FG7U99myw2FGncPn06D4/P3+xDO4j3V7mKIqep5teneTMqXNfHpU+5AbI9FGpuckdxfXJt8WrI/4MdwLP6YzDJWcMEN2rcXcTM/V/B7Ggzn1YLfP23Mmz0aTIDubjfsyXKoRPRdjkbrpC5gF4A2ixHIjWg/F4MAd/HPiljRr3iGeL7HVxW8RW01hxmuUt4n/E3FskmKIZr8BVKngfd4oH8qrdZ9fpVjFgDeWnwgB9vJtPfy/awYz3+cc7GVdbxY1dT1ZiixIl6zC0jV/Plcfd5hbTYvSkhykhxCF7ExuLGMNQjlj+W1emCr+SstMLBRvdwRQFOMWHg8WQV0CB2uk18Ap3B+diK6uT8qAt8ge3NGBUGiDbMBb9GxrdkM5mM8UHHSUHg3tk21qu2LZvz90ivXNKJ/dlj7LYylI4R6MYsTUQ2DIhihee5B/CMjheC//HS1HmcJf0RS9OMILiZ33Pi8dKB5fcPVFfwQEfxO/vXpvhFe5Zrrt1oIAIHvMC44c3GLBTOXuU0hiev/WZ8W4lcZyIOSQc7eI4viYX1hD3qoMFRU9YjCVHuW3P4xCEIc9pO0pgEBRGDcUiyR5CZXQFpfQd2WUTB4b7bJgXrtxYcEe+6Mug4EDF9By+Zj/WVoymjcekLF8gDYoDPkOx4FANwF/kB7PcHaKpXIeE8i6DO6LTMnbpDdja6cqkVlP7ccRYUGmyT2XhZAJkyucfImzuauVi205ys6QTj5ThqIROM0Lk0m5PxFiTEDHMP2KiEH0ZFRzw9/LnzWuj5wXu9l/fRDDtiTaU8YWcAVUDgLtd9gLMUA+yHQZ3GpddvIlfDz5eVWP7sIns9LqOKWdPhbsImelCXmJTm/QbYWG+pBqpdQH3PZGfj3ZL6XYhbSg9fcldZpTDoseJoPnw2gG8F7hHwV2/HH5EGLApyoMHVy1Kcn8S4aucrc5xx8uyg7O4iW2ABs/bZEY6RFVa3ATcYf1M5MeeKSslVTGhqXia1AN6wD1igwqVnjqbSo8PWWFHbqaIOG5XVlBEhsgy/DITX7CpKhemL/p5Ni+XJ61QWeC+NEBMyaoBwF2s9mCCq+eOaOk37EUzR/kaPF9Hd0/nD6Idc98E3J9kdY6MZVyerE949Gbn/YFILNcDZ7jjPFBgY8XOlD3XmXyoqNzDFn6eJiGvIP8RkUQ+F5K7Y0e6ys0mhfu41GSeKs96+SQlPHqzBy8ZANxFXuIV7tgXy5CmjnM1eY4a4fhwrESkZbfm5gD3iawO+jN3jYiu9gefUIKHyRjmjnruD05eLfvEClvDtFo4HKqFPC1d7rdFBf4YHlTgXnFbFe6YlHK8pZKmKWYXRKQB8Rh+W8/99zdxXz/CARarmc3epuI4Hs+yOIwSx3ocPG8qfRflFgL3r7I6xfcXSyHK/Ky/HOjOo557edIBUZ4XhszGAfZgZN8p+3FFBccnLYy+hLvS9XSonCIuczOvGnApd7VF7qfiPpg9Pc2O5RRKSHx/yIx85Z6XD4z3wF1Oy0VOi3qrySY1O7+e+1r1epAJU3Z5dgIucKfeY7axzQreyZ35dXh87oj1JgMu5a6pmS82Nbr/DsMMsWfe36sjamJwh3WdDMQCHrvhUW0CvZ77TI1oYnnv6gXuyBnXVvBe7hARlA4LH2ojm8a4R49N7MY3yl07b5KPe4jbMo6odrzLa3x+V7fponSyEz++gbsHPVOT8xLreW+tVjDoi8TQ+7krJ+yW1CLqPmOa7cQ0cCX3OWQiAq8BV98o9ztzsYkcaaHBHeZ3OLfG1vPKNkcv23rYUbqNPUfFyZwz3CFXfFLmd3FN5OchYxhlCw9T8Rgw7kUF1Q2Ql7nTA9y5oOpOxVkDLuc+QVPY98s+T96m4C43naRQX7T9qPt5OGzuyIXAmtJ74ZbtEeHZXQzdhvpfv37d8145w30ouwmcCeTByoSAzNymI4dXgGC8oxWr4ODRsSn/zdxHsFvAQtGzBlzK3V452re19tdP8c2er5uYTyLkw/f6eh6+XUIlru8E1ninoiSl2wgPxe081KvnDomA7+BM5PAuuMt0mv1YfBTBeM8rf4gtSgyVRZ3z84qLWjhyuL9kwKXc5/mYgecruj5l1/C5yoVRCnos227ncz9wj+QRRMjTLqhj7mLIC2W3pS+Mdygc9jaomacV3nIjEmUw3nOA4dl07VnuyoS+HIofpAGwQHmReyIWm2fz82pF7huQvKyGuUdbfcTL8faQ/6jk5w9lfXKC7UXIcsRSOC26DUlnUM9di+Po77LwfklGWXMV3OW2yaYc7rA/907uUAJfz8svV9hnDLhovEvMxRwVg6c/XjvFN8y9Fw0cOFKLnL64XhSvcH8oVqVE3tGbOzDXR/kBPeSAf/DyFVPOnYpvafTCqdoIOEL1JHodeqrIhEvuxaJYyboEMeYBZXh2W24Iww24I4KV+GBN5FwTkaoBOfd8fpdFieNdVMabkJCj5vdliHKs5PHKKb5p7qzhkxXFhFJKcAKheWU/rucmmFKnD2RYEKSk2DEhzgqOKEa7KR8kKXGGjgWXH9XzxEQm41lkQREiscIk9IaOA269lw0Jxktot+1/47+r9aB8xodHuNcbsqLyf2h/ryb9dgiIzkjFAO4wUr7ps5IfmmGHjVwvTmBH/pifqMCscPlMRgvWdNYKDGv6aOVc9ZqN5rnn25KD0WI02aTQ8Cp3Ftz+tVX28HgCUlkjueNJqOUn81vdb24QqId2giDYCK9uKedt3O2uP9ISpWkQuJhAGDcfTzZ6BfzfX2ocaDwas8YogAMpLdWbOboBR1ctPywMcPRPBcEdQZmttjRN7YnzPVXNtAM3QSP1vF7PzsaV6OkCNck9qM0vcYldJI27ofx43cosItWP5I2/VQ9kQrpI/c6SkFqg7cgv8kkZybua77S+4X0Xue6suhybbRhQOZHmYuNIOdOXqXlQ1fZxpRWf4Hxdzn3fr9+Mi2RuHLhX8O3NBUCu1NMuRP70Je6qpy91VI/j205lF32DtLezRDXD/W3vPYiyfElCjvrlNDYMoOYHGffKC2Kq3NMEV1rxSbjbPkF143nzKDtT2Yc1DuSJVATRvnUw31H1KGZvQIcvclf22wsdtRmIn+DTX8cyS8hOraAuI/Im7hvxzQtsGoDUTw8IMj741vH+OblnYRjy9CGmR31XInK3Q2iekq+bwksR2E07WftwIDjY7iNbsiEYDcGIrfjDwNRDX7Ef+8pabr5zvFkKd4b8mMZ0IiuYr3gFQCo41YVHr/r5wB0kQzk/OHJT3w5zA2DjJuVfm0n11qdPhA42+kuyNgM+v2tiq+DP6OdBJF6OnzbFmRV7Pb631HLVPC3xR+viS2LHe/VsKPVHT6E7m+zvURG2ouVxxi8c+JFV5FelhV7s9oHLiw2yBQ+JEvXOInT0R3l5o/vi21zIWh7X/MI2qd/p8kaV1K3U6LBd+vo3WYl/eCrKLw2gy0FhgM9/Nluf1FWJYvM2Cy1/N3TNK/maf08pi58wC3G8JEFDM9bQ8vOIOjhmd5k38T1cR/2KHS9QXqj5G3hmA4hDkyR2iPK6TO3Omgoc/YKhSuZWUc0bWS8z4Gw3mrdRU2c++Sb9uPcS11lU3Zf5QS8Q/fneS/rB+tj3Udftx3W6hTru7dTHcofj7Hcd95vq47gjttjbyWyWnUyHw24Svpk+jHvxnhMIPnmYd+rA30ofyL2aaeu430y35B513G+mbry3Ux/Hnb/nxPhbDauO+630gXFczR9n6XQrdX8/rp0C7lPcqT36JriHd53apLTk3ql96ri3Ux33dqrj3k5x7n/v1CoJ7v/64x+d2qM//l1y/+cvv3Vqj375VXD/7W+d2qOOezvVcW+nOu7tVMe9neq4t1Md93aq495OddzbqY57O9Vxb6eA+5+/dGqP/hTc//Nrpzbpv73u3EVb1XFvpzru7dT/AcWkSctuV8YPAAAAAElFTkSuQmCC');

-- Image ids
SET @idBankLogo = (SELECT id FROM Image where name LIKE CONCAT('%',@sharedIssuerName,'%'));
SET @idVisaLogo = (SELECT id FROM Image where name = 'VISA_LOGO');
SET @idMastercardLogo = (SELECT id FROM Image where name = 'MC_LOGO');

SELECT @idBankLogo, @idVisaLogo, @idMastercardLogo;

SET @networkVISA = 'VISA';
SET @networkMC = 'MASTERCARD';

SET  @idNetworkVISA = (SELECT id FROM Network where code = @networkVISA);
SET  @idNetworkMC = (SELECT id FROM Network where code = @networkMC);

/* Elements for the profile _TE_REFUSAL : */

SET @currentPageType = 'REFUSAL_PAGE';
SET @currentAuthentMean = 'REFUSAL';
SET @currentCustomItemSet = @customItemSetTERefusal;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG', 'de', 1, 'ALL', 'Banklogo', NULL, @idBankLogo,  @currentCustomItemSet),
('I', @createdBy, NOW(), NULL, NULL, NULL, 'VISA_LOGO', 'PUSHED_TO_CONFIG', 'de', 2, 'ALL','VISA_LOGO', @idNetworkVISA, @idNetworkVISA,  @currentCustomItemSet),
('I', @createdBy, NOW(), NULL, NULL, NULL, 'MASTERCARD_LOGO', 'PUSHED_TO_CONFIG', 'de', 2, 'ALL','MASTERCARD_LOGO', @idNetworkMC, @idNetworkMC,  @currentCustomItemSet),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
 'de', 1, @currentPageType, '<b>Freigabe der Zahlung nicht möglich</b>', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
 'de', 2, @currentPageType, 'Eine Freigabe der Zahlung durch das Online-Banking ist nicht möglich.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
 'de', 3, @currentPageType, 'Der Einkauf kann leider nicht fortgesetzt werden. Bitte wenden Sie sich an die kontoführende Filiale Ihrer Sparda-Bank.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_4'), 'PUSHED_TO_CONFIG',
 'de', 4, @currentPageType, 'Über den Button gelangen Sie zurück zum Shop.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_22'), 'PUSHED_TO_CONFIG',
 'de', 22, @currentPageType, 'Der Vorgang konnte nicht durchgeführt werden.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_23'), 'PUSHED_TO_CONFIG',
 'de', 23, @currentPageType, 'Bitte aktivieren Sie Ihre Kreditkarte im Online Banking oder wenden Sie sich an den Berater in Ihrer Filiale.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
 'de', 32, @currentPageType, 'Technischer Fehler', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
 'de', 33, @currentPageType, 'Ein technischer Fehler ist aufgetreten und Ihr Kauf konnte nicht abgeschlossen werden. Bitte versuchen Sie es später erneut.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
 'de', 174, 'ALL', 'Schließen', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
 'de', 175, 'ALL', 'Zurück zum Shop', NULL, NULL, @currentCustomItemSet);

/* Elements for the profile _FE_REFUSAL : */
SET @currentCustomItemSet = @customItemSetFERefusal;
SET @currentPageType = 'REFUSAL_PAGE';
SET @currentAuthentMean = 'REFUSAL';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT `DTYPE`, `createdBy`, NOW(), NULL, NULL, NULL, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, @MaestroVID, `fk_id_image`, @customItemSetFERefusal
  FROM `CustomItem` WHERE fk_id_customItemSet = @customItemSetTERefusal;

-- refusal custom items

SET @currentPageType = 'REFUSAL_PAGE';
SET @currentCustomItemSet = @customItemSetDefaultRefusal;

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT `DTYPE`, `createdBy`, NOW(), NULL, NULL, NULL, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, @MaestroVID, `fk_id_image`, @customItemSetDefaultRefusal
  FROM `CustomItem` WHERE fk_id_customItemSet = @customItemSetTERefusal;

/* Elements for the profile SMS : */
SET @currentCustomItemSet = @customItemSetSMS;
SET @currentAuthentMean = 'OTP_SMS_EXT_MESSAGE';
SET @currentPageType = 'OTP_FORM_PAGE';

/* Elements for the OTP page, for SMS Profile */

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG', 'de', 1, 'ALL', 'Banklogo', NULL, @idBankLogo,  @currentCustomItemSet),
('I', @createdBy, NOW(), NULL, NULL, NULL, 'VISA_LOGO', 'PUSHED_TO_CONFIG', 'de', 2, 'ALL','VISA_LOGO', @idNetworkVISA, @idNetworkVISA,  @currentCustomItemSet),
('I', @createdBy, NOW(), NULL, NULL, NULL, 'MASTERCARD_LOGO', 'PUSHED_TO_CONFIG', 'de', 2, 'ALL','MASTERCARD_LOGO', @idNetworkMC, @idNetworkMC,  @currentCustomItemSet),
-- ('T', @createdBy, NOW(), NULL, NULL, NULL, 'OTP_SMS_MESSAGE_BODY', 'PUSHED_TO_CONFIG', 'de', 0, 'MESSAGE_BODY', 'Die mobileTAN für Ihren Einkauf mit Kreditkarte @maskedPan am @formattedDate bei @merchant über @amount lautet: @otp Ihre Sparda Bank', NULL, NULL, @currentCustomItemSet),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
 'de', 1, @currentPageType, '<b>Schritt 2: Eingabe mobileTAN</b>', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
 'de', 2, @currentPageType, 'Bitte geben Sie die TAN ein, die per SMS an die unten aufgeführte Mobilfunknummer gesendet wurde.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
 'de', 3, @currentPageType, '<b>TAN* :</b>', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_12'), 'PUSHED_TO_CONFIG',
 'de', 12, @currentPageType, 'Authentifizierung läuft', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_13'), 'PUSHED_TO_CONFIG',
 'de', 13, @currentPageType, 'Bitte warten Sie ein paar Sekunden, um Ihre Eingabe zu überprüfen.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_14'), 'PUSHED_TO_CONFIG',
 'de', 14, @currentPageType, 'Die Zahlung wurde abgebrochen.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_15'), 'PUSHED_TO_CONFIG',
 'de', 15, @currentPageType, 'Starten Sie den Bezahlvorgang erneut, wenn Sie die Zahlung durchführen möchten.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_26'), 'PUSHED_TO_CONFIG',
 'de', 26, @currentPageType, 'Authentifizierung erfolgreich.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_27'), 'PUSHED_TO_CONFIG',
 'de', 27, @currentPageType, 'Sie wurden erfolgreich authentifiziert und werden automatisch zum Händler weitergeleitet.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_28'), 'PUSHED_TO_CONFIG',
 'de', 28, @currentPageType, 'Fehlerhafte TAN', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_29'), 'PUSHED_TO_CONFIG',
 'de', 29, @currentPageType, 'Diese TAN-Nummer ist ungültig. Bitte ändern Sie Ihre Eingabe. Die Anzahl der Ihnen verbleibenden Versuche lautet: @trialsLeft', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_30'), 'PUSHED_TO_CONFIG',
 'de', 30, @currentPageType, 'Die Session ist abgelaufen.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_31'), 'PUSHED_TO_CONFIG',
 'de', 31, @currentPageType, 'Sie haben einige Zeit keine Eingaben vorgenommen, daher wurde die Zahlung abgebrochen. Starten Sie den Bezahlvorgang erneut, wenn Sie die Zahlung durchführen  möchten.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
 'de', 32, @currentPageType, 'Technischer Fehler.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
 'de', 33, @currentPageType, 'Ein technischer Fehler ist aufgetreten, Ihr Kauf konnte nicht abgeschlossen werden. Bitte versuchen Sie es später erneut.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_34'), 'PUSHED_TO_CONFIG',
 'de', 34, @currentPageType, 'SMS wird versendet.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_35'), 'PUSHED_TO_CONFIG',
 'de', 35, @currentPageType, 'Bitte haben Sie einen kleinen Moment Geduld. In Kürze erhalten Sie ein neues Einmalpasswort.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
 'de', 40, @currentPageType, 'Abbrechen', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
 'de', 41, @currentPageType, '?', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_42'), 'PUSHED_TO_CONFIG',
 'de', 42, @currentPageType, 'Senden', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_100'), 'PUSHED_TO_CONFIG',
 'de', 100, 'ALL', 'Händler', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_101'), 'PUSHED_TO_CONFIG',
 'de', 101, 'ALL', 'Betrag', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_102'), 'PUSHED_TO_CONFIG',
 'de', 102, 'ALL', 'Datum', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
 'de', 103, 'ALL', 'Kartennummer', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_104'), 'PUSHED_TO_CONFIG',
 'de', 104, 'ALL', 'Mobilfunknummer', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
 'de', 174, 'ALL', 'Schließen', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
 'de', 175, 'ALL', 'Zurück zum Shop', NULL, NULL, @currentCustomItemSet);

/* Elements for the FAILURE page, for SMS Profile */
SET @currentPageType = 'FAILURE_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
 'de', 1, @currentPageType, '<b>Freigabe der Zahlung nicht möglich</b>', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
 'de', 2, @currentPageType, 'Die Anmeldung ist fehlgeschlagen. Bitte versuchen Sie es erneut mit gültigen Anmeldedaten.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
 'de', 3, @currentPageType, 'Über den Button gelangen Sie zurück zum Shop.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
 'de', 16, @currentPageType, 'Maximale Anzahl der Fehlversuche erreicht.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
 'de', 17, @currentPageType, 'Die Transaktion wurde abgebrochen, die Zahlung nicht durchgeführt.', NULL, NULL, @currentCustomItemSet);

/* Elements for the REFUSAL page, for SMS Profile */
SET @currentPageType = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
 'de', 1, @currentPageType, '<b>Hinweise zur mobilenTAN</b>', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
 'de', 2, @currentPageType, 'Wenn Sie eine mobileTAN anfordern, wird Ihnen diese als SMS auf Ihr Mobilfunkgerät gesandt. Bitte gleichen Sie die in der SMS enthaltenen Zahlungsinformationen ab und geben die mobileTAN ein. Um fortzufahren, bestätigen Sie die Eingabe mit „Senden“. Um die Freigabe der Zahlung abzubrechen, klicken Sie auf „Abbrechen“.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
 'de', 3, @currentPageType, 'Bitte beachten Sie, dass die mobileTAN nur für diese Transaktion gilt. Sie verfällt, wenn Sie die Bearbeitung an dieser Stelle abbrechen. Die Verwaltung des mobileTAN-Verfahrens können Sie im Sparda Online-Banking vornehmen.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
 'de', 174, @currentPageType, 'Schließen', NULL, NULL, @currentCustomItemSet);

SET @currentPageType = 'MEANS_PAGE';
SET @currentAuthentMean1 = 'OTP_SMS';
SET @Imageid = (SELECT `id` FROM `Image` im WHERE im.name LIKE CONCAT('%',@currentAuthentMean1,'_Logo','%'));

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_9'), 'PUSHED_TO_CONFIG',
 'de', 9, @currentPageType, 'mobileTAN', NULL, NULL, @currentCustomItemSet),
('I', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_9'), 'PUSHED_TO_CONFIG', 
 'de', 9, @currentPageType, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_9'), NULL, @Imageid, @currentCustomItemSet);

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT `DTYPE`, `createdBy`, NOW(), NULL, NULL, NULL, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, @MaestroVID, `fk_id_image`, @customItemSetSMSChoice
  FROM `CustomItem` WHERE fk_id_customItemSet = @customItemSetSMS;

/* Elements for the profile PASSWORD : */
SET @currentAuthentMean = 'EXT_PASSWORD';
SET @currentCustomItemSet = @customItemSetPassword;
SET @currentPageType = 'OTP_FORM_PAGE';

/* Here is what the content of the PASSWORD will be */
/*in this case it will be sent from HUB*/

/* Elements for the OTP page, for PASSWORD Profile */

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG', 'de', 1, 'ALL', 'Banklogo', NULL, @idBankLogo,  @currentCustomItemSet),
('I', @createdBy, NOW(), NULL, NULL, NULL, 'VISA_LOGO', 'PUSHED_TO_CONFIG', 'de', 2, 'ALL','VISA_LOGO', @idNetworkVISA, @idNetworkVISA,  @currentCustomItemSet),
('I', @createdBy, NOW(), NULL, NULL, NULL, 'MASTERCARD_LOGO', 'PUSHED_TO_CONFIG', 'de', 2, 'ALL','MASTERCARD_LOGO', @idNetworkMC, @idNetworkMC,  @currentCustomItemSet),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
 'de', 1, @currentPageType, '<b>Schritt 1: Eingabe Online-Banking-PIN</b>', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
 'de', 2, @currentPageType, 'Bitte geben Sie Ihre PIN für das Sparda Online-Banking zur dargestellten Kundenummer ein, um den Bezahlvorgang zu bestätigen.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
 'de', 3, @currentPageType, '<b>Kundennummer:</b> @challenge1', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_4'), 'PUSHED_TO_CONFIG',
 'de', 4, @currentPageType, '<b>Online-PIN*:</b>', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_12'), 'PUSHED_TO_CONFIG',
 'de', 12, @currentPageType, 'Authentifizierung läuft.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_13'), 'PUSHED_TO_CONFIG',
 'de', 13, @currentPageType, 'Bitte warten Sie ein paar Sekunden, um Ihre Eingabe zu überprüfen.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_14'), 'PUSHED_TO_CONFIG',
 'de', 14, @currentPageType, 'Die Zahlung wurde abgebrochen.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_15'), 'PUSHED_TO_CONFIG',
 'de', 15, @currentPageType, 'Starten Sie den Bezahlvorgang erneut, wenn Sie die Zahlung abschließen möchten.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_26'), 'PUSHED_TO_CONFIG',
 'de', 26, @currentPageType, 'Authentifizierung wird fortgesetzt', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_27'), 'PUSHED_TO_CONFIG',
 'de', 27, @currentPageType, ' ', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_28'), 'PUSHED_TO_CONFIG',
 'de', 28, @currentPageType, '<h3>Falsche Online-PIN</h3>', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_29'), 'PUSHED_TO_CONFIG',
 'de', 29, @currentPageType, 'Die Anmeldung ist fehlgeschlagen. Bitte versuchen Sie es erneut mit einer gültigen Online-PIN.<br>Die Anzahl der Ihnen verbleibenden Versuche lautet: @trialsLeft', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_30'), 'PUSHED_TO_CONFIG',
 'de', 30, @currentPageType, 'Die Session ist abgelaufen.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_31'), 'PUSHED_TO_CONFIG',
 'de', 31, @currentPageType, 'Sie haben einige Zeit keine Eingaben vorgenommen, daher wurde die Zahlung abgebrochen. Starten Sie den Bezahlvorgang erneut, wenn Sie die Zahlung abschließen möchten.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
 'de', 32, @currentPageType, 'Technischer Fehler.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
 'de', 33, @currentPageType, 'Ein technischer Fehler ist aufgetreten und Ihr Kauf konnte nicht abgeschlossen werden. Bitte versuchen Sie es später erneut.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
 'de', 40, @currentPageType, 'Abbrechen', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
 'de', 41, @currentPageType, '?', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_42'), 'PUSHED_TO_CONFIG',
 'de', 42, @currentPageType, 'Senden', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_100'), 'PUSHED_TO_CONFIG',
 'de', 100, 'ALL', 'Händler', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_101'), 'PUSHED_TO_CONFIG',
 'de', 101, 'ALL', 'Betrag', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_102'), 'PUSHED_TO_CONFIG',
 'de', 102, 'ALL', 'Datum', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
 'de', 103, 'ALL', 'Kartennummer', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
 'de', 174, 'ALL', 'Schließen', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
 'de', 175, 'ALL', 'Zurück zum Shop', NULL, NULL, @currentCustomItemSet);

/* Elements for the FAILURE page, for PASSWORD Profile */
SET @currentPageType = 'FAILURE_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
 'de', 1, @currentPageType, '<b>Freigabe der Zahlung nicht möglich</b>', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
 'de', 2, @currentPageType, 'Die Anmeldung ist fehlgeschlagen. Bitte versuchen Sie es erneut mit gültigen Anmeldedaten.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
 'de', 3, @currentPageType, 'Über den Button gelangen Sie zurück zum Shop.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
 'de', 16, @currentPageType, 'Maximale Anzahl der Fehlversuche erreicht.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
 'de', 17, @currentPageType, 'Die Transaktion wurde abgebrochen, die Zahlung nicht durchgeführt.', NULL, NULL, @currentCustomItemSet);

/* Elements for the REFUSAL page, for PASSWORD Profile */
SET @currentPageType = 'HELP_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
 'de', 1, @currentPageType, '<b>Hinweise zur Anmeldung</b>', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
 'de', 2, @currentPageType, 'Bitte geben Sie die zu der angezeigten Kundennummer passende Online-PIN Ihres Sparda Online-Bankings ein. Um fortzufahren, bestätigen Sie die Eingabe mit "Senden". Um die Freigabe der Zahlung abzubrechen, klicken Sie auf "Abbrechen".', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
 'de', 3, @currentPageType, 'Aus Sicherheitsgründen zeigen wir sowohl die Kartennummer als auch die Kundennummer nur maskiert an.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
 'de', 174, @currentPageType, 'Schließen', NULL, NULL, @currentCustomItemSet);

/* Elements for the profile APP : */
SET @currentAuthentMean = 'MOBILE_APP_EXT';
SET @currentPageType = 'POLLING_PAGE';
SET @currentCustomItemSet = @customItemSetMobileApp;

/* Here is what the content of the APP will be */
/*in this case it will be sent from HUB*/

/* Elements for the OTP page, for APP Profile */

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG', 'de', 1, 'ALL', 'Banklogo', NULL, @idBankLogo,  @currentCustomItemSet),
('I', @createdBy, NOW(), NULL, NULL, NULL, 'VISA_LOGO', 'PUSHED_TO_CONFIG', 'de', 2, 'ALL','VISA_LOGO', @idNetworkVISA, @idNetworkVISA,  @currentCustomItemSet),
('I', @createdBy, NOW(), NULL, NULL, NULL, 'MASTERCARD_LOGO', 'PUSHED_TO_CONFIG', 'de', 2, 'ALL','MASTERCARD_LOGO', @idNetworkMC, @idNetworkMC,  @currentCustomItemSet),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
 'de', 1, @currentPageType, '<b>Schritt 2: Freigabe per SpardaSecureApp</b>', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
 'de', 2, @currentPageType, 'Bitte geben Sie den Auftrag in der SpardaSecureApp frei.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
 'de', 3, @currentPageType, '<b>Hinweis :</b>', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_4'), 'PUSHED_TO_CONFIG',
 'de', 4, @currentPageType, 'Sie können die Zahlungsfreigabe in der SpardaSecureApp auch ablehnen.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_12'), 'PUSHED_TO_CONFIG',
 'de', 12, @currentPageType, 'Authentifizierung läuft', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_13'), 'PUSHED_TO_CONFIG',
 'de', 13, @currentPageType, 'Bitte warten Sie ein paar Sekunden, um Ihre Eingabe zu überprüfen.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_14'), 'PUSHED_TO_CONFIG',
 'de', 14, @currentPageType, 'Die Zahlung wurde abgebrochen', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_15'), 'PUSHED_TO_CONFIG',
 'de', 15, @currentPageType, 'Starten Sie den Bezahlvorgang erneut, wenn Sie die Zahlung abschließen möchten.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_26'), 'PUSHED_TO_CONFIG',
 'de', 26, @currentPageType, 'Authentifizierung erfolgreich', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_27'), 'PUSHED_TO_CONFIG',
 'de', 27, @currentPageType, 'Sie wurden erfolgreich authentifiziert und werden automatisch zum Händler weitergeleitet.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_28'), 'PUSHED_TO_CONFIG',
 'de', 28, @currentPageType, 'Ungültige BestSign TAN', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_29'), 'PUSHED_TO_CONFIG',
 'de', 29, @currentPageType, 'Sie haben eine ungültige BestSign TAN eingegeben. Nach der zweiten falschen TAN-Eingabe in Folge wird das Sicherheitsverfahren gesperrt. Bitte geben Sie die Ihnen zugesandte BestSign TAN erneut ein.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_30'), 'PUSHED_TO_CONFIG',
 'de', 30, @currentPageType, 'Die Session ist abgelaufen.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_31'), 'PUSHED_TO_CONFIG',
 'de', 31, @currentPageType, 'Sie haben einige Zeit keine Eingaben vorgenommen, daher wurde die Zahlung abgebrochen. Starten Sie den Bezahlvorgang erneut, wenn Sie die Zahlung abschließen möchten.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
 'de', 32, @currentPageType, 'Technischer Fehler', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
 'de', 33, @currentPageType, 'Ein technischer Fehler ist aufgetreten und Ihr Kauf konnte nicht abgeschlossen werden. Bitte versuchen Sie es später erneut.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
 'de', 40, @currentPageType, 'Abbrechen', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
 'de', 41, @currentPageType, '?', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_100'), 'PUSHED_TO_CONFIG',
 'de', 100, 'ALL', 'Händler', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_101'), 'PUSHED_TO_CONFIG',
 'de', 101, 'ALL', 'Betrag', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_102'), 'PUSHED_TO_CONFIG',
 'de', 102, 'ALL', 'Datum', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
 'de', 103, 'ALL', 'Kartennummer', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_104'), 'PUSHED_TO_CONFIG',
 'de', 104, 'ALL', 'Gerät', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
 'de', 174, 'ALL', 'Schließen', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
 'de', 175, 'ALL', 'Zurück zum Shop', NULL, NULL, @currentCustomItemSet);

/* Elements for the CHOICE page, for APP Profile */
SET @currentPageType = 'CHOICE_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
 'de', 1, @currentPageType, '<b>Schritt 2: Geräteauswahl</b>', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
 'de', 2, @currentPageType, 'Bitte wählen Sie das Gerät aus, mit dem Sie diesen Auftrag bestätigen wollen.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_14'), 'PUSHED_TO_CONFIG',
 'de', 14, @currentPageType, 'Die Zahlung wurde abgebrochen', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_15'), 'PUSHED_TO_CONFIG',
 'de', 15, @currentPageType, 'Starten Sie den Bezahlvorgang erneut, wenn Sie die Zahlung abschließen möchten.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_30'), 'PUSHED_TO_CONFIG',
 'de', 30, @currentPageType, 'Die Session ist abgelaufen.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_31'), 'PUSHED_TO_CONFIG',
 'de', 31, @currentPageType, 'Sie haben einige Zeit keine Eingaben vorgenommen, daher wurde die Zahlung abgebrochen. Starten Sie den Bezahlvorgang erneut, wenn Sie die Zahlung abschließen möchten.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
 'de', 32, @currentPageType, 'Technischer Fehler', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
 'de', 33, @currentPageType, 'Ein technischer Fehler ist aufgetreten und Ihr Kauf konnte nicht abgeschlossen werden. Bitte versuchen Sie es später erneut.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
 'de', 40, @currentPageType, 'Abbrechen', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
 'de', 41, @currentPageType, '?', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_42'), 'PUSHED_TO_CONFIG',
 'de', 42, @currentPageType, 'Senden', NULL, NULL, @currentCustomItemSet);

/* Elements for the FAILURE page, for APP Profile */
SET @currentPageType = 'FAILURE_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
 'de', 1, @currentPageType, '<b>Freigabe der Zahlung nicht möglich</b>', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
 'de', 2, @currentPageType, 'Die Anmeldung ist fehlgeschlagen. Bitte versuchen Sie es erneut mit gültigen Anmeldedaten.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
 'de', 3, @currentPageType, 'Über den Button gelangen Sie zurück zum Shop.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
 'de', 16, @currentPageType, 'Authentifizierung fehlgeschlagen', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
 'de', 17, @currentPageType, '', NULL, NULL, @currentCustomItemSet);

/* Elements for the HELPPAGE page, for MOBILEAPP Profile */
SET @currentPageType = 'HELP_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
 'de', 1, @currentPageType, '<b>Hinweise zur SpardaSecureApp</b>', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
 'de', 2, @currentPageType, 'Bitte öffnen Sie die SpardaSecureApp auf dem entsprechenden Gerät. Hierzu müssen Sie sich mit Ihrem SpardaSecureApp-Passwort oder mit der TouchID/FaceID einloggen. Anschließend werden Ihnen die Zahlungsinformationen angezeigt. Bitte gleichen Sie diese ab und geben die Zahlung frei.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
 'de', 3, @currentPageType, 'Sie können die Zahlungsfreigabe in der SpardaSecureApp auch ablehnen.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
 'de', 174, @currentPageType, 'Schließen', NULL, NULL, @currentCustomItemSet);

SET @currentPageType = 'MEANS_PAGE';
SET @currentAuthentMean1 = 'MOBILE_APP';
SET @Imageid = (SELECT `id` FROM `Image` im WHERE im.name LIKE CONCAT(@currentAuthentMean1,'_Logo','%'));

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_9'), 'PUSHED_TO_CONFIG',
 'de', 9, @currentPageType, 'SecureApp', NULL, NULL, @currentCustomItemSet),
('I', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_9'), 'PUSHED_TO_CONFIG', 
 'de', 9, @currentPageType, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_9'), NULL, @Imageid, @currentCustomItemSet);

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT `DTYPE`, `createdBy`, NOW(), NULL, NULL, NULL, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, @MaestroVID, `fk_id_image`, @customItemSetMobileAppChoice
  FROM `CustomItem` WHERE fk_id_customItemSet = @customItemSetMobileApp;

/* Elements for the profile CHIPTAN : */
SET @currentAuthentMean = 'CHIP_TAN';
SET @currentCustomItemSet = @customItemSetCHIPTAN;

SET @currentPageType = 'OTP_FORM_PAGE';
/* Here are the images for all pages associated to the CHIPTAN Profile */

/* Here is what the content of the CHIPTAN will be */

/* Elements for the OTP page, for CHIPTAN Profile */
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG', 'de', 1, 'ALL', 'Banklogo', NULL, @idBankLogo,  @currentCustomItemSet),
('I', @createdBy, NOW(), NULL, NULL, NULL, 'VISA_LOGO', 'PUSHED_TO_CONFIG', 'de', 2, 'ALL','VISA_LOGO', @idNetworkVISA, @idNetworkVISA,  @currentCustomItemSet),
('I', @createdBy, NOW(), NULL, NULL, NULL, 'MASTERCARD_LOGO', 'PUSHED_TO_CONFIG', 'de', 2, 'ALL','MASTERCARD_LOGO', @idNetworkMC, @idNetworkMC,  @currentCustomItemSet),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
 'de', 1, @currentPageType, '<b>Schritt 2: Eingabe chipTAN</b>', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
 'de', 2, @currentPageType, 'Bitte geben Sie die generierte chipTAN ein.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
 'de', 3, @currentPageType, '<b>TAN* :</b>', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_4'), 'PUSHED_TO_CONFIG',
 'de', 4, 'OTP_FORM_PAGE', 'Geschwindigkeit', NULL, null,  @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_5'), 'PUSHED_TO_CONFIG',
 'de', 5, 'OTP_FORM_PAGE', 'Zoom', NULL, null,  @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_6'), 'PUSHED_TO_CONFIG',
 'de', 6, 'OTP_FORM_PAGE', 'Beschreibung für manuelle Challenge', NULL, null,  @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_7'), 'PUSHED_TO_CONFIG',
 'de', 7, 'OTP_FORM_PAGE', 'Umschalten auf manuelle Challenge', NULL, null,  @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_12'), 'PUSHED_TO_CONFIG',
 'de', 12, @currentPageType, 'Authentifizierung läuft.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_13'), 'PUSHED_TO_CONFIG',
 'de', 13, @currentPageType, 'Bitte warten Sie ein paar Sekunden, um Ihre Eingabe zu überprüfen.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_14'), 'PUSHED_TO_CONFIG',
 'de', 14, @currentPageType, 'Die Zahlung wurde abgebrochen.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_15'), 'PUSHED_TO_CONFIG',
 'de', 15, @currentPageType, 'Starten Sie den Bezahlvorgang erneut, wenn Sie die Zahlung abschließen möchten.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_26'), 'PUSHED_TO_CONFIG',
 'de', 26, @currentPageType, 'Authentifizierung erfolgreich.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_27'), 'PUSHED_TO_CONFIG',
 'de', 27, @currentPageType, 'Sie wurden erfolgreich authentifiziert und werden automatisch zum Händler weitergeleitet.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_28'), 'PUSHED_TO_CONFIG',
 'de', 28, @currentPageType, '<h3>Fehlerhafte TAN</h3>', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_29'), 'PUSHED_TO_CONFIG',
 'de', 29, @currentPageType, 'Diese TAN-Nummer ist ungültig. Bitte ändern Sie Ihre Eingabe.<br>Die Anzahl der Ihnen verbleibenden Versuche lautet: @trialsLeft', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_30'), 'PUSHED_TO_CONFIG',
 'de', 30, @currentPageType, 'Die Session ist abgelaufen.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_31'), 'PUSHED_TO_CONFIG',
 'de', 31, @currentPageType, 'Sie haben einige Zeit keine Eingaben vorgenommen, daher wurde die Zahlung abgebrochen. Starten Sie den Bezahlvorgang erneut, wenn Sie die Zahlung abschließen möchten.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
 'de', 32, @currentPageType, 'Technischer Fehler.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
 'de', 33, @currentPageType, 'Ein technischer Fehler ist aufgetreten und Ihr Kauf konnte nicht abgeschlossen werden. Bitte versuchen Sie es später erneut.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
 'de', 40, @currentPageType, 'Abbrechen', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
 'de', 41, @currentPageType, '?', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_42'), 'PUSHED_TO_CONFIG',
 'de', 42, @currentPageType, 'Senden', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_100'), 'PUSHED_TO_CONFIG',
 'de', 100, 'ALL', 'Händler', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_101'), 'PUSHED_TO_CONFIG',
 'de', 101, 'ALL', 'Betrag', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_102'), 'PUSHED_TO_CONFIG',
 'de', 102, 'ALL', 'Datum', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
 'de', 103, 'ALL', 'Kreditkartennummer', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_104'), 'PUSHED_TO_CONFIG',
 'de', 104, 'ALL', 'Gerät', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
 'de', 174, 'ALL', 'Schließen', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
 'de', 175, 'ALL', 'Zurück zum Shop', NULL, NULL, @currentCustomItemSet);

/* Elements for the FAILURE page, for CHIPTAN Profile */
SET @currentPageType = 'FAILURE_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
 'de', 1, @currentPageType, '<b>Freigabe der Zahlung nicht möglich</b>', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
 'de', 2, @currentPageType, 'Die Anmeldung ist fehlgeschlagen. Bitte versuchen Sie es erneut mit gültigen Anmeldedaten.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
 'de', 3, @currentPageType, 'Über den Button gelangen Sie zurück zum Shop.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_16'), 'PUSHED_TO_CONFIG',
 'de', 16, @currentPageType, 'Maximale Anzahl der Fehlversuche erreicht.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_17'), 'PUSHED_TO_CONFIG',
 'de', 17, @currentPageType, 'Die Transaktion wurde abgebrochen, die Zahlung nicht durchgeführt.', NULL, NULL, @currentCustomItemSet);

/* Elements for the HELP_PAGE page, for CHIPTAN Profile */
SET @currentPageType = 'HELP_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
 'de', 1, @currentPageType, '<b>Hinweise zur chipTAN</b>', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
 'de', 2, @currentPageType, '<b>Eingabe per Flickercode:</b> <p>Stecken Sie Ihre BankCard (nicht die für den Einkauf verwendete Sparda-Kreditkarte) in den TAN-Generator und drücken „F“. Halten Sie den TAN-Generator vor die animierte Grafik.
Dabei müssen die Markierungen (Dreiecke) der Grafik mit denen auf Ihrem TAN-Generator übereinstimmen. Prüfen Sie die Anzeige auf dem Leserdisplay und drücken "OK".
Prüfen Sie die Hinweise und bestätigen Sie diese dann jeweils mit "OK" auf Ihrem TAN-Generator.
</p>', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
 'de', 3, @currentPageType, '<b>Manuelle Eingabe:</b> <p>Führen Sie Ihre Karte in den TAN-Generator ein. Drücken Sie die Taste "TAN", so dass im Display "Start-Code" erscheint. Geben Sie den Start-Code 267160 ein. Drücken Sie die Taste "OK". Geben Sie die geforderten Daten in den TAN-Generator ein und bestätigen Sie diese mit "OK".</p>', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
 'de', 174, @currentPageType, 'Schließen', NULL, NULL, @currentCustomItemSet);
 
SET @currentPageType = 'MEANS_PAGE';
SET @currentAuthentMean1 = 'TUPAS';
SET @Imageid = (SELECT `id` FROM `Image` im WHERE im.name LIKE CONCAT('%',@currentAuthentMean1,'_Logo','%'));

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_9'), 'PUSHED_TO_CONFIG',
 'de', 9, @currentPageType, 'chipTAN', NULL, NULL, @currentCustomItemSet),
('I', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_9'), 'PUSHED_TO_CONFIG', 
 'de', 9, @currentPageType, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_9'), NULL, @Imageid, @currentCustomItemSet);

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT `DTYPE`, `createdBy`, NOW(), NULL, NULL, NULL, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, @MaestroVID, `fk_id_image`, @customItemSetCHIPTANChoice
  FROM `CustomItem` WHERE fk_id_customItemSet = @customItemSetCHIPTAN;


/* Elements for the CHOICE page, for CHOICE ALL Profile */
SET @currentCustomItemSet = @customItemSetUndefinedAll;

SET @currentPageType = 'MEANS_PAGE';
SET @currentAuthentMean = 'UNDEFINED';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('I', @createdBy, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG', 'de', 1, 'ALL', 'Banklogo', NULL, @idBankLogo,  @currentCustomItemSet),
('I', @createdBy, NOW(), NULL, NULL, NULL, 'VISA_LOGO', 'PUSHED_TO_CONFIG', 'de', 2, 'ALL','VISA_LOGO', @idNetworkVISA, @idNetworkVISA,  @currentCustomItemSet),
('I', @createdBy, NOW(), NULL, NULL, NULL, 'MASTERCARD_LOGO', 'PUSHED_TO_CONFIG', 'de', 2, 'ALL','MASTERCARD_LOGO', @idNetworkMC, @idNetworkMC,  @currentCustomItemSet),
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
 'de', 1, @currentPageType, '<b>Schritt 2: Auswahl TAN-Verfahren</b>', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
 'de', 2, @currentPageType, 'Bitte wählen Sie eines der möglichen TAN-Verfahren aus.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
 'de', 3, @currentPageType, '<b>Auswahl TAN-Verfahren*: </b>', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_14'), 'PUSHED_TO_CONFIG',
 'de', 14, @currentPageType, 'Die Zahlung wurde abgebrochen', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_15'), 'PUSHED_TO_CONFIG',
 'de', 15, @currentPageType, 'Starten Sie den Bezahlvorgang erneut, wenn Sie die Zahlung abschließen möchten.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_30'), 'PUSHED_TO_CONFIG',
 'de', 30, @currentPageType, 'Die Session ist abgelaufen.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_31'), 'PUSHED_TO_CONFIG',
 'de', 31, @currentPageType, 'Sie haben einige Zeit keine Eingaben vorgenommen, daher wurde die Zahlung abgebrochen. Starten Sie den Bezahlvorgang erneut, wenn Sie die Zahlung abschließen möchten.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_32'), 'PUSHED_TO_CONFIG',
 'de', 32, @currentPageType, 'Technischer Fehler', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_33'), 'PUSHED_TO_CONFIG',
 'de', 33, @currentPageType, 'Ein technischer Fehler ist aufgetreten und Ihr Kauf konnte nicht abgeschlossen werden. Bitte versuchen Sie es später erneut.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_40'), 'PUSHED_TO_CONFIG',
 'de', 40, @currentPageType, 'Abbrechen', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_41'), 'PUSHED_TO_CONFIG',
 'de', 41, @currentPageType, '?', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_42'), 'PUSHED_TO_CONFIG',
 'de', 42, @currentPageType, 'Senden', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_100'), 'PUSHED_TO_CONFIG',
 'de', 100, 'ALL', 'Händler', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_101'), 'PUSHED_TO_CONFIG',
 'de', 101, 'ALL', 'Betrag', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_102'), 'PUSHED_TO_CONFIG',
 'de', 102, 'ALL', 'Datum', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_103'), 'PUSHED_TO_CONFIG',
 'de', 103, 'ALL', 'Kartennummer', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
 'de', 174, 'ALL', 'Schließen', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_175'), 'PUSHED_TO_CONFIG',
 'de', 175, 'ALL', 'Zurück zum Shop', NULL, NULL, @currentCustomItemSet);
 
SET @currentPageType = 'HELP_PAGE';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_1'), 'PUSHED_TO_CONFIG',
 'de', 1, @currentPageType, '<b>Hinweis zur TAN-Verfahrensauswahl</b>', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_2'), 'PUSHED_TO_CONFIG',
 'de', 2, @currentPageType, 'Sie haben die Möglichkeit eines Ihrer verfügbaren TAN-Verfahren auszuwählen. Klicken Sie hierzu auf das gewünschte Verfahren. Um die Freigabe der Zahlung abzubrechen, klicken Sie auf „Abbrechen”.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_3'), 'PUSHED_TO_CONFIG',
 'de', 3, @currentPageType, 'Sofern die SpardaSecureApp eines der verfügbaren Verfahren ist und Sie mehrere Geräte für die SpardaSecureApp angemeldet haben, werden Ihnen diese in der Auswahlliste angezeigt.', NULL, NULL, @currentCustomItemSet),

('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVISA,'_',@currentAuthentMean,'_',@currentPageType,'_174'), 'PUSHED_TO_CONFIG',
 'de', 174, @currentPageType, 'Schließen', NULL, NULL, @currentCustomItemSet);

/* Elements for the CHOICE page, for CHOICE_SMS_CHIP Profile */
SET @currentCustomItemSet = @customItemSetUndefinedSMSChip;
SET @currentPageType = 'MEANS_PAGE';
SET @currentAuthentMean = 'UNDEFINED';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT `DTYPE`, `createdBy`, NOW(), NULL, NULL, NULL, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, @MaestroVID, `fk_id_image`, @customItemSetUndefinedSMSChip
  FROM `CustomItem` WHERE fk_id_customItemSet = @customItemSetUndefinedAll;

/* Elements for the CHOICE page, for CHOICE_CHIP_APP Profile */
SET @currentCustomItemSet = @customItemSetUndefinedChipApp;
SET @currentPageType = 'MEANS_PAGE';
SET @currentAuthentMean = 'UNDEFINED';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT `DTYPE`, `createdBy`, NOW(), NULL, NULL, NULL, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, @MaestroVID, `fk_id_image`, @customItemSetUndefinedChipApp
  FROM `CustomItem` WHERE fk_id_customItemSet = @customItemSetUndefinedAll;

/* Elements for the CHOICE page, for CHOICE_SMS_APP Profile */
-- SET @customItemSetCHOICE_SMS_APP = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_SMS_APP'));
SET @currentCustomItemSet = @customItemSetUndefinedSMSApp;
SET @currentPageType = 'MEANS_PAGE';
SET @currentAuthentMean = 'UNDEFINED';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT `DTYPE`, `createdBy`, NOW(), NULL, NULL, NULL, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, @MaestroVID, `fk_id_image`, @customItemSetUndefinedSMSApp
  FROM `CustomItem` WHERE fk_id_customItemSet = @customItemSetUndefinedAll;

/* ProfileSet */

SET @sharedIssuerName = 'SPB_sharedBIN';


INSERT INTO `ProfileSet` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `fk_id_subIssuer`)
    SELECT @createdBy,NOW(),CONCAT(@sharedIssuerName, ' profile set'),NULL,NULL,CONCAT('PS_', @sharedIssuerName, '_01'),'PUSHED_TO_CONFIG',si.id
    FROM `SubIssuer` si
    WHERE si.fk_id_issuer = @issuerId and si.id = @subIssuerID;

-- link templates and profile set

INSERT INTO CustomPageLayout_ProfileSet
SELECT cpl.id, ps.id FROM (SELECT id FROM ProfileSet where name = CONCAT('PS_', @sharedIssuerName, '_01')) as ps
                        , (SELECT id FROM CustomPageLayout where description like CONCAT('%', @bankName, '%')) as cpl;

SET @idProfileSet = (SELECT id FROM ProfileSet where name = CONCAT('PS_', @sharedIssuerName, '_01'));

/* Profile */
INSERT INTO `Profile` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                       `updateState`, `maxAttempts`, dataEntryAllowedPattern, dataEntryFormat, `fk_id_authentMeans`,
                       `fk_id_customItemSetCurrent`, `fk_id_customItemSetOld`, `fk_id_customItemSetNew`,
                       `fk_id_subIssuer`) VALUES
(@createdBy, NOW(), 'TECHNICAL ERROR', NULL, NULL, CONCAT(@sharedIssuerName,'_DEFAULT_REFUSAL_TE'), 'PUSHED_TO_CONFIG', -1, '^[^OIi]*$', '6:(:DIGIT:1)', @authMeanRefusal, @customItemSetTERefusal, NULL, NULL, @subIssuerID),
(@createdBy, NOW(), 'FUNCTIONAL ERROR', NULL, NULL, CONCAT(@sharedIssuerName,'_DEFAULT_REFUSAL_FE'), 'PUSHED_TO_CONFIG', -1, '^[^OIi]*$', '6:(:DIGIT:1)', @authMeanRefusal, @customItemSetFERefusal, NULL, NULL, @subIssuerID),
(@createdBy, NOW(), 'RBA_DECLINE', NULL, NULL, CONCAT(@sharedIssuerName,'_DECLINE'), 'PUSHED_TO_CONFIG', 3, '^[^OIi]*$', '6:(:DIGIT:1)', @authMeanACCEPT, @customItemSetRBADECLINE, NULL, NULL, @subIssuerID),
(@createdBy, NOW(), 'RBA_ACCEPT', NULL, NULL, CONCAT(@sharedIssuerName,'_ACCEPT'), 'PUSHED_TO_CONFIG', 3, '^[^OIi]*$', '6:(:DIGIT:1)', @authMeanACCEPT, @customItemSetRBAACCEPT, NULL, NULL, @subIssuerID),
(@createdBy, NOW(), 'OTP_SMS_CHOICE', NULL, NULL, CONCAT(@sharedIssuerName,'_SMS_01'), 'PUSHED_TO_CONFIG', 3, '^[^OIi]*$', '6:(:DIGIT:1)', @authMeanOTPsms, @customItemSetSMSChoice, NULL, NULL, @subIssuerID),
(@createdBy, NOW(), 'CHIPTAN_CHOICE', NULL, NULL, CONCAT(@sharedIssuerName,'_CHIPTAN_01'), 'PUSHED_TO_CONFIG', 3, '^[^OIi]*$', '6:(:DIGIT:1)', @authMeanOTPchiptan, @customItemSetCHIPTANChoice, NULL, NULL, @subIssuerID),
(@createdBy, NOW(), 'MOBILE_APP_CHOICE', NULL, NULL, CONCAT(@sharedIssuerName,'_APP_01'), 'PUSHED_TO_CONFIG', 3, '^[^OIi]*$', '6:(:DIGIT:1)', @authentMeansMobileApp, @customItemSetMOBILEAPPChoice, NULL, NULL, @subIssuerID),
(@createdBy, NOW(), 'CHOICE_ALL', NULL, NULL, CONCAT(@sharedIssuerName,'_AUTHENT_MEANS_CHOICE_ALL'), 'PUSHED_TO_CONFIG', 3, '^[^OIi]*$', '6:(:DIGIT:1)', @authMeanUndefined, @customItemSetUndefinedAll, NULL, NULL, @subIssuerID),
(@createdBy, NOW(), 'CHOICE_SMS_CHIP', NULL, NULL, CONCAT(@sharedIssuerName,'_AUTHENT_MEANS_CHOICE_SMS_CHIP'), 'PUSHED_TO_CONFIG', 3, '^[^OIi]*$', '6:(:DIGIT:1)', @authMeanUndefined, @customItemSetUndefinedSMSChip, NULL, NULL, @subIssuerID),
(@createdBy, NOW(), 'CHOICE_CHIP_APP', NULL, NULL, CONCAT(@sharedIssuerName,'_AUTHENT_MEANS_CHOICE_CHIP_APP'), 'PUSHED_TO_CONFIG', 3, '^[^OIi]*$', '6:(:DIGIT:1)', @authMeanUndefined, @customItemSetUndefinedChipApp, NULL, NULL, @subIssuerID),
(@createdBy, NOW(), 'CHOICE_SMS_APP', NULL, NULL, CONCAT(@sharedIssuerName,'_AUTHENT_MEANS_CHOICE_SMS_APP'), 'PUSHED_TO_CONFIG', 3, '^[^OIi]*$', '6:(:DIGIT:1)', @authMeanUndefined, @customItemSetUndefinedSMSApp, NULL, NULL, @subIssuerID),
(@createdBy, NOW(), 'EXT PASSWORD (NORMAL)', NULL, NULL, CONCAT(@sharedIssuerName,'_PASSWORD_01'), 'PUSHED_TO_CONFIG', 3, '^[^OIi]*$', '6:(:DIGIT:1)', @authMeanPassword, @customItemSetPassword, NULL, NULL, @subIssuerID),
(@createdBy, NOW(), 'UNDEFINED', NULL, NULL, CONCAT(@sharedIssuerName,'_UNDEFINED_01'), 'PUSHED_TO_CONFIG', 3, '^[^OIi]*$', '6:(:DIGIT:1)', @authMeanUndefined, NULL, NULL, NULL, @subIssuerID),
(@createdBy, NOW(), 'OTP_SMS_NORMAL', NULL, NULL, CONCAT(@sharedIssuerName,'_SMS_02'), 'PUSHED_TO_CONFIG', 3, '^[^OIi]*$', '6:(:DIGIT:1)', @authMeanOTPsms, @customItemSetSMS, NULL, NULL, @subIssuerID),
(@createdBy, NOW(), 'CHIPTAN_NORMAL', NULL, NULL, CONCAT(@sharedIssuerName,'_CHIPTAN_02'), 'PUSHED_TO_CONFIG', 3, '^[^OIi]*$', '6:(:DIGIT:1)', @authMeanOTPchiptan, @customItemSetCHIPTAN, NULL, NULL, @subIssuerID),
(@createdBy, NOW(), 'MOBILE_APP_NORMAL', NULL, NULL, CONCAT(@sharedIssuerName,'_APP_02'), 'PUSHED_TO_CONFIG', 3, '^[^OIi]*$', '6:(:DIGIT:1)', @authentMeansMobileApp, @customItemSetMOBILEAPP, NULL, NULL, @subIssuerID),
(@createdBy, NOW(), 'REFUSAL (DEFAULT)', NULL, NULL, CONCAT(@sharedIssuerName,'_DEFAULT_REFUSAL'), 'PUSHED_TO_CONFIG', -1, '^[^OIi]*$', '6:(:DIGIT:1)', @authMeanRefusal, @customItemSetDefaultRefusal, NULL, NULL, @subIssuerID);

/* Rule */

SET @profileRefusal = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@sharedIssuerName, '_DEFAULT_REFUSAL'));
SET @profileRefusalTE = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@sharedIssuerName, '_DEFAULT_REFUSAL_TE'));
SET @profileRefusalFE = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@sharedIssuerName, '_DEFAULT_REFUSAL_FE'));
SET @profileRBADECLINE = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@sharedIssuerName,'_DECLINE'));
SET @profileRBAACCEPT = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@sharedIssuerName,'_ACCEPT'));
SET @profileSMSChoice = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@sharedIssuerName,'_SMS_01'));
SET @profileCHIPTANChoice = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@sharedIssuerName,'_CHIPTAN_01'));
SET @profileMOBILEAPPChoice = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@sharedIssuerName,'_APP_01'));
SET @profileCHOICE_ALL = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@sharedIssuerName, '_AUTHENT_MEANS_CHOICE_ALL'));
SET @profileSMS_CHIP = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@sharedIssuerName, '_AUTHENT_MEANS_CHOICE_SMS_CHIP'));
SET @profileCHIP_APP = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@sharedIssuerName, '_AUTHENT_MEANS_CHOICE_CHIP_APP'));
SET @profileSMS_APP = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@sharedIssuerName, '_AUTHENT_MEANS_CHOICE_SMS_APP'));
SET @profilePassword = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@sharedIssuerName,'_PASSWORD_01'));
SET @profileUndefined = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@sharedIssuerName,'_UNDEFINED_01'));
SET @profileSMS = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@sharedIssuerName,'_SMS_02'));
SET @profileCHIPTAN = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@sharedIssuerName,'_CHIPTAN_02'));
SET @profileMOBILEAPP = (SELECT id FROM `Profile` WHERE `name` = CONCAT(@sharedIssuerName,'_APP_02'));

INSERT INTO `Rule` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                    `updateState`, `orderRule`, `fk_id_profile`) VALUES
(@createdBy, NOW(), 'REFUSAL_TECHNICAL_ERROR', NULL, NULL, 'TECHNICAL_ERROR', 'PUSHED_TO_CONFIG', 1, @profileRefusalTE),
(@createdBy, NOW(), 'REFUSAL_FUNCTIONAL_ERROR', NULL, NULL, 'FUNCTIONAL_ERROR', 'PUSHED_TO_CONFIG', 2, @profileRefusalFE),
(@createdBy, NOW(), 'RBA_DECLINE', NULL, NULL, 'REFUSAL (DECLINE)', 'PUSHED_TO_CONFIG', 3, @profileRBADECLINE),
(@createdBy, NOW(), 'RBA_ACCEPT', NULL, NULL, 'NONE (ACCEPT)', 'PUSHED_TO_CONFIG', 4, @profileRBAACCEPT),
(@createdBy, NOW(), 'SMS_CHOICE_AVAILABLE', NULL, NULL, 'OTP_SMS (CHOICE)', 'PUSHED_TO_CONFIG', 5, @profileSMSChoice),
(@createdBy, NOW(), 'CHIP_TAN_CHOICE_AVAILABLE', NULL, NULL, 'CHIP_TAN (CHOICE)', 'PUSHED_TO_CONFIG', 6, @profileCHIPTANChoice),
(@createdBy, NOW(), 'OTP_APP_CHOICE_AVAILABLE', NULL, NULL, 'APP (CHOICE)', 'PUSHED_TO_CONFIG', 7, @profileMOBILEAPPChoice),
(@createdBy, NOW(), 'ALL METHODS AVAILABLE', NULL, NULL, 'ALL METHODS AVAILABLE', 'PUSHED_TO_CONFIG', 8, @profileCHOICE_ALL),
(@createdBy, NOW(), 'SMS & CHIPTAN AVAILABLE', NULL, NULL, 'SMS & CHIPTAN AVAILABLE', 'PUSHED_TO_CONFIG', 9, @profileSMS_CHIP),
(@createdBy, NOW(), 'CHIPTAN & APP AVAILABLE', NULL, NULL, 'CHIPTAN & APP AVAILABLE', 'PUSHED_TO_CONFIG', 10, @profileCHIP_APP),
(@createdBy, NOW(), 'SMS & APP AVAILABLE', NULL, NULL, 'SMS & APP AVAILABLE', 'PUSHED_TO_CONFIG', 11, @profileSMS_APP),
(@createdBy, NOW(), 'PASSWORD_AVAILABLE_NORMAL', NULL, NULL, 'EXT_PASSWORD (NORMAL)', 'PUSHED_TO_CONFIG', 12, @profilePassword),
(@createdBy, NOW(), 'UNDEFINED_NORMAL', NULL, NULL, 'UNDEFINED (NORMAL)', 'PUSHED_TO_CONFIG', 13, @profileUndefined),
(@createdBy, NOW(), 'SMS_AVAILABLE_NORMAL', NULL, NULL, 'OTP_SMS (NORMAL)', 'PUSHED_TO_CONFIG', 14, @profileSMS),
(@createdBy, NOW(), 'CHIP_TAN (NORMAL)', NULL, NULL, 'CHIP_TAN (NORMAL)', 'PUSHED_TO_CONFIG', 15, @profileCHIPTAN),
(@createdBy, NOW(), 'OTP_APP (NORMAL)', NULL, NULL, 'APP (NORMAL)', 'PUSHED_TO_CONFIG', 16, @profileMOBILEAPP),
(@createdBy, NOW(), 'REFUSAL_DEFAULT', NULL, NULL, 'REFUSAL (DEFAULT)', 'PUSHED_TO_CONFIG', 17, @profileRefusal);


/* RuleCondition */

SET @ruleRefusalTE = (SELECT id FROM `Rule` WHERE `description` = 'REFUSAL_TECHNICAL_ERROR' AND `fk_id_profile` = @profileRefusalTE);
SET @ruleRefusalFE = (SELECT id FROM `Rule` WHERE `description` = 'REFUSAL_FUNCTIONAL_ERROR' AND `fk_id_profile` = @profileRefusalFE);
SET @ruleRBADecline = (SELECT id FROM `Rule` WHERE `description` = 'RBA_DECLINE' AND `fk_id_profile` = @profileRBADECLINE);
SET @ruleRBAAccept = (SELECT id FROM `Rule` WHERE `description` = 'RBA_ACCEPT' AND `fk_id_profile` = @profileRBAACCEPT);
SET @ruleSMSChoice = (SELECT id FROM `Rule` WHERE `description` = 'SMS_CHOICE_AVAILABLE' AND `fk_id_profile` = @profileSMSChoice);
SET @ruleChipTanChoice = (SELECT id FROM `Rule` WHERE `description` = 'CHIP_TAN_CHOICE_AVAILABLE' AND `fk_id_profile` = @profileCHIPTANChoice);
SET @ruleMobileAppChoice = (SELECT id FROM `Rule` WHERE `description` = 'OTP_APP_CHOICE_AVAILABLE' AND `fk_id_profile` = @profileMOBILEAPPChoice);
SET @ruleCHOICE_ALL = (SELECT id FROM `Rule` WHERE `description` = 'ALL METHODS AVAILABLE' AND `fk_id_profile` = @profileCHOICE_ALL);
SET @ruleSMS_CHIP = (SELECT id FROM `Rule` WHERE `description` = 'SMS & CHIPTAN AVAILABLE' AND `fk_id_profile` = @profileSMS_CHIP);
SET @ruleCHIP_APP = (SELECT id FROM `Rule` WHERE `description` = 'CHIPTAN & APP AVAILABLE' AND `fk_id_profile` = @profileCHIP_APP);
SET @ruleSMS_APP = (SELECT id FROM `Rule` WHERE `description` = 'SMS & APP AVAILABLE' AND `fk_id_profile` = @profileSMS_APP);
SET @rulePasswordnormal = (SELECT id FROM `Rule` WHERE `description` = 'PASSWORD_AVAILABLE_NORMAL' AND `fk_id_profile` = @profilePassword);
SET @ruleUndefinednormal = (SELECT id FROM `Rule` WHERE `description` = 'UNDEFINED_NORMAL' AND `fk_id_profile` = @profileUndefined);
SET @ruleSMSnormal = (SELECT id FROM `Rule` WHERE `description` = 'SMS_AVAILABLE_NORMAL' AND `fk_id_profile` = @profileSMS);
SET @ruleChipTannormal = (SELECT id FROM `Rule` WHERE `description` = 'CHIP_TAN (NORMAL)' AND `fk_id_profile` = @profileCHIPTAN);
SET @ruleMobileAppnormal = (SELECT id FROM `Rule` WHERE `description` = 'OTP_APP (NORMAL)' AND `fk_id_profile` = @profileMOBILEAPP);
SET @ruleRefusalDefault = (SELECT id FROM `Rule` WHERE `description` = 'REFUSAL_DEFAULT' AND `fk_id_profile` = @profileRefusal);

INSERT INTO `RuleCondition` (`createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`,
                             `updateState`, `fk_id_rule`) VALUES
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @sharedIssuerName, '_01_TECHNICAL_ERROR'), 'PUSHED_TO_CONFIG', @ruleRefusalTE),
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @sharedIssuerName, '_02_TECHNICAL_ERROR'), 'PUSHED_TO_CONFIG', @ruleRefusalTE),
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @sharedIssuerName, '_03_TECHNICAL_ERROR'), 'PUSHED_TO_CONFIG', @ruleRefusalTE),
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @sharedIssuerName, '_04_TECHNICAL_ERROR'), 'PUSHED_TO_CONFIG', @ruleRefusalTE),
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @sharedIssuerName, '_05_TECHNICAL_ERROR'), 'PUSHED_TO_CONFIG', @ruleRefusalTE),
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @sharedIssuerName, '_01_FUNCTIONAL_ERROR'), 'PUSHED_TO_CONFIG', @ruleRefusalFE),
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @sharedIssuerName, '_01_RBA_DECLINE'), 'PUSHED_TO_CONFIG', @ruleRBADecline),
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @sharedIssuerName, '_01_RBA_ACCEPT'), 'PUSHED_TO_CONFIG', @ruleRBAAccept),
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @sharedIssuerName, '_01_SMS_CHOICE_AVAILABLE'), 'PUSHED_TO_CONFIG', @ruleSMSChoice),
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @sharedIssuerName, '_02_SMS_CHOICE_AVAILABLE'), 'PUSHED_TO_CONFIG', @ruleSMSChoice),
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @sharedIssuerName, '_01_CHIP_TAN_CHOICE_AVAILABLE'), 'PUSHED_TO_CONFIG', @ruleChipTanChoice),
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @sharedIssuerName, '_02_CHIP_TAN_CHOICE_AVAILABLE'), 'PUSHED_TO_CONFIG', @ruleChipTanChoice),
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @sharedIssuerName, '_01_MOBILE_APP_CHOICE_AVAILABLE'), 'PUSHED_TO_CONFIG', @ruleMobileAppChoice),
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @sharedIssuerName, '_02_MOBILE_APP_CHOICE_AVAILABLE'), 'PUSHED_TO_CONFIG', @ruleMobileAppChoice),
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_ALL'), 'PUSHED_TO_CONFIG', @ruleCHOICE_ALL),
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_SMS_CHIP'), 'PUSHED_TO_CONFIG', @ruleSMS_CHIP),
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_CHIP_APP'), 'PUSHED_TO_CONFIG', @ruleCHIP_APP),
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_SMS_APP'), 'PUSHED_TO_CONFIG', @ruleSMS_APP),
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @sharedIssuerName, '_01_PASSWORD_NORMAL'), 'PUSHED_TO_CONFIG', @rulePasswordnormal),
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @sharedIssuerName, '_01_UNDEFINED_NORMAL'), 'PUSHED_TO_CONFIG', @ruleUndefinednormal),
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @sharedIssuerName, '_01_OTP_SMS_NORMAL'), 'PUSHED_TO_CONFIG', @ruleSMSnormal),
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @sharedIssuerName, '_01_CHIP_TAN_NORMAL'), 'PUSHED_TO_CONFIG', @ruleChipTannormal),
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @sharedIssuerName, '_01_OTP_APP_NORMAL'), 'PUSHED_TO_CONFIG', @ruleMobileAppnormal),
(@createdBy, NOW(), NULL, NULL, NULL, CONCAT('C1_P_', @sharedIssuerName, '_01_DEFAULT'), 'PUSHED_TO_CONFIG', @ruleRefusalDefault);

-- the ids of the authent means
SET @rulePasswordCondtn = (SELECT `id` FROM `RuleCondition` WHERE `name` = CONCAT('C1_P_', @sharedIssuerName, '_01_PASSWORD_NORMAL') AND `fk_id_rule` = @rulePasswordnormal);
SET @ruleChipTanChoiceCondtn1 = (SELECT `id` FROM `RuleCondition` WHERE `name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHIP_TAN_CHOICE_AVAILABLE') AND `fk_id_rule` = @ruleChipTanChoice);
SET @ruleChipTanChoiceCondtn2 = (SELECT `id` FROM `RuleCondition` WHERE `name` = CONCAT('C1_P_', @sharedIssuerName, '_02_CHIP_TAN_CHOICE_AVAILABLE') AND `fk_id_rule` = @ruleChipTanChoice);
SET @ruleCHOICE_ALLCondtn = (SELECT `id` FROM `RuleCondition` WHERE `name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_ALL') AND `fk_id_rule` = @ruleCHOICE_ALL);
SET @ruleSMS_CHIPCondtn = (SELECT `id` FROM `RuleCondition` WHERE `name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_SMS_CHIP') AND `fk_id_rule` = @ruleSMS_CHIP);
SET @ruleCHIP_APPCondtn = (SELECT `id` FROM `RuleCondition` WHERE `name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_CHIP_APP') AND `fk_id_rule` = @ruleCHIP_APP);
SET @ruleChipTannormalCondtn = (SELECT `id` FROM `RuleCondition` WHERE `name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHIP_TAN_NORMAL') AND `fk_id_rule` = @ruleChipTannormal);

SET @authMeanOTPchiptan = (SELECT id FROM `AuthentMeans`  WHERE `name` = 'CHIP_TAN');

/* Condition_TransactionStatuses */


INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_TECHNICAL_ERROR')
  AND (ts.`transactionStatusType` = 'PAYMENT_MEANS_IN_NEGATIVE_LIST' AND ts.`reversed` = FALSE);
INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_02_TECHNICAL_ERROR')
  AND (ts.`transactionStatusType` = 'CARD_HOLDER_IP_IN_NEGATIVE_LIST' AND ts.`reversed` = FALSE);
INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_03_TECHNICAL_ERROR')
  AND (ts.`transactionStatusType` = 'CARD_HOLDER_COUNTRY_IN_NEGATIVE_LIST' AND ts.`reversed` = FALSE);
INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_04_TECHNICAL_ERROR')
  AND (ts.`transactionStatusType` = 'MERCHANT_URL_IN_NEGATIVE_LIST' AND ts.`reversed` = FALSE);
INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_05_TECHNICAL_ERROR')
  AND (ts.`transactionStatusType` = 'PHONE_NUMBER_IN_NEGATIVE_LIST' AND ts.`reversed` = FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_FUNCTIONAL_ERROR')
  AND (ts.`transactionStatusType` = 'CARD_HOLDER_BLOCKED' AND ts.`reversed` = FALSE);
INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_FUNCTIONAL_ERROR')
  AND (ts.`transactionStatusType` = 'ALWAYS_DECLINE' AND ts.`reversed` = FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_RBA_DECLINE')
  AND (ts.`transactionStatusType` = 'ALWAYS_DECLINE' AND ts.`reversed` = FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_RBA_DECLINE')
  AND (ts.`transactionStatusType` = 'ALWAYS_ACCEPT' AND ts.`reversed` = TRUE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_RBA_ACCEPT')
  AND (ts.`transactionStatusType` = 'ALWAYS_ACCEPT' AND ts.`reversed` = FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_RBA_ACCEPT')
  AND (ts.`transactionStatusType` = 'ALWAYS_DECLINE' AND ts.`reversed` = TRUE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_SMS_CHOICE_AVAILABLE')
  AND (ts.`transactionStatusType` = 'USER_CHOICE_ALLOWED' AND ts.`reversed` = FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_02_SMS_CHOICE_AVAILABLE')
  AND (ts.`transactionStatusType` = 'USER_CHOICE_ALLOWED' AND ts.`reversed` = FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHIP_TAN_CHOICE_AVAILABLE')
  AND (ts.`transactionStatusType` = 'USER_CHOICE_ALLOWED' AND ts.`reversed` = FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_02_CHIP_TAN_CHOICE_AVAILABLE')
  AND (ts.`transactionStatusType` = 'USER_CHOICE_ALLOWED' AND ts.`reversed` = FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_MOBILE_APP_CHOICE_AVAILABLE')
  AND (ts.`transactionStatusType` = 'USER_CHOICE_ALLOWED' AND ts.`reversed` = FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_02_MOBILE_APP_CHOICE_AVAILABLE')
  AND (ts.`transactionStatusType` = 'USER_CHOICE_ALLOWED' AND ts.`reversed` = FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_PASSWORD_NORMAL')
  AND (ts.`transactionStatusType` = 'COMBINED_AUTHENTICATION_ALLOWED' AND ts.`reversed` = FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_UNDEFINED_NORMAL')
  AND (ts.`transactionStatusType` = 'COMBINED_AUTHENTICATION_ALLOWED' AND ts.`reversed` = FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_ALL')
  AND (ts.`transactionStatusType` = 'COMBINED_AUTHENTICATION_ALLOWED' AND ts.`reversed` = FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_ALL')
  AND (ts.`transactionStatusType` = 'USER_CHOICE_ALLOWED' AND ts.`reversed` = FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_SMS_CHIP')
  AND (ts.`transactionStatusType` = 'COMBINED_AUTHENTICATION_ALLOWED' AND ts.`reversed` = FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_SMS_CHIP')
  AND (ts.`transactionStatusType` = 'USER_CHOICE_ALLOWED' AND ts.`reversed` = FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_CHIP_APP')
  AND (ts.`transactionStatusType` = 'COMBINED_AUTHENTICATION_ALLOWED' AND ts.`reversed` = FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_CHIP_APP')
  AND (ts.`transactionStatusType` = 'USER_CHOICE_ALLOWED' AND ts.`reversed` = FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_SMS_APP')
  AND (ts.`transactionStatusType` = 'COMBINED_AUTHENTICATION_ALLOWED' AND ts.`reversed` = FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_SMS_APP')
  AND (ts.`transactionStatusType` = 'USER_CHOICE_ALLOWED' AND ts.`reversed` = FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_OTP_SMS_NORMAL')
  AND (ts.`transactionStatusType` = 'COMBINED_AUTHENTICATION_ALLOWED' AND ts.`reversed` = FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHIP_TAN_NORMAL')
  AND (ts.`transactionStatusType` = 'COMBINED_AUTHENTICATION_ALLOWED ' AND ts.`reversed` = FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_OTP_APP_NORMAL')
  AND (ts.`transactionStatusType` = 'COMBINED_AUTHENTICATION_ALLOWED ' AND ts.`reversed` = FALSE);

INSERT INTO `Condition_TransactionStatuses` (`id_condition`, `id_transactionStatuses`)
SELECT c.id, ts.id FROM `RuleCondition` c, `TransactionStatuses` ts
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_DEFAULT')
  AND (ts.`transactionStatusType` = 'DEFAULT' AND ts.`reversed` = FALSE);


/* Condition_MeansProcessStatuses */
INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_SMS_CHOICE_AVAILABLE')
  AND mps.`fk_id_authentMean` = @authMeanOTPsms
  AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_SMS_CHOICE_AVAILABLE')
  AND mps.`fk_id_authentMean` = @authMeanOTPsms
  AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_SMS_CHOICE_AVAILABLE')
  AND mps.`fk_id_authentMean` = @authMeanOTPsms
  AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_SMS_CHOICE_AVAILABLE')
  AND mps.`fk_id_authentMean` = @authMeanUndefined
  AND (mps.`meansProcessStatusType` IN ('USER_CHOICE_DEMANDED') AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_02_SMS_CHOICE_AVAILABLE')
  AND mps.`fk_id_authentMean` = @authMeanOTPsms
  AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_02_SMS_CHOICE_AVAILABLE')
  AND mps.`fk_id_authentMean` = @authMeanOTPsms
  AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_02_SMS_CHOICE_AVAILABLE')
  AND mps.`fk_id_authentMean` = @authMeanOTPsms
  AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_02_SMS_CHOICE_AVAILABLE')
  AND mps.`fk_id_authentMean` = @authMeanOTPsms
  AND (mps.`meansProcessStatusType` IN ('USER_CHOICE_DEMANDED') AND mps.`reversed` = FALSE);

--
INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHIP_TAN_CHOICE_AVAILABLE')
  AND mps.`fk_id_authentMean` = @authMeanOTPchiptan
  AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHIP_TAN_CHOICE_AVAILABLE')
  AND mps.`fk_id_authentMean` = @authMeanOTPchiptan
  AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHIP_TAN_CHOICE_AVAILABLE')
  AND mps.`fk_id_authentMean` = @authMeanOTPchiptan
  AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHIP_TAN_CHOICE_AVAILABLE')
  AND mps.`fk_id_authentMean` = @authMeanUndefined
  AND (mps.`meansProcessStatusType` IN ('USER_CHOICE_DEMANDED') AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_02_CHIP_TAN_CHOICE_AVAILABLE')
  AND mps.`fk_id_authentMean` = @authMeanOTPchiptan
  AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_02_CHIP_TAN_CHOICE_AVAILABLE')
  AND mps.`fk_id_authentMean` = @authMeanOTPchiptan
  AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_02_CHIP_TAN_CHOICE_AVAILABLE')
  AND mps.`fk_id_authentMean` = @authMeanOTPchiptan
  AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_02_CHIP_TAN_CHOICE_AVAILABLE')
  AND mps.`fk_id_authentMean` = @authMeanOTPchiptan
  AND (mps.`meansProcessStatusType` IN ('USER_CHOICE_DEMANDED') AND mps.`reversed` = FALSE);

--
INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_MOBILE_APP_CHOICE_AVAILABLE')
  AND mps.`fk_id_authentMean` = @authentMeansMobileApp
  AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_MOBILE_APP_CHOICE_AVAILABLE')
  AND mps.`fk_id_authentMean` = @authentMeansMobileApp
  AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_MOBILE_APP_CHOICE_AVAILABLE')
  AND mps.`fk_id_authentMean` = @authentMeansMobileApp
  AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_MOBILE_APP_CHOICE_AVAILABLE')
  AND mps.`fk_id_authentMean` = @authMeanUndefined
  AND (mps.`meansProcessStatusType` IN ('USER_CHOICE_DEMANDED') AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_02_MOBILE_APP_CHOICE_AVAILABLE')
  AND mps.`fk_id_authentMean` = @authentMeansMobileApp
  AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_02_MOBILE_APP_CHOICE_AVAILABLE')
  AND mps.`fk_id_authentMean` = @authentMeansMobileApp
  AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_02_MOBILE_APP_CHOICE_AVAILABLE')
  AND mps.`fk_id_authentMean` = @authentMeansMobileApp
  AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_02_MOBILE_APP_CHOICE_AVAILABLE')
  AND mps.`fk_id_authentMean` = @authentMeansMobileApp
  AND (mps.`meansProcessStatusType` IN ('USER_CHOICE_DEMANDED') AND mps.`reversed` = FALSE);

--
INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_PASSWORD_NORMAL')
  AND mps.`fk_id_authentMean` = @authMeanPassword
  AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_PASSWORD_NORMAL')
  AND mps.`fk_id_authentMean` = @authMeanPassword
  AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_PASSWORD_NORMAL')
  AND mps.`fk_id_authentMean` = @authMeanPassword
  AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_PASSWORD_NORMAL')
  AND mps.`fk_id_authentMean` = @authMeanPassword
  AND (mps.`meansProcessStatusType` IN ('COMBINED_MEANS_REQUIRED') AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_PASSWORD_NORMAL')
  AND mps.`fk_id_authentMean` = @authMeanPassword
  AND (mps.`meansProcessStatusType` IN ('MEANS_PROCESS_ERROR') AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_PASSWORD_NORMAL')
  AND mps.`fk_id_authentMean` = @authMeanPassword
  AND (mps.`meansProcessStatusType` IN ('USER_CHOICE_DEMANDED') AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_PASSWORD_NORMAL')
  AND mps.`fk_id_authentMean` = @authMeanUndefined
  AND (mps.`meansProcessStatusType` IN ('USER_CHOICE_DEMANDED') AND mps.`reversed` = TRUE);

INSERT INTO `Thresholds` (`isAmountThreshold`, `reversed`, `thresholdType`, `value`, `fk_id_condition`) 
VALUES (b'0', b'0', 'UNDER_TRIAL_NUMBER_THRESHOLD', 3, @rulePasswordCondtn);


INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_UNDEFINED_NORMAL')
  AND mps.`fk_id_authentMean` = @authMeanUndefined
  AND (mps.`meansProcessStatusType` = 'FORCED_MEANS_USAGE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_UNDEFINED_NORMAL')
  AND mps.`fk_id_authentMean` = @authMeanPassword
  AND (mps.`meansProcessStatusType` IN ('COMBINED_MEANS_REQUIRED') AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_UNDEFINED_NORMAL')
  AND mps.`fk_id_authentMean` = @authMeanUndefined
  AND (mps.`meansProcessStatusType` = 'COMBINED_MEANS_REQUIRED' AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_UNDEFINED_NORMAL')
  AND mps.`fk_id_authentMean` = @authMeanOTPsms
  AND (mps.`meansProcessStatusType` = 'COMBINED_MEANS_REQUIRED' AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_UNDEFINED_NORMAL')
  AND mps.`fk_id_authentMean` = @authentMeansMobileApp
  AND (mps.`meansProcessStatusType` = 'COMBINED_MEANS_REQUIRED' AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_UNDEFINED_NORMAL')
  AND mps.`fk_id_authentMean` = @authMeanOTPchiptan
  AND (mps.`meansProcessStatusType` = 'COMBINED_MEANS_REQUIRED' AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_ALL')
  AND mps.`fk_id_authentMean` = @authMeanUndefined
  AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_ALL')
  AND mps.`fk_id_authentMean` = @authMeanOTPsms
  AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_ALL')
  AND mps.`fk_id_authentMean` = @authMeanOTPsms
  AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_ALL')
  AND mps.`fk_id_authentMean` = @authMeanOTPsms
  AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_ALL')
  AND mps.`fk_id_authentMean` = @authentMeansMobileApp
  AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_ALL')
  AND mps.`fk_id_authentMean` = @authentMeansMobileApp
  AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_ALL')
  AND mps.`fk_id_authentMean` = @authentMeansMobileApp
  AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_ALL')
  AND mps.`fk_id_authentMean` = @authMeanOTPchiptan
  AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_ALL')
  AND mps.`fk_id_authentMean` = @authMeanOTPchiptan
  AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_ALL')
  AND mps.`fk_id_authentMean` = @authMeanOTPchiptan
  AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_ALL')
  AND mps.`fk_id_authentMean` = @authMeanPassword
  AND (mps.`meansProcessStatusType` = 'COMBINED_MEANS_REQUIRED' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_ALL')
  AND mps.`fk_id_authentMean` = @authMeanOTPchiptan
  AND (mps.`meansProcessStatusType` = 'USER_CHOICE_DEMANDED' AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_ALL')
  AND mps.`fk_id_authentMean` = @authMeanOTPsms
  AND (mps.`meansProcessStatusType` = 'USER_CHOICE_DEMANDED' AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_ALL')
  AND mps.`fk_id_authentMean` = @authentMeansMobileApp
  AND (mps.`meansProcessStatusType` = 'USER_CHOICE_DEMANDED' AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_ALL')
  AND mps.`fk_id_authentMean` = @authMeanOTPchiptan
  AND (mps.`meansProcessStatusType` = 'COMBINED_MEANS_REQUIRED' AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_ALL')
  AND mps.`fk_id_authentMean` = @authMeanOTPsms
  AND (mps.`meansProcessStatusType` = 'COMBINED_MEANS_REQUIRED' AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_ALL')
  AND mps.`fk_id_authentMean` = @authentMeansMobileApp
  AND (mps.`meansProcessStatusType` = 'COMBINED_MEANS_REQUIRED' AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_SMS_CHIP')
  AND mps.`fk_id_authentMean` = @authMeanUndefined
  AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_SMS_CHIP')
  AND mps.`fk_id_authentMean` = @authMeanOTPsms
  AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_SMS_CHIP')
  AND mps.`fk_id_authentMean` = @authMeanOTPsms
  AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_SMS_CHIP')
  AND mps.`fk_id_authentMean` = @authMeanOTPsms
  AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_SMS_CHIP')
  AND mps.`fk_id_authentMean` = @authMeanOTPchiptan
  AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_SMS_CHIP')
  AND mps.`fk_id_authentMean` = @authMeanOTPchiptan
  AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_SMS_CHIP')
  AND mps.`fk_id_authentMean` = @authMeanOTPchiptan
  AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_SMS_CHIP')
  AND mps.`fk_id_authentMean` = @authMeanPassword
  AND (mps.`meansProcessStatusType` = 'COMBINED_MEANS_REQUIRED' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_SMS_CHIP')
  AND mps.`fk_id_authentMean` = @authMeanOTPchiptan
  AND (mps.`meansProcessStatusType` = 'USER_CHOICE_DEMANDED' AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_SMS_CHIP')
  AND mps.`fk_id_authentMean` = @authMeanOTPsms
  AND (mps.`meansProcessStatusType` = 'USER_CHOICE_DEMANDED' AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_SMS_CHIP')
  AND mps.`fk_id_authentMean` = @authMeanOTPchiptan
  AND (mps.`meansProcessStatusType` = 'COMBINED_MEANS_REQUIRED' AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_SMS_CHIP')
  AND mps.`fk_id_authentMean` = @authMeanOTPsms
  AND (mps.`meansProcessStatusType` = 'COMBINED_MEANS_REQUIRED' AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_CHIP_APP')
  AND mps.`fk_id_authentMean` = @authMeanUndefined
  AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_CHIP_APP')
  AND mps.`fk_id_authentMean` = @authMeanOTPchiptan
  AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_CHIP_APP')
  AND mps.`fk_id_authentMean` = @authMeanOTPchiptan
  AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_CHIP_APP')
  AND mps.`fk_id_authentMean` = @authMeanOTPchiptan
  AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_CHIP_APP')
  AND mps.`fk_id_authentMean` = @authentMeansMobileApp
  AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_CHIP_APP')
  AND mps.`fk_id_authentMean` = @authentMeansMobileApp
  AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_CHIP_APP')
  AND mps.`fk_id_authentMean` = @authentMeansMobileApp
  AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_CHIP_APP')
  AND mps.`fk_id_authentMean` = @authMeanPassword
  AND (mps.`meansProcessStatusType` = 'COMBINED_MEANS_REQUIRED' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_CHIP_APP')
  AND mps.`fk_id_authentMean` = @authMeanOTPchiptan
  AND (mps.`meansProcessStatusType` = 'USER_CHOICE_DEMANDED' AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_CHIP_APP')
  AND mps.`fk_id_authentMean` = @authentMeansMobileApp
  AND (mps.`meansProcessStatusType` = 'USER_CHOICE_DEMANDED' AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_CHIP_APP')
  AND mps.`fk_id_authentMean` = @authMeanOTPchiptan
  AND (mps.`meansProcessStatusType` = 'COMBINED_MEANS_REQUIRED' AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_CHIP_APP')
  AND mps.`fk_id_authentMean` = @authentMeansMobileApp
  AND (mps.`meansProcessStatusType` = 'COMBINED_MEANS_REQUIRED' AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_SMS_APP')
  AND mps.`fk_id_authentMean` = @authMeanUndefined
  AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_SMS_APP')
  AND mps.`fk_id_authentMean` = @authMeanOTPsms
  AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_SMS_APP')
  AND mps.`fk_id_authentMean` = @authMeanOTPsms
  AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_SMS_APP')
  AND mps.`fk_id_authentMean` = @authMeanOTPsms
  AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_SMS_APP')
  AND mps.`fk_id_authentMean` = @authentMeansMobileApp
  AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_SMS_APP')
  AND mps.`fk_id_authentMean` = @authentMeansMobileApp
  AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_SMS_APP')
  AND mps.`fk_id_authentMean` = @authentMeansMobileApp
  AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_SMS_APP')
  AND mps.`fk_id_authentMean` = @authMeanPassword
  AND (mps.`meansProcessStatusType` = 'COMBINED_MEANS_REQUIRED' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_SMS_APP')
  AND mps.`fk_id_authentMean` = @authMeanOTPsms
  AND (mps.`meansProcessStatusType` = 'USER_CHOICE_DEMANDED' AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_SMS_APP')
  AND mps.`fk_id_authentMean` = @authentMeansMobileApp
  AND (mps.`meansProcessStatusType` = 'USER_CHOICE_DEMANDED' AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_SMS_APP')
  AND mps.`fk_id_authentMean` = @authMeanOTPsms
  AND (mps.`meansProcessStatusType` = 'COMBINED_MEANS_REQUIRED' AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHOICE_SMS_APP')
  AND mps.`fk_id_authentMean` = @authentMeansMobileApp
  AND (mps.`meansProcessStatusType` = 'COMBINED_MEANS_REQUIRED' AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_OTP_SMS_NORMAL')
  AND mps.`fk_id_authentMean` = @authMeanOTPsms
  AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_OTP_SMS_NORMAL')
  AND mps.`fk_id_authentMean` = @authMeanOTPsms
  AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_OTP_SMS_NORMAL')
  AND mps.`fk_id_authentMean` = @authMeanOTPsms
  AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_OTP_SMS_NORMAL')
  AND mps.`fk_id_authentMean` = @authMeanOTPsms
  AND (mps.`meansProcessStatusType` = 'COMBINED_MEANS_REQUIRED' AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_OTP_SMS_NORMAL')
  AND mps.`fk_id_authentMean` = @authMeanPassword
  AND (mps.`meansProcessStatusType` = 'COMBINED_MEANS_REQUIRED' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_OTP_SMS_NORMAL')
  AND mps.`fk_id_authentMean` = @authMeanOTPsms
  AND (mps.`meansProcessStatusType` = 'USER_CHOICE_DEMANDED' AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_OTP_SMS_NORMAL')
  AND mps.`fk_id_authentMean` = @authMeanUndefined
  AND (mps.`meansProcessStatusType` = 'USER_CHOICE_DEMANDED' AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_OTP_SMS_NORMAL')
  AND mps.`fk_id_authentMean` = @authentMeansMobileApp
  AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_OTP_SMS_NORMAL')
  AND mps.`fk_id_authentMean` = @authMeanOTPchiptan
  AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHIP_TAN_NORMAL')
  AND mps.`fk_id_authentMean` = @authMeanOTPchiptan
  AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHIP_TAN_NORMAL')
  AND mps.`fk_id_authentMean` = @authMeanOTPchiptan
  AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHIP_TAN_NORMAL')
  AND mps.`fk_id_authentMean` = @authMeanOTPchiptan
  AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHIP_TAN_NORMAL')
  AND mps.`fk_id_authentMean` = @authMeanOTPchiptan
  AND (mps.`meansProcessStatusType` = 'COMBINED_MEANS_REQUIRED' AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHIP_TAN_NORMAL')
  AND mps.`fk_id_authentMean` = @authMeanPassword
  AND (mps.`meansProcessStatusType` = 'COMBINED_MEANS_REQUIRED' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHIP_TAN_NORMAL')
  AND mps.`fk_id_authentMean` = @authMeanOTPchiptan
  AND (mps.`meansProcessStatusType` = 'USER_CHOICE_DEMANDED' AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHIP_TAN_NORMAL')
  AND mps.`fk_id_authentMean` = @authMeanUndefined
  AND (mps.`meansProcessStatusType` = 'USER_CHOICE_DEMANDED' AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHIP_TAN_NORMAL')
  AND mps.`fk_id_authentMean` = @authentMeansMobileApp
  AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_CHIP_TAN_NORMAL')
  AND mps.`fk_id_authentMean` = @authMeanOTPsms
  AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_OTP_APP_NORMAL')
  AND mps.`fk_id_authentMean` = @authentMeansMobileApp
  AND (mps.`meansProcessStatusType` IN ('MEANS_DISABLED') AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_OTP_APP_NORMAL')
  AND mps.`fk_id_authentMean` = @authentMeansMobileApp
  AND (mps.`meansProcessStatusType` = 'MEANS_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_OTP_APP_NORMAL')
  AND mps.`fk_id_authentMean` = @authentMeansMobileApp
  AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_OTP_APP_NORMAL')
  AND mps.`fk_id_authentMean` = @authentMeansMobileApp
  AND (mps.`meansProcessStatusType` = 'COMBINED_MEANS_REQUIRED' AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_OTP_APP_NORMAL')
  AND mps.`fk_id_authentMean` = @authMeanPassword
  AND (mps.`meansProcessStatusType` = 'COMBINED_MEANS_REQUIRED' AND mps.`reversed` = FALSE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_OTP_APP_NORMAL')
  AND mps.`fk_id_authentMean` = @authentMeansMobileApp
  AND (mps.`meansProcessStatusType` = 'USER_CHOICE_DEMANDED' AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_OTP_APP_NORMAL')
  AND mps.`fk_id_authentMean` = @authMeanUndefined
  AND (mps.`meansProcessStatusType` = 'USER_CHOICE_DEMANDED' AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_OTP_APP_NORMAL')
  AND mps.`fk_id_authentMean` = @authMeanOTPsms
  AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed` = TRUE);

INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`)
SELECT c.id, mps.id FROM `RuleCondition` c, `MeansProcessStatuses` mps
WHERE c.`name` = CONCAT('C1_P_', @sharedIssuerName, '_01_OTP_APP_NORMAL')
  AND mps.`fk_id_authentMean` = @authMeanOTPchiptan
  AND (mps.`meansProcessStatusType` = 'HUB_AUTHENTICATION_MEAN_AVAILABLE' AND mps.`reversed` = TRUE);


INSERT INTO `TransactionValue` (`reversed`, `transactionValueType`, `value`, `fk_id_condition`) VALUES 
(b'1', 'DEVICE_CHANNEL', '01', @ruleChipTanChoiceCondtn1),
(b'1', 'DEVICE_CHANNEL', '01', @ruleChipTanChoiceCondtn2),
(b'1', 'DEVICE_CHANNEL', '01', @ruleCHOICE_ALLCondtn),
(b'1', 'DEVICE_CHANNEL', '01', @ruleSMS_CHIPCondtn),
(b'1', 'DEVICE_CHANNEL', '01', @ruleCHIP_APPCondtn),
(b'1', 'DEVICE_CHANNEL', '01', @ruleChipTannormalCondtn);

/* ProfileSet_Rule */

INSERT INTO `ProfileSet_Rule` (`id_profileSet`, `id_rule`)
SELECT ps.`id`, r.`id` FROM `ProfileSet` ps, `Rule` r
WHERE ps.`name` = CONCAT('PS_', @sharedIssuerName, '_01')AND r.`id` IN (@ruleRefusalTE, @ruleRefusalFE, @ruleRBADecline, @ruleRBAAccept, @ruleSMSChoice, @ruleChipTanChoice, @ruleMobileAppChoice, @rulePasswordnormal, @ruleUndefinednormal,
                                                                        @ruleSMSnormal, @ruleMobileAppnormal, @ruleChipTannormal, @ruleSMS_APP, @ruleCHIP_APP, @ruleSMS_CHIP, @ruleCHOICE_ALL, @ruleRefusalDefault);
-- Bin ranges
SET @cryptoConfidId = (SELECT id FROM CryptoConfig WHERE description = 'Sparda CryptoConfig');

INSERT INTO `BinRange` (`activateState`, `createdBy`, `creationDate`, `updateState`, `immediateActivation`, `activationDate`, `lowerBound`, `panLength`, `sharedBinRange`, `updateDSDate`, `upperBound`, `fk_id_network`, `fk_id_profileSet`, `toExport`, `coBrandedCardNetwork`, `fk_id_cryptoConfig`, `serviceCode`)
VALUES
('ACTIVATED', 'A169318', NOW(), 'PUSHED_TO_CONFIG', false, NULL, '4908040000', 16, true, NULL, '4908049999', @idNetworkVISA, @idProfileSet, false, NULL, @cryptoConfidId, NULL),
('ACTIVATED', 'A169318', NOW(), 'PUSHED_TO_CONFIG', false, NULL, '5232790000', 16, true, NULL, '5232799999', @idNetworkMC, @idProfileSet, false, NULL, @cryptoConfidId, NULL),
('ACTIVATED', 'A169318', NOW(), 'PUSHED_TO_CONFIG', false, NULL, '5247210000', 16, true, NULL, '5247219999', @idNetworkMC, @idProfileSet, false, NULL, @cryptoConfidId, NULL),
('ACTIVATED', 'A169318', NOW(), 'PUSHED_TO_CONFIG', false, NULL, '5256150000', 16, true, NULL, '5256159999', @idNetworkMC, @idProfileSet, false, NULL, @cryptoConfidId, NULL);

INSERT INTO BinRange_SubIssuer (id_binRange, id_subIssuer)
SELECT br.id, @subIssuerID FROM BinRange br WHERE lowerBound in ('4908040000', '5232790000', '5247210000', '5256150000');


/* MerchantPivotList */

INSERT INTO `MerchantPivotList` (`level`, `keyword`, `type`, `amount`, `display`, forceAuthent, expertMode, `fk_id_issuer`, `fk_id_subIssuer`)
VALUES ('ISSUER', 'TestMerchant', 'NAME', 0, 0, 0, 0, @issuerId, @subIssuerID);

/*!40101 SET SQL_MODE = IFNULL(@OLD_SQL_MODE, '') */;
/*!40101 SET CHARACTER_SET_CLIENT = @OLD_CHARACTER_SET_CLIENT */;
