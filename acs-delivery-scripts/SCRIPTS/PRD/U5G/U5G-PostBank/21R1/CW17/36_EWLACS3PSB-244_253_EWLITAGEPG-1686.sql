USE U5G_ACS_BO;

#PSB-224
SET @createdBy = 'A757435';
SET @cisSMSChoice = (SELECT `id` FROM `CustomItemSet` where name = 'customitemset_18502_PB_SMS_Choice');
SET @cisSMSnormal = (SELECT `id` FROM `CustomItemSet` where name = 'customitemset_18502_PB_SMS');
SET @cisTAChoice = (SELECT `id` FROM `CustomItemSet` where name = 'customitemset_18502_PB_TA_Choice');
SET @cisTAnormal = (SELECT `id` FROM `CustomItemSet` where name = 'customitemset_18502_PB_TA');
SET @cisTAChoice_18501 = (SELECT `id` FROM `CustomItemSet` where name = 'customitemset_18501_PB_MOBILE_APP_Choice');
SET @cisTAnormal_18501 = (SELECT `id` FROM `CustomItemSet` where name = 'customitemset_18501_PB_MOBILE_APP');
SET @cisSMSChoice_18501 = (SELECT `id` FROM `CustomItemSet` where name = 'customitemset_18501_PB_SMS_Choice');
SET @cisSMSnormal_18501 = (SELECT `id` FROM `CustomItemSet` where name = 'customitemset_18501_PB_SMS');
SET @cisUndefined_18501 = (SELECT `id` FROM `CustomItemSet` where name = 'customitemset_18501_PB_UNDEFINED');
SET @pageTypeAppView = 'APP_VIEW';
SET @pageTypeAppViewDeviceSelect = 'APP_VIEW_DEVICE_SELECT';
SET @pageTypeAppViewMeansSelect = 'APP_VIEW_DEVICE_SELECT';

SET @ordinal = 156;
SET @text = 'Hilfe';
/*UPDATE `CustomItem` SET `value` = @text WHERE `fk_id_customItemSet` = @cisSMSChoice AND
												`pageTypes` = @pageTypeAppView AND
												`ordinal` = @ordinal;

UPDATE `CustomItem` SET `value` = @text WHERE `fk_id_customItemSet` = @cisSMSnormal AND
												`pageTypes` = @pageTypeAppView AND
												`ordinal` = @ordinal;

UPDATE `CustomItem` SET `value` = @text WHERE `fk_id_customItemSet` = @cisTAChoice AND
												`pageTypes` = @pageTypeAppView AND
												`ordinal` = @ordinal;

UPDATE `CustomItem` SET `value` = @text WHERE `fk_id_customItemSet` = @cisTAnormal AND
												`pageTypes` = @pageTypeAppView AND
												`ordinal` = @ordinal;

UPDATE `CustomItem` SET `value` = @text WHERE `fk_id_customItemSet` = @cisTAChoice_18501 AND
												`pageTypes` = @pageTypeAppView AND
												`ordinal` = @ordinal;

UPDATE `CustomItem` SET `value` = @text WHERE `fk_id_customItemSet` = @cisTAnormal_18501 AND
												`pageTypes` = @pageTypeAppView AND
												`ordinal` = @ordinal;*/

UPDATE `CustomItem` SET `value` = @text WHERE `fk_id_customItemSet` in (@cisSMSChoice,
                                                                       @cisSMSnormal,
                                                                       @cisTAChoice,
                                                                       @cisTAnormal,
                                                                        @cisTAChoice_18501,
                                                                        @cisTAnormal_18501,
                                                                        @cisSMSChoice_18501,
                                                                        @cisSMSnormal_18501,
                                                                        @cisUndefined_18501) AND
                                              `pageTypes` like CONCAT('%', @pageTypeAppView, '%') AND
                                              `ordinal` = @ordinal;

#GEPG-1686
SET @text = 'Fortsetzen nach der Freigabe über BestSign';
SET @pageTypeAppView = 'APP_VIEW';
UPDATE `CustomItem` SET `value` = @text WHERE pageTypes = @pageTypeAppView AND
                                              fk_id_customItemSet = @cisTAChoice_18501 AND
                                              `ordinal` = 165;


SET @text = 'Fortsetzen nach der Freigabe über BestSign';
SET @pageTypeAppView = 'APP_VIEW';
UPDATE `CustomItem` SET `value` = @text WHERE pageTypes = @pageTypeAppView AND
                                              fk_id_customItemSet = @cisTAChoice AND
                                              `ordinal` = 165;

SET @text = 'Fortsetzen nach der Freigabe über BestSign';
SET @pageTypeAppView = 'APP_VIEW';
UPDATE `CustomItem` SET `value` = @text WHERE pageTypes = @pageTypeAppView AND
                                              fk_id_customItemSet = @cisTAnormal AND
                                              `ordinal` = 165;



SET @ordinal = 153;
SET @cisKBA = (SELECT `id` FROM `CustomItemSet` where name = 'customitemset_18501_PB_LOGIN');

UPDATE `CustomItem` SET `value` = 'Passwort zur Postbank-ID:' WHERE `fk_id_customItemSet` = @cisKBA AND
		`pageTypes` = @pageTypeAppView AND
		`ordinal` = @ordinal;


SET @pageTypeAppView = 'APP_VIEW_DEVICE_SELECT';
SET @cisSMSChoice_18501 = (SELECT `id` FROM `CustomItemSet` where name = 'customitemset_18501_PB_SMS_Choice');
SET @cisSMSnormal_18501 = (SELECT `id` FROM `CustomItemSet` where name = 'customitemset_18501_PB_SMS');

SET @ordinal = 152;
SET @text = 'Abrechnungskonto : @pam \nHändler : @merchant \nBetrag : @amount \nDatum : @formattedDate \nKartennummer : @displayedPan';
UPDATE `CustomItem` SET `value` = @text WHERE `fk_id_customItemSet` = @cisTAChoice_18501 AND
		`pageTypes` = @pageTypeAppView AND
		`ordinal` = @ordinal;

