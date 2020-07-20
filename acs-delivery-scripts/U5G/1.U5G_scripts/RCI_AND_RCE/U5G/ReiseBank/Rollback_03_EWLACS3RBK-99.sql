use U5G_ACS_BO;
set @layoutDesc = 'Message Banner (ReiseBank)';
set @layoutId = (select id
				 from `CustomPageLayout`
				 where `DESCRIPTION` = @layoutDesc);
set @layout = '<div id="messageBanner">
	<span id="info-icon" class="fa fa-info-circle"></span>
	<custom-text id="headingTxt" custom-text-key="$parent.heading"></custom-text>
	<custom-text id="message" custom-text-key="$parent.message"></custom-text>
</div>
<style>
	span#info-icon {
		position:absolute;
		top:15px;
		left:15px;
		float:none;
	}
	@media all and (max-width: 480px) {
		span#info-icon {
			position: absolute;
			font-size: 3em;
			top: 1px;
			left: 5px;
			display: inline-block;
		}
		message-banner .spinner {
			padding-top:10px;
			padding-bottom:10px;
		}
	}
	message-banner .spinner {
		position: relative;
		display:block;
		padding-top:5px;
		padding-bottom:15px;
	}
	#headingTxt {
		font-size : large;
		font-weight : bold;
		width : 80%;
		margin : auto;
		display : block;
		text-align:center;
		padding:4px 1px 1px 1px;
	}
	#message {
		text-align:center;
	}
	#message-container {
		position:relative;
	}
	#optGblPage message-banner div#message-container {
		width:100% ;
		box-shadow: none ;
		-webkit-box-shadow:none;
		position: relative;
	}
	div.message-button {
		padding-top: 0px;
	}
	div#message-content {
		text-align: center;
		background-color: inherit;
		padding-bottom: 5px;
	}
</style>';

update CustomComponent
set value = @layout
where fk_id_layout = @layoutId;

set @layoutDesc = 'Failure Page (ReiseBank)';
set @layoutId = (select id
				 from `CustomPageLayout`
				 where `DESCRIPTION` = @layoutDesc);
set @layout = '<style>
	#pageHeader {
		margin-top: 1em;
		margin-bottom: 1em;
	}
	#issuerLogo,
	#networkLogo {
		max-height: 46px;
		max-width: 100%;
		height: auto;
		padding: 0px;
	}
	#centeredTitle {
		color: rgb(0, 100, 62);
		font-weight: 500;
		display: block;
		font-size: 150%;
		margin-top: 10px;
	}
	#i18n-container {
		width: 100%;
		text-align: center;
		background: #ced8f6;
		padding-bottom: 10px;
	}
	#i18n-inner {
		display: inline-block;
	}
	message-banner {
		display: block;
		width: 100%;
		position: relative;
	}
	.noLeftRightMargin {
		margin-left: 0px;
		margin-right: 0px;
	}
	.noLeftRightPadding {
		padding-left: 0px;
		padding-right: 0px;
	}
	#centerPieceLayout {
		padding: 5px 10px 0px;
		min-height: 200px;
	}
	.paragraph {
		margin: 0px 0px 10px;
		text-align: justify;
	}
	.menu-title {
		color: rgb(0, 100, 62);
	}
	.menu-title span {
		display: block;
		font-size: 18px;
		margin-top: 10px;
		margin-bottom: 10px;
	}
	#validateButton {
		background-color: rgb(255, 255, 255);
		color: rgb(51, 51, 51);
		white-space: normal;
		border-radius: 4px;
		border-color: rgb(204, 204, 204);
	}
	#validateButton button {
		margin-top: 5px;
	}
	button span.fa {
		padding-right: 7px;
	}
	@media screen and (max-width: 480px) {
		div.hideable-text {
			display: none;
		}
	}
	#headerLayout {
		/* border-bottom-color:#85aafd;
		 border-bottom-width:1px;
		 border-bottom-style:solid;*/
	}
	#bottomMenu {
		/* border-top: 5px solid rgb(0, 100, 62); */
		margin-top: 10px;
		text-align: center;
		width: 100%;
		background: #ced8f6;
	}
	#cancelButton, #helpButton {
		color: rgb(51, 51, 51);
		white-space: normal;
		display: inline-block;
		border-width: 1px;
		border-style: solid;
		border-color: rgb(0, 166, 235);
		border-image: initial;
		margin: 10px;
	}
