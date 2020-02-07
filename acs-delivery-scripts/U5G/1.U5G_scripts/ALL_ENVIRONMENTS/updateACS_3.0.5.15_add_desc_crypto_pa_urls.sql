ALTER TABLE CryptoConfig ADD COLUMN description VARCHAR(255) DEFAULT NULL AFTER protocolTwo;
ALTER TABLE SubIssuer ADD COLUMN paChallengePublicUrl VARCHAR(255) DEFAULT NULL AFTER fk_id_cryptoConfig;