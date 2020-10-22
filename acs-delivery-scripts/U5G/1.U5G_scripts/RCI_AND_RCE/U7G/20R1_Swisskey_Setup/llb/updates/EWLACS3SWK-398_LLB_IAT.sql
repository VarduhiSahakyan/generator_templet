USE U7G_ACS_BO;

SET @BankB = 'SWISSKEY';
SET @BankUB = 'LLB';

--  update title --
SET @ordinal = 28;
SET @pageType = 'OTP_FORM_PAGE';

SET @customItemNamePWD = 'VISA_EXT_PASSWORD_OTP_FORM_PAGE_28';
SET @customItemSetNamePWD = 'customitemset_LLB_PASSWORD';
SET @customItemSetIDPWD = (SELECT id FROM `CustomItemSet` WHERE `name` = @customItemSetNamePWD);

SET @locale = 'de';
UPDATE CustomItem SET value = 'Ungültige Eingabe'
WHERE ordinal = @ordinal AND pageTypes = @pageType AND name = @customItemNamePWD AND locale = @locale AND fk_id_customItemSet = @customItemSetIDPWD;

SET @locale = 'en';
UPDATE CustomItem SET value = 'Invalid input'
WHERE ordinal = @ordinal AND pageTypes = @pageType AND name = @customItemNamePWD AND locale = @locale AND fk_id_customItemSet = @customItemSetIDPWD;

SET @locale = 'fr';
UPDATE CustomItem SET value = 'Entrée invalide'
WHERE ordinal = @ordinal AND pageTypes = @pageType AND name = @customItemNamePWD AND locale = @locale AND fk_id_customItemSet = @customItemSetIDPWD;

SET @locale = 'it';
UPDATE CustomItem SET value = 'Inserimento non valido'
WHERE ordinal = @ordinal AND pageTypes = @pageType AND name = @customItemNamePWD AND locale = @locale AND fk_id_customItemSet = @customItemSetIDPWD;


-- update text --
SET @ordinal = 29;
SET @pageType = 'OTP_FORM_PAGE';
SET @customItemNamePWD = 'VISA_EXT_PASSWORD_OTP_FORM_PAGE_29';

SET @locale = 'de';
UPDATE CustomItem SET value = 'Das eingegebene Passwort oder Eingabe-Code ist nicht korrekt. Bitte versuchen Sie es erneut.'
WHERE ordinal = @ordinal AND pageTypes = @pageType AND name = @customItemNamePWD AND locale = @locale AND fk_id_customItemSet = @customItemSetIDPWD;

SET @locale = 'en';
UPDATE CustomItem SET value = 'The entered password or approval code is incorrect. Please try again.'
WHERE ordinal = @ordinal AND pageTypes = @pageType AND name = @customItemNamePWD AND locale = @locale AND fk_id_customItemSet = @customItemSetIDPWD;

SET @locale = 'fr';
UPDATE CustomItem SET value = 'Le mot de passe ou le code d''activation saisi est incorrect. Veuillez réessayer.'
WHERE ordinal = @ordinal AND pageTypes = @pageType AND name = @customItemNamePWD AND locale = @locale AND fk_id_customItemSet = @customItemSetIDPWD;

SET @locale = 'it';
UPDATE CustomItem SET value = 'La password o il codice di autenticazione inseriti non sono corretti. Per favore riprova.'
WHERE ordinal = @ordinal AND pageTypes = @pageType AND name = @customItemNamePWD AND locale = @locale AND fk_id_customItemSet = @customItemSetIDPWD;

-- update button --
SET @ordinal = 174;
SET @pageType = 'OTP_FORM_PAGE';
SET @customItemNamePWD = 'VISA_EXT_PASSWORD_OTP_FORM_PAGE_174';

SET @locale = 'de';
UPDATE CustomItem SET value = 'Schliessen'
WHERE ordinal = @ordinal AND pageTypes = @pageType AND name = @customItemNamePWD AND locale = @locale AND fk_id_customItemSet = @customItemSetIDPWD;

SET @locale = 'en';
UPDATE CustomItem SET value = 'Close'
WHERE ordinal = @ordinal AND pageTypes = @pageType AND name = @customItemNamePWD AND locale = @locale AND fk_id_customItemSet = @customItemSetIDPWD;

SET @locale = 'fr';
UPDATE CustomItem SET value = 'Fermer'
WHERE ordinal = @ordinal AND pageTypes = @pageType AND name = @customItemNamePWD AND locale = @locale AND fk_id_customItemSet = @customItemSetIDPWD;

SET @locale = 'it';
UPDATE CustomItem SET value = 'Chiudere'
WHERE ordinal = @ordinal AND pageTypes = @pageType AND name = @customItemNamePWD AND locale = @locale AND fk_id_customItemSet = @customItemSetIDPWD;


-- Native APP --

SET @ordinal = 160;
SET @pageType = 'APP_VIEW';
SET @customItemSetId = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_LLB_PASSWORD');

SET @locale = 'de';
UPDATE CustomItem SET value = 'Das eingegebene Passwort oder Eingabe-Code ist nicht korrekt. Bitte versuchen Sie es erneut.'
WHERE ordinal = @ordinal AND pageTypes = @pageType AND fk_id_customItemSet = @customItemSetId AND locale = @locale;

SET @locale = 'en';
UPDATE CustomItem SET value = 'The entered password or approval code is incorrect. Please try again.'
WHERE ordinal = @ordinal AND pageTypes = @pageType AND fk_id_customItemSet = @customItemSetId AND locale = @locale;

SET @locale = 'fr';
UPDATE CustomItem SET value = 'Le mot de passe ou le code d''activation saisi est incorrect. Veuillez réessayer.'
WHERE ordinal = @ordinal AND pageTypes = @pageType AND fk_id_customItemSet = @customItemSetId AND locale = @locale;

SET @locale = 'it';
UPDATE CustomItem SET value = 'La password o il codice di autenticazione inseriti non sono corretti. Per favore riprova.'
WHERE ordinal = @ordinal AND pageTypes = @pageType AND fk_id_customItemSet = @customItemSetId AND locale = @locale;