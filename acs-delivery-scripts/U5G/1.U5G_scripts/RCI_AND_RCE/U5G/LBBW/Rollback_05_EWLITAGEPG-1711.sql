USE U5G_ACS_BO;

SET @customItemSet_LBBW_OTP_SMS = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_LBBW_OTP_SMS');

SET @pageType ='HELP_PAGE';
SET @text = 'Das SMS mTAN Verfahren wird zum 31.05.2021 von uns deaktiviert. Bitte registrieren Sie sich für das neue Sicherheitsverfahren BW&#8209;Secure. Diese ist in wenigen Minuten schnell und einfach erledigt. Gleich anmelden im BW&#8209;Secure Portal:<br><a href="https://sicheres-bezahlen.bw-bank.de/" target="_blank">https://sicheres-bezahlen.bw-bank.de/</a>';

SET @ordinal = 6;
UPDATE `CustomItem` SET `value` = @text
WHERE fk_id_customItemSet = @customItemSet_LBBW_OTP_SMS and ordinal = @ordinal and pageTypes = @pageType;