USE U5G_ACS_BO;

START TRANSACTION;

-- add text for help button

INSERT INTO CustomItem(DTYPE, createdBy, creationDate, description, name, updateState, locale, ordinal, pageTypes, value, fk_id_network,  fk_id_customItemSet)
SELECT 'T', 'a513048', now(), CONCAT(n.code, '_', am.name, '_', ci.pageTypes, '_', ci.ordinal),
       CONCAT(n.code, '_', am.name, '_', ci.pageTypes, '_', ci.ordinal), 'PUSHED_TO_CONFIG', ci.locale, 5, ci.pageTypes, 'Hilfe', n.id, cis.id
FROM CustomItem ci INNER JOIN CustomItemSet cis ON ci.fk_id_customItemSet = cis.id
                   INNER JOIN Network n ON ci.fk_id_network = n.id
                   INNER JOIN Profile p ON cis.id = p.fk_id_customItemSetCurrent
                   INNER Join AuthentMeans am on p.fk_id_AuthentMeans = am.id
WHERE cis.name LIKE 'customitemset_SBK%' AND ci.ordinal = 1 AND ci.pageTypes <> 'HELP_PAGE' AND dtype = 'T'
ORDER BY cis.name, ci.pageTypes, ci.ordinal;

SET @bankName = 'Spardabank';

INSERT INTO CustomPageLayout_ProfileSet
SELECT cpl.id, ps.id FROM (SELECT id FROM ProfileSet where name like '%PS_SBK_%' AND name <> 'PS_SPB_sharedBIN_01') as ps
            , (SELECT id FROM CustomPageLayout where description like CONCAT('%', @bankName, '%')) as cpl;

COMMIT;