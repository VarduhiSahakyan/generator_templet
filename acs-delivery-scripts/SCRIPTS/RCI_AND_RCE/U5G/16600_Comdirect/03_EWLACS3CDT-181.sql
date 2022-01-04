USE U5G_ACS_BO;

SET @createdBy = 'A758582';

SET @issuerId = (SELECT id FROM Issuer WHERE name = 'Comdirect' AND code = '16600');

SET @pageType = 'OTP_FORM_PAGE';
SET @layoutId = (SELECT id FROM CustomPageLayout WHERE pageType = @pageType AND  description = 'OTP Form Page (Comdirect)');

UPDATE `CustomComponent` SET `value` = '
	<style type="text/css">
	:root {
		font-family: Verdana, Helvetica, sans-serif;
		padding: 0px;
		margin: 0px;
	}
	#main-container {
		width: 480px;
		max-width: 480px;
		margin-left: auto;
		margin-right: auto;
		padding-left: 10px;
		padding-right: 10px;
	}
	#main-container .btn {
		border-radius: 20px;
		border: 0px;
		height: 40px;
	}
	#main-container #header {
		height: 64px;
		position: relative;
	}
	#issuerLogo {
		height: 25px;
		margin-left: 5px;
		margin-top: 1em;
	}
	#networkLogo {
		width: 100px;
		position: absolute;
		right: 1px;
		top: 5px;
		padding-right: 1em;
	}
	#main-container #content {
		text-align: center;
		display: flex;
		flex-direction: column;
	}
	#main-container #footer {
		display: flex;
		width: 100%;
		border-top: 1px solid #000;
		padding-top: 10px;
		justify-content: space-between;
		background-image: none;
	}
	#main-container #cancelButton .btn-default {
		background-color: #f4f4f4;
		align-content: flex-start;
	}
	#main-container #helpButton .btn-default {
		background-color: #f4f4f4;
		align-content: flex-start;
		width: 120px;
	}
	span.fa.fa-info {
		display: none;
	}
	.fa-ban { display: none; }
	#main-container #validateButton .btn-default {
		background-color: #fff500;
		align-content: flex-end;
	}
	#validateButton {
		outline: 0px;
		border: 0px;
		border-radius: 20px;
		height: 40px;
		width: 120px;
		background-color: #fff500;
		margin-right: 10px;
		align-content: flex-end;
		text-align: center;
	}
	.fa-check-square {display: none}
	.fa-ban { display: none; }
	#cancelButton {
		background-color: #f4f4f4;
		border-radius: 20px;
		border: 0px;
		height: 40px;
		width: 120px;
		margin-left: 10px;
		align-content: flex-start;
		text-align: center;
	}
	.splashtext {
		width: 80%;
		margin-left: auto;
		margin-right: auto;
	}
	input {
		border: 1px solid #d1d1d1;
		border-radius: 6px;
		color: #464646;
		height: 20px;
		box-shadow: rgba(0, 0, 0, 0.15) 1px 1px 3px 0 inset;
	}
	#tan_input_ctrl {
		align-items: center;
	}
	.autharea {
		padding-top: 10px;
		padding-bottom: 10px;
	}
	span#tan-label {
		padding-right: 5px;
		padding-left: 5px;
		text-align: center;
		font-weight: 700;
	}
	.otp-field {
		padding-right: 5px;
		padding-left: 5px;
		padding-top: 10px;
		text-align: center;
	}
	@media (max-width: 560px) {
		.transactiondetails ul li { text-align: left;}
		.transactiondetails ul li label { display: block; float: left; width: 50%; text-align: right; font-size: 14px; color: #909090; margin-right: 0.5em;}
		.transactiondetails ul li span.value { clear: both; text-align: left; margin-left: 0.5em; }
		.otp-field { display: block;}
		.contact { width: 100%; order: 1; }
		#footer .small-font { font-size: 0.75em;}
	}
	@media all and (max-width: 391px) {
		#main-container #header { position: inherit;}
		div#message-container { width: 370px;}
		#main-container #content { width: 380px;}
		#main-container #footer {display: inherit;}
		.otp-field { display: block;}
		#footer .small-font { font-size: 0.75em;}
		#cancelButton { margin-right: 20px;}
		#main-container #helpButton { margin-right: 20px;}
	}
</style>
 <div id="main-container">
	<div id="header">
		<div id="banklogo">
			<custom-image id="issuerLogo"
								  alt-key="''network_means_pageType_170_IMAGE_ALT''"
								  image-key="''network_means_pageType_170_IMAGE_DATA''"
								  straight-mode="false">
					</custom-image>
		</div>
		<div id="schemeLogo">
			 <custom-image id="networkLogo"
								  alt-key="''network_means_pageType_171_IMAGE_ALT''"
								  image-key="''network_means_pageType_171_IMAGE_DATA''"
								  straight-mode="false">
			 </custom-image>
		</div>
	</div>
	<message-banner back-button="''network_means_pageType_5''"></message-banner>
	<div id="content">
		<div class="transactiondetails">
			<h3>
				<custom-text custom-text-key="''network_means_pageType_1''" id="paragraph1"></custom-text>
			</h3>
			<side-menu></side-menu>
		</div>
		<div class="autharea">
				<div id="tan_input_ctrl">
					<span id="tan-label">
					  <custom-text custom-text-key="''network_means_pageType_2''"></custom-text>
					  <custom-text custom-text-key="''network_means_pageType_4''"></custom-text>
					</span>
					<div class="otp-field">
							  <otp-form></otp-form>
					</div>
				</div>
		</div>
	</div>
	<div id="footer">
		<cancel-button cn-label="''network_means_pageType_40''" id="cancelButton" ></cancel-button>
		<help help-label="''network_means_pageType_41''" id="helpButton" class="helpButtonClass"></help>
		<val-button val-label="''network_means_pageType_6''" id="validateButton"></val-button>
	</div>

</div>' WHERE `fk_id_layout` = @layoutId;


SET @pageType = 'PHOTO_TAN_OTP_FORM_PAGE';
SET @layoutId = (SELECT id FROM CustomPageLayout WHERE pageType = @pageType AND  description = 'OTP Phototan Form Page (Comdirect)');

UPDATE `CustomComponent` SET `value` = '
	<style type="text/css">
	:root {
		font-family: Verdana, Helvetica, sans-serif;
		padding: 0px;
		margin: 0px;
	}
	#main-container {
		width: 480px;
		max-width: 480px;
		margin-left: auto;
		margin-right: auto;
		padding-left: 10px;
		padding-right: 10px;
	}
	#main-container .btn {
		border-radius: 20px;
		border: 0px;
		height: 40px;
	}
	#main-container #header {
		height: 64px;
		position: relative;
	}
	#issuerLogo {
		height: 25px;
		margin-left: 5px;
		margin-top: 1em;
	}
	#networkLogo {
		width: 100px;
		position: absolute;
		right: 1px;
		top: 5px;
		padding-right: 1em;
	}
	#main-container #content {
		text-align: center;
		display: flex;
		flex-direction: column;
	}
	#main-container #footer {
		display: flex;
		width: 100%;
		border-top: 1px solid #000;
		padding-top: 10px;
		justify-content: space-between;
		background-image: none;
	}
	#main-container #cancelButton .btn-default {
		background-color: #f4f4f4;
		align-content: flex-start;
	}
	#main-container #helpButton .btn-default {
		background-color: #f4f4f4;
		align-content: flex-start;
		width: 120px;
	}
	span.fa.fa-info {
		display: none;
	}
	#main-container #validateButton .btn-default {
		background-color: #fff500;
		align-content: flex-end;
	}
	#validateButton {
		outline: 0px;
		border: 0px;
		border-radius: 20px;
		height: 40px;
		width: 120px;
		background-color: #fff500;
		margin-right: 10px;
		align-content: flex-end;
		text-align: center;
	}
	.fa-ban { display: none; }
	.fa-check-square {
		display: none;
	}
	#cancelButton {
		background-color: #f4f4f4;
		border-radius: 20px;
		border: 0px;
		height: 40px;
		width: 120px;
		margin-left: 10px;
		align-content: flex-start;
		text-align: center;
	}
	.splashtext {
		width: 80%;
		margin-left: auto;
		margin-right: auto;
	}
	input {
		border: 1px solid #d1d1d1;
		border-radius: 6px;
		color: #464646;
		height: 20px;
		box-shadow: rgba(0, 0, 0, 0.15) 1px 1px 3px 0 inset;
	}
	#tan_input_ctrl {
		align-items: center;
	}
	.autharea {
		padding-top: 10px;
		padding-bottom: 10px;
	}
	external-image {
		margin-left: auto;
		margin-right: auto;
		display: block;
		width: 214px;
	}
	#phototan_ctrl {
		align-content: center;
	}
	span#tan-label {
		padding-right: 5px;
		padding-left: 5px;
		text-align: center;
		font-weight: 700;
	}
	.otp-field {
		padding-right: 5px;
		padding-left: 5px;
		padding-top: 10px;
		text-align: center;
	}
	@media (max-width: 560px) {
		.transactiondetails ul li { text-align: left;}
		.transactiondetails ul li label { display: block; float: left; width: 50%; text-align: right; font-size: 14px; color: #909090; margin-right: 0.5em;}
		.transactiondetails ul li span.value { clear: both; text-align: left; margin-left: 0.5em; }
		.otp-field { display: block;}
		.contact { width: 100%; order: 1; }
		#footer .small-font { font-size: 0.75em;}
	}
	 @media all and (max-width: 391px) {
		#main-container #header { position: inherit;}
		div#message-container { width: 370px;}
		#main-container #content { width: 380px;}
		#main-container #footer {display: inherit;}
		.otp-field { display: block;}
		#footer .small-font { font-size: 0.75em;}
		#cancelButton { margin-right: 25px;}
		help#helpButton { margin-right: 25px;}
	}
</style>
 <div id="main-container">
	<div id="header">
		<div id="banklogo">
			<custom-image id="issuerLogo"
								  alt-key="''network_means_pageType_170_IMAGE_ALT''"
								  image-key="''network_means_pageType_170_IMAGE_DATA''"
								  straight-mode="false">
					</custom-image>
		</div>
		<div id="schemeLogo">
			 <custom-image id="networkLogo"
								  alt-key="''network_means_pageType_171_IMAGE_ALT''"
								  image-key="''network_means_pageType_171_IMAGE_DATA''"
								  straight-mode="false">
			 </custom-image>
		</div>
	</div>
	<message-banner back-button="''network_means_pageType_5''"></message-banner>
	<div id="content">
		<div class="transactiondetails">
			<h3>
				<custom-text custom-text-key="''network_means_pageType_1''" id="paragraph1"></custom-text>
			</h3>
			<side-menu></side-menu>
		</div>
		<div class="autharea">
				<div id="tan_input_ctrl">
				  <custom-text custom-text-key="''network_means_pageType_2''" id="tan-label"></custom-text>
				  <!-- output for photo tan -->
					<div class="otp-field">
							  <otp-form></otp-form>
					</div>
					</div>
					<external-image></external-image>
		</div>
	</div>
	<div id="footer">
		<cancel-button cn-label="''network_means_pageType_40''" id="cancelButton" ></cancel-button>
		<help help-label="''network_means_pageType_41''" id="helpButton" class="helpButtonClass"></help>
		<val-button val-label="''network_means_pageType_6''" id="validateButton"></val-button>
	</div>
</div>' WHERE `fk_id_layout` = @layoutId;

SET @pageType = 'EXT_PASSWORD_OTP_FORM_PAGE';
SET @layoutId = (SELECT id FROM CustomPageLayout WHERE pageType = @pageType AND  description = 'Password OTP Form Page (Comdirect)');
UPDATE CustomComponent SET value = '
	<style type="text/css">
	:root {
		font-family: Verdana, Helvetica, sans-serif;
		padding: 0px;
		margin: 0px;
	}
	#main-container {
		width: 480px;
		max-width: 480px;
		margin-left: auto;
		margin-right: auto;
		padding-left: 10px;
		padding-right: 10px;
	}
	#main-container .btn {
		border-radius: 20px;
		border: 0px;
		height: 40px;
	}
	div#message-container.success {
		background-color: #E0700A !important;
	}
	#main-container #header {
		height: 64px;
		position: relative;
	}
	#issuerLogo {
		height: 25px;
		margin-left: 5px;
		margin-top: 1em;
	}
	#networkLogo {
		width: 100px;
		position: absolute;
		right: 1px;
		top: 5px;
		padding-right: 1em;
	}
	#main-container #content {
		text-align: center;
		display: flex;
		flex-direction: column;
	}
	#main-container #footer {
		display: flex;
		width: 100%;
		border-top: 1px solid #000;
		padding-top: 10px;
		justify-content: space-between;
		background-image: none;
	}
	#main-container #cancelButton .btn-default {
		background-color: #f4f4f4;
		align-content: flex-start;
	}
	#main-container #helpButton .btn-default {
		background-color: #f4f4f4;
		align-content: flex-start;
		width: 120px;
	}
	span.fa.fa-info {
		display: none;
	}
	.fa-ban { display: none; }
	#main-container #validateButton .btn-default {
		background-color: #fff500;
		align-content: flex-end;
	}
	#validateButton {
		outline: 0px;
		border: 0px;
		border-radius: 20px;
		height: 40px;
		width: 120px;
		background-color: #fff500;
		margin-right: 10px;
		align-content: flex-end;
		text-align: center;
	}
	.fa-check-square {display: none}
	.fa-ban { display: none; }
	#cancelButton {
		background-color: #f4f4f4;
		border-radius: 20px;
		border: 0px;
		height: 40px;
		width: 120px;
		margin-left: 10px;
		align-content: flex-start;
		text-align: center;
	}
	.splashtext {
		width: 80%;
		margin-left: auto;
		margin-right: auto;
	}
	input {
		border: 1px solid #d1d1d1;
		border-radius: 6px;
		color: #464646;
		height: 20px;
		box-shadow: rgba(0, 0, 0, 0.15) 1px 1px 3px 0 inset;
	}
	#tan_input_ctrl {
		align-items: center;
	}
	.autharea {
		padding-top: 10px;
		padding-bottom: 10px;
	}
	span#tan-label {
		padding-right: 5px;
		padding-left: 5px;
		width: 50%;
		text-align: center;
		font-weight: 700;
	}
	.otp-field {
		padding-right: 5px;
		padding-left: 5px;
		padding-top: 10px;
		text-align: center;
	}
	@media (max-width: 560px) {
		.transactiondetails ul li { text-align: left;}
		.transactiondetails ul li label { display: block; float: left; width: 50%; text-align: right; font-size: 14px; color: #909090; margin-right: 0.5em;}
		.transactiondetails ul li span.value { clear: both; text-align: left; margin-left: 0.5em; }
		.otp-field { display: block;}
		.contact { width: 100%; order: 1; }
		#footer .small-font { font-size: 0.75em;}
	}
	 @media all and (max-width: 391px) {
		#main-container #header { position: inherit;}
		div#message-container { width: 370px;}
		#main-container #content { width: 380px;}
		#main-container #footer {display: inherit;}
		.otp-field { display: block;}
		#footer .small-font { font-size: 0.75em;}
		#cancelButton { margin-right: 25px;}
		#main-container #helpButton { margin-right: 25px;}
	}
</style>
 <div id="main-container">
	<div id="header">
		<div id="banklogo">
			<custom-image id="issuerLogo"
								  alt-key="''network_means_pageType_1_IMAGE_ALT''"
								  image-key="''network_means_pageType_1_IMAGE_DATA''"
								  straight-mode="false">
					</custom-image>
		</div>
		<div id="schemeLogo">
			 <custom-image id="networkLogo"
								  alt-key="''network_means_pageType_2_IMAGE_ALT''"
								  image-key="''network_means_pageType_2_IMAGE_DATA''"
								  straight-mode="false">
			 </custom-image>
		</div>
	</div>
	<message-banner back-button="''network_means_pageType_175''"></message-banner>
	<div id="content">
		<div class="transactiondetails">
			<h3>
				<custom-text custom-text-key="''network_means_pageType_2''" id="paragraph1"></custom-text>
			</h3>
			<side-menu></side-menu>
		</div>
		<div class="autharea">
				<div id="tan_input_ctrl">
					<span id="tan-label">
					  <custom-text custom-text-key="''network_means_pageType_1''"></custom-text>
					</span>
					<div class="otp-field">
						<pwd-form></pwd-form>
					</div>
				</div>
		</div>
	</div>
	<div id="footer">
		<cancel-button cn-label="''network_means_pageType_40''" id="cancelButton" ></cancel-button>
		<help help-label="''network_means_pageType_41''" id="helpButton" class="helpButtonClass"></help>
		<val-button val-label="''network_means_pageType_42''" id="validateButton"></val-button>
	</div>
</div>
' WHERE `fk_id_layout` = @layoutId;

SET @pageType = 'POLLING_PAGE';
SET @layoutId = (SELECT id FROM CustomPageLayout WHERE pageType = @pageType AND  description = 'Polling Page (Comdirect)');
UPDATE CustomComponent SET value = '
	<style type="text/css">:root {
		font-family: Verdana, Helvetica, sans-serif;
		padding: 0px;
		margin: 0px;
	}
	#main-container {
		width: 480px;
		max-width: 480px;
		margin-left: auto;
		margin-right: auto;
		padding-left: 10px;
		padding-right: 10px;
	}
	#main-container .btn {
		border-radius: 20px;
		border: 0px;
		height: 40px;
	}
	#main-container #header {
		height: 64px;
		position: relative;
	}
	#issuerLogo {
		height: 25px;
		margin-left: 5px;
		margin-top: 1em;
	}
	#networkLogo {
		width: 100px;
		position: absolute;
		right: 1px;
		top: 5px;
		padding-right: 1em;
	}
	#main-container #content {
		text-align: center;
		display: flex;
		flex-direction: column;
	}
	#main-container #footer {
		display: flex;
		width: 100%;
		border-top: 1px solid #000;
		padding-top: 10px;
		justify-content: space-between;
		background-image: none;
	}
	#main-container #cancelButton .btn-default {
		background-color: #f4f4f4;
		align-content: flex-start;
	}
	#main-container #helpButton .btn-default {
		background-color: #f4f4f4;
		align-content: flex-start;
		width: 120px;
	}
	span.fa.fa-info {
		display: none;
	}
	.fa-ban {
		display: none;
	}
	#main-container #validateButton .btn-default {
		background-color: #fff500;
		align-content: flex-end;
	}
	#validateButton {
		outline: 0px;
		border: 0px;
		border-radius: 20px;
		height: 40px;
		width: 120px;
		background-color: #fff500;
		margin-right: 10px;
		align-content: flex-end;
		text-align: center;
	}
	.fa-check-square {
		display: none
	}
	.fa-ban {
		display: none;
	}
	#cancelButton {
		background-color: #f4f4f4;
		border-radius: 20px;
		border: 0px;
		height: 40px;
		width: 120px;
		margin-left: 10px;
		align-content: flex-start;
		text-align: center;
	}
	.splashtext {
		width: 80%;
		margin-left: auto;
		margin-right: auto;
	}
	input {
		border: 1px solid #d1d1d1;
		border-radius: 6px;
		color: #464646;
		height: 20px;
		box-shadow: rgba(0, 0, 0, 0.15) 1px 1px 3px 0 inset;
	}
	#tan_input_ctrl {
		align-items: center;
	}
	.autharea {
		padding-top: 10px;
		padding-bottom: 10px;
	}
	span#tan-label {
		padding-right: 5px;
		padding-left: 5px;
		margin-left: 8.33333333%;
		width: 41.66666667%;
		text-align: right;
		float: left;
		font-weight: 700;
	}
	.otp-field {
		padding-right: 5px;
		padding-left: 5px;
		margin-right: 8.33333333%;
		width: 41.66666667%;
		text-align: left;
		float: left;
	}
	@media (max-width: 560px) {
		.transactiondetails ul li { text-align: left;}
		.transactiondetails ul li label { display: block; float: left; width: 50%; text-align: right; font-size: 14px; color: #909090; margin-right: 0.5em;}
		.transactiondetails ul li span.value { clear: both; text-align: left; margin-left: 0.5em; }
		.otp-field { display: block;}
		.contact { width: 100%; order: 1; }
		#footer .small-font { font-size: 0.75em;}
	}
	@media all and (max-width: 391px) {
		#main-container #header { position: inherit;}
		div#message-container { width: 370px;}
		#main-container #content { width: 380px;}
		#main-container #footer {display: inherit;}
		#footer .small-font { font-size: 0.75em;}
		#cancelButton { margin-left: 20px; margin-right: 100px;}
		#main-container #helpButton { margin-right: 25px;}
	}
	</style>
 <div id="main-container">
	<div id="header">
		<div id="banklogo">
			<custom-image id="issuerLogo" alt-key="''network_means_pageType_170_IMAGE_ALT''"
						  image-key="''network_means_pageType_170_IMAGE_DATA''" straight-mode="false"></custom-image>
		</div>
		<div id="schemeLogo">
			<custom-image id="networkLogo" alt-key="''network_means_pageType_171_IMAGE_ALT''"
						  image-key="''network_means_pageType_171_IMAGE_DATA''" straight-mode="false"></custom-image>
		</div>
	</div>
	<message-banner back-button="''network_means_pageType_175''"></message-banner>
	<div id="content">
		<div class="transactiondetails">
			<h3>
				<custom-text custom-text-key="''network_means_pageType_1''" id="paragraph1"></custom-text>
			</h3>
			<side-menu></side-menu>
		</div>
		<div class="autharea">
			<div class="paragraph">
				<custom-text custom-text-key="''network_means_pageType_2''"></custom-text>
			</div>
			<div class="paragraphDescription">
				<custom-text custom-text-key="''network_means_pageType_3''"></custom-text>
			</div>
		</div>
	</div>
	<div id="footer">
		<cancel-button cn-label="''network_means_pageType_40''" id="cancelButton"></cancel-button>
		<help help-label="''network_means_pageType_41''" id="helpButton" class="helpButtonClass"></help>
	</div>
</div>' WHERE `fk_id_layout` = @layoutId;


SET @pageType = 'REFUSAL_PAGE';
SET @layoutId = (SELECT id FROM CustomPageLayout WHERE pageType = @pageType AND  description = 'Refusal Page (Comdirect)');

UPDATE `CustomComponent` SET `value` = '
	<style type="text/css">
		:root {
			font-family: Verdana, Helvetica, sans-serif;
			padding:0px;
			margin:0px;
		}
		#main-container {
			width:480px;
			max-width:480px;
			margin-left:auto;
			margin-right:auto;
			padding-left:10px;
			padding-right:10px;
		}
		#main-container .btn {
			border-radius: 20px;
			border:0px;
			height:40px;
			margin-left:10px;
		}
		#main-container #header {
			height:64px;
			position:relative;
		}
		#issuerLogo {
			height:25px;
			margin-left:5px;
			margin-top:1em;
		}
		#networkLogo {
			width:100px;
			position:absolute;
			right:1px;
			top:5px;
			padding-right:1em;
		}
		#main-container #content {
			text-align:left;
			display:flex;
			flex-direction: column;
		}
		#main-container #content .transactiondetails {
			border-top:1px solid black;
			border-bottom: 1px solid black;
		}
		#main-container #content .transactiondetails .h3, h3 {
			margin-left: 185px;
		}
		#main-container #content .transactiondetails ul {
			list-style-type: none;
			padding-left:0px;
		}
		#main-container #content .transactiondetails ul li {
			width:100%;
			text-align: left;
		}
		#main-container #content .transactiondetails ul li label {
			display:block;
			float:left;
			width:180px;
			text-align: right;
			font-size:14px;
			color: #909090;
			margin-right:0.5em;
		}
		#main-container #content .transactiondetails ul li span.value {
			clear:both;
			text-align: left;
			margin-left:0.5em;
		}
		#main-container #content div.autharea {
			display: flex;
			flex-direction: row;
		}
		#main-container #footer {
			display: flex;
			width:100%;
			border-top: 1px solid #000;
			padding-top:10px;
			justify-content: space-between;
			background-image:none;
		}
		#main-container #cancelButton .btn-default{
			background-color:#f4f4f4;
			align-content: flex-start;

		}
		#main-container #validateButton .btn-default {
			background-color:#FFF500;
			align-content: flex-end;
		}
		#validateButton {
			outline: 0px;
			border:0px;
			border-radius: 20px;
			height:40px;
			width:120px;
			background-color:#FFF500;
			margin-right:10px;
			align-content: flex-end;
		}
		#cancelButton {
			background-color:#f4f4f4;
			border-radius: 20px;
			border:0px;
			height:40px;
			width:120px;
			margin-left:10px;
			align-content: flex-start;
		}
		.splashtext {
			width:80%;
			margin-left:auto;
			margin-right:auto;
		}
		.autharea {
			display:flex;
			flex-direction: row;
			align-items: center;
			padding-top:10px;
			padding-bottom:10px;
		}
   @media (max-width: 560px) {
		.transactiondetails ul li { text-align: left;}
		.transactiondetails ul li label { display: block; float: left; width: 50%; text-align: right; font-size: 14px; color: #909090; margin-right: 0.5em;}
		.transactiondetails ul li span.value { clear: both; text-align: left; margin-left: 0.5em; }
		.contact { width: 100%; order: 1; }
		#footer .small-font { font-size: 0.75em;}
	}
	@media all and (max-width: 391px) {
		#main-container #header { position: inherit;}
		div#message-container { width: 370px;}
		#main-container #content { width: 380px;}
		#main-container #footer {display: inherit;}
		#footer .small-font { font-size: 0.75em;}
		#cancelButton { margin-right: 20px;}
		#main-container #helpButton { margin-right: 20px;}
	}
	</style>
	<div id="main-container">
	<div id="header">
		<div id="banklogo">
			<custom-image id="issuerLogo"
								  alt-key="''network_means_pageType_170_IMAGE_ALT''"
								  image-key="''network_means_pageType_170_IMAGE_DATA''"
								  straight-mode="false">
			</custom-image>
		</div>
		<div id="schemeLogo">
			 <custom-image id="networkLogo"
								  alt-key="''network_means_pageType_171_IMAGE_ALT''"
								  image-key="''network_means_pageType_171_IMAGE_DATA''"
								  straight-mode="false">
			 </custom-image>
		</div>
	</div>
	<message-banner></message-banner>
	<div id="content">
		<div class="transactiondetails">
			<h3>
				<custom-text custom-text-key="''network_means_pageType_1''" id="paragraph1"></custom-text>
			</h3>
			<side-menu></side-menu>
		</div>
	</div>
	<div id="footer">
		<val-button id="validateButton"></val-button>
	</div>
</div>
  ' WHERE `fk_id_layout` = @layoutId;

SET @pageType = 'FAILURE_PAGE';
SET @layoutId = (SELECT id FROM CustomPageLayout WHERE pageType = @pageType AND  description = 'Failure Page (Comdirect)');

UPDATE `CustomComponent` SET `value` = '
	<style type="text/css">
	:root {
		font-family: Verdana, Helvetica, sans-serif;
		padding: 0px;
		margin: 0px;
	}
	#main-container {
		width: 480px;
		max-width: 480px;
		margin-left: auto;
		margin-right: auto;
		padding-left: 10px;
		padding-right: 10px;
	}
	#main-container .btn {
		border-radius: 20px;
		border: 0px;
		height: 40px;
		margin-left: 10px;
	}
	#main-container #header {
		height: 64px;
		position: relative;
	}
	#issuerLogo {
		height: 25px;
		margin-left: 5px;
		margin-top: 1em;
	}
	#networkLogo {
		width: 100px;
		position: absolute;
		right: 1px;
		top: 5px;
		padding-right: 1em;
	}
	#main-container #content {
		text-align: left;
		display: flex;
		flex-direction: column;
	}
	#main-container #content .transactiondetails {
		border-top: 1px solid black;
		border-bottom: 1px solid black;
		padding-top: 10px;
		padding-bottom: 10px;
	}
	#main-container #content .transactiondetails h3 {
		margin-top: 10px;
		margin-bottom: 10px;
	}
	#main-container #content .transactiondetails ul {
		list-style-type: none;
		padding-left: 0px;
	}
	#main-container #content .transactiondetails ul li {
		width: 100%;
		text-align: left;
	}
	#main-container #content .transactiondetails ul li label {
		display: block;
		float: left;
		width: 180px;
		text-align: right;
		font-size: 14px;
		color: #909090;
		margin-right: 0.5em;
	}
	#main-container #content .transactiondetails ul li span.value {
		clear: both;
		text-align: left;
		margin-left: 0.5em;
	}
	#main-container #content div.autharea {
		display: flex;
		flex-direction: column;
	}
	#main-container #footer {
		display: flex;
		width: 100%;
		border-top: 1px solid #000;
		padding-top: 10px;
		justify-content: space-between;
		background-image: none;
	}
	#main-container #cancelButton .btn-default {
		background-color: #f4f4f4;
		align-content: flex-start;
	}
	#main-container #validateButton .btn-default {
		background-color: #fff500;
		align-content: flex-end;
	}
	#validateButton {
		outline: 0px;
		border: 0px;
		border-radius: 20px;
		height: 40px;
		width: 120px;
		background-color: #fff500;
		margin-right: 10px;
		align-content: flex-end;
	}
	@media (max-width: 560px) {
		.transactiondetails ul li { text-align: left;}
		.transactiondetails ul li label { display: block; float: left; width: 50%; text-align: right; font-size: 14px; color: #909090; margin-right: 0.5em;}
		.transactiondetails ul li span.value { clear: both; text-align: left; margin-left: 0.5em; }
		.contact { width: 100%; order: 1; }
		#footer .small-font { font-size: 0.75em;}
	}
	@media all and (max-width: 391px) {
		#main-container #header { position: inherit;}
		div#message-container { width: 370px;}
		#main-container #content { width: 380px;}
		#main-container #footer {display: inherit;}
		#footer .small-font { font-size: 0.75em;}
		#main-container #helpButton{ margin-right: 20px;}
	}
</style>
<div id="main-container">
	<div id="header">
		<div id="banklogo">
			<custom-image id="issuerLogo"
								  alt-key="''network_means_pageType_170_IMAGE_ALT''"
								  image-key="''network_means_pageType_170_IMAGE_DATA''"
								  straight-mode="false">
					</custom-image>
		</div>
		<div id="schemeLogo">
			 <custom-image id="networkLogo"
								  alt-key="''network_means_pageType_171_IMAGE_ALT''"
								  image-key="''network_means_pageType_171_IMAGE_DATA''"
								  straight-mode="false">
			 </custom-image>
		</div>
	</div>
	<message-banner></message-banner>
	<div id="content">
		<div class="transactiondetails">
			<h3>
				<custom-text custom-text-key="''network_means_pageType_1''" id="paragraph1"></custom-text>
			</h3>
			<side-menu></side-menu>
		</div>
	</div>

	<div id="footer">
		<val-button id="validateButton"></val-button>
	</div>
</div>
  ' WHERE `fk_id_layout` = @layoutId;

SET @pageType = 'MESSAGE_BANNER';
SET @layoutId = (SELECT id FROM CustomPageLayout WHERE pageType = @pageType AND  description = 'Message Banner (Comdirect)');

UPDATE `CustomComponent` SET `value` = '
<div id="messageBanner">
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
			.spinner {
				padding-top:10px;
				padding-bottom:10px;
			}
			#headingTxt { font-size:14px; }
			#message { font-size:12px; }
			span#headingTxt { font-size:14px; }
			span#message { font-size:12px; }
		}
		@media all and (max-width: 347px) {
			span#info-icon { font-size: 2em; }
			span#headingTxt { font-size:14px; }
			span#message { font-size:12px; }
		}
		@media all and (max-width: 309px) {
			span#headingTxt { font-size:12px; }
			span#message { font-size:10px; }
		}
		@media all and (max-width: 250px) {
			span#headingTxt { font-size:10px; }
			span#message { font-size:8px; }
		}
		.spinner {
			position: relative;
			display:block;
			padding-top:15px;
			padding-bottom:15px;
		}
		div#message-container.info {
			background-color:#002395;
			font-family: Arial, standard;
			font-size:12px;
			color: #EAEAEA;
		}
		div#message-container.success {
			background-color:#04BD07;
			font-family: Arial, standard;
			font-size:12px;
			color: #EAEAEA;
		}
		div#message-container.error {
			background-color:#DB1818;
			font-family: Arial, standard;
			font-size:12px;
			color: #EAEAEA;
		}
		div#message-container.warn {
			background-color:#E0700A;
			font-family: Arial, standard;
			font-size:12px;
			color: #EAEAEA;
		}
		#headingTxt {
			font-family: Arial,bold;
			color: #FFFFFF;
			font-size:14px;
			width : 70%;
			margin : auto;
			display : block;
			text-align:center;
			padding:4px 1px 1px 1px;
		}
		#message {
			font-family: Arial,normal;
			font-size:12px;
			color: #FFFFFF; font-size:14px;
			text-align:center;
		}
		/*span#message {
			font-size:14px;
		}*/
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
	</style>
  ' WHERE `fk_id_layout` = @layoutId;

