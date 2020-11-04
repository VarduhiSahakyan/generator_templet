
USE `U5G_ACS_FO`;

/* CBC */
SET @subIssuerID = (SELECT `SUB_ISSUER_CODE` From `ISSUER_CONFIG` WHERE `SUB_ISSUER_CODE` = 00070);

UPDATE `ISSUER_CONFIG`
SET `PA_CHALLENGE_PUBLIC_URL` = '{ "Vendome" : "https://cbc-vdm.wlp-acs.com/", "Brussels" : "https://cbc-bxl.wlp-acs.com/", "Unknown" : "https://cbc.wlp-acs.com/" }'
WHERE `SUB_ISSUER_CODE` = @subIssuerID;

/* OP */
SET @subIssuerID = (SELECT `SUB_ISSUER_CODE` From `ISSUER_CONFIG` WHERE `SUB_ISSUER_CODE` = 20000);

UPDATE `ISSUER_CONFIG`
SET `PA_CHALLENGE_PUBLIC_URL` = '{ "Vendome" : "https://op-vdm.wlp-acs.com/", "Brussels" : "https://op-bxl.wlp-acs.com/", "Unknown" : "https://op.wlp-acs.com/" }'
WHERE `SUB_ISSUER_CODE` = @subIssuerID;


/* Paybox */
SET @subIssuerID = (SELECT `SUB_ISSUER_CODE` From `ISSUER_CONFIG` WHERE `SUB_ISSUER_CODE` = 18951);

UPDATE `ISSUER_CONFIG`
SET `PA_CHALLENGE_PUBLIC_URL` = '{ "Vendome" : "https://german-3ds-vdm.wlp-acs.com/", "Brussels" : "https://german-3ds-bxl.wlp-acs.com/", "Unknown" : "https://german-3ds.wlp-acs.com/" }'
WHERE `SUB_ISSUER_CODE` = @subIssuerID;

/* Bankard NULL in PROD */
SET @subIssuerID = (SELECT `SUB_ISSUER_CODE` From `ISSUER_CONFIG` WHERE `SUB_ISSUER_CODE` = 00006);

UPDATE `ISSUER_CONFIG`
SET `PA_CHALLENGE_PUBLIC_URL` = '{ "Vendome" : "https://german-3ds-vdm.wlp-acs.com/", "Brussels" : "https://german-3ds-bxl.wlp-acs.com/", "Unknown" : "https://german-3ds.wlp-acs.com/" }'
WHERE `SUB_ISSUER_CODE` = @subIssuerID;


/* RCBC */
SET @subIssuerID = (SELECT `SUB_ISSUER_CODE` From `ISSUER_CONFIG` WHERE `SUB_ISSUER_CODE` = 00018);

UPDATE `ISSUER_CONFIG`
SET `PA_CHALLENGE_PUBLIC_URL` = '{ "Vendome" : https://german-3ds-vdm.wlp-acs.com/", "Brussels" : "https://german-3ds-bxl.wlp-acs.com/", "Unknown" : "https://german-3ds.wlp-acs.com/" }'
WHERE `SUB_ISSUER_CODE` = @subIssuerID;

/* East West Bank */
SET @subIssuerID = (SELECT `SUB_ISSUER_CODE` From `ISSUER_CONFIG` WHERE `SUB_ISSUER_CODE` = 00062);

UPDATE `ISSUER_CONFIG`
SET `PA_CHALLENGE_PUBLIC_URL` = '{ "Vendome" : "https://german-3ds-vdm.wlp-acs.com/", "Brussels" : "https://german-3ds-bxl.wlp-acs.com/", "Unknown" : "https://german-3ds.wlp-acs.com/" }'
WHERE `SUB_ISSUER_CODE` = @subIssuerID;

/* Wallester */
/* SET @subIssuerID = (SELECT `SUB_ISSUER_CODE` From `ISSUER_CONFIG` WHERE `SUB_ISSUER_CODE` = 80101);

UPDATE `ISSUER_CONFIG`
SET `PA_CHALLENGE_PUBLIC_URL` = '{ "Vendome" : "https://german-3ds-vdm.wlp-acs.com/", "Brussels" : "https://german-3ds-bxl.wlp-acs.com/", "Unknown" : "https://german-3ds.wlp-acs.com/" }'
WHERE `SUB_ISSUER_CODE` = @subIssuerID;*/

/* Commerzbank Cobrands */
SET @subIssuerID = (SELECT `SUB_ISSUER_CODE` From `ISSUER_CONFIG` WHERE `SUB_ISSUER_CODE` = 19450);

