USE U5G_ACS_BO;

SET @pageType = 'REFUSAL_PAGE';
SET @subissuerId = (SELECT id from SubIssuer WHERE code = 19440);
SET @defaultRefusalID = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_COZ_MISSING_AUTHENT_REFUSAL' and fk_id_subIssuer = @subissuerId);


SET @textValue = 'Bitte aktivieren Sie Ihre Kreditkarte im Commerzbank Online Banking unter „Karte verwalten“ oder rufen Sie uns unter der Nr. 069 / 5 8000 8000 an.';

UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @defaultRefusalID AND pageTypes = @pageType AND ordinal = 201;