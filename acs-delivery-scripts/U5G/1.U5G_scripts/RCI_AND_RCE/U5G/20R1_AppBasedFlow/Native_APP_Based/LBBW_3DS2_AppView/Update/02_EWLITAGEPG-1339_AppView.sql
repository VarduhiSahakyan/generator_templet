USE `U5G_ACS_BO`;

-- PASSWORD_UNIFIED --

SET @locale = 'de';
SET @amName = 'PASSWORD';
SET @username = 'A709391';

SET @networkVISA = (SELECT id FROM `Network` WHERE `code` = 'VISA');
SET @networkMC = (SELECT id FROM `Network` WHERE `code` = 'MASTERCARD');

SET @customItemSet_PWD = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_LBBW_PASSWORD_UNIFIED');

/* 3DS2 implem */
/* IMAGES */
-- 3x bank logo
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG', @locale, 251, 'APP_VIEW', 'LBBW_SMALL_LOGO', NULL, im.id, @customItemSet_PWD
FROM `Image` im WHERE im.name = 'lbbw_small.png';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG', @locale, 252, 'APP_VIEW', 'LBBW_MEDIUM_LOGO', NULL, im.id, @customItemSet_PWD
FROM `Image` im WHERE im.name = 'lbbw_medium.png';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Bank Logo', 'PUSHED_TO_CONFIG', @locale, 253, 'APP_VIEW', 'LBBW_LARGE_LOGO', NULL, im.id, @customItemSet_PWD
FROM `Image` im WHERE im.name = 'lbbw_large.png';

-- 3x MC logo same naming convention needs to be used in the mc and visa queries as bank logo (above queries high,vhigh and medium)

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Mastercard Logo', 'PUSHED_TO_CONFIG', @locale, 254, 'APP_VIEW', 'MC_SMALL_LOGO', n.id, im.id, @customItemSet_PWD
FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_small.png%' AND n.code LIKE '%MASTERCARD%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Mastercard Logo', 'PUSHED_TO_CONFIG', @locale, 255, 'APP_VIEW', 'MC_MEDIUM_LOGO', n.id, im.id, @customItemSet_PWD
FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_medium.png%' AND n.code LIKE '%MASTERCARD%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Mastercard Logo', 'PUSHED_TO_CONFIG', @locale, 256, 'APP_VIEW', 'MC_LARGE_LOGO', n.id, im.id, @customItemSet_PWD
FROM `Image` im, `Network` n WHERE im.name LIKE '%MC_large.png%' AND n.code LIKE '%MASTERCARD%';


-- 3x VISA logo

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG', @locale, 254, 'APP_VIEW', 'VISA_SMALL_LOGO', n.id, im.id, @customItemSet_PWD
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_small.png%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG', @locale, 255, 'APP_VIEW', 'VISA_MEDIUM_LOGO', n.id, im.id, @customItemSet_PWD
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_medium.png%' AND n.code LIKE '%VISA%';

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'I', @username, NOW(), NULL, NULL, NULL, 'Visa Logo', 'PUSHED_TO_CONFIG', @locale, 256, 'APP_VIEW', 'VISA_LARGE_LOGO', n.id, im.id, @customItemSet_PWD
FROM `Image` im, `Network` n WHERE im.name LIKE '%VISA_large.png%' AND n.code LIKE '%VISA%';

-- ADD CB logo
SET @networkVISA = NULL;
/* 3DS2 Native UI */
/* Texts */
SET @pageType = 'APP_VIEW';
-- 3DS TITLE (Eg: SMS Authentication)
SET @ordinal = 151;
SET @text = 'BW-Secure Passwort eingeben';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code,'_',@amName,'_',@pageType,'_',@ordinal,'_',@locale), 'PUSHED_TO_CONFIG', @locale, @ordinal, @pageType, @text, NULL, NULL, @customItemSet_PWD FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);