UPDATE `ISSUER_CONFIG`
SET `PA_CHALLENGE_PUBLIC_URL` = '{ "Vendome" : "https://geschuetztkaufen1.commerzbank.de/", "Brussels" : "https://geschuetztkaufen2.commerzbank.de/", "Unknown" : "https://geschuetztkaufen.commerzbank.de/" }'
WHERE `SUB_ISSUER_CODE` = @subIssuerID;


/* Comdirect */
SET @subIssuerID = (SELECT `SUB_ISSUER_CODE` From `ISSUER_CONFIG` WHERE `SUB_ISSUER_CODE` = 16600);

UPDATE `ISSUER_CONFIG`
SET `PA_CHALLENGE_PUBLIC_URL` = '{ "Vendome" : "https://visasecure1.comdirect.de/", "Brussels" : "https://visasecure2.comdirect.de/", "Unknown" : "https://verifiedbyvisa2.comdirect.de/" }'
WHERE `SUB_ISSUER_CODE` = @subIssuerID;

/* ING */
SET @subIssuerID = (SELECT `SUB_ISSUER_CODE` From `ISSUER_CONFIG` WHERE `SUB_ISSUER_CODE` = 16500);

UPDATE `ISSUER_CONFIG`
SET `PA_CHALLENGE_PUBLIC_URL` = '{ "Vendome" : "https://visa-secure-vdm.ing.de/", "Brussels" : "https://visa-secure-bxl.ing.de/", "Unknown" : "https://visa-secure.ing.de/" }'
WHERE `SUB_ISSUER_CODE` = @subIssuerID;

/* Commerzbank AG */
SET @subIssuerID = (SELECT `SUB_ISSUER_CODE` From `ISSUER_CONFIG` WHERE `SUB_ISSUER_CODE` = 19440);

UPDATE `ISSUER_CONFIG`
SET `PA_CHALLENGE_PUBLIC_URL` = '{ "Vendome" : "https://geschuetztkaufen1.commerzbank.de/", "Brussels" : "https://geschuetztkaufen2.commerzbank.de/", "Unknown" : "https://geschuetztkaufen.commerzbank.de/" }'
WHERE `SUB_ISSUER_CODE` = @subIssuerID;

/* Landesbank Berlin NULL in Prod */
SET @subIssuerID = (SELECT `SUB_ISSUER_CODE` From `ISSUER_CONFIG` WHERE `SUB_ISSUER_CODE` = 19600);

UPDATE `ISSUER_CONFIG`
SET `PA_CHALLENGE_PUBLIC_URL` = '{ "Vendome" : "https://german-3ds-vdm.wlp-acs.com/", "Brussels" : "https://german-3ds-bxl.wlp-acs.com/", "Unknown" : "https://german-3ds.wlp-acs.com/" }'
WHERE `SUB_ISSUER_CODE` = @subIssuerID;

/* Volkswagen Bank */
SET @subIssuerID = (SELECT `SUB_ISSUER_CODE` From `ISSUER_CONFIG` WHERE `SUB_ISSUER_CODE` = 19151);

UPDATE `ISSUER_CONFIG`
SET `PA_CHALLENGE_PUBLIC_URL` = '{ "Vendome" : "https://german-3ds-vdm.wlp-acs.com/", "Brussels" : "https://german-3ds-bxl.wlp-acs.com/", "Unknown" : "https://german-3ds.wlp-acs.com/" }'
WHERE `SUB_ISSUER_CODE` = @subIssuerID;


/* Audi Bank */
SET @subIssuerID = (SELECT `SUB_ISSUER_CODE` From `ISSUER_CONFIG` WHERE `SUB_ISSUER_CODE` = 19152);

UPDATE `ISSUER_CONFIG`
SET `PA_CHALLENGE_PUBLIC_URL` = '{ "Vendome" : "https://german-3ds-vdm.wlp-acs.com/", "Brussels" : "https://german-3ds-bxl.wlp-acs.com/", "Unknown" : "https://german-3ds.wlp-acs.com/" }'
WHERE `SUB_ISSUER_CODE` = @subIssuerID;

/* LBBW */
SET @subIssuerID = (SELECT `SUB_ISSUER_CODE` From `ISSUER_CONFIG` WHERE `SUB_ISSUER_CODE` = 19550);

UPDATE `ISSUER_CONFIG`
SET `PA_CHALLENGE_PUBLIC_URL` = '{ "Vendome" : "https://german-3ds-vdm.wlp-acs.com/", "Brussels" : "https://german-3ds-bxl.wlp-acs.com/", "Unknown" : "https://german-3ds.wlp-acs.com/" }'
WHERE `SUB_ISSUER_CODE` = @subIssuerID;