</style>
<div class="container-fluid">
	<div id="headerLayout" class="row">
		<div id="pageHeader" class="text-center col-xs-12">
			<div class="row">
				<div class=" col-xs-4 col-lg-3">
					<custom-image id="issuerLogo"
								  alt-key="''network_means_pageType_1_IMAGE_ALT''"
								  image-key="''network_means_pageType_1_IMAGE_DATA''"
								  straight-mode="false">
					</custom-image>
				</div>
				<div class=" col-xs-4 col-lg-6">
					<div id="centeredTitle">
						<custom-text id="page-title" custom-text-key="''network_means_pageType_20''">
						</custom-text>
					</div>
				</div>
				<div class=" col-xs-4 col-lg-3">
					<custom-image id="networkLogo"
								  alt-key="''network_means_pageType_2_IMAGE_ALT''"
								  image-key="''network_means_pageType_2_IMAGE_DATA''"
								  straight-mode="false">
					</custom-image>
				</div>
			</div>
		</div>
	</div>
	<message-banner back-button="''network_means_pageType_99''"></message-banner>
	<div id="i18n-container">
		<div id="i18n-inner">
			<i18n></i18n>
		</div>
	</div>
	<div id="mainLayout" class="row">
		<div class="noLeftRightMargin">
			<div id="leftMenuLayout" class=" col-xs-12 col-sm-4 col-md-4 col-lg-4">
				<div class="noLeftRightPadding">
					<side-menu menu-title="''network_means_pageType_9''"></side-menu>
				</div>
			</div>
			<div id="centerPieceLayout" class=" col-xs-12 col-sm-8 col-md-8 col-lg-7">
				<div class="paragraph hideable-text">
					<custom-text custom-text-key="''network_means_pageType_1''" id="paragraph1">
					</custom-text>
				</div>
				<div class="paragraph">
					<custom-text custom-text-key="''network_means_pageType_2''" id="paragraph2">
					</custom-text>
				</div>
			</div>
		</div>
	</div>
	<div id="bottomLayout" class="row">
		<div id="bottomMenu">
			<help help-label="''network_means_pageType_41''" id="helpButton"></help>
		</div>
	</div>
</div>';

update CustomComponent
set value = @layout
where fk_id_layout = @layoutId;

set @layoutDesc = 'OTP Form Page (ReiseBank)';
set @layoutId = (select id
				 from `CustomPageLayout`
				 where `DESCRIPTION` = @layoutDesc);
