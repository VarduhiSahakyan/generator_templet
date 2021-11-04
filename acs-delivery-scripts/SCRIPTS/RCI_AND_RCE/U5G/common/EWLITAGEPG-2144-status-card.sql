USE U5G_ACS_BO;

INSERT INTO `SubIssuer_Configuration` (`subIssuerCode`, `defaultDelayInExemption`, `authDataAddition`, `defaultTransactionSearchPeriod`, `aesKeyTag`, `displayCardExpiryDate`, `changeCardStatus`, `displayCardId`, `displayCardUpdatedTime`, `displayCardDeletedTime`) 
SELECT s.code, 1, b'0', 1, '', b'1', b'1', b'0', b'0', b'0' FROM SubIssuer s;