/* Consorsbank */
SET @subIssuerID = (SELECT `SUB_ISSUER_CODE` From `ISSUER_CONFIG` WHERE `SUB_ISSUER_CODE` = 16900);

UPDATE `ISSUER_CONFIG`
SET `PA_CHALLENGE_PUBLIC_URL` = '{ "Vendome" : "https://visasecure1.consorsbank.de/", "Brussels" : "https://visasecure2.consorsbank.de/", "Unknown" : "https://visasecure.consorsbank.de/" }'
WHERE `SUB_ISSUER_CODE` = @subIssuerID;

/* Reisebank */
SET @subIssuerID = (SELECT `SUB_ISSUER_CODE` From `ISSUER_CONFIG` WHERE `SUB_ISSUER_CODE` = 12000);

UPDATE `ISSUER_CONFIG`
SET `PA_CHALLENGE_PUBLIC_URL` = '{ "Vendome" : "https://securepayment1.reisebank.de/", "Brussels" : "https://securepayment2.reisebank.de/", "Unknown" : "https://securepayment.reisebank.de/" }'
WHERE `SUB_ISSUER_CODE` = @subIssuerID;

/* Postbank EBK */
SET @subIssuerID = (SELECT `SUB_ISSUER_CODE` From `ISSUER_CONFIG` WHERE `SUB_ISSUER_CODE` = 18501);

UPDATE `ISSUER_CONFIG`
SET `PA_CHALLENGE_PUBLIC_URL` = '{ "Vendome" : "https://postbank-3ds-vdm.wlp-acs.com/", "Brussels" : "https://postbank-3ds-bxl.wlp-acs.com/", "Unknown" : "https://postbank-3ds.wlp-acs.com/" }'
WHERE `SUB_ISSUER_CODE` = @subIssuerID;

/* Postbank */
SET @subIssuerID = (SELECT `SUB_ISSUER_CODE` From `ISSUER_CONFIG` WHERE `SUB_ISSUER_CODE` = 18500);

UPDATE `ISSUER_CONFIG`
SET `PA_CHALLENGE_PUBLIC_URL` = '{ "Vendome" : "https://postbank-3ds-vdm.wlp-acs.com/", "Brussels" : "https://postbank-3ds-bxl.wlp-acs.com/", "Unknown" : "https://postbank-3ds.wlp-acs.com/" }'
WHERE `SUB_ISSUER_CODE` = @subIssuerID;

/* Postbank FBK */
SET @subIssuerID = (SELECT `SUB_ISSUER_CODE` From `ISSUER_CONFIG` WHERE `SUB_ISSUER_CODE` = 18502);

UPDATE `ISSUER_CONFIG`
SET `PA_CHALLENGE_PUBLIC_URL` = '{ "Vendome" : "https://postbank-3ds-vdm.wlp-acs.com/", "Brussels" : "https://postbank-3ds-bxl.wlp-acs.com/", "Unknown" : "https://postbank-3ds.wlp-acs.com/" }'
WHERE `SUB_ISSUER_CODE` = @subIssuerID;

/* BNP Paribas Wealth Management */
SET @subIssuerID = (SELECT `SUB_ISSUER_CODE` From `ISSUER_CONFIG` WHERE `SUB_ISSUER_CODE` = 16901);

UPDATE `ISSUER_CONFIG`
SET `PA_CHALLENGE_PUBLIC_URL` = '{ "Vendome" : "https://visasecure1.consorsbank.de/", "Brussels" : "https://visasecure2.consorsbank.de/", "Unknown" : "https://visasecure.consorsbank.de/" }'
WHERE `SUB_ISSUER_CODE` = @subIssuerID;

/* Sparda SharedBin */
SET @subIssuerID = (SELECT `SUB_ISSUER_CODE` From `ISSUER_CONFIG` WHERE `SUB_ISSUER_CODE` = 16950);

UPDATE `ISSUER_CONFIG`
SET `PA_CHALLENGE_PUBLIC_URL` = '{ "Vendome" : "https://german-3ds-vdm.wlp-acs.com/", "Brussels" : "https://german-3ds-bxl.wlp-acs.com/", "Unknown" : "https://german-3ds.wlp-acs.com/" }'
WHERE `SUB_ISSUER_CODE` = @subIssuerID;

/* SBK_West */
SET @subIssuerID = (SELECT `SUB_ISSUER_CODE` From `ISSUER_CONFIG` WHERE `SUB_ISSUER_CODE` = 13606);