-- 3DS MAIN CONTENT TEXT
SET @ordinal = 152;
SET @text = 'Geben Sie Ihr BW-Secure Passwort ein, um den Vorgang zu bestätigen. Diese Information wird dem Händler nicht mitgeteilt. \n\n Durch die Freigabe bezahlen Sie dem Händler @merchant den Betrag von @amount am @formattedDate.';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code,'_',@amName,'_',@pageType,'_',@ordinal,'_',@locale), 'PUSHED_TO_CONFIG', @locale, @ordinal, @pageType, @text, NULL, NULL, @customItemSet_PWD FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);

-- 3DS INPUT LABEL
SET @ordinal = 153;
SET @text = 'BW-Secure Passwort';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code,'_',@amName,'_',@pageType,'_',@ordinal,'_',@locale), 'PUSHED_TO_CONFIG', @locale, @ordinal, @pageType, @text, NULL, NULL, @customItemSet_PWD FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);

-- 3DS SUBMIT BUTTON LABEL
SET @ordinal = 154;
SET @text = 'Bestätigen';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code,'_',@amName,'_',@pageType,'_',@ordinal,'_',@locale), 'PUSHED_TO_CONFIG', @locale, @ordinal, @pageType, @text, NULL, NULL, @customItemSet_PWD FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);

-- 3DS RESEND BUTTON LABEL
SET @ordinal = 155;
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code,'_',@amName,'_',@pageType,'_',@ordinal,'_',@locale), 'PUSHED_TO_CONFIG', @locale, @ordinal, @pageType, @text, NULL, NULL, @customItemSet_PWD FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);

-- 3DS WHY INFO_LABEL (Kind of help button text)
SET @ordinal = 156;
SET @text = 'Hilfe';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code,'_',@amName,'_',@pageType,'_',@ordinal,'_',@locale), 'PUSHED_TO_CONFIG', @locale, @ordinal, @pageType, @text, NULL, NULL, @customItemSet_PWD FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);

-- 3DS WHY INFO_TEXT (Kind of help text but shorter)
SET @ordinal = 157;
SET @text = 'Ihre Kreditkartenzahlung muss mit Ihrem BW-Secure Passwort sowie der mTAN für 3D-Secure bestätigt werden.\n \n Nähere Informationen finden Sie im BW-Secure Portal: https://sicheres-bezahlen.bw-bank.de/';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code,'_',@amName,'_',@pageType,'_',@ordinal,'_',@locale), 'PUSHED_TO_CONFIG', @locale, @ordinal, @pageType, @text, NULL, NULL, @customItemSet_PWD FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);

-- 3DS EXPAND_INFO_LABEL (Similar to help label)
SET @ordinal = 158;
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code,'_',@amName,'_',@pageType,'_',@ordinal,'_',@locale), 'PUSHED_TO_CONFIG', @locale, @ordinal, @pageType, @text, NULL, NULL, @customItemSet_PWD FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);

-- 3DS EXPAND_INFO_TEXT (Similar to help text)
SET @ordinal = 159;
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code,'_',@amName,'_',@pageType,'_',@ordinal,'_',@locale), 'PUSHED_TO_CONFIG', @locale, @ordinal, @pageType, @text, NULL, NULL, @customItemSet_PWD FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);


-- 3DS BAD_OTP_TEXT (Similar to regular one)
SET @ordinal = 160;
SET @text = 'Das eingegebene Passwort oder Eingabe-Code ist nicht korrekt. Bitte versuchen Sie es erneut.';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code,'_',@amName,'_',@pageType,'_',@ordinal,'_',@locale), 'PUSHED_TO_CONFIG', @locale, @ordinal, @pageType, @text, NULL, NULL, @customItemSet_PWD FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);

-- 3DS WHITELISTING_INFO_TEXT (Some text for whitelist cases)
SET @ordinal = 161;
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code,'_',@amName,'_',@pageType,'_',@ordinal,'_',@locale), 'PUSHED_TO_CONFIG', @locale, @ordinal, @pageType, @text, NULL, NULL, @customItemSet_PWD FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);

-- 3DS CHALLENGE_ADDITIONAL_INFO (More text provided)
SET @ordinal = 162;
SET @text = '';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
SELECT 'T', @username, NOW(), NULL, NULL, NULL, CONCAT(n.code,'_',@amName,'_',@pageType,'_',@ordinal,'_',@locale), 'PUSHED_TO_CONFIG', @locale, @ordinal, @pageType, @text, NULL, NULL, @customItemSet_PWD FROM `Network` n WHERE  n.id in (@networkVISA, @networkMC);



