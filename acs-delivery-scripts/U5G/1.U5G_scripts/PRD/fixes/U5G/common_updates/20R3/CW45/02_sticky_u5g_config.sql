USE `U5G_ACS_BO`;

/* CBC */
SET @subIssuerID = (SELECT `id` From `SubIssuer` WHERE `code` = 00070);

UPDATE `SubIssuer`
SET `paChallengePublicUrl` = '{ "Vendome" : "https://cbc-vdm.wlp-acs.com/", "Brussels" : "https://cbc-bxl.wlp-acs.com/", "Unknown" : "https://cbc.wlp-acs.com/" }'
WHERE `id` = @subIssuerID;

/* OP */
SET @subIssuerID = (SELECT `id` From `SubIssuer` WHERE `code` = 20000);

UPDATE `SubIssuer`
SET `paChallengePublicUrl` = '{ "Vendome" : "https://op-vdm.wlp-acs.com/", "Brussels" : "https://op-bxl.wlp-acs.com/", "Unknown" : "https://op.wlp-acs.com/" }'
WHERE `id` = @subIssuerID;


/* Paybox */
SET @subIssuerID = (SELECT `id` From `SubIssuer` WHERE `code` = 18951);

UPDATE `SubIssuer`
SET `paChallengePublicUrl` = '{ "Vendome" : "https://german-3ds-vdm.wlp-acs.com/", "Brussels" : "https://german-3ds-bxl.wlp-acs.com/", "Unknown" : "https://german-3ds.wlp-acs.com/" }'
WHERE `id` = @subIssuerID;

/* Bankard NULL in PROD */
SET @subIssuerID = (SELECT `id` From `SubIssuer` WHERE `code` = 00006);

UPDATE `SubIssuer`
SET `paChallengePublicUrl` = '{ "Vendome" : "https://german-3ds-vdm.wlp-acs.com/", "Brussels" : "https://german-3ds-bxl.wlp-acs.com/", "Unknown" : "https://german-3ds.wlp-acs.com/" }'
WHERE `id` = @subIssuerID;


/* RCBC */
SET @subIssuerID = (SELECT `id` From `SubIssuer` WHERE `code` = 00018);

UPDATE `SubIssuer`
SET `paChallengePublicUrl` = '{ "Vendome" : https://german-3ds-vdm.wlp-acs.com/", "Brussels" : "https://german-3ds-bxl.wlp-acs.com/", "Unknown" : "https://german-3ds.wlp-acs.com/" }'
WHERE `id` = @subIssuerID;

/* East West Bank */
SET @subIssuerID = (SELECT `id` From `SubIssuer` WHERE `code` = 00062);

UPDATE `SubIssuer`
SET `paChallengePublicUrl` = '{ "Vendome" : "https://german-3ds-vdm.wlp-acs.com/", "Brussels" : "https://german-3ds-bxl.wlp-acs.com/", "Unknown" : "https://german-3ds.wlp-acs.com/" }'
WHERE `id` = @subIssuerID;

/* Wallester */
/* SET @subIssuerID = (SELECT `id` From `SubIssuer` WHERE `code` = 80101);

UPDATE `SubIssuer`
SET `paChallengePublicUrl` = '{ "Vendome" : "https://german-3ds-vdm.wlp-acs.com/", "Brussels" : "https://german-3ds-bxl.wlp-acs.com/", "Unknown" : "https://german-3ds.wlp-acs.com/" }'
WHERE `id` = @subIssuerID;*/

/* Commerzbank Cobrands */
SET @subIssuerID = (SELECT `id` From `SubIssuer` WHERE `code` = 19450);

UPDATE `SubIssuer`
SET `paChallengePublicUrl` = '{ "Vendome" : "https://geschuetztkaufen1.commerzbank.de/", "Brussels" : "https://geschuetztkaufen2.commerzbank.de/", "Unknown" : "https://geschuetztkaufen.commerzbank.de/" }'
WHERE `id` = @subIssuerID;


/* Comdirect */
SET @subIssuerID = (SELECT `id` From `SubIssuer` WHERE `code` = 16600);

UPDATE `SubIssuer`
SET `paChallengePublicUrl` = '{ "Vendome" : "https://visasecure1.comdirect.de/", "Brussels" : "https://visasecure2.comdirect.de/", "Unknown" : "https://verifiedbyvisa2.comdirect.de/" }'
WHERE `id` = @subIssuerID;

/* ING */
SET @subIssuerID = (SELECT `id` From `SubIssuer` WHERE `code` = 16500);

UPDATE `SubIssuer`
SET `paChallengePublicUrl` = '{ "Vendome" : "https://visa-secure-vdm.ing.de/", "Brussels" : "https://visa-secure-bxl.ing.de/", "Unknown" : "https://visa-secure.ing.de/" }'
WHERE `id` = @subIssuerID;

