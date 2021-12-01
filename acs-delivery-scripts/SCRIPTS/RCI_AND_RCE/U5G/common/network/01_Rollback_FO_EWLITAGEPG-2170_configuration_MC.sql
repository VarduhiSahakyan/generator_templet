USE U5G_ACS_FO;

SELECT * FROM CARDNETWORK;

UPDATE CARDNETWORK SET DS_REFERENCE_NUMBER = 'MCReferenceNumber', ECI_AUTH_SUCCESS = '02', ECI_NPA_AUTH_SUCCESS = NULL, ECI_NO_AUTH = '01',ECI_FAILED = '00', ECI_NPA_FAILED = NULL, SOLUTION = 'SecureCode™', DISPLAY_NAME = 'MASTERCARD©', ACS_LOGIN_ID = 'Atos Worldline', VE_PUBLIC_URL = 'http://ve/', SECONDARY_DS_REFERENCE_NUMBER = NULL
WHERE NAME = 'MASTERCARD';

SELECT * FROM CARDNETWORK;
