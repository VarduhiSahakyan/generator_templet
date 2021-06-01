
USE `U7G_ACS_BO`;

UPDATE `SubIssuer` set `3DS2AdditionalInfo` = '{
      "VISA": {
        "operatorId": "acsOperatorVisa",
        "dsKeyAlias": "dsvisa_call_alias_cert_01"
      },
      "MASTERCARD": {
        "operatorId": "ACS-V210-EQUENSWORLDLINE-34926",
        "dsKeyAlias": "1"
      }
}
' where `id` in (8,9,10);

UPDATE `SubIssuer` set `3DS2AdditionalInfo` = '{
      "VISA": {
        "operatorId": "acsOperatorVisa",
        "dsKeyAlias": "dsvisa_call_alias_cert_01"
      }
}' where `id` in (7,11);

SET @acsURLVEMastercard = 'https://ssl-prd-u7g-fo-acs-ve.wlp-acs.com:9743/acs-ve-service/ve/veRequest';
SET @acsURLVEVisa = 'https://ssl-prd-u7g-fo-acs-ve.wlp-acs.com:9643/acs-ve-service/ve/veRequest';

UPDATE `SubIssuer` set `acs_URL1_VE_MC` = @acsURLVEMastercard, `acs_URL2_VE_MC` = @acsURLVEMastercard, `acs_URL1_VE_VISA` = @acsURLVEVisa, `acs_URL2_VE_VISA` = @acsURLVEVisa;