SET @pageType = 'HELP_PAGE';
SET @layoutId = (SELECT id FROM CustomPageLayout WHERE pageType = @pageType AND  description = 'Help Page (Comdirect)');

UPDATE `CustomComponent` SET `value` = '
<div id="help-page">
	<div id="help-contents">
		<p><custom-text custom-text-key="''network_means_HELP_PAGE_1''"></custom-text></p>
	</div>

	<div class="row">
		<div class="col-xs-12" style="text-align:center">
			<help-close-button help-close-label="''network_means_HELP_PAGE_3''" id="helpCloseButton"></help-close-button>
		</div>
	</div>
</div>
<style>
	#help-contents {
		text-align:center;
		margin-top:20px;
		margin-bottom:20px;
	}
	#help-container #help-modal {
		overflow:hidden;
	}
	#helpCloseButton button {
		display: flex;
		align-items: center;
		width: 120px;
		margin-left: auto;
		margin-right: auto;
		justify-content: center;
	}
	#help-page {
		font-family:Arial,sans-serif;
		font-size:14px;
		padding:14px;
		overflow:auto;
		text-align:center;
	}
	@media screen and (max-width: 700px) and (min-width: 361px) {
		#helpCloseButton > button {

		}
	}
	@media screen and (max-width: 360px) {
		#helpCloseButton > button {

		}
	}
	@media only screen and (max-width: 480px) {
		div#message-container {
			width:100%;
			box-shadow: none;
			-webkit-box-shadow:none;
		}
		#help-page {
			font-family:Arial,sans-serif;
			font-size:9.1px;
		}
	}
	@media only screen and (max-width: 309px) {
		#help-page {
			font-family:Arial,sans-serif;
			font-size:8.3px;
		}
	}
	@media only screen and (max-width: 250px) {
		#help-page {
			font-family:Arial,sans-serif;
			font-size:7.7px;
		}
	}
