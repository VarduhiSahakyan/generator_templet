USE `U5G_ACS_FO`;

DELETE FROM `PROFILE_SET` WHERE `ID` in (45);

DELETE FROM `ISSUER_CONFIG` WHERE `ISSUER_NAME` in ('PAYBOX');

DELETE FROM `CRYPTO_CONFIG` WHERE `ID` = 14;

DELETE FROM `BIN_RANGE` WHERE `PROFILE_SET_ID` in (45);