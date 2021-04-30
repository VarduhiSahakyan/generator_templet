
USE `U5G_ACS_BO`;

SET @issuerCodes1 = '16950';
SET @issuerCodes2 = '12069';
SET @issuerCodes3 = '13606';
SET @issuerCodes4 = '15009';
SET @issuerCodes5 = '16009';
SET @issuerCodes6 = '17009';
SET @issuerCodes7 = '17209';
SET @issuerCodes8 = '17509';
SET @issuerCodes9 = '17609';

 UPDATE `SubIssuer` set `paChallengePublicUrl` = 'https://3dsecure.sparda.de/' Where `code` in ( @issuerCodes1,@issuerCodes2,@issuerCodes3,@issuerCodes4,
@issuerCodes5,@issuerCodes6,@issuerCodes7,@issuerCodes8,@issuerCodes9);