UPDATE `CustomItem` SET `value` = @text WHERE `fk_id_customItemSet` = @cisTAnormal_18501 AND
		`pageTypes` = @pageTypeAppView AND
		`ordinal` = @ordinal;

UPDATE `CustomItem` SET `value` = @text WHERE `fk_id_customItemSet` = @cisSMSChoice_18501 AND
		`pageTypes` = @pageTypeAppView AND
		`ordinal` = @ordinal;

UPDATE `CustomItem` SET `value` = @text WHERE `fk_id_customItemSet` = @cisSMSnormal_18501 AND
		`pageTypes` = @pageTypeAppView AND
		`ordinal` = @ordinal;


SET @ordinal = 153;
SET @text = 'Bitte wählen Sie Ihr gewünschtes Gerät aus.';
UPDATE `CustomItem` SET `value` = @text WHERE `fk_id_customItemSet` = @cisTAChoice_18501 AND
		`pageTypes` = @pageTypeAppView AND
		`ordinal` = @ordinal;

UPDATE `CustomItem` SET `value` = @text WHERE `fk_id_customItemSet` = @cisTAnormal_18501 AND
		`pageTypes` = @pageTypeAppView AND
		`ordinal` = @ordinal;

UPDATE `CustomItem` SET `value` = @text WHERE `fk_id_customItemSet` = @cisSMSChoice_18501 AND
		`pageTypes` = @pageTypeAppView AND
		`ordinal` = @ordinal;

UPDATE `CustomItem` SET `value` = @text WHERE `fk_id_customItemSet` = @cisSMSnormal_18501 AND
		`pageTypes` = @pageTypeAppView AND
		`ordinal` = @ordinal;

SET @pageTypeAppView = 'APP_VIEW_MEAN_SELECT';
SET @cisUndefined_18501 = (SELECT `id` FROM `CustomItemSet` where name = 'customitemset_18501_PB_UNDEFINED');

SET @ordinal = 152;
SET @text = 'Abrechnungskonto : @pam \nHändler : @merchant \nBetrag : @amount \nDatum : @formattedDate \nKartennummer : @displayedPan';
UPDATE `CustomItem` SET `value` = @text WHERE `fk_id_customItemSet` = @cisUndefined_18501 AND
		`pageTypes` = @pageTypeAppView AND
		`ordinal` = @ordinal;


SET @ordinal = 153;
SET @text = 'Bitte wählen Sie Ihr gewünschtes Gerät aus.';
UPDATE `CustomItem` SET `value` = @text WHERE `fk_id_customItemSet` = @cisUndefined_18501 AND
		`pageTypes` = @pageTypeAppView AND
		`ordinal` = @ordinal;



SET @pageTypeAppView = 'APP_VIEW_MEAN_SELECT';
SET @cisUndefined_18502 = (SELECT `id` FROM `CustomItemSet` where name = 'customitemset_18502_PB_UNDEFINED');

SET @ordinal = 152;
SET @text = 'Damit Sie noch sicherer mit Ihrer Kreditkarte zahlen, haben wir eine zusätzliche Abfrage eingefügt.\n\n Abrechnungskonto : @pam \nHändler : @merchant \nBetrag : @amount \nDatum : @formattedDate \nKartennummer : @displayedPan';
UPDATE `CustomItem` SET `value` = @text WHERE `fk_id_customItemSet` = @cisUndefined_18502 AND
		`pageTypes` = @pageTypeAppView AND
		`ordinal` = @ordinal;


SET @ordinal = 153;
SET @text = 'Bitte wählen Sie Ihr gewünschtes Gerät aus.';
UPDATE `CustomItem` SET `value` = @text WHERE `fk_id_customItemSet` = @cisUndefined_18502 AND
		`pageTypes` = @pageTypeAppView AND
		`ordinal` = @ordinal;