</style>
  ' WHERE `fk_id_layout` = @layoutId;


SET @locale = 'de';
SET @updateState =  'PUSHED_TO_CONFIG';
SET @networkVName = (SELECT `name` FROM `Network` WHERE `code` = 'VISA');


SET @customItemSetRefusal = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_16600_DEFAULT_REFUSAL');
SET @pageType = 'REFUSAL_PAGE';

SET @ordinal = 22;
SET @textValue = 'Anfrage nicht möglich';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetRefusal AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 23;
SET @textValue = 'Die Anfrage war nicht erfolgreich. Bitte versuchen Sie es erneut oder wenden Sie sich telefonisch an uns. Sie erreichen uns rund um die Uhr unter 04106 – 708 25 00.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetRefusal AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 32;
SET @textValue = 'Technischer Fehler';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetRefusal AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 33;
SET @textValue = 'Es ist ein Fehler aufgetreten. Bitte versuchen Sie es erneut oder wenden Sie sich telefonisch an uns. Sie erreichen uns rund um die Uhr unter 04106 – 708 25 00.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetRefusal AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 16;
SET @textValue = 'Zugang gesperrt';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetRefusal AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 17;
SET @textValue = 'Ihr Kontozugang wurde aus Sicherheitsgründen gesperrt. Zur Entsperrung rufen Sie uns bitte an unter 04106 – 708 25 00. Geben Sie keine Zugangsdaten am Servicecomputer ein. Sie werden automatisch an einen Kundenbetreuer weitergeleitet.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetRefusal AND ordinal = @ordinal AND pageTypes = @pageType;

