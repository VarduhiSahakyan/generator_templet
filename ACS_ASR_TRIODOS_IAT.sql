-- Generated by sql-script-generator
-- Version: 22R1-GE-3.5-SNAPSHOT
-- Date: Wed Sep 07 15:47:23 CEST 2022
-- Properties file: /json/Configuration_IAT.json
-- Template file: /templates/ACS_ASR_script_template.j2

USE H0G_ASR;
-- ------------------------
-- ASR CONFIG FILE
-- service = ACS_U5G
-- issuer = 10000
-- subissuer = 
-- ------------------------
-- Beginning of data insertion --

--
--  Data for table `CONFIGS`
--
select count(*) as 'table_configs_count_before_inserts' from `CONFIGS`;
INSERT INTO `CONFIGS` (`CODE`, `DATA`)
    VALUES
        ('ACS_U5G-10000-CHECK_EXPIRY','false'),
        ('ACS_U5G-10000-cr.favoreAll','true'),
        ('ACS_U5G-10000-default.language','en'),
        ('ACS_U5G-10000-default.masked.pan','######xxxxxx####'),
        
        ('ACS_U5G-10000-DETOKENIZE_DESE','false'),
        ('ACS_U5G-10000-hotp.method','HOTP_SOFT'),
        ('ACS_U5G-10000-KEYS','CN=test-acs.wlp-acs.com,CN=test-hub.wlp-acs.com,CN=Triodos_3DS_client_auth_TEST'),
        ('ACS_U5G-10000-referential.languages','en,fr,nl'),
        ('ACS_U5G-10000-SMS_PHONE_PREFIXES','0031,+31'),
        ('ACS_U5G-10000-MEANS_ALWAYS_AVAILABLE','EXTMOBAPP');

select count(*) as 'table_configs_count_after_inserts' from `CONFIGS`;

select count(*) as 'table_configs_sources_count_before_inserts' from `CONFIGS_SOURCES`;

INSERT INTO `CONFIGS_SOURCES` (`CODE`, `TYPE`, `DATA`)
    VALUES
    -- ACS CR (SOURCES)
     ('ACS_U5G-10000-CR_cr.connect.timeout','SOURCES','2000'),
     ('ACS_U5G-10000-CR_cr.response.timeout','SOURCES','2000'),
     ('ACS_U5G-10000-CR_EHCACHE_MAX_BYTE_LOCAL_HEAP','SOURCES','2000000'),
     ('ACS_U5G-10000-CR_EHCACHE_TIME_TTL_SEC','SOURCES','600'),
     ('ACS_U5G-10000-CR_favoreAll','SOURCES','true'),

    -- ACS FLASH (SOURCES)
     ('ACS_U5G-10000-FLASH_FLASH_COEFFICIENT','SOURCES','2'),
     ('ACS_U5G-10000-FLASH_FLASH_COLLECTION','SOURCES','hub-authentication-rbu2-h5g'),
     ('ACS_U5G-10000-FLASH_FLASH_CONNECT_TO','SOURCES','2000'),
     ('ACS_U5G-10000-FLASH_FLASH_INITIAL_DELAY','SOURCES','4000'),
     ('ACS_U5G-10000-FLASH_FLASH_MAX_ALEATORY','SOURCES','4000'),
     ('ACS_U5G-10000-FLASH_FLASH_MAX_TRYOUTS','SOURCES','2'),
     ('ACS_U5G-10000-FLASH_FLASH_MIN_ALEATORY','SOURCES','2000'),
     ('ACS_U5G-10000-FLASH_FLASH_READ_TO','SOURCES','2000'),

    -- ACS SM (MODULES)
     ('ACS_U5G-10000-SM_hub-authentication-rbu2-h5g.apikey','MODULES','CN=test-acs.wlp-acs.com'),
     ('ACS_U5G-10000-SM_session.ttl','MODULES','600'),
     ('ACS_U5G-10000-SM_SESSION_SLEEP_BEFORE_DELETE','MODULES','250'),
     ('ACS_U5G-10000-SM_SPLUNK_TIMER_ENABLED','MODULES','false'),

    -- ACS WS_WSSTANDARD (SOURCES)
     ('ACS_U5G-10000-WS_WSSTANDARD_PRINCIPAL_TYPE','SOURCES','CARD_HOLDER_ID'),
     
     
select count(*) as 'table_configs_sources_count_after_inserts' from `CONFIGS_SOURCES`;

--
-- Data for table `CONFIGS_URLS`
--
select count(*) as 'table_configs_urls_count_before_inserts' from `CONFIGS_URLS`;
INSERT INTO `CONFIGS_URLS` (`code`, `type`, `ping_url`, `url`)
    VALUES
    #CR#
    ('ACS_U5G-10000-CR','SOURCES','http://qlf-h5g-fo-hub-cr.vdm.qvmbfi.svc.meshcore.net/referential/rest/referential/serviceAvailable','src?url=http://cr/api/&type=CrRDA&order=1&mandatory=true,snk?url=http://cr/api/&type=CrRDA&order=1&mandatory=true'),
    #EXTMOBAPP#
    ('ACS_U5G-10000-EXTMOBAPP','MEANS','http://qlf-h0g-fo-hub-as.qvmbfi.svc.meshcore.net/wsstandard/rest/mean/serviceAvailable','http://qlf-h0g-fo-hub-as.qvmbfi.svc.meshcore.net/wsstandard/rest/'),
    #REFERENTIAL#
    ('ACS_U5G-10000-REFERENTIAL','MODULES','http://qlf-h5g-fo-hub-cr.vdm.qvmbfi.svc.meshcore.net/referential/rest/referential/serviceAvailable','http://qlf-h5g-fo-hub-cr.vdm.qvmbfi.svc.meshcore.net/referential/rest/'),
    #WS_EXTMOBAPP#
    ('ACS_U5G-10000-WS_EXTMOBAPP','SOURCES_WS','http://qlf-h0g-fo-hub-as.qvmbfi.svc.meshcore.net/wsstandard/rest/mean/serviceAvailable','https://test-ideal.triodos.com/soso/purple/worldline-card/services/sca');
select count(*) as 'table_configs_urls_count_after_inserts' from `CONFIGS_URLS`;

-- End of data insertion