SET @locale = 'de';
SET @cisPWDChoice =(SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_18502_PB_PASSWORD_Choice');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
VALUES
('T' ,@createdBy , NOW() ,NULL ,'MASTERCARD_OTP_SMS_APP_VIEW_MEAN_SELECT_9' ,'PUSHED_TO_CONFIG' ,@locale ,9 ,'APP_VIEW_MEAN_SELECT' ,'mobileTAN' ,NULL , NULL ,@cisPWDChoice);



SET @BankB = 'FBK';

SET @pageTypeAppView = 'UNDEFINED_APP_VIEW_MEAN_SELECT';
SET @appViewPageDescription = CONCAT('Choice_App_View (', @BankB ,')');
SET @idAppViewPage=(SELECT id FROM `CustomPageLayout` WHERE `pageType`= @pageTypeAppView and `description` = @appViewPageDescription);

UPDATE `CustomComponent` SET `value` = '
<style>
 .acs-container {
	 padding: 0em;
}
 .scrollbar{
	 overflow: auto;
}
 .acs-header {
	 display: flex;
	 align-items: center;
	 margin-bottom: 0.5em;
	 margin-top: 0.5em;
}
 .card-logo-container {
	 text-align: right;
}
 .acs-purchase-context {
	 margin-bottom: 2em;
	 margin-top: 0.5em;
	 height: 24.5em;
}
 .acs-purchase-context button{
	 width: 100%;
	 margin-bottom: 0.5em;
	 text-transform: uppercase;
}
 .acs-purchase-context input {
	 margin-bottom: 0.5em;
	 margin-right: 0.5em;
}
 .acs-challengeInfoHeader {
	 text-align: center;
	 font-weight: bold;
	 font-size: 1.15em;
	 margin-bottom: 1.1em;
}
 div.acs-challengeInfoText {
	 width: 90%;
	 margin-bottom: 2em;
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
 .col-md-12, .col-md-10, .col-md-6, .col-md-2 {
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
	 -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, .6);
	 box-shadow: inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, .6);
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
 .btn:hover, .btn:focus, .btn {
	 color: #333;
	 text-decoration: none;
}
 .btn-default {
	 color: #333;
	 background-color: #fff;
	 border-color: #ccc;
}
 .btn-default:focus, .btn-default {
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
 .btn-primary:focus, .btn-primary.focus {
	 color: #fff;
	 background-color: #286090;
	 border-color: #122b40;
}
 .btn-primary:hover {
	 color: #fff;
	 background-color: #286090;
	 border-color: #204d74;
}
 #show,#content{
	 display:none;
}
 [data-tooltip], .tooltip {
	 position: relative;
	 cursor: pointer;
}
 [data-tooltip]:before, [data-tooltip]:after, .tooltip:before, .tooltip:after {
	 position: absolute;
	 visibility: hidden;
	 -ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=0)";
	 filter: progid:DXImageTransform.Microsoft.Alpha(Opacity=0);
	 opacity: 0;
	 -webkit-transition: opacity 0.2s ease-in-out, visibility 0.2s ease-in-out, -webkit-transform 0.2s cubic-bezier(0.71, 1.7, 0.77, 1.24);
	 -moz-transition: opacity 0.2s ease-in-out, visibility 0.2s ease-in-out, -moz-transform 0.2s cubic-bezier(0.71, 1.7, 0.77, 1.24);
	 transition: opacity 0.2s ease-in-out, visibility 0.2s ease-in-out, transform 0.2s cubic-bezier(0.71, 1.7, 0.77, 1.24);
	 -webkit-transform: translate3d(0, 0, 0);
	 -moz-transform: translate3d(0, 0, 0);
	 transform: translate3d(0, 0, 0);
	 pointer-events: none;
}
 [data-tooltip]:hover:before, [data-tooltip]:hover:after, [data-tooltip]:focus:before, [data-tooltip]:focus:after, .tooltip:hover:before, .tooltip:hover:after, .tooltip:focus:before, .tooltip:focus:after {
	 visibility: visible;
	 -ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=100)";
	 filter: progid:DXImageTransform.Microsoft.Alpha(Opacity=100);
	 opacity: 1;
}
 .tooltip:before, [data-tooltip]:before {
	 z-index: 1001;
	 border: 6px solid transparent;
	 background: transparent;
	 content: "";
}
 .tooltip:after, [data-tooltip]:after {
	 z-index: 1001;
	 padding: 8px;
	 width: 250px;
	 border-radius: 4px;
	 border: 1px solid #d3d3d3;
	 background-color: #fff;
	 background-color: #fff;
	 ;
	 color: #333;
	 content: attr(data-tooltip);
	 font-size: 0.95em;
	 font-weight: normal;
	 line-height: 1.42857143;
	 vertical-align: middle;
	 text-align:start;
}
 [data-tooltip]:before, [data-tooltip]:after, .tooltip:before, .tooltip:after, .tooltip-top:before, .tooltip-top:after {
	 bottom: 100%;
	 left: 50%;
}
 [data-tooltip]:before, .tooltip:before, .tooltip-top:before {
	 margin-left: -6px;
	 margin-bottom: -12px;
	 color: #000;
	 border-top-color: #fff;
}
 [data-tooltip]:after, .tooltip:after, .tooltip-top:after {
	 margin-left: -235px;
}
 [data-tooltip]:hover:before, [data-tooltip]:hover:after, [data-tooltip]:focus:before, [data-tooltip]:focus:after, .tooltip:hover:before, .tooltip:hover:after, .tooltip:focus:before, .tooltip:focus:after, .tooltip-top:hover:before, .tooltip-top:hover:after, .tooltip-top:focus:before, .tooltip-top:focus:after {
	 -webkit-transform: translateY(-12px);
	 -moz-transform: translateY(-12px);
	 transform: translateY(-12px);
}
</style>
</head>
<body>
<div class="acs-container">
	<div class="scrollbar col-md-12">
		<!-- ACS HEADER | Branding zone-->
		<div class="acs-header row branding-zone">
			<div class="col-md-6">
				<img src="network_means_pageType_251" id="issuer-image" alt="Issuer image" data-cy="ISSUER_IMAGE" />
			</div>
			<div class="col-md-6 card-logo-container">
				<img src="network_means_pageType_254" id="payment-system-image" alt="Card network image" data-cy="CARD_NETWORK_IMAGE" />
			</div>
		</div>
		<!-- ACS BODY | Challenge/Processing zone -->
		<div class="acs-purchase-context col-md-12 challenge-processing-zone">
			<div class="row">
				<div class="acs-challengeInfoHeader col-md-12" id="acs-challenge-info-header" data-cy="CHALLENGE_INFO_HEADER">
							network_means_pageType_151
						</div>
				<div class="row">
					<div class="acs-challengeInfoText col-md-10" id="acs-challenge-info-text" data-cy="CHALLENGE_INFO_TEXT">
								network_means_pageType_152
							</div>
					<div class="col-md-12">
                        <div class="acs-challengeInfoLabel" for="challenge-html-data-entry" data-cy="CHALLENGE_INFO_LABEL">
                            network_means_pageType_153
                        </div>
                    </div>
				</div>
				<div class="col-md-12">
					<!-- DO NOT change the id attribute of the form tag -->
					<form id="select-means-form" action="HTTPS://EMV3DS/challenge" method="get">
						<!-- The list of selectable values will be inserted here by the challenge-app service -->
						<div>
							<!-- The value attribute of the input tag can be set as a customItem -->
							<input type="submit" id="select-means-submit" class="btn btn-primary" value="network_means_pageType_154" data-cy="CHALLENGE_MEANS_SELECT_FORM_SUBMIT"/>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- ACS FOOTER | Information zone -->
	<div class="acs-footer col-md-12 information-zone">
		<div class="row">
			<div class="col-md-10" id="why-info-label" data-cy="WHY_INFO_LABEL">
						network_means_pageType_156
					</div>
			<div class="acs-footer-icon col-md-2" id="why-info-text">
				<input type=checkbox id="show" class="div-right">
					<label for="show">
						<a data-tooltip="network_means_pageType_157">
							<i class="fa fa-plus"></i>
						</a>
					</label>
					<span id="content">network_means_pageType_157 </span>
				</div>
			</div>
		</div>
	</div>' where fk_id_layout = @idAppViewPage;

SET @BankB = 'EBK';

