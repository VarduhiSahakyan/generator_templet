USE U5G_ACS_BO;

SELECT * FROM Network;

UPDATE Network SET dsReferenceNumber = '3DS_LOA_DIS_MAST_020200_00281', displayName = 'MASTERCARD©'
WHERE code = 'MASTERCARD';

SELECT * FROM Network;
