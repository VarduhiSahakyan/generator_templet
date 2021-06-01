USE `U5G_ACS_BO`;


SET @customItemSetId = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_18501_PB_MOBILE_APP');

UPDATE `CustomItem` SET VALUE = 'Bitte bestätigen Sie Ihren Einkauf.\n\nGeben Sie dazu die Zahlung über BestSign frei.\n\nHändler : @merchant \nBetrag : @amount\nDatum : @formattedDate\nKartennummer : @displayedPan\nBestSign-Verfahren: @device' WHERE fk_id_customItemSet in (@customItemSetId) and ordinal = 160 and pageTypes = 'APP_VIEW' and DTYPE ='T';


SET @customItemSetId = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_18501_PB_MOBILE_APP_Choice');

UPDATE `CustomItem` SET VALUE = 'Bitte bestätigen Sie Ihren Einkauf.\n\nGeben Sie dazu die Zahlung über BestSign frei.\n\nHändler : @merchant\nBetrag : @amount\nDatum : @formattedDate\nKartennummer : @displayedPan\nBestSign-Verfahren: @device' WHERE fk_id_customItemSet in (@customItemSetId) and ordinal = 160 and pageTypes = 'APP_VIEW' and DTYPE ='T';