SET @pageType = 'HELP_PAGE';
SET @ordinal = 1;
SET @textValue = 'Informationen zur starken Kundenauthentifizierung finden Sie unter www.comdirect.de/faq/online-zahlungen';
SET @customItemSetRefusalFraud = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_16600_FRAUD_REFUSAL');
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN(@customItemSetRefusal, @customItemSetRefusalFraud) AND ordinal = @ordinal AND pageTypes = @pageType;
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
						  `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
						  `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES

	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVName, '_', @currentAuthentMean, '_', @pageType, '_3'), @updateState,
	@locale, 3, @pageType, 'Schließen', NULL, NULL, @customItemSetRefusal),
	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVName, '_', @currentAuthentMean, '_', @pageType, '_3'), @updateState,
	@locale, 3, @pageType, 'Schließen', NULL, NULL, @customItemSetRefusalFraud);


SET @customItemSetPassword = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_16600_PASSWORD');
SET @pageType = 'OTP_FORM_PAGE';

SET @ordinal = 2;
SET @textValue = '<b>Bitte bestätigen Sie folgende Anfrage</b>';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetPassword AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 1;
SET @textValue = '<b>Bitte geben Sie zunächst Ihre 6-stellige Online-Banking-PIN ein:</b>';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetPassword AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 42;
SET @textValue = 'Weiter';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetPassword AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 12;
SET @textValue = 'Authentifizierung wird fortgesetzt';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetPassword AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 13;
SET @textValue = 'Bitte warten Sie einen Moment. Im nächsten Schritt wird eine TAN abgefragt.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetPassword AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 14;
SET @textValue = 'Anfrage abgebrochen';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetPassword AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 15;
SET @textValue = 'Die Anfrage wurde abgebrochen. Bitte starten Sie den Vorgang bei Bedarf erneut.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetPassword AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 26;
SET @textValue = 'Authentifizierung wird fortgesetzt';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetPassword AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 27;
SET @textValue = 'Bitte warten Sie einen Moment. Im nächsten Schritt wird eine TAN abgefragt..';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetPassword AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 30;
SET @textValue = 'Session abgelaufen';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetPassword AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 31;
SET @textValue = 'Sie haben einige Zeit keine Eingabe vorgenommen, daher wurde die Anfrage abgebrochen. Bitte starten Sie den Vorgang bei Bedarf erneut.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetPassword AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 32;
SET @textValue = 'Technischer Fehler';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetPassword AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 33;
SET @textValue = 'Es ist ein Fehler aufgetreten. Bitte versuchen Sie es erneut oder wenden Sie sich telefonisch an uns. Sie erreichen uns rund um die Uhr unter 04106 – 708 25 00.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetPassword AND ordinal = @ordinal AND pageTypes = @pageType;