/* Commerzbank AG */
SET @subIssuerID = (SELECT `id` From `SubIssuer` WHERE `code` = 19440);

UPDATE `SubIssuer`
SET `paChallengePublicUrl` = '{ "Vendome" : "https://geschuetztkaufen1.commerzbank.de/", "Brussels" : "https://geschuetztkaufen2.commerzbank.de/", "Unknown" : "https://geschuetztkaufen.commerzbank.de/" }'
WHERE `id` = @subIssuerID;

/* Landesbank Berlin NULL in Prod */
SET @subIssuerID = (SELECT `id` From `SubIssuer` WHERE `code` = 19600);

UPDATE `SubIssuer`
SET `paChallengePublicUrl` = '{ "Vendome" : "https://german-3ds-vdm.wlp-acs.com/", "Brussels" : "https://german-3ds-bxl.wlp-acs.com/", "Unknown" : "https://german-3ds.wlp-acs.com/" }'
WHERE `id` = @subIssuerID;

/* Volkswagen Bank */
SET @subIssuerID = (SELECT `id` From `SubIssuer` WHERE `code` = 19151);

UPDATE `SubIssuer`
SET `paChallengePublicUrl` = '{ "Vendome" : "https://german-3ds-vdm.wlp-acs.com/", "Brussels" : "https://german-3ds-bxl.wlp-acs.com/", "Unknown" : "https://german-3ds.wlp-acs.com/" }'
WHERE `id` = @subIssuerID;


/* Audi Bank */
SET @subIssuerID = (SELECT `id` From `SubIssuer` WHERE `code` = 19152);

UPDATE `SubIssuer`
SET `paChallengePublicUrl` = '{ "Vendome" : "https://german-3ds-vdm.wlp-acs.com/", "Brussels" : "https://german-3ds-bxl.wlp-acs.com/", "Unknown" : "https://german-3ds.wlp-acs.com/" }'
WHERE `id` = @subIssuerID;

/* LBBW */
SET @subIssuerID = (SELECT `id` From `SubIssuer` WHERE `code` = 19550);

UPDATE `SubIssuer`
SET `paChallengePublicUrl` = '{ "Vendome" : "https://german-3ds-vdm.wlp-acs.com/", "Brussels" : "https://german-3ds-bxl.wlp-acs.com/", "Unknown" : "https://german-3ds.wlp-acs.com/" }'
WHERE `id` = @subIssuerID;

/* Consorsbank */
SET @subIssuerID = (SELECT `id` From `SubIssuer` WHERE `code` = 16900);

UPDATE `SubIssuer`
SET `paChallengePublicUrl` = '{ "Vendome" : "https://visasecure1.consorsbank.de/", "Brussels" : "https://visasecure2.consorsbank.de/", "Unknown" : "https://visasecure.consorsbank.de/" }'
WHERE `id` = @subIssuerID;

/* Reisebank */
SET @subIssuerID = (SELECT `id` From `SubIssuer` WHERE `code` = 12000);

UPDATE `SubIssuer`
SET `paChallengePublicUrl` = '{ "Vendome" : "https://securepayment1.reisebank.de/", "Brussels" : "https://securepayment2.reisebank.de/", "Unknown" : "https://securepayment.reisebank.de/" }'
WHERE `id` = @subIssuerID;

/* Postbank EBK */
SET @subIssuerID = (SELECT `id` From `SubIssuer` WHERE `code` = 18501);

UPDATE `SubIssuer`
SET `paChallengePublicUrl` = '{ "Vendome" : "https://postbank-3ds-vdm.wlp-acs.com/", "Brussels" : "https://postbank-3ds-bxl.wlp-acs.com/", "Unknown" : "https://postbank-3ds.wlp-acs.com/" }'
WHERE `id` = @subIssuerID;

/* Postbank */
SET @subIssuerID = (SELECT `id` From `SubIssuer` WHERE `code` = 18500);

UPDATE `SubIssuer`
SET `paChallengePublicUrl` = '{ "Vendome" : "https://postbank-3ds-vdm.wlp-acs.com/", "Brussels" : "https://postbank-3ds-bxl.wlp-acs.com/", "Unknown" : "https://postbank-3ds.wlp-acs.com/" }'
WHERE `id` = @subIssuerID;

/* Postbank FBK */
SET @subIssuerID = (SELECT `id` From `SubIssuer` WHERE `code` = 18502);

UPDATE `SubIssuer`
SET `paChallengePublicUrl` = '{ "Vendome" : "https://postbank-3ds-vdm.wlp-acs.com/", "Brussels" : "https://postbank-3ds-bxl.wlp-acs.com/", "Unknown" : "https://postbank-3ds.wlp-acs.com/" }'
WHERE `id` = @subIssuerID;