set @layout = '<div class="container-fluid">
	<div id="headerLayout" class="row">
		<div id="pageHeader" class="text-center col-xs-12">
			<div class="row">
				<div class=" col-xs-4 col-lg-3">
					<custom-image id="issuerLogo"
								  alt-key="''network_means_pageType_1_IMAGE_ALT''"
								  image-key="''network_means_pageType_1_IMAGE_DATA''"
								  straight-mode="false">
					</custom-image>
				</div>
				<div class=" col-xs-4 col-lg-6">
					<div id="centeredTitle">
						<custom-text id="page-title" custom-text-key="''network_means_pageType_20''">
						</custom-text>
					</div>
				</div>
				<div class=" col-xs-4 col-lg-3">
					<custom-image id="networkLogo"
								  alt-key="''network_means_pageType_2_IMAGE_ALT''"
								  image-key="''network_means_pageType_2_IMAGE_DATA''"
								  straight-mode="false">
					</custom-image>
				</div>
			</div>
		</div>
	</div>
	<style>
		#pageHeader {
		  margin-top: 1em;
		  margin-bottom: 1em;
		}

		#issuerLogo,
		#networkLogo {
			max-height: 46px;
			max-width: 100%;
			height: auto;
			padding: 0px;
		}

		#centeredTitle {
			color: rgb(0, 100, 62);
			font-weight: 500;
			display: block;
			font-size: 150%;
			margin-top:10px;
		}

		 #i18n-container {
			width: 100%;
			text-align: center;
			background: #CED8F6;
			padding-bottom: 10px;
		}

		#i18n-inner {
		  display:inline-block;
		}
	</style>


	<message-banner back-button="''network_means_pageType_99''"></message-banner>

	<style>
		message-banner {
			display: block;
			width: 100%;
			position: relative;
		}
	</style>

	<div id="i18n-container">
	  <div id="i18n-inner">
		<i18n></i18n>
	  </div>
	</div>

	<div id="mainLayout" class="row">
		<div class="noLeftRightMargin">
			<div id="leftMenuLayout" class=" col-xs-12 col-sm-4 col-md-4 col-lg-4">
				<div class="noLeftRightPadding">
					<side-menu menu-title="''network_means_pageType_9''"></side-menu>
				</div>
			</div>

			<div id="centerPieceLayout" class=" col-xs-12 col-sm-8 col-md-8 col-lg-7">
				<div class="paragraph hideable-text">
					<custom-text custom-text-key="''network_means_pageType_1''" id="paragraph1">
					</custom-text>
					<p>
					<custom-text custom-text-key="''network_means_pageType_2''" id="paragraph2">
					</custom-text>
					</p>
				</div>
				<div class="text-center">
					<otp-form ></otp-form>
					<div class="resendButton">
						<re-send-otp rso-label="''network_means_pageType_4''"></re-send-otp>
					</div>
				</div>
				<div class="text-center">
					<val-button val-label="''network_means_OTP_FORM_PAGE_42''" id="validateButton"></val-button>
				</div>
				<div class="paragraph">
					<custom-text custom-text-key="''network_means_pageType_3''" id="paragraph3">
					</custom-text>
				</div>

			</div>
		</div>
	</div>
	<style>
		.noLeftRightMargin {
			margin-left: 0px;
			margin-right: 0px;
		}
		.noLeftRightPadding {
			padding-left: 0px;
			padding-right: 0px;
		}
		#centerPieceLayout {
			padding: 5px 10px 0px;
			min-height: 200px;
			width:fit-content;
			margin-left:auto;
			margin-right:auto;
		}
		.paragraph {
			margin: 0px 0px 10px;
			text-align: justify;
		}
		.menu-title {
			color: rgb(0, 100, 62);
		}
		.menu-title span {
			display: block;
			font-size: 18px;
			margin-top: 10px;
			margin-bottom: 10px;
		}
		#validateButton {
			background-color: rgb(255, 255, 255);
			color: rgb(51, 51, 51);
			white-space: normal;
			border-radius: 4px;
			border-color: rgb(204, 204, 204);
		}
		#validateButton button {
			margin-top: 5px;
		}
		#validateButton .btn div{
			display:initial;
		}
		button span.fa {
			padding-right: 7px;
		}
		.resendButton {
		position: relative;
		color: #f7f7f7;
		padding-top: 1px;
	}

	.resendButton button {
		border: 0px;
	}
		@media screen and (max-width: 480px){
			div.hideable-text {
				display: none;
			}
		}
	</style>
	<div id="bottomLayout" class="row">
		<div id="bottomMenu" >
			<cancel-button cn-label="''network_means_pageType_40''" id="cancelButton" ></cancel-button>
			<help help-label="''network_means_pageType_41''" id="helpButton" ></help>
		</div>
	</div>
	<style>
	#headerLayout {
	 /* border-bottom-color:#85aafd;
	  border-bottom-width:1px;
	  border-bottom-style:solid;*/
	}

	 @media screen and (max-width: 480px){
			#bottomLayout {
				display: block!important;
			}
		}
		#bottomMenu {
			/* border-top: 5px solid rgb(0, 100, 62); */
			margin-top: 10px;
			text-align: center;
			width: 100%;
			background: #CED8F6;
		}
		#cancelButton, #helpButton {
			color: rgb(51, 51, 51);
			white-space: normal;
			display: inline-block;
			border-width: 1px;
			border-style: solid;
			border-color: rgb(0, 166, 235);
			border-image: initial;
			margin: 10px;
		}
	</style>
</div>';

update CustomComponent
set value = @layout
where fk_id_layout = @layoutId;


set @layoutDesc = 'Refusal Page (ReiseBank)';
set @layoutId = (select id
				 from `CustomPageLayout`
				 where `DESCRIPTION` = @layoutDesc);