-- HTML --

set @issuerCode = '19550';
set @customPageLayoutDesc_appView = 'PASSWORD_App_View (LBBW)';
set @pageType_appView = 'PASSWORD_APP_VIEW';

insert into CustomPageLayout (controller, pageType, description)
values (null, @pageType_appView, @customPageLayoutDesc_appView);

set @idAppViewPage = (select id from `CustomPageLayout`
                      where `pageType` = @pageType_appView and DESCRIPTION = @customPageLayoutDesc_appView);


insert into `CustomComponent` (`type`, `value`, `fk_id_layout`)
values ('div',
        '<style>
            .acs-container {
                padding: 0em;
            }
            .scrollbar{
                overflow: auto;
            }
            .acs-header {
                margin-bottom: 0.5em;
                margin-top: 0.5em;
                display: flex;
                align-items: center;
            }
            #issuerLogo {
                max-height: 96px;
                max-width: 100%;
            }
            #networkLogo {
                max-height: 96px;
                max-width: 100%;
            }
            div#bankLogoDiv {
                width: 50%;
                float: left;
                height: 100%;
                display: flex;
                align-items: center;
            }
            div#networkLogoDiv {
                width: 50%;
                float: right;
                height: 100%;
                display: flex;
                align-items: center;
                justify-content: flex-end;
            }
            .acs-purchase-context {
                margin-bottom: 2em;
                margin-top: 0.5em;
                min-height: 24.5em;
            }
            .acs-purchase-context button,
            .acs-purchase-context input {
                width: 100%;
                margin-bottom: 0.5em;
                text-transform: uppercase;
            }
            .acs-challengeInfoHeader {
                text-align: center;
                font-weight: bold;
                font-size: 1.15em;
            }
            .acs-challengeInfoText {
                margin-bottom: 0em;
            }
            .acs-footer {
                font-size: 0.9em;
                margin-bottom: 0.5em;
            }
            .acs-footer-icon {
                text-align: right;
            }
            .row {
                margin-right: -15px;
                margin-left: -15px;
            }
            .col-md-12,
            .col-md-10,
            .col-md-6,
            .col-md-2 {
                position: relative;
                min-height: 1px;
                padding-right: 15px;
                padding-left: 15px;
            }
            .col-md-12 {
                width: 100%;
            }
            .col-md-10 {
                width: 83.33333333%;
            }
            .col-md-6 {
                width: 50%;
            }
            .col-md-2 {
                width: 16.66666667%;
            }
            .form-group {
                margin-bottom: 15px;
            }
            .form-control {
                display: block;
                width: 100%;
                height: 34px;
                padding: 6px 12px;
                font-size: 14px;
                line-height: 1.42857143;
                color: #555;
                background-color: #fff;
                background-image: none;
                border: 1px solid #ccc;
                border-radius: 4px;
                -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
                box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
                -webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow ease-in-out .15s;
                -o-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
                transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
            }
            .form-control:focus {
                border-color: #66afe9;
                outline: 0;
                -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075), 0 0 8px rgba(102, 175, 233, .6);
                box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075), 0 0 8px rgba(102, 175, 233, .6);
            }
            .btn {
                display: inline-block;
                padding: 6px 12px;
                margin-bottom: 0;
                font-size: 14px;
                font-weight: normal;
                line-height: 1.42857143;
                text-align: center;
                white-space: nowrap;
                vertical-align: middle;
                -ms-touch-action: manipulation;
                touch-action: manipulation;
                cursor: pointer;
                -webkit-user-select: none;
                -moz-user-select: none;
                -ms-user-select: none;
                user-select: none;
                background-image: none;
                border: 1px solid transparent;
                border-radius: 4px;
            }
            .btn:hover,
            .btn:focus,
            .btn {
                color: #333;
                text-decoration: none;
            }
            .btn-default {
                color: #333;
                background-color: #fff;
                border-color: #ccc;
            }
            .btn-default:focus,
            .btn-default {
                color: #333;
                background-color: #e6e6e6;
                border-color: #8c8c8c;
            }
            .btn-default:hover {
                color: #333;
                background-color: #e6e6e6;
                border-color: #adadad;
            }
            .btn-primary {
                color: #fff;
                background-color: #337ab7;
                border-color: #2e6da4;
            }
            .btn-primary:focus,
            .btn-primary.focus {
                color: #fff;
                background-color: #286090;
                border-color: #122b40;
            }
            .btn-primary:hover {
                color: #fff;
                background-color: #286090;
                border-color: #204d74;
            }
        </style>
        </head>
        <body>
        <div class="acs-container">
            <div class="scrollbar col-md-12">
                <!-- ACS HEADER | Branding zone-->
                <div class="acs-header row branding-zone">
                    <div id="bankLogoDiv" class="col-md-6">
                        <img id="issuerLogo" src="network_means_pageType_251" alt="Issuer image" data-cy="ISSUER_IMAGE"/>
                    </div>
                    <div id="networkLogoDiv" class="col-md-6">
                        <img id="networkLogo" src="network_means_pageType_254" alt="Card network image" data-cy="CARD_NETWORK_IMAGE"/>
                    </div>
                </div>
                <!-- ACS BODY | Challenge/Processing zone -->
                <div class="acs-purchase-context col-md-12 challenge-processing-zone">
                    <div class="row">
                        <div class="acs-challengeInfoHeader col-md-12" data-cy="CHALLENGE_INFO_HEADER">
                            network_means_pageType_151
                        </div>
                        <div class="row">
                            <div class="acs-challengeInfoText col-md-10" id="acs-challenge-info-text" data-cy="CHALLENGE_INFO_TEXT">
                                network_means_pageType_152
                            </div>
                        </div>

                        <div class="col-md-12">
                            <form action="HTTPS://EMV3DS/challenge" method="get" data-cy="CHALLENGE_FORM">
                                <div class="form-group">
                                    <label for="challenge-html-data-entry" data-cy="CHALLENGE_INFO_LABEL">
                                        network_means_pageType_153
                                    </label>
                                    <input id="challenge-html-data-entry" name="submitted-otp-value"
                                           type="text" class="form-control" data-cy="CHALLENGE_HTML_DATA_ENTRY"/>
                                </div>
                                <input type="submit" value="network_means_pageType_154" class="btn btn-primary"
                                       id="challenge-submit" data-cy="CHALLENGE_HTML_DATA_ENTRY_FORM_SUBMIT"/>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <!-- ACS FOOTER | Information zone -->
            <div class="acs-footer col-md-12 information-zone">
                <div class="row">
                    <div class="col-md-10">network_means_pageType_156</div>
                    <div class="acs-footer-icon col-md-2">
                        <a tabindex="0" role="button"
                           data-container="body" data-toggle="popover" data-placement="top"
                           data-trigger="focus" data-content="network_means_pageType_157">
                            <i class="fa fa-plus"></i>
                        </a>
                    </div>
                </div>
            </div>
                </div>', @idAppViewPage);