SET @pageTypeAppView = 'UNDEFINED_APP_VIEW_MEAN_SELECT';
SET @appViewPageDescription = CONCAT('Choice_App_View (', @BankB ,')');
SET @idAppViewPage=(SELECT id FROM `CustomPageLayout` WHERE `pageType`= @pageTypeAppView and `description` = @appViewPageDescription);

UPDATE `CustomComponent` SET `value` = '
<style>
 .acs-container {
	 padding: 0em;
}
 .scrollbar{
	 overflow: auto;
}
 .acs-header {
	 display: flex;
	 align-items: center;
	 margin-bottom: 0.5em;
	 margin-top: 0.5em;
}
 .card-logo-container {
	 text-align: right;
}
 .acs-purchase-context {
	 margin-bottom: 2em;
	 margin-top: 0.5em;
	 height: 24.5em;
}
 .acs-purchase-context button{
	 width: 100%;
	 margin-bottom: 0.5em;
	 text-transform: uppercase;
}
 .acs-purchase-context input {
	 margin-bottom: 0.5em;
	 margin-right: 0.5em;
}
 .acs-challengeInfoHeader {
	 text-align: center;
	 font-weight: bold;
	 font-size: 1.15em;
	 margin-bottom: 1.1em;
}
 div.acs-challengeInfoText {
	 width: 90%;
	 margin-bottom: 2em;
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
 .col-md-12, .col-md-10, .col-md-6, .col-md-2 {
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
	 -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, .6);
	 box-shadow: inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, .6);
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
 .btn:hover, .btn:focus, .btn {
	 color: #333;
	 text-decoration: none;
}
 .btn-default {
	 color: #333;
	 background-color: #fff;
	 border-color: #ccc;
}
 .btn-default:focus, .btn-default {
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
 .btn-primary:focus, .btn-primary.focus {
	 color: #fff;
	 background-color: #286090;
	 border-color: #122b40;
}
 .btn-primary:hover {
	 color: #fff;
	 background-color: #286090;
	 border-color: #204d74;
}
 #show,#content{
	 display:none;
}
 [data-tooltip], .tooltip {
	 position: relative;
	 cursor: pointer;
}
 [data-tooltip]:before, [data-tooltip]:after, .tooltip:before, .tooltip:after {
	 position: absolute;
	 visibility: hidden;
	 -ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=0)";
	 filter: progid:DXImageTransform.Microsoft.Alpha(Opacity=0);
	 opacity: 0;
	 -webkit-transition: opacity 0.2s ease-in-out, visibility 0.2s ease-in-out, -webkit-transform 0.2s cubic-bezier(0.71, 1.7, 0.77, 1.24);
	 -moz-transition: opacity 0.2s ease-in-out, visibility 0.2s ease-in-out, -moz-transform 0.2s cubic-bezier(0.71, 1.7, 0.77, 1.24);
	 transition: opacity 0.2s ease-in-out, visibility 0.2s ease-in-out, transform 0.2s cubic-bezier(0.71, 1.7, 0.77, 1.24);
	 -webkit-transform: translate3d(0, 0, 0);
	 -moz-transform: translate3d(0, 0, 0);
	 transform: translate3d(0, 0, 0);
	 pointer-events: none;
}
 [data-tooltip]:hover:before, [data-tooltip]:hover:after, [data-tooltip]:focus:before, [data-tooltip]:focus:after, .tooltip:hover:before, .tooltip:hover:after, .tooltip:focus:before, .tooltip:focus:after {
	 visibility: visible;
	 -ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=100)";
	 filter: progid:DXImageTransform.Microsoft.Alpha(Opacity=100);
	 opacity: 1;
}
 .tooltip:before, [data-tooltip]:before {
	 z-index: 1001;
	 border: 6px solid transparent;
	 background: transparent;
	 content: "";
}
 .tooltip:after, [data-tooltip]:after {
	 z-index: 1001;
	 padding: 8px;
	 width: 250px;
	 border-radius: 4px;
	 border: 1px solid #d3d3d3;
	 background-color: #fff;
	 background-color: #fff;
	 ;
	 color: #333;
	 content: attr(data-tooltip);
	 font-size: 0.95em;
	 font-weight: normal;
	 line-height: 1.42857143;
	 vertical-align: middle;
	 text-align:start;
}
 [data-tooltip]:before, [data-tooltip]:after, .tooltip:before, .tooltip:after, .tooltip-top:before, .tooltip-top:after {
	 bottom: 100%;
	 left: 50%;
}
 [data-tooltip]:before, .tooltip:before, .tooltip-top:before {
	 margin-left: -6px;
	 margin-bottom: -12px;
	 color: #000;
	 border-top-color: #fff;
}
 [data-tooltip]:after, .tooltip:after, .tooltip-top:after {
	 margin-left: -235px;
}
 [data-tooltip]:hover:before, [data-tooltip]:hover:after, [data-tooltip]:focus:before, [data-tooltip]:focus:after, .tooltip:hover:before, .tooltip:hover:after, .tooltip:focus:before, .tooltip:focus:after, .tooltip-top:hover:before, .tooltip-top:hover:after, .tooltip-top:focus:before, .tooltip-top:focus:after {
	 -webkit-transform: translateY(-12px);
	 -moz-transform: translateY(-12px);
	 transform: translateY(-12px);
}
</style>
</head>
<body>
	<div class="acs-container">
	<div class="scrollbar col-md-12">
		<!-- ACS HEADER | Branding zone-->
		<div class="acs-header row branding-zone">
			<div class="col-md-6">
				<img src="network_means_pageType_251" id="issuer-image" alt="Issuer image" data-cy="ISSUER_IMAGE" />
			</div>
			<div class="col-md-6 card-logo-container">
				<img src="network_means_pageType_254" id="payment-system-image" alt="Card network image" data-cy="CARD_NETWORK_IMAGE" />
			</div>
		</div>
		<!-- ACS BODY | Challenge/Processing zone -->
		<div class="acs-purchase-context col-md-12 challenge-processing-zone">
			<div class="row">
				<div class="acs-challengeInfoHeader col-md-12" id="acs-challenge-info-header" data-cy="CHALLENGE_INFO_HEADER">
							network_means_pageType_151
						</div>
				<div class="row">
					<div class="acs-challengeInfoText col-md-10" id="acs-challenge-info-text" data-cy="CHALLENGE_INFO_TEXT">
								network_means_pageType_152
							</div>
					<div class="col-md-12">
                        <div class="acs-challengeInfoLabel" for="challenge-html-data-entry" data-cy="CHALLENGE_INFO_LABEL">
                            network_means_pageType_153
                        </div>
                    </div>
				</div>
				<div class="col-md-12">
					<!-- DO NOT change the id attribute of the form tag -->
					<form id="select-means-form" action="HTTPS://EMV3DS/challenge" method="get">
						<!-- The list of selectable values will be inserted here by the challenge-app service -->
						<div>
							<!-- The value attribute of the input tag can be set as a customItem -->
							<input type="submit" id="select-means-submit" class="btn btn-primary" value="network_means_pageType_154" data-cy="CHALLENGE_MEANS_SELECT_FORM_SUBMIT"/>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- ACS FOOTER | Information zone -->
	<div class="acs-footer col-md-12 information-zone">
		<div class="row">
			<div class="col-md-10" id="why-info-label" data-cy="WHY_INFO_LABEL">
						network_means_pageType_156
					</div>
			<div class="acs-footer-icon col-md-2" id="why-info-text">
				<input type=checkbox id="show" class="div-right">
					<label for="show">
						<a data-tooltip="network_means_pageType_157">
							<i class="fa fa-plus"></i>
						</a>
					</label>
					<span id="content">network_means_pageType_157 </span>
				</div>
			</div>
		</div>
	</div>' where fk_id_layout = @idAppViewPage;