set @layout = '<div class="container-fluid">
	<div id="headerLayout" class="row">
		<div id="pageHeader" class="text-center col-xs-12">
			<div class="row">
				<div class=" col-xs-4 col-lg-3">
					<custom-image id="issuerLogo"
								  alt-key="''network_means_pageType_1_IMAGE_ALT''"
								  image-key="''network_means_pageType_1_IMAGE_DATA''"
								  straight-mode="false">
					</custom-image>
				</div>
				<div class=" col-xs-4 col-lg-6">
					<div id="centeredTitle">
						<custom-text id="page-title" custom-text-key="''network_means_pageType_20''">
						</custom-text>
					</div>
				</div>
				<div class=" col-xs-4 col-lg-3">
					<custom-image id="networkLogo"
								  alt-key="''network_means_pageType_2_IMAGE_ALT''"
								  image-key="''network_means_pageType_2_IMAGE_DATA''"
								  straight-mode="false">
					</custom-image>
				</div>
			</div>
		</div>
	</div>
	<style>
		#pageHeader {
		  margin-top: 1em;
		  margin-bottom: 1em;
		}

		#issuerLogo,
		#networkLogo {
			max-height: 46px;
			max-width: 100%;
			height: auto;
			padding: 0px;
		}
		#centeredTitle {
			color: rgb(0, 100, 62);
			font-weight: 500;
			display: block;
			font-size: 150%;
			margin-top:10px;
		}

		#i18n-container {
			width: 100%;
			text-align: center;
			background: #CED8F6;
			padding-bottom: 10px;

		}

		#i18n-inner {
		  display:inline-block;
		}

	 #headerLayout {
	 /* border-bottom-color:#85aafd;
	  border-bottom-width:1px;
	  border-bottom-style:solid;*/
	}
	</style>

	<message-banner back-button="''network_means_pageType_99''"></message-banner>
	<div id="i18n-container">
	  <div id="i18n-inner">
		<i18n></i18n>
	  </div>
	</div>

	<style>
		message-banner {
			display: block;
			width: 100%;
			position: relative;
		}
	</style>

	<div id="mainLayout" class="row">
		<div class="noLeftRightMargin">
			<div id="leftMenuLayout" class=" col-xs-12 col-sm-4 col-md-4 col-lg-4">
				<div class="noLeftRightPadding">
					<side-menu menu-title="''network_means_pageType_9''"></side-menu>

				</div>
			</div>

			<div id="centerPieceLayout" class=" col-xs-12 col-sm-8 col-md-8 col-lg-7">
				<div class="paragraph">
					<custom-text custom-text-key="''network_means_pageType_1''" id="paragraph1">
					</custom-text>
				</div>
				<div class="paragraph">
					<custom-text custom-text-key="''network_means_pageType_2''" id="paragraph2">
					</custom-text>
				</div>

			</div>
		</div>
	</div>
	<style>
		.noLeftRightMargin {
			margin-left: 0px;
			margin-right: 0px;
		}
		.noLeftRightPadding {
			padding-left: 0px;
			padding-right: 0px;
		}
		#centerPieceLayout {
			padding: 5px 10px 0px;
			min-height: 200px;
		}
		.paragraph {
			margin: 0px 0px 10px;
			text-align: justify;
		}
		.menu-title {
			color: rgb(0, 100, 62);
		}
		.menu-title span {
			display: block;
			font-size: 18px;
			margin-top: 10px;
			margin-bottom: 10px;
		}
		#validateButton {
			background-color: rgb(255, 255, 255);
			color: rgb(51, 51, 51);
			white-space: normal;
			border-radius: 4px;
			border-color: rgb(204, 204, 204);
		}
		#validateButton button {
			margin-top: 5px;
		}
		button span.fa {
			padding-right: 7px;
		}

	</style>
	<div id="bottomLayout" class="row">
		<div id="bottomMenu" >
			<cancel-button cn-label="''network_means_pageType_40''" id="cancelButton" ></cancel-button>
			<help help-label="''network_means_pageType_41''" id="helpButton" ></help>
		</div>
	</div>
	<style>
		#bottomMenu {
			/* border-top: 5px solid rgb(0, 100, 62); */
			margin-top: 10px;
			text-align: center;
			width: 100%;
			background: #CED8F6;
		}
		#cancelButton, #helpButton {
			color: rgb(51, 51, 51);
			white-space: normal;
			display: inline-block;
			border-width: 1px;
			border-style: solid;
			border-color: rgb(0, 166, 235);
			border-image: initial;
			margin: 10px;
		}
	</style>
</div>';

update CustomComponent
set value = @layout
where fk_id_layout = @layoutId;