INSERT INTO CustomPageLayout_ProfileSet (customPageLayout_id, profileSet_id)
select cpl.id, ps.id
from CustomPageLayout cpl, ProfileSet ps
where cpl.description = @customPageLayoutDesc_appView and pageType = @pageType_appView and ps.name = 'PS_LBBW_01';


-- synchronize EWLACSLBBW-180 --

SET @pageType = 'APP_VIEW';

SET @customItemSet_PWD = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_LBBW_PASSWORD_UNIFIED');

SET @ordinal = 152;
update CustomItem set value = 'Bitte geben Sie das von Ihnen vergebene BW-Secure Passwort ein, um den genannten Vorgang zu bestätigen.
                                \n\n Durch die Freigabe bezahlen Sie dem Händler @merchant den Betrag von @amount am @formattedDate. '
where fk_id_customItemSet = @customItemSet_PWD  and pageTypes = @pageType  and ordinal = @ordinal;

SET @ordinal = 157;
update CustomItem set value = 'Ihre Kreditkartenzahlung muss mit Ihrem BW-Secure Passwort sowie der mTAN für 3D-Secure bestätigt werden.
                                \n \n Für Änderungen Ihres Passworts loggen Sie sich im BW-Secure Portal ein: https://sicheres-bezahlen.bw-bank.de/ '
