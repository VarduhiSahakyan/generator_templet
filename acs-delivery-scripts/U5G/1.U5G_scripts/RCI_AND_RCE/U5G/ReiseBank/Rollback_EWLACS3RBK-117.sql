USE U5G_ACS_BO;
set @customPageLayoutDesc_appView = 'TA_App_View (REISEBANK)';
set @pageType = 'MOBILE_APP_APP_VIEW';

set @idAppViewPage = (select id
					  from `CustomPageLayout`
					  where `pageType` = @pageType
						and DESCRIPTION = @customPageLayoutDesc_appView);

UPDATE `CustomComponent`
SET `value` = '<style>
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
		width: 100%;
		margin-bottom: 0.5em;
	}
	.acs-challengeInfoHeader {
		text-align: center;
		font-weight: bold;
		font-size: 1.15em;
		margin-bottom: 1.1em;
	}
	.acs-challengeInfoText {
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
		-moz-transform:	 translate3d(0, 0, 0);
		transform:		 translate3d(0, 0, 0);
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
	  margin-left: -235px;
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
		-moz-transform:	 translateY(-12px);
		transform:		 translateY(-12px);
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
					<div class="col-md-10">network_means_pageType_156</div>
					<div class="acs-footer-icon col-md-2">
						<input type=checkbox id="show" class="div-right">
			<label for="show"><a data-tooltip="network_means_pageType_157"><i class="fa fa-plus"></i></a></label>
			<span id="content">network_means_pageType_157 </span>
					</div>
				</div>
			</div>
		</div>'
WHERE `fk_id_layout` = @idAppViewPage;


set @customPageLayoutDesc_appView = 'SMS_App_View (Reise)';
set @pageType = 'OTP_SMS_APP_VIEW';

set @idAppViewPage = (select id
					  from `CustomPageLayout`
					  where `pageType` = @pageType
						and DESCRIPTION = @customPageLayoutDesc_appView);

UPDATE `CustomComponent`
SET `value` = '<style>
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
		width: 100%;
		margin-bottom: 0.5em;
	}
	.acs-challengeInfoHeader {
		text-align: center;
		font-weight: bold;
		font-size: 1.15em;
		margin-bottom: 1.1em;
	}
	.acs-challengeInfoText {
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
		-moz-transform:	 translate3d(0, 0, 0);
		transform:		 translate3d(0, 0, 0);
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
		font-size: 0.95em;
		font-weight: normal;
		line-height: 1.42857143;
		vertical-align: middle;
		text-align:start;
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
		margin-left: -235px;
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
		-moz-transform:	 translateY(-12px);
		transform:		 translateY(-12px);
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
							<form action="HTTPS://EMV3DS/challenge" method="get" id="challenge-resend-form">
								<div>
									<!-- The name and value attribute MUST NOT be changed -->
									<input type="hidden" name="challenge-resend" value="Y"/>
									<input type="submit" id="challenge-resend-submit" value="network_means_pageType_155"/>
								</div>
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
						<input type=checkbox id="show" class="div-right">
							<label for="show"><a data-tooltip="network_means_pageType_157">
							<i class="fa fa-plus"></i></a></label>
							<span id="content">network_means_pageType_157 </span>
					</div>
				</div>
			</div>
		</div>'
WHERE `fk_id_layout` = @idAppViewPage;