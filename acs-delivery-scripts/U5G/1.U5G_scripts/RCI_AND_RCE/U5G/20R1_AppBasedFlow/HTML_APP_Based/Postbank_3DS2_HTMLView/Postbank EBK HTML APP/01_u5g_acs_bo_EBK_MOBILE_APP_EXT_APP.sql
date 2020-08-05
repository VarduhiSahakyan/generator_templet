USE `U5G_ACS_BO`;

INSERT INTO CustomPageLayout (controller, pageType, description) VALUES
( NULL, 'MOBILE_APP_EXT_APP_VIEW', 'MOBILE_APP_EXT_App_View (EBK)');

SET @ProfileSet = (SELECT id FROM `ProfileSet` WHERE `name` ='PS_18501_PB_01');

SET @idAppViewPage=(SELECT id FROM `CustomPageLayout` WHERE `pageType`= 'MOBILE_APP_EXT_APP_VIEW' and DESCRIPTION = 'MOBILE_APP_EXT_App_View (EBK)') ;

INSERT INTO `CustomComponent` (`type`, `value`, `fk_id_layout`)
  VALUES( 'div',
 '<style>
			.acs-container {
				padding: 0.5em;
			}
			.acs-header {
				margin-bottom: 0.5em;
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
				white-space: normal;
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
				<div class="col-md-6">
					<img src="network_means_pageType_251" alt="Issuer image" data-cy="ISSUER_IMAGE"/>
				</div>
				<div class="col-md-6">
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
							<input type="submit" value="network_means_pageType_165" class="btn btn-primary"
								   id="challenge-oob-continue-submit" data-cy="CHALLENGE_OOB_CONTINUE_FORM_SUBMIT"/>
						</form>
					</div>
				</div>
			</div>
			<!-- ACS FOOTER | Information zone -->
			<div class="acs-footer col-md-12 information-zone">
				<div class="row">
					<div class="acs-footer-icon col-md-2">
						<a tabindex="0" role="button"
						   data-container="body" data-toggle="popover" data-placement="top"
						   data-trigger="focus" data-content="network_means_pageType_157">
							<i class="fa fa-plus"></i>
						</a>
					</div>
				</div>
			</div>
		</div>
  ', @idAppViewPage);

INSERT INTO CustomPageLayout_ProfileSet (customPageLayout_id, profileSet_id)
select cpl.id, ps.id
  from CustomPageLayout cpl, ProfileSet ps
    where cpl.description = 'MOBILE_APP_EXT_App_View (EBK)' and pageType ='MOBILE_APP_EXT_APP_VIEW'and ps.name = 'PS_18501_PB_01';
