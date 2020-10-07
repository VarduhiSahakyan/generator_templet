USE `U5G_ACS_BO`;


SET @customItemSetId = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_18502_PB_TA');

UPDATE `CustomItem` SET VALUE = 'Bitte bestätigen Sie Ihren Einkauf.\n\nGeben Sie dazu die Zahlung über die App Postbank Kreditkarten-Ident frei.\n\nHändler : @merchant\nBetrag : @amount\nDatum : @formattedDate\nKartennummer : @displayedPan' WHERE fk_id_customItemSet in (@customItemSetId) and ordinal = 160 and pageTypes = 'APP_VIEW' and DTYPE ='T';


SET @customItemSetId = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_18502_PB_TA_Choice');

UPDATE `CustomItem` SET VALUE = 'Bitte bestätigen Sie Ihren Einkauf.\n\nGeben Sie dazu die Zahlung über die App Postbank Kreditkarten-Ident frei.\n\nHändler : @merchant\nBetrag : @amount\nDatum : @formattedDate\nKartennummer : @displayedPan' WHERE fk_id_customItemSet in (@customItemSetId) and ordinal = 160 and pageTypes = 'APP_VIEW' and DTYPE ='T';