SET @pageTypeAppView = 'MOBILE_APP_EXT_APP_VIEW_DEVICE_SELECT';
SET @appViewPageDescription = CONCAT('MOBILE_APP_EXT_DEVICE_Choice_App_View (', @BankB ,')');
SET @idAppViewPage=(SELECT id FROM `CustomPageLayout` WHERE `pageType`= @pageTypeAppView and `description` = @appViewPageDescription);

UPDATE `CustomComponent` SET `value` = '
<style>
 .acs-container {
	 padding: 0em;
}
 .scrollbar {
	 overflow: auto;
}
 .acs-header {
	 display: flex;
	 align-items: center;
	 margin-bottom: 0.5em;
	 margin-top: 0.5em;
}
 .card-logo-container {
	 text-align: right;
}
 .acs-purchase-context {
	 margin-bottom: 2em;
	 margin-top: 0.5em;
	 height: 24.5em;
}
 .acs-purchase-context button{
	 width: 100%;
	 margin-bottom: 0.5em;
	 text-transform: uppercase;
}
 .acs-purchase-context input {
	 margin-bottom: 0.5em;
	 margin-right: 0.5em;
}
 .acs-challengeInfoHeader {
	 text-align: center;
	 font-weight: bold;
	 font-size: 1.15em;
	 margin-bottom: 1.1em;
}
 div.acs-challengeInfoText {
	 width: 90%;
	 margin-bottom: 2em;
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
 .col-md-12, .col-md-10, .col-md-6, .col-md-2 {
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
	 -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, .6);
	 box-shadow: inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, .6);
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
 .btn:hover, .btn:focus, .btn {
	 color: #333;
	 text-decoration: none;
}
 .btn-default {
	 color: #333;
	 background-color: #fff;
	 border-color: #ccc;
}
 .btn-default:focus, .btn-default {
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
 .btn-primary:focus, .btn-primary.focus {
	 color: #fff;
	 background-color: #286090;
	 border-color: #122b40;
}
 .btn-primary:hover {
	 color: #fff;
	 background-color: #286090;
	 border-color: #204d74;
}
 #show,#content{
	 display:none;
}
 [data-tooltip], .tooltip {
	 position: relative;
	 cursor: pointer;
}
 [data-tooltip]:before, [data-tooltip]:after, .tooltip:before, .tooltip:after {
	 position: absolute;
	 visibility: hidden;
	 -ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=0)";
	 filter: progid:DXImageTransform.Microsoft.Alpha(Opacity=0);
	 opacity: 0;
	 -webkit-transition: opacity 0.2s ease-in-out, visibility 0.2s ease-in-out, -webkit-transform 0.2s cubic-bezier(0.71, 1.7, 0.77, 1.24);
	 -moz-transition: opacity 0.2s ease-in-out, visibility 0.2s ease-in-out, -moz-transform 0.2s cubic-bezier(0.71, 1.7, 0.77, 1.24);
	 transition: opacity 0.2s ease-in-out, visibility 0.2s ease-in-out, transform 0.2s cubic-bezier(0.71, 1.7, 0.77, 1.24);
	 -webkit-transform: translate3d(0, 0, 0);
	 -moz-transform: translate3d(0, 0, 0);
	 transform: translate3d(0, 0, 0);
	 pointer-events: none;
}
 [data-tooltip]:hover:before, [data-tooltip]:hover:after, [data-tooltip]:focus:before, [data-tooltip]:focus:after, .tooltip:hover:before, .tooltip:hover:after, .tooltip:focus:before, .tooltip:focus:after {
	 visibility: visible;
	 -ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=100)";
	 filter: progid:DXImageTransform.Microsoft.Alpha(Opacity=100);
	 opacity: 1;
}
 .tooltip:before, [data-tooltip]:before {
	 z-index: 1001;
	 border: 6px solid transparent;
	 background: transparent;
	 content: "";
}
 .tooltip:after, [data-tooltip]:after {
	 z-index: 1001;
	 padding: 8px;
	 width: 250px;
	 border-radius: 4px;
	 border: 1px solid #d3d3d3;
	 background-color: #fff;
	 background-color: #fff;
	 ;
	 color: #333;
	 content: attr(data-tooltip);
	 font-size: 0.95em;
	 font-weight: normal;
	 line-height: 1.42857143;
	 vertical-align: middle;
	 text-align:start;
}
 [data-tooltip]:before, [data-tooltip]:after, .tooltip:before, .tooltip:after, .tooltip-top:before, .tooltip-top:after {
	 bottom: 100%;
	 left: 50%;
}
 [data-tooltip]:before, .tooltip:before, .tooltip-top:before {
	 margin-left: -6px;
	 margin-bottom: -12px;
	 color: #000;
	 border-top-color: #fff;
}
 [data-tooltip]:after, .tooltip:after, .tooltip-top:after {
	 margin-left: -235px;
}
 [data-tooltip]:hover:before, [data-tooltip]:hover:after, [data-tooltip]:focus:before, [data-tooltip]:focus:after, .tooltip:hover:before, .tooltip:hover:after, .tooltip:focus:before, .tooltip:focus:after, .tooltip-top:hover:before, .tooltip-top:hover:after, .tooltip-top:focus:before, .tooltip-top:focus:after {
	 -webkit-transform: translateY(-12px);
	 -moz-transform: translateY(-12px);
	 transform: translateY(-12px);
}
</style>
</head>
<body>
	<div class="acs-container">
	<div class="scrollbar col-md-12">
		<!-- ACS HEADER | Branding zone-->
		<div class="acs-header row branding-zone">
			<div class="col-md-6">
				<img src="network_means_pageType_251" id="issuer-image" alt="Issuer image" data-cy="ISSUER_IMAGE"/>
			</div>
			<div class="col-md-6 card-logo-container">
				<img src="network_means_pageType_254" id="payment-system-image" alt="Card network image" data-cy="CARD_NETWORK_IMAGE" />
			</div>
		</div>
		<!-- ACS BODY | Challenge/Processing zone -->
		<div class="acs-purchase-context col-md-12 challenge-processing-zone">
			<div class="row">
				<div class="acs-challengeInfoHeader col-md-12" id="acs-challenge-info-header" data-cy="CHALLENGE_INFO_HEADER">
					network_means_pageType_151
				</div>
				<div class="row">
					<div class="acs-challengeInfoText col-md-10" id="acs-challenge-info-text" data-cy="CHALLENGE_INFO_TEXT">
						network_means_pageType_152
					</div>
				</div>
				<div class="col-md-12">
                    <div class="acs-challengeInfoLabel" for="challenge-html-data-entry" data-cy="CHALLENGE_INFO_LABEL">
                        network_means_pageType_153
                    </div>
                </div>
				<div class="col-md-12">
					<!-- DO NOT change the id attribute of the form tag -->
					<form id="select-devices-form" action="HTTPS://EMV3DS/challenge" method="get">
						<!-- The list of selectable values will be inserted here by the challenge-app service -->
						<div>
							<!-- The value attribute of the input tag can be set as a customItem -->
							<input type="submit" id="select-device-submit" class="btn btn-primary" value="network_means_pageType_154" data-cy="CHALLENGE_DEVICE_SELECT_FORM_SUBMIT" />
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- ACS FOOTER | Information zone -->
	<div class="acs-footer col-md-12 information-zone">
		<div class="row">
			<div class="col-md-10" id="why-info-label" data-cy="WHY_INFO_LABEL">
						network_means_pageType_156
					</div>
			<div class="acs-footer-icon col-md-2" id="why-info-text">
				<input type=checkbox id="show" class="div-right">
					<label for="show">
						<a data-tooltip="network_means_pageType_157">
							<i class="fa fa-plus"></i>
						</a>
					</label>
					<span id="content">network_means_pageType_157 </span>
				</div>
			</div>
		</div>
	</div>' where fk_id_layout = @idAppViewPage;