/* BNP Paribas Wealth Management */
SET @subIssuerID = (SELECT `id` From `SubIssuer` WHERE `code` = 16901);

UPDATE `SubIssuer`
SET `paChallengePublicUrl` = '{ "Vendome" : "https://visasecure1.consorsbank.de/", "Brussels" : "https://visasecure2.consorsbank.de/", "Unknown" : "https://visasecure.consorsbank.de/" }'
WHERE `id` = @subIssuerID;

/* Sparda SharedBin */
SET @subIssuerID = (SELECT `id` From `SubIssuer` WHERE `code` = 16950);

UPDATE `SubIssuer`
SET `paChallengePublicUrl` = '{ "Vendome" : "https://german-3ds-vdm.wlp-acs.com/", "Brussels" : "https://german-3ds-bxl.wlp-acs.com/", "Unknown" : "https://german-3ds.wlp-acs.com/" }'
WHERE `id` = @subIssuerID;

/* SBK_West */
SET @subIssuerID = (SELECT `id` From `SubIssuer` WHERE `code` = 13606);

UPDATE `SubIssuer`
SET `paChallengePublicUrl` = '{ "Vendome" : "https://german-3ds-vdm.wlp-acs.com/", "Brussels" : "https://german-3ds-bxl.wlp-acs.com/", "Unknown" : "https://german-3ds.wlp-acs.com/" }'
WHERE `id` = @subIssuerID;

/* SBK_Ostbayern */
SET @subIssuerID = (SELECT `id` From `SubIssuer` WHERE `code` = 17509);

UPDATE `SubIssuer`
SET `paChallengePublicUrl` = '{ "Vendome" : "https://german-3ds-vdm.wlp-acs.com/", "Brussels" : "https://german-3ds-bxl.wlp-acs.com/", "Unknown" : "https://german-3ds.wlp-acs.com/" }'
WHERE `id` = @subIssuerID;

/* SBK_Nürnberg */
SET @subIssuerID = (SELECT `id` From `SubIssuer` WHERE `code` = 17609);

UPDATE `SubIssuer`
SET `paChallengePublicUrl` = '{ "Vendome" : "https://german-3ds-vdm.wlp-acs.com/", "Brussels" : "https://german-3ds-bxl.wlp-acs.com/", "Unknown" : "https://german-3ds.wlp-acs.com/" }'
WHERE `id` = @subIssuerID;

/* SBK_Munchen */
SET @subIssuerID = (SELECT `id` From `SubIssuer` WHERE `code` = 17009);

UPDATE `SubIssuer`
SET `paChallengePublicUrl` = '{ "Vendome" : "https://german-3ds-vdm.wlp-acs.com/", "Brussels" : "https://german-3ds-bxl.wlp-acs.com/", "Unknown" : "https://german-3ds.wlp-acs.com/" }'
WHERE `id` = @subIssuerID;

/* SBK_Hessen */
SET @subIssuerID = (SELECT `id` From `SubIssuer` WHERE `code` = 15009);

UPDATE `SubIssuer`
SET `paChallengePublicUrl` = '{ "Vendome" : "https://german-3ds-vdm.wlp-acs.com/", "Brussels" : "https://german-3ds-bxl.wlp-acs.com/", "Unknown" : "https://german-3ds.wlp-acs.com/" }'
WHERE `id` = @subIssuerID;

/* SBK_Hamburg */
SET @subIssuerID = (SELECT `id` From `SubIssuer` WHERE `code` = 12069);

UPDATE `SubIssuer`
SET `paChallengePublicUrl` = '{ "Vendome" : "https://german-3ds-vdm.wlp-acs.com/", "Brussels" : "https://german-3ds-bxl.wlp-acs.com/", "Unknown" : "https://german-3ds.wlp-acs.com/" }'
WHERE `id` = @subIssuerID;

/* SBK_BW */
SET @subIssuerID = (SELECT `id` From `SubIssuer` WHERE `code` = 16009);

UPDATE `SubIssuer`
SET `paChallengePublicUrl` = '{ "Vendome" : "https://german-3ds-vdm.wlp-acs.com/", "Brussels" : "https://german-3ds-bxl.wlp-acs.com/", "Unknown" : "https://german-3ds.wlp-acs.com/" }'
WHERE `id` = @subIssuerID;

/* SBK_Augsburg */
SET @subIssuerID = (SELECT `id` From `SubIssuer` WHERE `code` = 17209);

UPDATE `SubIssuer`
SET `paChallengePublicUrl` = '{ "Vendome" : "https://german-3ds-vdm.wlp-acs.com/", "Brussels" : "https://german-3ds-bxl.wlp-acs.com/", "Unknown" : "https://german-3ds.wlp-acs.com/" }'
WHERE `id` = @subIssuerID;