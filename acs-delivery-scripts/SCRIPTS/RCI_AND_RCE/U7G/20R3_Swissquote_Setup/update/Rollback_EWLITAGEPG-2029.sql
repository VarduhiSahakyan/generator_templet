USE `U7G_ACS_BO`;

SET @createdBy = 'A758582';
SET @BankB = 'SWISSQUOTE';
SET @BankUB = 'SQB';

SET @id_layout = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Help Page (', @BankB, ')%') );

UPDATE `CustomComponent` SET `value` = '<style>
        help-page {
                font-family:"Helvetica Neue",Helvetica,Arial,sans-serif;
                font-size:14px;
                padding:14px;
                overflow:auto;
                text-align:left;
        }
        #help-contents {
                text-align:left;
                margin-top:20px;
                margin-bottom:20px;
        }
        #help-container #help-modal {
                overflow:hidden;
        }
        #helpCloseButton button {
                display: flex;
                align-items: center;
                margin-left: auto;
                margin-right: auto;
                justify-content: center;
        }
        #helpCloseButton button custom-text {
                vertical-align:0px;
        }

        @media screen and (max-width: 700px) and (min-width: 361px) {
                #helpCloseButton > button {		}
        }
        @media screen and (max-width: 360px) {
                #helpCloseButton > button {		}
        }
        @media only screen and (max-width: 480px) {
                div#message-container {width:100%;box-shadow: none;-webkit-box-shadow:none;}
        }
</style>
<div id="help-page">
	<div id="help-contents">
		<p><custom-text custom-text-key="''network_means_HELP_PAGE_1''"></custom-text></p>
		<p><custom-text custom-text-key="''network_means_HELP_PAGE_2''"></custom-text>
        <custom-text custom-text-key="''network_means_HELP_PAGE_3''"></custom-text></p>

	</div>
	<div class="row">
		<div class="col-xs-12" style="text-align:center">
			<help-close-button help-close-label="''network_means_HELP_PAGE_174''" id="helpCloseButton" help-label="help"></help-close-button>
		</div>
	</div>
</div>' WHERE `fk_id_layout` = @id_layout;

SET @customItemSetSMS = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_SMS'));
SET @currentPageType = 'OTP_FORM_PAGE';
SET @locale = 'de';
SET @text = 'Neuen Authentifizierungscode anfordern';
UPDATE `CustomItem` SET value = @text WHERE `ordinal` = 19
										AND pageTypes = @currentPageType
										AND locale = @locale
										AND `fk_id_customItemSet` = @customItemSetSMS;

SET @locale = 'en';
SET @text = 'Request new authentication code';
UPDATE `CustomItem` SET value = @text WHERE `ordinal` = 19
										AND pageTypes = @currentPageType
										AND locale = @locale
										AND `fk_id_customItemSet` = @customItemSetSMS;

SET @locale = 'fr';
SET @text = 'Demander un nouveau code d‘authentification';
UPDATE `CustomItem` SET value = @text WHERE `ordinal` = 19
										AND pageTypes = @currentPageType
										AND locale = @locale
										AND `fk_id_customItemSet` = @customItemSetSMS;

SET @locale = 'it';
SET @text = 'Richiedere un nuovo codice di autenticazione';
UPDATE `CustomItem` SET value = @text WHERE `ordinal` = 19
										AND pageTypes = @currentPageType
										AND locale = @locale
										AND `fk_id_customItemSet` = @customItemSetSMS;