where fk_id_customItemSet = @customItemSet_PWD  and pageTypes = @pageType  and ordinal = @ordinal;

SET @ordinal = 160;
update CustomItem set value = 'Das eingegebene Passwort und/oder die mTAN war(en) nicht korrekt. Bitte prüfen Sie die Eingaben und versuchen Sie es erneut. '
where fk_id_customItemSet = @customItemSet_PWD  and pageTypes = @pageType  and ordinal = @ordinal;


SET @customItemSet_SMS = (SELECT id FROM CustomItemSet WHERE name = 'customitemset_LBBW_OTP_SMS_UNIFIED');

SET @ordinal = 151;
update CustomItem set value = 'BW-Secure mTAN'
where fk_id_customItemSet = @customItemSet_SMS  and pageTypes = @pageType  and ordinal = @ordinal;

SET @ordinal = 152;
update CustomItem set value = 'Zur Bestätigung der Zahlung, haben wir Ihnen eben eine mTAN per SMS gesendet. Bitte geben Sie diese im Feld \"mTAN\" ein'
where fk_id_customItemSet = @customItemSet_SMS  and pageTypes = @pageType  and ordinal = @ordinal;

SET @ordinal = 157;
update CustomItem set value = 'Ihre Kreditkartenzahlung muss aus Sicherheitsgründen mit 3D-Secure bestätigt werden. Dazu erhalten Sie eine mTAN per SMS auf Ihr Mobiltelefon.
                                \n\n Eine neue Mobilfunknummer können Sie im BW-Secure Portal registrieren: https://sicheres-bezahlen.bw-bank.de/'
where fk_id_customItemSet = @customItemSet_SMS  and pageTypes = @pageType  and ordinal = @ordinal;

-- HTML --

set @appViewPageDescription = 'PASSWORD_App_View (LBBW)';
set @pageType = 'PASSWORD_APP_VIEW';

SET @idAppViewPage=(SELECT id FROM `CustomPageLayout` WHERE `pageType`= @pageType and `description` = @appViewPageDescription) ;