SET @pageTypeAppView = 'OTP_SMS_EXT_MESSAGE_APP_VIEW_DEVICE_SELECT';
SET @appViewPageDescription = CONCAT('SMS_DEVICE_Choice_App_View (', @BankB ,')');
SET @idAppViewPage=(SELECT id FROM `CustomPageLayout` WHERE `pageType`= @pageTypeAppView and `description` = @appViewPageDescription);

UPDATE `CustomComponent` SET `value` = '
<style>
 .acs-container {
	 padding: 0em;
}
 .scrollbar{
	 overflow: auto;
}
 .acs-header {
	 display: flex;
	 align-items: center;
	 margin-bottom: 0.5em;
	 margin-top: 0.5em;
}
 .card-logo-container {
	 text-align: right;
}
 .acs-purchase-context {
	 margin-bottom: 2em;
	 margin-top: 0.5em;
	 height: 24.5em;
}
 .acs-purchase-context button{
	 width: 100%;
	 margin-bottom: 0.5em;
	 text-transform: uppercase;
}
 .acs-purchase-context input {
	 margin-bottom: 0.5em;
	 margin-right: 0.5em;
}
 .acs-challengeInfoHeader {
	 text-align: center;
	 font-weight: bold;
	 font-size: 1.15em;
	 margin-bottom: 1.1em;
}
 div.acs-challengeInfoText {
	 width: 90%;
	 margin-bottom: 2em;
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
 .col-md-12, .col-md-10, .col-md-6, .col-md-2 {
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
	 -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, .6);
	 box-shadow: inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, .6);
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
 .btn:hover, .btn:focus, .btn {
	 color: #333;
	 text-decoration: none;
}
 .btn-default {
	 color: #333;
	 background-color: #fff;
	 border-color: #ccc;
}
 .btn-default:focus, .btn-default {
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
 .btn-primary:focus, .btn-primary.focus {
	 color: #fff;
	 background-color: #286090;
	 border-color: #122b40;
}
 .btn-primary:hover {
	 color: #fff;
	 background-color: #286090;
	 border-color: #204d74;
}
 #show,#content{
	 display:none;
}
 [data-tooltip], .tooltip {
	 position: relative;
	 cursor: pointer;
}
 [data-tooltip]:before, [data-tooltip]:after, .tooltip:before, .tooltip:after {
	 position: absolute;
	 visibility: hidden;
	 -ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=0)";
	 filter: progid:DXImageTransform.Microsoft.Alpha(Opacity=0);
	 opacity: 0;
	 -webkit-transition: opacity 0.2s ease-in-out, visibility 0.2s ease-in-out, -webkit-transform 0.2s cubic-bezier(0.71, 1.7, 0.77, 1.24);
	 -moz-transition: opacity 0.2s ease-in-out, visibility 0.2s ease-in-out, -moz-transform 0.2s cubic-bezier(0.71, 1.7, 0.77, 1.24);
	 transition: opacity 0.2s ease-in-out, visibility 0.2s ease-in-out, transform 0.2s cubic-bezier(0.71, 1.7, 0.77, 1.24);
	 -webkit-transform: translate3d(0, 0, 0);
	 -moz-transform: translate3d(0, 0, 0);
	 transform: translate3d(0, 0, 0);
	 pointer-events: none;
}
 [data-tooltip]:hover:before, [data-tooltip]:hover:after, [data-tooltip]:focus:before, [data-tooltip]:focus:after, .tooltip:hover:before, .tooltip:hover:after, .tooltip:focus:before, .tooltip:focus:after {
	 visibility: visible;
	 -ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=100)";
	 filter: progid:DXImageTransform.Microsoft.Alpha(Opacity=100);
	 opacity: 1;
}
 .tooltip:before, [data-tooltip]:before {
	 z-index: 1001;
	 border: 6px solid transparent;
	 background: transparent;
	 content: "";
}
 .tooltip:after, [data-tooltip]:after {
	 z-index: 1001;
	 padding: 8px;
	 width: 250px;
	 border-radius: 4px;
	 border: 1px solid #d3d3d3;
	 background-color: #fff;
	 background-color: #fff;
	 ;
	 color: #333;
	 content: attr(data-tooltip);
	 font-size: 0.95em;
	 font-weight: normal;
	 line-height: 1.42857143;
	 vertical-align: middle;
	 text-align:start;
}
 [data-tooltip]:before, [data-tooltip]:after, .tooltip:before, .tooltip:after, .tooltip-top:before, .tooltip-top:after {
	 bottom: 100%;
	 left: 50%;
}
 [data-tooltip]:before, .tooltip:before, .tooltip-top:before {
	 margin-left: -6px;
	 margin-bottom: -12px;
	 color: #000;
	 border-top-color: #fff;
}
 [data-tooltip]:after, .tooltip:after, .tooltip-top:after {
	 margin-left: -235px;
}
 [data-tooltip]:hover:before, [data-tooltip]:hover:after, [data-tooltip]:focus:before, [data-tooltip]:focus:after, .tooltip:hover:before, .tooltip:hover:after, .tooltip:focus:before, .tooltip:focus:after, .tooltip-top:hover:before, .tooltip-top:hover:after, .tooltip-top:focus:before, .tooltip-top:focus:after {
	 -webkit-transform: translateY(-12px);
	 -moz-transform: translateY(-12px);
	 transform: translateY(-12px);
}
</style>
</head>
<body>
	<div class="acs-container">
	<div class="scrollbar col-md-12">
		<!-- ACS HEADER | Branding zone-->
		<div class="acs-header row branding-zone">
			<div class="col-md-6">
				<img src="network_means_pageType_251" id="issuer-image" alt="Issuer image" data-cy="ISSUER_IMAGE" />
			</div>
			<div class="col-md-6 card-logo-container">
				<img src="network_means_pageType_254" id="payment-system-image" alt="Card network image" data-cy="CARD_NETWORK_IMAGE" />
			</div>
		</div>
		<!-- ACS BODY | Challenge/Processing zone -->
		<div class="acs-purchase-context col-md-12 challenge-processing-zone">
			<div class="row">
				<div class="acs-challengeInfoHeader col-md-12" id="acs-challenge-info-header" data-cy="CHALLENGE_INFO_HEADER">
							network_means_pageType_151
						</div>
				<div class="row">
					<div class="acs-challengeInfoText col-md-10" id="acs-challenge-info-text" data-cy="CHALLENGE_INFO_TEXT">
								network_means_pageType_152
							</div>
				</div>
                <div class="col-md-12">
                    <div class="acs-challengeInfoLabel" for="challenge-html-data-entry" data-cy="CHALLENGE_INFO_LABEL">
                        network_means_pageType_153
                    </div>
                </div>
				<div class="col-md-12">
					<!-- DO NOT change the id attribute of the form tag -->
					<form id="select-devices-form" action="HTTPS://EMV3DS/challenge" method="get">
						<!-- The list of selectable values will be inserted here by the challenge-app service -->
						<div>
							<!-- The value attribute of the input tag can be set as a customItem -->
							<input type="submit" id="select-device-submit" class="btn btn-primary" value="network_means_pageType_154" data-cy="CHALLENGE_DEVICE_SELECT_FORM_SUBMIT" />
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- ACS FOOTER | Information zone -->
	<div class="acs-footer col-md-12 information-zone">
		<div class="row">
			<div class="col-md-10" id="why-info-label" data-cy="WHY_INFO_LABEL">
						network_means_pageType_156
					</div>
			<div class="acs-footer-icon col-md-2" id="why-info-text">
				<input type=checkbox id="show" class="div-right">
					<label for="show">
						<a data-tooltip="network_means_pageType_157">
							<i class="fa fa-plus"></i>
						</a>
					</label>
					<span id="content">network_means_pageType_157 </span>
				</div>
			</div>
		</div>
	</div>' where fk_id_layout = @idAppViewPage;