SET @currentAuthentMean = 'EXT_PASSWORD';
SET @currentPageType = 'EXT_PASSWORD_OTP_FORM_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
						  `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
						  `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES

	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVName, '_', @currentAuthentMean, '_', @currentPageType, '_41'), @updateState,
	@locale, 41, @pageType, 'Hilfe', NULL, NULL, @customItemSetPassword);

SET @pageType = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
						  `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
						  `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES

	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVName, '_', @currentAuthentMean, '_', @pageType, '_1'), @updateState,
	@locale, 1, @pageType, 'Informationen zur starken Kundenauthentifizierung finden Sie unter www.comdirect.de/faq/online-zahlungen', NULL, NULL, @customItemSetPassword),
	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVName, '_', @currentAuthentMean, '_', @pageType, '_3'), @updateState,
	@locale, 3, @pageType, 'Schließen', NULL, NULL, @customItemSetPassword);


SET @pageType = 'FAILURE_PAGE';
SET @ordinal = 16;
SET @textValue = 'Zugang gesperrt';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetPassword AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 17;
SET @textValue = 'Ihr Kontozugang wurde aus Sicherheitsgründen gesperrt. Zur Entsperrung rufen Sie uns bitte an unter 04106 – 708 25 00. Geben Sie keine Zugangsdaten am Servicecomputer ein. Sie werden automatisch an einen Kundenbetreuer weitergeleitet.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetPassword AND ordinal = @ordinal AND pageTypes = @pageType;

