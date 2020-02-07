ALTER TABLE  `Issuer` CHANGE  `inactivatedAuthentMeans`  `authentMeans` TEXT CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL;
/* update all issuer elements and activate by defaut all authentmeans availaible*/
UPDATE `Issuer` SET `authentMeans` = '[{"authentMeans" : "OTP_SMS","validate" : true},{"authentMeans" : "OTP_MAIL","validate" : true},{"authentMeans" : "OTP_IVR","validate" : true},{"authentMeans" : "OTP_PHONE","validate" : true},{"authentMeans" : "ATTEMPT","validate" : true}]', `availaibleAuthentMeans` = 'OTP_SMS|OTP_MAIL|OTP_IVR|OTP_PHONE|ATTEMPT'
