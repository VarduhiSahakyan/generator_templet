
set @BankUB=16900;

UPDATE `U5G_ACS_BO`.`CustomItem` SET `value`='Beachten Sie bitte, dass aus Sicherheitsgründen nach 3x falscher mTan Eingabe eine Sperrung Ihres TAN-Verfahren erfolgt ist.' WHERE pageTypes='FAILURE_PAGE' and ordinal=1 and locale='de' and Dtype='T' and fk_id_customItemSet in (SELECT id FROM `CustomItemSet` WHERE `name` in ( CONCAT('customitemset_',@BankUB,'_SMS'), CONCAT('customitemset_',@BankUB,'_TOKENTAN')));
UPDATE `U5G_ACS_BO`.`CustomItem` SET `value`='Bei Rückfragen wenden Sie sich bitte an Ihr persönliches Betreungsteam.' WHERE pageTypes='FAILURE_PAGE' and ordinal=2 and locale='de' and Dtype='T' and fk_id_customItemSet in (SELECT id FROM `CustomItemSet` WHERE `name` in ( CONCAT('customitemset_',@BankUB,'_SMS'), CONCAT('customitemset_',@BankUB,'_TOKENTAN')));
UPDATE `U5G_ACS_BO`.`CustomItem` SET `value`='Authentifizierung läuft' WHERE pageTypes='OTP_FORM_PAGE' and ordinal=12 and locale='de' and Dtype='T' and fk_id_customItemSet in (SELECT id FROM `CustomItemSet` WHERE `name` in ( CONCAT('customitemset_',@BankUB,'_SMS'), CONCAT('customitemset_',@BankUB,'_TOKENTAN')));
UPDATE `U5G_ACS_BO`.`CustomItem` SET `value`='Authentifizierung erfolgreich' WHERE pageTypes='OTP_FORM_PAGE' and ordinal=26 and locale='de' and Dtype='T' and fk_id_customItemSet in (SELECT id FROM `CustomItemSet` WHERE `name` in ( CONCAT('customitemset_',@BankUB,'_SMS'), CONCAT('customitemset_',@BankUB,'_TOKENTAN')));
UPDATE `U5G_ACS_BO`.`CustomItem` SET `value`='Die Session ist abgelaufen' WHERE pageTypes='OTP_FORM_PAGE' and ordinal=30 and locale='de' and Dtype='T' and fk_id_customItemSet in (SELECT id FROM `CustomItemSet` WHERE `name` in ( CONCAT('customitemset_',@BankUB,'_SMS'), CONCAT('customitemset_',@BankUB,'_TOKENTAN')));


UPDATE `U5G_ACS_BO`.`CustomItem` SET `value`='Beachten Sie bitte, dass aus Sicherheitsgründen nach 3x falscher mTan Eingabe eine Sperrung Ihres TAN-Verfahren erfolgt ist.' WHERE pageTypes='OTP_FORM_PAGE' and ordinal=29 and locale='de' and Dtype='T' and fk_id_customItemSet in (SELECT id FROM `CustomItemSet` WHERE `name` in ( CONCAT('customitemset_',@BankUB,'_SMS')));


UPDATE `U5G_ACS_BO`.`CustomItem` SET `value`='Bei Rückfragen wenden Sie sich bitte an Ihr persönliches Betreungsteam.' WHERE pageTypes='REFUSAL_PAGE' and ordinal=2 and locale='de' and Dtype='T' and fk_id_customItemSet in (SELECT id FROM `CustomItemSet` WHERE `name` in ( CONCAT('customitemset_',@BankUB,'_1_REFUSAL'), CONCAT('customitemset_',@BankUB,'_SMS'), CONCAT('customitemset_',@BankUB,'_TOKENTAN')));



update `U5G_ACS_BO`.`CustomItem` set value=' ' where fk_id_customItemSet in (SELECT id FROM `CustomItemSet` WHERE `name` like ( CONCAT('customitemset_',@BankUB,'%'))) and DTYPE='T' and value='';