SET @pageType = 'ALL';
SET @ordinal = 175;
SET @textValue = 'Zurück zum Händler';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetPassword AND ordinal = @ordinal AND pageTypes = @pageType;



SET @customItemSetPhotoTan_1 = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_16600_PHOTOTAN_1');
SET @customItemSetPhotoTan_2 = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_16600_PHOTOTAN_2');
SET @pageType = 'OTP_FORM_PAGE';

SET @ordinal = 1;
SET @textValue = 'Bitte bestätigen Sie folgende Anfrage';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN(@customItemSetPhotoTan_1, @customItemSetPhotoTan_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 12;
SET @textValue = 'Authentifizierung läuft';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN(@customItemSetPhotoTan_1, @customItemSetPhotoTan_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 13;
SET @textValue = 'Bitte warten Sie kurz, während Ihre Eingabe geprüft wird.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN(@customItemSetPhotoTan_1, @customItemSetPhotoTan_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 14;
SET @textValue = 'Anfrage abgebrochen';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN(@customItemSetPhotoTan_1, @customItemSetPhotoTan_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 15;
SET @textValue = 'Die Anfrage wurde abgebrochen. Bitte starten Sie den Vorgang bei Bedarf erneut.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN(@customItemSetPhotoTan_1, @customItemSetPhotoTan_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 26;
SET @textValue = 'Authentifizierung erfolgreich';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN(@customItemSetPhotoTan_1, @customItemSetPhotoTan_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 27;
SET @textValue = 'Bitte warten Sie einen Moment. Sie wurden erfolgreich authentifiziert und werden automatisch zum Händler weitergeleitet. Brechen Sie den Vorgang bitte nicht ab.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN(@customItemSetPhotoTan_1, @customItemSetPhotoTan_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 30;
SET @textValue = 'Session abgelaufen';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN(@customItemSetPhotoTan_1, @customItemSetPhotoTan_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 31;
SET @textValue = 'Sie haben einige Zeit keine Eingabe vorgenommen, daher wurde die Anfrage abgebrochen. Bitte starten Sie den Vorgang bei Bedarf erneut.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN(@customItemSetPhotoTan_1, @customItemSetPhotoTan_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 32;
SET @textValue = 'Technischer Fehler';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN(@customItemSetPhotoTan_1, @customItemSetPhotoTan_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 33;
SET @textValue = 'Es ist ein Fehler aufgetreten. Bitte versuchen Sie es erneut oder wenden Sie sich telefonisch an uns. Sie erreichen uns rund um die Uhr unter 04106 – 708 25 00.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN(@customItemSetPhotoTan_1, @customItemSetPhotoTan_2) AND ordinal = @ordinal AND pageTypes = @pageType;


SET @pageType = 'FAILURE_PAGE';
SET @ordinal = 16;
SET @textValue = 'Zugang gesperrt';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN(@customItemSetPhotoTan_1, @customItemSetPhotoTan_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 17;
SET @textValue = 'Ihr Kontozugang wurde aus Sicherheitsgründen gesperrt. Zur Entsperrung rufen Sie uns bitte an unter 04106 – 708 25 00. Geben Sie keine Zugangsdaten am Servicecomputer ein. Sie werden automatisch an einen Kundenbetreuer weitergeleitet.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN(@customItemSetPhotoTan_1, @customItemSetPhotoTan_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 30;
SET @textValue = 'Session abgelaufen';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN(@customItemSetPhotoTan_1, @customItemSetPhotoTan_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 31;
SET @textValue = 'Sie haben einige Zeit keine Eingabe vorgenommen, daher wurde die Anfrage abgebrochen. Bitte starten Sie den Vorgang bei Bedarf erneut.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN(@customItemSetPhotoTan_1, @customItemSetPhotoTan_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 32;
SET @textValue = 'Technischer Fehler';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN(@customItemSetPhotoTan_1, @customItemSetPhotoTan_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 33;
SET @textValue = 'Es ist ein Fehler aufgetreten. Bitte versuchen Sie es erneut oder wenden Sie sich telefonisch an uns. Sie erreichen uns rund um die Uhr unter 04106 – 708 25 00.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN(@customItemSetPhotoTan_1, @customItemSetPhotoTan_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @pageType = 'ALL';
SET @currentPageType = 'OTP_FORM_PAGE';
SET @currentAuthentMean_1 = 'PHOTOTAN_1';
SET @currentAuthentMean_2 = 'PHOTOTAN_2';
SET @ordinal = 5;
SET @textValue = 'Zurück zum Händler';
UPDATE CustomItem SET value = @textValue,
`name` = CONCAT(@networkVName, '_', @currentAuthentMean_1, '_', @currentPageType, '_175') WHERE fk_id_customItemSet = @customItemSetPhotoTan_1 AND ordinal = @ordinal AND pageTypes = @pageType;
UPDATE CustomItem SET value = @textValue,
`name` = CONCAT(@networkVName, '_', @currentAuthentMean_2, '_', @currentPageType, '_175') WHERE fk_id_customItemSet = @customItemSetPhotoTan_2 AND ordinal = @ordinal AND pageTypes = @pageType;


SET @pageType = 'HELP_PAGE';
SET @ordinal = 1;
SET @textValue = 'Informationen zur starken Kundenauthentifizierung finden Sie unter www.comdirect.de/faq/online-zahlungen';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetPhotoTan_1 AND ordinal = @ordinal AND pageTypes = @pageType;
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetPhotoTan_2 AND ordinal = @ordinal AND pageTypes = @pageType;
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
						  `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
						  `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVName, '_', @currentAuthentMean_1, '_', @pageType, '_3'), @updateState,
	@locale, 3, @pageType, 'Schließen', NULL, NULL, @customItemSetPhotoTan_1),
	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVName, '_', @currentAuthentMean_2, '_', @pageType, '_3'), @updateState,
	@locale, 3, @pageType, 'Schließen', NULL, NULL, @customItemSetPhotoTan_2);



SET @customItemSetSMS_1 = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_16600_SMS_1');
SET @customItemSetSMS_2 = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_16600_SMS_2');
SET @pageType = 'OTP_FORM_PAGE';

SET @ordinal = 1;
SET @textValue = 'Bitte bestätigen Sie folgende Anfrage';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN (@customItemSetSMS_1, @customItemSetSMS_2)  AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 12;
SET @textValue = 'Authentifizierung läuft';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet  IN (@customItemSetSMS_1, @customItemSetSMS_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 13;
SET @textValue = 'Bitte warten Sie kurz, während Ihre Eingabe geprüft wird.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN (@customItemSetSMS_1, @customItemSetSMS_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 14;
SET @textValue = 'Anfrage abgebrochen';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN (@customItemSetSMS_1, @customItemSetSMS_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 15;
SET @textValue = 'Die Anfrage wurde abgebrochen. Bitte starten Sie den Vorgang bei Bedarf erneut.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN (@customItemSetSMS_1, @customItemSetSMS_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 26;
SET @textValue = 'Authentifizierung erfolgreich';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN (@customItemSetSMS_1, @customItemSetSMS_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 27;
SET @textValue = 'Bitte warten Sie einen Moment. Sie wurden erfolgreich authentifiziert und werden automatisch zum Händler weitergeleitet. Brechen Sie den Vorgang bitte nicht ab.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN (@customItemSetSMS_1, @customItemSetSMS_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 30;
SET @textValue = 'Session abgelaufen';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN (@customItemSetSMS_1, @customItemSetSMS_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 31;
SET @textValue = 'Sie haben einige Zeit keine Eingabe vorgenommen, daher wurde die Anfrage abgebrochen. Bitte starten Sie den Vorgang bei Bedarf erneut.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN (@customItemSetSMS_1, @customItemSetSMS_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 32;
SET @textValue = 'Technischer Fehler';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN (@customItemSetSMS_1, @customItemSetSMS_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 33;
SET @textValue = 'Es ist ein Fehler aufgetreten. Bitte versuchen Sie es erneut oder wenden Sie sich telefonisch an uns. Sie erreichen uns rund um die Uhr unter 04106 – 708 25 00.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN (@customItemSetSMS_1, @customItemSetSMS_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @pageType = 'FAILURE_PAGE';
SET @ordinal = 16;
SET @textValue = 'Zugang gesperrt';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN (@customItemSetSMS_1, @customItemSetSMS_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 17;
SET @textValue = 'Ihr Kontozugang wurde aus Sicherheitsgründen gesperrt. Zur Entsperrung rufen Sie uns bitte an unter 04106 – 708 25 00. Geben Sie keine Zugangsdaten am Servicecomputer ein. Sie werden automatisch an einen Kundenbetreuer weitergeleitet.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN (@customItemSetSMS_1, @customItemSetSMS_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 30;
SET @textValue = 'Session abgelaufen';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN (@customItemSetSMS_1, @customItemSetSMS_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 31;
SET @textValue = 'Sie haben einige Zeit keine Eingabe vorgenommen, daher wurde die Anfrage abgebrochen. Bitte starten Sie den Vorgang bei Bedarf erneut.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN (@customItemSetSMS_1, @customItemSetSMS_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 32;
SET @textValue = 'Technischer Fehler';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN (@customItemSetSMS_1, @customItemSetSMS_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 33;
SET @textValue = 'Es ist ein Fehler aufgetreten. Bitte versuchen Sie es erneut oder wenden Sie sich telefonisch an uns. Sie erreichen uns rund um die Uhr unter 04106 – 708 25 00.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN (@customItemSetSMS_1, @customItemSetSMS_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @pageType = 'ALL';
SET @ordinal = 5;
SET @textValue = 'Zurück zum Händler';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN (@customItemSetSMS_1, @customItemSetSMS_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @pageType = 'HELP_PAGE';
SET @ordinal = 1;
SET @textValue = 'Informationen zur starken Kundenauthentifizierung finden Sie unter www.comdirect.de/faq/online-zahlungen';
SET @currentAuthentMean = 'SMS';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN (@customItemSetSMS_1, @customItemSetSMS_2) AND ordinal = @ordinal AND pageTypes = @pageType;
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
						  `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
						  `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES

	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVName, '_', @currentAuthentMean, '_', @pageType, '_3'), @updateState,
	@locale, 3, @pageType, 'Schließen', NULL, NULL, @customItemSetSMS_1),
	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVName, '_', @currentAuthentMean, '_', @pageType, '_3'), @updateState,
	@locale, 3, @pageType, 'Schließen', NULL, NULL, @customItemSetSMS_2);



SET @customItemSetApp = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_16600_APP_1');
SET @pageType = 'POLLING_PAGE';

SET @ordinal = 1;
SET @textValue = 'Bitte bestätigen Sie folgende Anfrage';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetApp AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 2;
SET @textValue = 'Freigabe durch photoTAN-Push';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetApp AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 3;
SET @textValue = 'Bitte öffnen Sie die photoTAN App, um die Zahlung dort freizugeben.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetApp AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 14;
SET @textValue = 'Anfrage abgebrochen';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetApp AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 15;
SET @textValue = 'Die Anfrage wurde abgebrochen. Bitte starten Sie den Vorgang bei Bedarf erneut.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetApp AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 26;
SET @textValue = 'Authentifizierung erfolgreich';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetApp AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 27;
SET @textValue = 'Bitte warten Sie einen Moment. Sie wurden erfolgreich authentifiziert und werden automatisch zum Händler weitergeleitet. Brechen Sie den Vorgang bitte nicht ab.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetApp AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 30;
SET @textValue = 'Session abgelaufen';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetApp AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 31;
SET @textValue = 'Sie haben einige Zeit keine Eingabe vorgenommen, daher wurde die Anfrage abgebrochen. Bitte starten Sie den Vorgang bei Bedarf erneut.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetApp AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 32;
SET @textValue = 'Technischer Fehler';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetApp AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 33;
SET @textValue = 'Es ist ein Fehler aufgetreten. Bitte versuchen Sie es erneut oder wenden Sie sich telefonisch an uns. Sie erreichen uns rund um die Uhr unter 04106 – 708 25 00.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetApp AND ordinal = @ordinal AND pageTypes = @pageType;

SET @pageType = 'FAILURE_PAGE';
SET @ordinal = 16;
SET @textValue = 'Zugang gesperrt';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetApp AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 17;
SET @textValue = 'Ihr Kontozugang wurde aus Sicherheitsgründen gesperrt. Zur Entsperrung rufen Sie uns bitte an unter 04106 – 708 25 00. Geben Sie keine Zugangsdaten am Servicecomputer ein. Sie werden automatisch an einen Kundenbetreuer weitergeleitet.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetApp AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 32;
SET @textValue = 'Technischer Fehler';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetApp AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 33;
SET @textValue = 'Es ist ein Fehler aufgetreten. Bitte versuchen Sie es erneut oder wenden Sie sich telefonisch an uns. Sie erreichen uns rund um die Uhr unter 04106 – 708 25 00.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetApp AND ordinal = @ordinal AND pageTypes = @pageType;


SET @currentAuthentMean = 'MOBILE_APP_EXT';
SET @pageType = 'POLLING_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
						  `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
						  `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES

	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVName, '_', @currentAuthentMean, '_', @pageType, '_41'), @updateState,
	@locale, 41, @pageType, 'Hilfe', NULL, NULL, @customItemSetApp),
	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVName, '_', @currentAuthentMean, '_', @pageType, '_175'), @updateState,
	@locale, 175, 'ALL', 'Zurück zum Händler', NULL, NULL, @customItemSetApp);


SET @pageType = 'HELP_PAGE';
INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `lastUpdateBy`, `lastUpdateDate`,
						  `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`,
						  `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`) VALUES
	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVName, '_', @currentAuthentMean, '_', @pageType, '_1'), @updateState,
	@locale, 1, @pageType, 'Informationen zur starken Kundenauthentifizierung finden Sie unter www.comdirect.de/faq/online-zahlungen', NULL, NULL, @customItemSetApp),
	('T', @createdBy, NOW(), NULL, NULL, NULL, CONCAT(@networkVName, '_', @currentAuthentMean, '_', @pageType, '_3'), @updateState,
	@locale, 3, @pageType, 'Schließen', NULL, NULL, @customItemSetApp);