USE `U5G_ACS_BO`;

set @customITemSetDefaultRefusal= (SELECT `id` from `CustomItemSet` where `name`= 'customitemset_16500_REFUSAL' );
SET @MaestroVID = (SELECT `id` FROM `Network` WHERE `code` = 'VISA');
SET @MaestroVName = (SELECT `name` FROM `Network` WHERE `code` = 'VISA');
SET @currentPageType = 'REFUSAL_PAGE';
SET @locale = 'de';

UPDATE `CustomItem`
SET `value` = 'Authentifizierung nicht erfolgreich'
WHERE `ordinal` = 22 and `pageTypes`= @currentPageType and `fk_id_network` =  @MaestroVID and `locale` = @locale and `fk_id_customItemSet`= @customITemSetDefaultRefusal;

UPDATE `CustomItem`
SET `value` = 'Ihre Zahlung konnte nicht durchgeführt werden'
WHERE `ordinal` = 23 and `pageTypes`= @currentPageType and `fk_id_network` =  @MaestroVID and `locale` = @locale and `fk_id_customItemSet`= @customITemSetDefaultRefusal;

UPDATE `CustomItem`
SET `value` = 'Haben Sie Ihre Zugangsdaten korrekt eingegeben?'
WHERE `ordinal` = 5 and `pageTypes`= @currentPageType and `fk_id_network` =  @MaestroVID and `locale` = @locale and `fk_id_customItemSet`= @customITemSetDefaultRefusal;

UPDATE `CustomItem`
SET `value` = ''
WHERE `ordinal` = 6 and `pageTypes`= @currentPageType and `fk_id_network` =  @MaestroVID and `locale` = @locale and `fk_id_customItemSet`= @customITemSetDefaultRefusal;

UPDATE `CustomItem`
SET `value` = '<ul><li>Kommt es im Internetbanking oder bei VISA Secure - während der Freigabe - zu 3 Fehleingaben oder Vorgangsabbrüchen, wird Ihr Freigabeverfahren gesperrt. </li><li>Um wieder am VISA Secure-Verfahren teilzunehmen, benötigen Sie neue Zugangsdaten für Ihr Internetbanking. Diese können Sie unter www.ing.de selbst erstellen. Klicken Sie auf "Login Banking" und dann direkt auf "Zugangsdaten vergessen?". Für die Freigabe benötigen Sie dann nur noch Ihre iTAN-Liste oder die Banking to go App.</li></ul>'
WHERE `ordinal` = 7 and `pageTypes`= @currentPageType and `fk_id_network` =  @MaestroVID and `locale` = @locale and `fk_id_customItemSet`= @customITemSetDefaultRefusal;


