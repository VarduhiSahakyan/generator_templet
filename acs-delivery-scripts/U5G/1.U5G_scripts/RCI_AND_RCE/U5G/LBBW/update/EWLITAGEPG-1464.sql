USE U5G_ACS_BO;

SET @locale = 'de';
SET @username = 'W100851';
SET @customItemSet_LBBW_OTP_SMS = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_LBBW_OTP_SMS');
SET @pageType_HELP_PAGE ='HELP_PAGE';

SET @text = 'Das SMS mTAN Verfahren wird zum 31.05.2021 von uns deaktiviert. Bitte registrieren Sie sich für das neue Sicherheitsverfahren BW-Secure. Diese ist in wenigen Minuten schnell und einfach erledigt. Gleich anmelden im BW-Secure Portal:<br><a href="https://sicheres-bezahlen.bw-bank.de/" target="_blank">https://sicheres-bezahlen.bw-bank.de/</a>';

UPDATE `CustomItem` SET `value` = @text
					WHERE `locale` = @locale
					AND  `ordinal` = 3
					AND `pageTypes` = @pageType_HELP_PAGE
					AND `fk_id_customItemSet` = @customItemSet_LBBW_OTP_SMS;