SET @pageTypeAppView = 'MOBILE_APP_EXT_APP_VIEW';
SET @appViewPageDescription = CONCAT('MOBILE_APP_EXT_App_View (', @BankB ,')');

SET @idAppViewPage=(SELECT id FROM `CustomPageLayout` WHERE `pageType`= @pageTypeAppView and `description` = @appViewPageDescription);

UPDATE `CustomComponent` SET `value` = '
<style>
 .acs-container {
     padding: 0.5em;
}
 .scrollbar{
     overflow: auto;
}
 .acs-header {
     display: flex;
     align-items: center;
     margin-bottom: 0.5em;
     margin-top: 0.5em;
}
 .card-logo-container {
     text-align: right;
}
 .acs-purchase-context {
     margin-bottom: 2em;
     margin-top: 0.5em;
     height: 24.5em;
}
 .acs-purchase-context button{
     width: 100%;
     margin-bottom: 0.5em;
     text-transform: uppercase;
}
 .acs-purchase-context input {
     width: 100%;
     margin-bottom: 0.5em;
}
 .acs-challengeInfoHeader {
     text-align: center;
     font-weight: bold;
     font-size: 1.15em;
     margin-bottom: 1.1em;
}
img.warn-image {
    vertical-align: middle;
    float: left;
    padding-left: 5px;
}
 div.acs-challengeInfoText {
     width: 90%;
     margin-bottom: 2em;
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
 .col-md-12, .col-md-10, .col-md-6, .col-md-2 {
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
     -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, .6);
     box-shadow: inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, .6);
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
 .btn:hover, .btn:focus, .btn {
     color: #333;
     text-decoration: none;
}
 .btn-default {
     color: #333;
     background-color: #fff;
     border-color: #ccc;
}
 .btn-default:focus, .btn-default {
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
 .btn-primary:focus, .btn-primary.focus {
     color: #fff;
     background-color: #286090;
     border-color: #122b40;
}
 .btn-primary:hover {
     color: #fff;
     background-color: #286090;
     border-color: #204d74;
}
 #show,#content{
     display:none;
}
 [data-tooltip], .tooltip {
     position: relative;
     cursor: pointer;
}
 [data-tooltip]:before, [data-tooltip]:after, .tooltip:before, .tooltip:after {
     position: absolute;
     visibility: hidden;
     -ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=0)";
     filter: progid:DXImageTransform.Microsoft.Alpha(Opacity=0);
     opacity: 0;
     -webkit-transition: opacity 0.2s ease-in-out, visibility 0.2s ease-in-out, -webkit-transform 0.2s cubic-bezier(0.71, 1.7, 0.77, 1.24);
     -moz-transition: opacity 0.2s ease-in-out, visibility 0.2s ease-in-out, -moz-transform 0.2s cubic-bezier(0.71, 1.7, 0.77, 1.24);
     transition: opacity 0.2s ease-in-out, visibility 0.2s ease-in-out, transform 0.2s cubic-bezier(0.71, 1.7, 0.77, 1.24);
     -webkit-transform: translate3d(0, 0, 0);
     -moz-transform: translate3d(0, 0, 0);
     transform: translate3d(0, 0, 0);
     pointer-events: none;
}
 [data-tooltip]:hover:before, [data-tooltip]:hover:after, [data-tooltip]:focus:before, [data-tooltip]:focus:after, .tooltip:hover:before, .tooltip:hover:after, .tooltip:focus:before, .tooltip:focus:after {
     visibility: visible;
     -ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=100)";
     filter: progid:DXImageTransform.Microsoft.Alpha(Opacity=100);
     opacity: 1;
}
 .tooltip:before, [data-tooltip]:before {
     z-index: 1001;
     border: 6px solid transparent;
     background: transparent;
     content: "";
}
 .tooltip:after, [data-tooltip]:after {
     z-index: 1001;
     padding: 8px;
     width: 250px;
     border-radius: 4px;
     border: 1px solid #d3d3d3;
     background-color: #fff;
     background-color: #fff;
     ;
     color: #333;
     content: attr(data-tooltip);
     font-size: 0.95em;
     font-weight: normal;
     line-height: 1.42857143;
     vertical-align: middle;
     text-align:start;
}
 [data-tooltip]:before, [data-tooltip]:after, .tooltip:before, .tooltip:after, .tooltip-top:before, .tooltip-top:after {
     bottom: 100%;
     left: 50%;
}
 [data-tooltip]:before, .tooltip:before, .tooltip-top:before {
     margin-left: -6px;
     margin-bottom: -12px;
     color: #000;
     border-top-color: #fff;
}
 [data-tooltip]:after, .tooltip:after, .tooltip-top:after {
     margin-left: -235px;
}
 [data-tooltip]:hover:before, [data-tooltip]:hover:after, [data-tooltip]:focus:before, [data-tooltip]:focus:after, .tooltip:hover:before, .tooltip:hover:after, .tooltip:focus:before, .tooltip:focus:after, .tooltip-top:hover:before, .tooltip-top:hover:after, .tooltip-top:focus:before, .tooltip-top:focus:after {
     -webkit-transform: translateY(-12px);
     -moz-transform: translateY(-12px);
     transform: translateY(-12px);
}

