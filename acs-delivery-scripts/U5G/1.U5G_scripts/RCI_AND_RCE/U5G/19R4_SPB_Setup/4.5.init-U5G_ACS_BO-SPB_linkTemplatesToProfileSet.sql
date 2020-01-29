USE U5G_ACS_BO;

START TRANSACTION;

SET @bankName = 'Spardabank';

INSERT INTO CustomPageLayout_ProfileSet
SELECT cpl.id, ps.id FROM (SELECT id FROM ProfileSet where name like '%PS_SBK_%' AND name <> 'PS_SPB_sharedBIN_01') as ps
            , (SELECT id FROM CustomPageLayout where description like CONCAT('%', @bankName, '%')) as cpl;

COMMIT;