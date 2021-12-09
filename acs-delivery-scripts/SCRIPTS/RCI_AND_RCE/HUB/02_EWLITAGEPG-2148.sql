USE H0G_RBA;


INSERT INTO ELIGIBLE_MERCHANT (service, issuer, sub_issuer, payee_type, payee_value, hash_key, trusted, top_level, created_time, updated_time, deleted_time)
    VALUES ('ACS_U5G', null, null, 'MERCHANT_URL', 'www.toto.fr', 'fc151b0ee67fb61fb2bd37cc25e66c512154ab87296bb47538f1b2140d4fcc27', 1, 1, NOW(), null, null);
INSERT INTO ELIGIBLE_MERCHANT (service, issuer, sub_issuer, payee_type, payee_value, hash_key, trusted, top_level, created_time, updated_time, deleted_time)
    VALUES ('ACS_U5G', null, null, 'MERCHANT_ID', 'Test', '3a3908487ee38c671f1d0b38dd562093fdfef624663383cffc29d026549dabef', 1, 1, NOW(), null, null);

SET @payeeValueToto = 'www.toto.fr';
SET @merchantId1 = (SELECT `id` FROM `ELIGIBLE_MERCHANT` WHERE `payee_value` = @payeeValueToto);
SET @payeeValueTest = 'Test';
SET @merchantId2 = (SELECT `id` FROM `ELIGIBLE_MERCHANT` WHERE `payee_value` = @payeeValueTest);



INSERT INTO ELIGIBLE_MERCHANT_CATEGORY (eligible_merchant_id, type) VALUES (@merchantId1, 'RISK');
INSERT INTO ELIGIBLE_MERCHANT_CATEGORY (eligible_merchant_id, type) VALUES (@merchantId1, 'LEVEL_1');
INSERT INTO ELIGIBLE_MERCHANT_CATEGORY (eligible_merchant_id, type) VALUES (@merchantId1, 'TRUSTED_BENEFICIARIES_ACS');
INSERT INTO ELIGIBLE_MERCHANT_CATEGORY (eligible_merchant_id, type) VALUES (@merchantId1, 'DELEGATED_AUTHENTICATION');
INSERT INTO ELIGIBLE_MERCHANT_CATEGORY (eligible_merchant_id, type) VALUES (@merchantId2, 'LEVEL_1');
INSERT INTO ELIGIBLE_MERCHANT_CATEGORY (eligible_merchant_id, type) VALUES (@merchantId2, 'TRUSTED_BENEFICIARIES_ACS');