UPDATE `ISSUER_CONFIG`
SET `PA_CHALLENGE_PUBLIC_URL` = '{ "Vendome" : "https://german-3ds-vdm.wlp-acs.com/", "Brussels" : "https://german-3ds-bxl.wlp-acs.com/", "Unknown" : "https://german-3ds.wlp-acs.com/" }'
WHERE `SUB_ISSUER_CODE` = @subIssuerID;

/* SBK_Ostbayern */
SET @subIssuerID = (SELECT `SUB_ISSUER_CODE` From `ISSUER_CONFIG` WHERE `SUB_ISSUER_CODE` = 17509);

UPDATE `ISSUER_CONFIG`
SET `PA_CHALLENGE_PUBLIC_URL` = '{ "Vendome" : "https://german-3ds-vdm.wlp-acs.com/", "Brussels" : "https://german-3ds-bxl.wlp-acs.com/", "Unknown" : "https://german-3ds.wlp-acs.com/" }'
WHERE `SUB_ISSUER_CODE` = @subIssuerID;

/* SBK_Nürnberg */
SET @subIssuerID = (SELECT `SUB_ISSUER_CODE` From `ISSUER_CONFIG` WHERE `SUB_ISSUER_CODE` = 17609);

UPDATE `ISSUER_CONFIG`
SET `PA_CHALLENGE_PUBLIC_URL` = '{ "Vendome" : "https://german-3ds-vdm.wlp-acs.com/", "Brussels" : "https://german-3ds-bxl.wlp-acs.com/", "Unknown" : "https://german-3ds.wlp-acs.com/" }'
WHERE `SUB_ISSUER_CODE` = @subIssuerID;

/* SBK_Munchen */
SET @subIssuerID = (SELECT `SUB_ISSUER_CODE` From `ISSUER_CONFIG` WHERE `SUB_ISSUER_CODE` = 17009);

UPDATE `ISSUER_CONFIG`
SET `PA_CHALLENGE_PUBLIC_URL` = '{ "Vendome" : "https://german-3ds-vdm.wlp-acs.com/", "Brussels" : "https://german-3ds-bxl.wlp-acs.com/", "Unknown" : "https://german-3ds.wlp-acs.com/" }'
WHERE `SUB_ISSUER_CODE` = @subIssuerID;

/* SBK_Hessen */
SET @subIssuerID = (SELECT `SUB_ISSUER_CODE` From `ISSUER_CONFIG` WHERE `SUB_ISSUER_CODE` = 15009);

UPDATE `ISSUER_CONFIG`
SET `PA_CHALLENGE_PUBLIC_URL` = '{ "Vendome" : "https://german-3ds-vdm.wlp-acs.com/", "Brussels" : "https://german-3ds-bxl.wlp-acs.com/", "Unknown" : "https://german-3ds.wlp-acs.com/" }'
WHERE `SUB_ISSUER_CODE` = @subIssuerID;

/* SBK_Hamburg */
SET @subIssuerID = (SELECT `SUB_ISSUER_CODE` From `ISSUER_CONFIG` WHERE `SUB_ISSUER_CODE` = 12069);

UPDATE `ISSUER_CONFIG`
SET `PA_CHALLENGE_PUBLIC_URL` = '{ "Vendome" : "https://german-3ds-vdm.wlp-acs.com/", "Brussels" : "https://german-3ds-bxl.wlp-acs.com/", "Unknown" : "https://german-3ds.wlp-acs.com/" }'
WHERE `SUB_ISSUER_CODE` = @subIssuerID;

/* SBK_BW */
SET @subIssuerID = (SELECT `SUB_ISSUER_CODE` From `ISSUER_CONFIG` WHERE `SUB_ISSUER_CODE` = 16009);

UPDATE `ISSUER_CONFIG`
SET `PA_CHALLENGE_PUBLIC_URL` = '{ "Vendome" : "https://german-3ds-vdm.wlp-acs.com/", "Brussels" : "https://german-3ds-bxl.wlp-acs.com/", "Unknown" : "https://german-3ds.wlp-acs.com/" }'
WHERE `SUB_ISSUER_CODE` = @subIssuerID;

/* SBK_Augsburg */
SET @subIssuerID = (SELECT `SUB_ISSUER_CODE` From `ISSUER_CONFIG` WHERE `SUB_ISSUER_CODE` = 17209);

UPDATE `ISSUER_CONFIG`
SET `PA_CHALLENGE_PUBLIC_URL` = '{ "Vendome" : "https://german-3ds-vdm.wlp-acs.com/", "Brussels" : "https://german-3ds-bxl.wlp-acs.com/", "Unknown" : "https://german-3ds.wlp-acs.com/" }'
WHERE `SUB_ISSUER_CODE` = @subIssuerID;