USE `U5G_ACS_BO`;

SET @subIssuerCodeFBK = 18502;

SET @idCustomItemSetFBKUndefined = (Select id From `CustomItemSet` where `name` = 'customitemset_18502_PB_UNDEFINED');

UPDATE `CustomItem` SET `value` = 'Damit Sie noch sicherer mit Ihrer Kreditkarte zahlen, haben wir eine zusätzliche Abfrage eingefügt. Bitte wählen Sie Ihr gewünschtes Sicherheitsverfahren aus. 

Händler : @merchant 
Betrag : @amount 
Datum : @formattedDate 
Kartennummer : @displayedPan
'
WHERE `ordinal` = 152 and `pageTypes` = 'APP_VIEW_MEAN_SELECT' and `fk_id_customitemset` = @idCustomItemSetFBKUndefined;