UPDATE `CustomComponent` SET `value` = '
<style>
            .acs-container {
                padding: 0em;
            }
            .scrollbar{
                overflow: auto;
            }
            .acs-header {
                margin-bottom: 0.5em;
                margin-top: 0.5em;
                display: flex;
                align-items: center;
            }
            #issuerLogo {
                max-height: 96px;
                max-width: 100%;
            }
            #networkLogo {
                max-height: 96px;
                max-width: 100%;
            }
            div#bankLogoDiv {
                width: 50%;
                float: left;
                height: 100%;
                display: flex;
                align-items: center;
            }
            div#networkLogoDiv {
                width: 50%;
                float: right;
                height: 100%;
                display: flex;
                align-items: center;
                justify-content: flex-end;
            }
            .acs-purchase-context {
                margin-bottom: 2em;
                margin-top: 0.5em;
                min-height: 24.5em;
            }
            .acs-purchase-context button,
            .acs-purchase-context input {
                width: 100%;
                margin-bottom: 0.5em;
                text-transform: uppercase;
            }
            .acs-challengeInfoHeader {
                text-align: center;
                font-weight: bold;
                font-size: 1.15em;
            }
            .acs-challengeInfoText {
                margin-bottom: 0em;
            }
            .acs-footer {
                font-size: 0.9em;
                margin-bottom: 0.5em;
            }
            .acs-footer-icon {
                text-align: right;
            }
            .row {
                margin-right: -15px;
                margin-left: -15px;
            }
            .col-md-12,
            .col-md-10,
            .col-md-6,
            .col-md-2 {
                position: relative;
                min-height: 1px;
                padding-right: 15px;
                padding-left: 15px;
            }
            .col-md-12 {
                width: 100%;
            }
            .col-md-10 {
                width: 83.33333333%;
            }
            .col-md-6 {
                width: 50%;
            }
            .col-md-2 {
                width: 16.66666667%;
            }
            .form-group {
                margin-bottom: 15px;
            }
            .form-control {
                display: block;
                width: 100%;
                height: 34px;
                padding: 6px 12px;
                font-size: 14px;
                line-height: 1.42857143;
                color: #555;
                background-color: #fff;
                background-image: none;
                border: 1px solid #ccc;
                border-radius: 4px;
                -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
                box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
                -webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow ease-in-out .15s;
                -o-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
                transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
            }
            .form-control:focus {
                border-color: #66afe9;
                outline: 0;
                -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075), 0 0 8px rgba(102, 175, 233, .6);
                box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075), 0 0 8px rgba(102, 175, 233, .6);
            }
            .btn {
                display: inline-block;
                padding: 6px 12px;
                margin-bottom: 0;
                font-size: 14px;
                font-weight: normal;
                line-height: 1.42857143;
                text-align: center;
                white-space: nowrap;
                vertical-align: middle;
                -ms-touch-action: manipulation;
                touch-action: manipulation;
                cursor: pointer;
                -webkit-user-select: none;
                -moz-user-select: none;
                -ms-user-select: none;
                user-select: none;
                background-image: none;
                border: 1px solid transparent;
                border-radius: 4px;
            }
            .btn:hover,
            .btn:focus,
            .btn {
                color: #333;
                text-decoration: none;
            }
            .btn-default {
                color: #333;
                background-color: #fff;
                border-color: #ccc;
            }
            .btn-default:focus,
            .btn-default {
                color: #333;
                background-color: #e6e6e6;
                border-color: #8c8c8c;
            }
            .btn-default:hover {
                color: #333;
                background-color: #e6e6e6;
                border-color: #adadad;
            }
            .btn-primary {
                color: #fff;
                background-color: #337ab7;
                border-color: #2e6da4;
            }
            .btn-primary:focus,
            .btn-primary.focus {
                color: #fff;
                background-color: #286090;
                border-color: #122b40;
            }
            .btn-primary:hover {
                color: #fff;
                background-color: #286090;
                border-color: #204d74;
            }

            #show,#content{display:none;}

            [data-tooltip],
            .tooltip {
              position: relative;
              cursor: pointer;
            }

            [data-tooltip]:before,
            [data-tooltip]:after,
            .tooltip:before,
            .tooltip:after {
              position: absolute;
              visibility: hidden;
              -ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=0)";
              filter: progid:DXImageTransform.Microsoft.Alpha(Opacity=0);
              opacity: 0;
              -webkit-transition:
                  opacity 0.2s ease-in-out,
                    visibility 0.2s ease-in-out,
                    -webkit-transform 0.2s cubic-bezier(0.71, 1.7, 0.77, 1.24);
                -moz-transition:
                    opacity 0.2s ease-in-out,
                    visibility 0.2s ease-in-out,
                    -moz-transform 0.2s cubic-bezier(0.71, 1.7, 0.77, 1.24);
                transition:
                    opacity 0.2s ease-in-out,
                    visibility 0.2s ease-in-out,
                    transform 0.2s cubic-bezier(0.71, 1.7, 0.77, 1.24);
              -webkit-transform: translate3d(0, 0, 0);
              -moz-transform:    translate3d(0, 0, 0);
              transform:         translate3d(0, 0, 0);
              pointer-events: none;
            }

            [data-tooltip]:hover:before,
            [data-tooltip]:hover:after,
            [data-tooltip]:focus:before,
            [data-tooltip]:focus:after,
            .tooltip:hover:before,
            .tooltip:hover:after,
            .tooltip:focus:before,
            .tooltip:focus:after {
              visibility: visible;
              -ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=100)";
              filter: progid:DXImageTransform.Microsoft.Alpha(Opacity=100);
              opacity: 1;
            }

            .tooltip:before,
            [data-tooltip]:before {
              z-index: 1001;
              border: 6px solid transparent;
              background: transparent;
              content: "";
            }

            .tooltip:after,
            [data-tooltip]:after {
              z-index: 1001;
              padding: 8px;
              width: 250px;
              border-radius: 4px;
              border: 1px solid #d3d3d3;
              background-color: #fff;
              background-color: #fff;;
              color: #333;
              content: attr(data-tooltip);
              font-family: "Helvetica Neue",Helvetica,Arial,sans-serif;
              font-size: 14px;
                    font-weight: normal;
                    line-height: 1.42857143;
                    vertical-align: middle;
            }


            [data-tooltip]:before,
            [data-tooltip]:after,
            .tooltip:before,
            .tooltip:after,
            .tooltip-top:before,
            .tooltip-top:after {
              bottom: 100%;
              left: 50%;
            }

            [data-tooltip]:before,
            .tooltip:before,
            .tooltip-top:before {
              margin-left: -6px;
              margin-bottom: -12px;
              color: #000;
              border-top-color: #fff;
            }

            [data-tooltip]:after,
            .tooltip:after,
            .tooltip-top:after {
              margin-left: -220px;
            }

            [data-tooltip]:hover:before,
            [data-tooltip]:hover:after,
            [data-tooltip]:focus:before,
            [data-tooltip]:focus:after,
            .tooltip:hover:before,
            .tooltip:hover:after,
            .tooltip:focus:before,
            .tooltip:focus:after,
            .tooltip-top:hover:before,
            .tooltip-top:hover:after,
            .tooltip-top:focus:before,
            .tooltip-top:focus:after {
              -webkit-transform: translateY(-12px);
              -moz-transform:    translateY(-12px);
              transform:         translateY(-12px);
            }
        </style>
        </head>
        <body>
        <div class="acs-container">
            <div class="scrollbar col-md-12">
                <!-- ACS HEADER | Branding zone-->
                <div class="acs-header row branding-zone">
                    <div id="bankLogoDiv" class="col-md-6">
                        <img id="issuerLogo" src="network_means_pageType_251" alt="Issuer image" data-cy="ISSUER_IMAGE"/>
                    </div>
                    <div id="networkLogoDiv" class="col-md-6">
                        <img id="networkLogo" src="network_means_pageType_254" alt="Card network image" data-cy="CARD_NETWORK_IMAGE"/>
                    </div>
                </div>
                <!-- ACS BODY | Challenge/Processing zone -->
                <div class="acs-purchase-context col-md-12 challenge-processing-zone">
                    <div class="row">
                        <div class="acs-challengeInfoHeader col-md-12" data-cy="CHALLENGE_INFO_HEADER">
                            network_means_pageType_151
                        </div>
                        <div class="row">
                            <div class="acs-challengeInfoText col-md-10" id="acs-challenge-info-text" data-cy="CHALLENGE_INFO_TEXT">
                                network_means_pageType_152
                            </div>
                        </div>

                        <div class="col-md-12">
                            <form action="HTTPS://EMV3DS/challenge" method="get" data-cy="CHALLENGE_FORM">
                                <div class="form-group">
                                    <label for="challenge-html-data-entry" data-cy="CHALLENGE_INFO_LABEL">
                                        network_means_pageType_153
                                    </label>
                                    <input id="challenge-html-data-entry" name="submitted-otp-value"
                                           type="text" class="form-control" data-cy="CHALLENGE_HTML_DATA_ENTRY"/>
                                </div>
                                <input type="submit" value="network_means_pageType_154" class="btn btn-primary"
                                       id="challenge-submit" data-cy="CHALLENGE_HTML_DATA_ENTRY_FORM_SUBMIT"/>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <!-- ACS FOOTER | Information zone -->
            <div class="acs-footer col-md-12 information-zone">
                <div class="row">
                    <div class="col-md-10 div-left">network_means_pageType_156</div>
                    <input type=checkbox id="show" class="div-right">
                    <label for="show">
                        <a data-tooltip="network_means_pageType_157">
                            <i class="fa fa-plus"></i>
                        </a>
                    </label>
                    <span id="content">network_means_pageType_157 </span>
                </div>
            </div>
                </div>' where fk_id_layout = @idAppViewPage;
