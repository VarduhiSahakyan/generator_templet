use `U7G_ACS_BO`;
set @issuerCode = '23000';
set @customPageLayoutDesc_appView = 'App_View OTP_SMS (UBS)';
set @pageType = 'OTP_SMS_EXT_MESSAGE_APP_VIEW';

insert into CustomPageLayout (controller, pageType, description)
values (null, @pageType, @customPageLayoutDesc_appView);

set @idAppViewPage = (select id
					  from `CustomPageLayout`
					  where `pageType` = @pageType
						and DESCRIPTION = @customPageLayoutDesc_appView);

insert into `CustomComponent` (`type`, `value`, `fk_id_layout`)
values ('div',
'<style>
	.acs-container {
		padding: 0.5em;
	}
	.acs-header {
		margin-bottom: 0.5em;
	}
    div#bankLogoDiv {
        width: 50%;
        float: left;
        height: 100%;
        display: flex;
        align-items: center;
    }
	#issuerLogo {
        max-height: 96px;
        max-width: 100%;
	}
    div#networkLogoDiv {
        width: 50%;
        float: right;
        padding-right: 16px;
        height: 100%;
        display: flex;
        align-items: center;
        justify-content: flex-end;
    }
	#networkLogo {
        max-height: 96px;
        max-width: 100%;
	}
	.acs-purchase-context {
		margin-bottom: 2em;
		margin-top: 0.5em;
		height: 24.5em;
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
		margin-bottom: 1.1em;
	}
	.acs-challengeInfoText {
		white-space: pre-line;
		margin-bottom: 2em;
	}
	.acs-footer {
		font-size: 0.9em;
		margin-top: 15px;
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
<div class="acs-container col-md-12">
	<!-- ACS HEADER | Branding zone-->
	<div class="acs-header row branding-zone">
		<div id="bankLogoDiv" class="col-md-6">
			<img src="network_means_pageType_251" id = "issuerLogo" alt="Issuer image" data-cy="ISSUER_IMAGE"/>
		</div>
		<div id="networkLogoDiv" class="col-md-6">
			<img src="network_means_pageType_254" id = "networkLogo" alt="Card network image" data-cy="CARD_NETWORK_IMAGE"/>
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
				<form action="HTTPS://EMV3DS/challenge" id="challenge-resend-form" method="get">
					<div>
						<!-- The name and value attribute MUST NOT be changed -->
						<input name="challenge-resend" type="hidden" value="Y"/>
						<input id="challenge-resend-submit" type="submit" value="network_means_pageType_155" class="btn btn-default" data-cy="CHALLENGE_RESEND_FORM_SUBMIT"/>
					</div>
				</form>
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

insert into CustomPageLayout_ProfileSet (customPageLayout_id, profileSet_id)
select cpl.id, profileSetIDs.id
from CustomPageLayout cpl,
	 (select ProfileSet.id
	  from `ProfileSet`,
		   (select SubIssuer.id
			from `SubIssuer`,
				 (select Issuer.`id`
				  from `Issuer`
				  where `code` = @issuerCode) as issuer
			where `fk_id_issuer` = issuer.id) as subissuers
	  where fk_id_subIssuer = subissuers.id) as profileSetIDs
where cpl.description = @customPageLayoutDesc_appView
