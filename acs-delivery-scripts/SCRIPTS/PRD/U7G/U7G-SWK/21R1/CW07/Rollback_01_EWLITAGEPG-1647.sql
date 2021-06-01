
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