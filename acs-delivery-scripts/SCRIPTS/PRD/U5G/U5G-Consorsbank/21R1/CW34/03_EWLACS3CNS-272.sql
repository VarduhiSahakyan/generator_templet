USE `U5G_ACS_BO`;

SET @createdBy = 'A758582';
SET @updateState = 'PUSHED_TO_CONFIG';
SET @MaestroVID = (SELECT id FROM `Network` WHERE code = 'VISA');
SET @MaestroVName = (SELECT name FROM `Network` WHERE code = 'VISA');

SET @BankUB = '16900';
SET @helpPageType ='HELP_PAGE';
SET @currentAuthentMean = (SELECT id FROM `AuthentMeans` WHERE name = 'REFUSAL');
SET @refusalCustomItemSet = (SELECT id FROM CustomItemSet WHERE name = CONCAT('customitemset_',@BankUB,'_1_REFUSAL'));

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
                          `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
                          `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
   ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPageType,'_1'), @updateState,
    'de', 1, @helpPageType, '<b>Informationen über Visa Secure</b></br>
Visa Secure ist ein Service von Visa und der Consorsbank, der Ihnen beim Einkaufen im Internet zusätzlichen Schutz vor unberechtigter Verwendung Ihrer Kreditkarte bietet. So können Sie unbesorgt online einkaufen oder Ihre Kreditkartendaten bei Händlern abgesichert hinterlegen.', @MaestroVID, NULL, @refusalCustomItemSet),
   ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPageType,'_2'), @updateState,
    'de', 2, @helpPageType, '<b>Registrierung für Visa Secure</b></br>
Eine separate Registrierung bei Visa ist nicht erforderlich. Sie werden als Inhaber einer Consorsbank Visa Karte automatisch für den Visa Secure Service angemeldet.', @MaestroVID, NULL, @refusalCustomItemSet),
   ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPageType,'_3'), @updateState,
    'de', 3, @helpPageType, '<b>Deaktivierung des Visa Secure Service</b></br>
Solange Sie ein Girokonto und eine Visa Karte bei der Consorsbank haben, ist eine Abmeldung bzw. Löschung aus Visa Secure nicht möglich.', @MaestroVID, NULL, @refusalCustomItemSet),
   ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPageType,'_4'), @updateState,
    'de', 4, @helpPageType, '<b>Höhere Sicherheit durch Visa Secure beim Online-Einkauf</b></br>
Zukünftig öffnet sich beim Online-Einkauf (bei teilnehmenden Händlern) vor Abschluss des Kaufvorganges das Visa Secure Eingabefenster. Visa Secure erkennt automatisch das von Ihnen genutzte Autorisierungsverfahren. Ihr Online-Einkauf wird durch Ihre Autorisierung zusätzlich abgesichert.', @MaestroVID, NULL, @refusalCustomItemSet),
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPageType,'_5'), @updateState,
    'de', 5, @helpPageType, '<b>Falscheingabe der Visa Secure TAN</b></br>
Nach dreimaliger Falscheingabe der TAN wird der TAN-Service aus Sicherheitsgründen gesperrt. Kontaktieren Sie in diesem Fall Ihr Consorsbank Betreuungsteam, um den TAN-Service wieder zu entsperren. Ihre Visa Karte behält während der Sperre des TAN-Service weiterhin Ihre Gültigkeit und kann von Ihnen, wie gewohnt, zum Bezahlen in Geschäften und für Bargeldabhebungen genutzt werden.', @MaestroVID, NULL, @refusalCustomItemSet),
  ('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@MaestroVName,'_',@currentAuthentMean,'_',@helpPageType,'_11'), @updateState,
    'de', 11, @helpPageType, 'Schließen', @MaestroVID, NULL, @refusalCustomItemSet);