</style>
</head>
	<body>
		<div class="acs-container">
	<div class="scrollbar col-md-12">
		<!-- ACS HEADER | Branding zone-->
		<div class="acs-header row branding-zone">
			<div class="col-md-6">
				<img src="network_means_pageType_251" alt="Issuer image" data-cy="ISSUER_IMAGE"/>
			</div>
			<div class="col-md-6 card-logo-container">
				<img src="network_means_pageType_254" alt="Card network image" data-cy="CARD_NETWORK_IMAGE"/>
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
					<form action="HTTPS://EMV3DS/challenge" method="get">
						<input type="hidden" name="submitted-oob-continue-value" value="Y">
							<input type="submit" value="network_means_pageType_165" class="btn btn-primary" id="challenge-oob-continue-submit" data-cy="CHALLENGE_OOB_CONTINUE_FORM_SUBMIT"/>
						</form>
					</div>
				</div>
			</div>
		</div>
		<!-- ACS FOOTER | Information zone -->
		<div class="acs-footer col-md-12 information-zone">
			<div class="row">
                <div class="col-md-10" id="why-info-label" data-cy="WHY_INFO_LABEL">
						network_means_pageType_156
					</div>
				<div class="acs-footer-icon col-md-2">
					<input type=checkbox id="show" class="div-right">
						<label for="show">
							<a data-tooltip="network_means_pageType_157">
								<i class="fa fa-plus"></i>
							</a>
						</label>
						<span id="content">network_means_pageType_157 </span>
					</div>
				</div>
			</div>
		</div>
' where fk_id_layout = @idAppViewPage;
