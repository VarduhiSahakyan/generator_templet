USE U5G_ACS_BO;

SET @createdBy = 'A758582';

SET @issuerId = (SELECT id FROM Issuer WHERE name = 'Comdirect' AND code = '16600');

SET @pageType = 'OTP_FORM_PAGE';
SET @layoutId = (SELECT id FROM CustomPageLayout WHERE pageType = @pageType AND  description = 'OTP Form Page (Comdirect)');

UPDATE `CustomComponent` SET `value` = '
<div id="main-container">

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
	/* message banner overrides */
	message-banner #spinner-row {
		height: 50px;
		padding-top: 25px;
		margin-bottom: 10px;
	}
	.spinner-container {
		display: block;
		width: 100%;
	}
	#messageBanner {
		width: 100%;
		margin-left: 0px;
		margin-right: 0px;
		margin-top: 10px;
		background-color: #f5f5f5;
		box-sizing: border-box;
	}
	#messageBanner p {
		margin-top: 0.25em;
		margin-bottom: 0.25em;
	}
	#messageBanner h3 {
		margin-top: 0.25em;
		margin-bottom: 0.25em;
	}
	div#message-controls {
		padding-top: 0px;
	}
	#close-button-row, #return-button-row {
		margin-bottom: 10px;
		margin-top: 10px;
	}
	.error {
		color: #fff;
		background-color: #f00 !important;
	}
	.spinner {
		display: block;
		width: 120px;
		height: 120px;
	}
	#otp-error-message {
		margin-top: 10px;
		position: relative;
		background-color: #f5f5f5;
		text-align: center;
		width: 300px;
		margin-left: 56px;
		padding: 12px;
	}
	#otp-error-message:after {
		content: '''';
		position: absolute;
		top: 0;
		left: 0px;
		width: 0;
		height: 0;
		border: 10px solid transparent;
		border-bottom-color: #f5f5f5;
		border-top: 0;
		margin-left: 166px;
		margin-top: -10px;
	}
	#otp-error-message p {
		color: #d00;
	}
	#meansSelect {
		padding-top: 10px;
		padding-bottom: 10px;
		text-align: center;
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
	#mtan_ctrl {
		align-content: center;
	}
	#itan_ctrl {
		align-content: center;
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
		#main-container {
			width: auto;
		}
		body {
			font-size: 14px;
		}
		#header {
			height: 65px;
		}
		.transactiondetails ul li {
			text-align: left;
		}
		.transactiondetails ul li label {
			display: block;
			float: left;
			width: 50%;
			text-align: right;
			font-size: 14px;
			color: #909090;
			margin-right: 0.5em;
		}
		.transactiondetails ul li span.value {
			clear: both;
			text-align: left;
			margin-left: 0.5em;
		}
		.mtan-input {
			display: flex;
			flex-direction: column;
			width: 100%;
			padding-bottom: 1em;
			padding-top: 1em;
		}
		.resendTan {
			margin-left: 0px;
			flex-grow: 2;
		}
		.resendTan a {
			color: #06c2d4;
			margin-left: 90px;
			padding-left: 16px;
		}
		.mtan-label {
			flex: 0 0 90px;
		}
		.input-label {
		}
		.otp-field {
			display: inline;
		}
		.otp-field input {
		}
		#main-container #footer {
			width: 100%;
			clear: both;
			margin-top: 3em;
			background-image: none;
		}
		.help-link {
			width: 100%;
			order: 2;
			text-align: center;
			padding-top: 1em;
		}
		.contact {
			width: 100%;
			order: 1;
		}
		#footer .small-font {
			font-size: 0.75em;
		}
		#otp-error-message {
			margin-top: 0px;
			position: relative;
			background-color: #f5f5f5;
			text-align: center;
			width: 100%;
			margin-left: 0px;
			margin-bottom: 16px;
			box-sizing: border-box;
		}
		#otp-error-message:after {
			content: '''';
			position: absolute;
			top: 0;
			left: 0px;
			width: 0;
			height: 0;
			border: 10px solid transparent;
			border-bottom-color: #f5f5f5;
			border-top: 0;
			margin-left: 50%;
			margin-top: -10px;
		}
	}

</style>
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
		<val-button val-label="''network_means_pageType_6''" id="validateButton"></val-button>
	</div>

</div>' WHERE `fk_id_layout` = @layoutId;


SET @pageType = 'PHOTO_TAN_OTP_FORM_PAGE';
SET @layoutId = (SELECT id FROM CustomPageLayout WHERE pageType = @pageType AND  description = 'OTP Phototan Form Page (Comdirect)');

UPDATE `CustomComponent` SET `value` = '
	<div id="main-container">

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
	/* message banner overrides */
	message-banner #spinner-row {
		height: 50px;
		padding-top: 25px;
		margin-bottom: 10px;
	}
	.spinner-container {
		display: block;
		width: 100%;
	}
	#messageBanner {
		width: 100%;
		margin-left: 0px;
		margin-right: 0px;
		margin-top: 10px;
		background-color: #f5f5f5;
		box-sizing: border-box;
	}
	#messageBanner p {
		margin-top: 0.25em;
		margin-bottom: 0.25em;
	}
	#messageBanner h3 {
		margin-top: 0.25em;
		margin-bottom: 0.25em;
	}
	div#message-controls {
		padding-top: 0px;
	}
	#close-button-row, #return-button-row {
		margin-bottom: 10px;
		margin-top: 10px;
	}
	.error {
		color: #fff;
		background-color: #f00 !important;
	}
	.spinner {
		display: block;
		width: 120px;
		height: 120px;
	}
	#otp-error-message {
		margin-top: 10px;
		position: relative;
		background-color: #f5f5f5;
		text-align: center;
		width: 300px;
		margin-left: 56px;
		padding: 12px;
	}
	#otp-error-message:after {
		content: '''';
		position: absolute;
		top: 0;
		left: 0px;
		width: 0;
		height: 0;
		border: 10px solid transparent;
		border-bottom-color: #f5f5f5;
		border-top: 0;
		margin-left: 166px;
		margin-top: -10px;
	}
	#otp-error-message p {
		color: #d00;
	}
	#meansSelect {
		padding-top: 10px;
		padding-bottom: 10px;
		text-align: center;
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
	#mtan_ctrl {
		align-content: center;
	}
	#itan_ctrl {
		align-content: center;
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
		#main-container {
			width: auto;
		}
		body {
			font-size: 14px;
		}
		#header {
			height: 65px;
		}
		.transactiondetails ul li {
			text-align: left;
		}
		.transactiondetails ul li label {
			display: block;
			float: left;
			width: 50%;
			text-align: right;
			font-size: 14px;
			color: #909090;
			margin-right: 0.5em;
		}
		.transactiondetails ul li span.value {
			clear: both;
			text-align: left;
			margin-left: 0.5em;
		}
		.mtan-input {
			display: flex;
			flex-direction: column;
			width: 100%;
			padding-bottom: 1em;
			padding-top: 1em;
		}
		.resendTan {
			margin-left: 0px;
			flex-grow: 2;
		}
		.resendTan a {
			color: #06c2d4;
			margin-left: 90px;
			padding-left: 16px;
		}
		.mtan-label {
			flex: 0 0 90px;
		}
		.input-label {
		}
		.otp-field {
			display: inline;
		}
		.otp-field input {
		}
		#main-container #footer {
			width: 100%;
			clear: both;
			margin-top: 3em;
			background-image: none;
		}
		.help-link {
			width: 100%;
			order: 2;
			text-align: center;
			padding-top: 1em;
		}
		.contact {
			width: 100%;
			order: 1;
		}
		#footer .small-font {
			font-size: 0.75em;
		}
		#otp-error-message {
			margin-top: 0px;
			position: relative;
			background-color: #f5f5f5;
			text-align: center;
			width: 100%;
			margin-left: 0px;
			margin-bottom: 16px;
			box-sizing: border-box;
		}
		#otp-error-message:after {
			content: '''';
			position: absolute;
			top: 0;
			left: 0px;
			width: 0;
			height: 0;
			border: 10px solid transparent;
			border-bottom-color: #f5f5f5;
			border-top: 0;
			margin-left: 50%;
			margin-top: -10px;
		}
	}

</style>
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
		<val-button val-label="''network_means_pageType_6''" id="validateButton"></val-button>
	</div>

</div>' WHERE `fk_id_layout` = @layoutId;

SET @pageType = 'EXT_PASSWORD_OTP_FORM_PAGE';
SET @layoutId = (SELECT id FROM CustomPageLayout WHERE pageType = @pageType AND  description = 'Password OTP Form Page (Comdirect)');
UPDATE CustomComponent SET value = '
<div id="main-container">

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
	/* message banner overrides */
	message-banner #spinner-row {
		height: 50px;
		padding-top: 25px;
		margin-bottom: 10px;
	}
	.spinner-container {
		display: block;
		width: 100%;
	}
	#messageBanner {
		width: 100%;
		margin-left: 0px;
		margin-right: 0px;
		margin-top: 10px;
		background-color: #f5f5f5;
		box-sizing: border-box;
	}
	#messageBanner p {
		margin-top: 0.25em;
		margin-bottom: 0.25em;
	}
	#messageBanner h3 {
		margin-top: 0.25em;
		margin-bottom: 0.25em;
	}
	div#message-controls {
		padding-top: 0px;
	}
	#close-button-row, #return-button-row {
		margin-bottom: 10px;
		margin-top: 10px;
	}
	.error {
		color: #fff;
		background-color: #f00 !important;
	}
	.spinner {
		display: block;
		width: 120px;
		height: 120px;
	}
	#otp-error-message {
		margin-top: 10px;
		position: relative;
		background-color: #f5f5f5;
		text-align: center;
		width: 300px;
		margin-left: 56px;
		padding: 12px;
	}
	#otp-error-message:after {
		content: '''';
		position: absolute;
		top: 0;
		left: 0px;
		width: 0;
		height: 0;
		border: 10px solid transparent;
		border-bottom-color: #f5f5f5;
		border-top: 0;
		margin-left: 166px;
		margin-top: -10px;
	}
	#otp-error-message p {
		color: #d00;
	}
	#meansSelect {
		padding-top: 10px;
		padding-bottom: 10px;
		text-align: center;
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
	#mtan_ctrl {
		align-content: center;
	}
	#itan_ctrl {
		align-content: center;
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
		#main-container {
			width: auto;
		}
		body {
			font-size: 14px;
		}
		#header {
			height: 65px;
		}
		.transactiondetails ul li {
			text-align: left;
		}
		.transactiondetails ul li label {
			display: block;
			float: left;
			width: 50%;
			text-align: right;
			font-size: 14px;
			color: #909090;
			margin-right: 0.5em;
		}
		.transactiondetails ul li span.value {
			clear: both;
			text-align: left;
			margin-left: 0.5em;
		}
		.mtan-input {
			display: flex;
			flex-direction: column;
			width: 100%;
			padding-bottom: 1em;
			padding-top: 1em;
		}
		.resendTan {
			margin-left: 0px;
			flex-grow: 2;
		}
		.resendTan a {
			color: #06c2d4;
			margin-left: 90px;
			padding-left: 16px;
		}
		.mtan-label {
			flex: 0 0 90px;
		}
		.input-label {
		}
		.otp-field {
			display: inline;
		}
		.otp-field input {
		}
		#main-container #footer {
			width: 100%;
			clear: both;
			margin-top: 3em;
			background-image: none;
		}
		.help-link {
			width: 100%;
			order: 2;
			text-align: center;
			padding-top: 1em;
		}
		.contact {
			width: 100%;
			order: 1;
		}
		#footer .small-font {
			font-size: 0.75em;
		}
		#otp-error-message {
			margin-top: 0px;
			position: relative;
			background-color: #f5f5f5;
			text-align: center;
			width: 100%;
			margin-left: 0px;
			margin-bottom: 16px;
			box-sizing: border-box;
		}
		#otp-error-message:after {
			content: '''';
			position: absolute;
			top: 0;
			left: 0px;
			width: 0;
			height: 0;
			border: 10px solid transparent;
			border-bottom-color: #f5f5f5;
			border-top: 0;
			margin-left: 50%;
			margin-top: -10px;
		}
	}

</style>
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
		<val-button val-label="''network_means_pageType_42''" id="validateButton"></val-button>
	</div>

</div>
' WHERE `fk_id_layout` = @layoutId;

SET @pageType = 'POLLING_PAGE';
SET @layoutId = (SELECT id FROM CustomPageLayout WHERE pageType = @pageType AND  description = 'Polling Page (Comdirect)');
UPDATE CustomComponent SET value = '
<div id="main-container"> <style type="text/css">:root {
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
/* message banner overrides */
message-banner #spinner-row {
	height: 50px;
	padding-top: 25px;
	margin-bottom: 10px;
}
.spinner-container {
	display: block;
	width: 100%;
}
#messageBanner {
	width: 100%;
	margin-left: 0px;
	margin-right: 0px;
	margin-top: 10px;
	background-color: #f5f5f5;
	box-sizing: border-box;
}
#messageBanner p {
	margin-top: 0.25em;
	margin-bottom: 0.25em;
}
#messageBanner h3 {
	margin-top: 0.25em;
	margin-bottom: 0.25em;
}
div#message-controls {
	padding-top: 0px;
}
#close-button-row, #return-button-row {
	margin-bottom: 10px;
	margin-top: 10px;
}
.error {
	color: #fff;
	background-color: #f00 !important;
}
.spinner {
	display: block;
	width: 120px;
	height: 120px;
}
#otp-error-message {
	margin-top: 10px;
	position: relative;
	background-color: #f5f5f5;
	text-align: center;
	width: 300px;
	margin-left: 56px;
	padding: 12px;
}
#otp-error-message:after {
	content: '''';
	position: absolute;
	top: 0;
	left: 0px;
	width: 0;
	height: 0;
	border: 10px solid transparent;
	border-bottom-color: #f5f5f5;
	border-top: 0;
	margin-left: 166px;
	margin-top: -10px;
}
#otp-error-message p {
	color: #d00;
}
#meansSelect {
	padding-top: 10px;
	padding-bottom: 10px;
	text-align: center;
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
#mtan_ctrl {
	align-content: center;
}
#itan_ctrl {
	align-content: center;
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
	#main-container {
		width: auto;
	}
	body {
		font-size: 14px;
	}
	#header {
		height: 65px;
	}
	.transactiondetails ul li {
		text-align: left;
	}
	.transactiondetails ul li label {
		display: block;
		float: left;
		width: 50%;
		text-align: right;
		font-size: 14px;
		color: #909090;
		margin-right: 0.5em;
	}
	.transactiondetails ul li span.value {
		clear: both;
		text-align: left;
		margin-left: 0.5em;
	}
	.mtan-input {
		display: flex;
		flex-direction: column;
		width: 100%;
		padding-bottom: 1em;
		padding-top: 1em;
	}
	.resendTan {
		margin-left: 0px;
		flex-grow: 2;
	}
	.resendTan a {
		color: #06c2d4;
		margin-left: 90px;
		padding-left: 16px;
	}
	.mtan-label {
		flex: 0 0 90px;
	}
	.input-label {}
	.otp-field {
		display: inline;
	}
	.otp-field input {}
	#main-container #footer {
		width: 100%;
		clear: both;
		margin-top: 3em;
		background-image: none;
	}
	.help-link {
		width: 100%;
		order: 2;
		text-align: center;
		padding-top: 1em;
	}
	.contact {
		width: 100%;
		order: 1;
	}
	#footer .small-font {
		font-size: 0.75em;
	}
	#otp-error-message {
		margin-top: 0px;
		position: relative;
		background-color: #f5f5f5;
		text-align: center;
		width: 100%;
		margin-left: 0px;
		margin-bottom: 16px;
		box-sizing: border-box;
	}
	#otp-error-message:after {
		content: '''';
		position: absolute;
		top: 0;
		left: 0px;
		width: 0;
		height: 0;
		border: 10px solid transparent;
		border-bottom-color: #f5f5f5;
		border-top: 0;
		margin-left: 50%;
		margin-top: -10px;
	}
}
</style>
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
	<message-banner back-button="''network_means_pageType_5''"></message-banner>
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
	</div>
</div>' WHERE `fk_id_layout` = @layoutId;

SET @pageType = 'REFUSAL_PAGE';
SET @layoutId = (SELECT id FROM CustomPageLayout WHERE pageType = @pageType AND  description = 'Refusal Page (Comdirect)');

UPDATE `CustomComponent` SET `value` = '
<div id="main-container">

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
	}
	#main-container #content .transactiondetails .h3, h3 {
		margin-left: 185px;
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
		flex-direction: row;
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
	#cancelButton {
		background-color: #f4f4f4;
		border-radius: 20px;
		border: 0px;
		height: 40px;
		width: 120px;
		margin-left: 10px;
		align-content: flex-start;
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
		padding: 7px 10px 5px;
		height: 20px;
		box-shadow: rgba(0, 0, 0, 0.15) 1px 1px 3px 0 inset;
	}
	.spinner-container {
		display: block;
		width: 100%;
	}
	#messageBanner {
		width: 100%;
		border-radius: 10px;
		margin-left: 0px;
		margin-right: 0px;
		margin-top: 10px;
		margin-bottom: 10px;
		background-color: #f5f5f5;
		padding: 10px;
		box-sizing: border-box;
	}
	.error {
		color: #fff;
		background-color: #f00 !important;
	}
	#messageBanner p {
		margin-top: 0.25em;
		margin-bottom: 0.25em;
	}
	#messageBanner h3 {
		margin-top: 0.25em;
		margin-bottom: 0.25em;
	}
	div#message-content {
		padding: 10px;
	}
	.spinner {
		display: block;
		width: 120px;
		height: 120px;
		margin-left: auto;
		margin-right: auto;
	}
	#otp-error-message {
		margin-top: 10px;
		position: relative;
		background-color: #f5f5f5;
		text-align: center;
		width: 300px;
		margin-left: 56px;
		padding: 12px;
	}
	#otp-error-message:after {
		content: '''';
		position: absolute;
		top: 0;
		left: 0px;
		width: 0;
		height: 0;
		border: 10px solid transparent;
		border-bottom-color: #f5f5f5;
		border-top: 0;
		margin-left: 166px;
		margin-top: -10px;
	}
	#otp-error-message p {
		color: #d00;
	}
	#meansSelect {
		padding-top: 10px;
		padding-bottom: 10px;
		text-align: center;
	}
	.autharea {
		display: flex;
		flex-direction: row;
		align-items: center;
		padding-top: 10px;
		padding-bottom: 10px;
	}
	#tan_input_ctrl {
		display: flex;
		flex-direction: row;
		align-items: center;
	}
	#phototan_ctrl {
		align-content: center;
	}
	#mtan_ctrl {
		align-content: center;
	}
	#itan_ctrl {
		align-content: center;
	}
	#phototanImg {
		text-align: center;
		margin-top: 12px;
		margin-bottom: 12px;
	}
	@media (max-width: 560px) {
		#main-container {
			width: auto;
		}
		body {
			font-size: 14px;
		}
		#header {
			height: 65px;
		}
		.transactiondetails ul li {
			text-align: left;
		}
		.transactiondetails ul li label {
			display: block;
			float: left;
			width: 50%;
			text-align: right;
			font-size: 14px;
			color: #909090;
			margin-right: 0.5em;
		}
		.transactiondetails ul li span.value {
			clear: both;
			text-align: left;
			margin-left: 0.5em;
		}
		.mtan-input {
			display: flex;
			flex-direction: column;
			width: 100%;
			padding-bottom: 1em;
			padding-top: 1em;
		}
		.resendTan {
			margin-left: 0px;
			flex-grow: 2;
		}
		.resendTan a {
			color: #06c2d4;
			margin-left: 90px;
			padding-left: 16px;
		}
		.mtan-label {
			flex: 0 0 90px;
		}
		.input-label {
		}
		.otp-field {
			display: inline;
		}
		.otp-field input {
		}
		#main-container #footer {
			width: 100%;
			clear: both;
			margin-top: 3em;
			background-image: none;
		}
		.help-link {
			width: 100%;
			order: 2;
			text-align: center;
			padding-top: 1em;
		}
		.contact {
			width: 100%;
			order: 1;
		}
		#footer .small-font {
			font-size: 0.75em;
		}
		#otp-error-message {
			margin-top: 0px;
			position: relative;
			background-color: #f5f5f5;
			text-align: center;
			width: 100%;
			margin-left: 0px;
			margin-bottom: 16px;
			box-sizing: border-box;
		}
		#otp-error-message:after {
			content: '''';
			position: absolute;
			top: 0;
			left: 0px;
			width: 0;
			height: 0;
			border: 10px solid transparent;
			border-bottom-color: #f5f5f5;
			border-top: 0;
			margin-left: 50%;
			margin-top: -10px;
		}
	}
</style>

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



	<div id="main-container">

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
	#cancelButton {
		background-color: #f4f4f4;
		border-radius: 20px;
		border: 0px;
		height: 40px;
		width: 120px;
		margin-left: 10px;
		align-content: flex-start;
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
		padding: 7px 10px 5px;
		height: 20px;
		box-shadow: rgba(0, 0, 0, 0.15) 1px 1px 3px 0 inset;
	}
	.spinner-container {
		display: block;
		width: 100%;
	}
	#messageBanner {
		width: 100%;
		border-radius: 10px;
		margin-left: 0px;
		margin-right: 0px;
		margin-top: 10px;
		margin-bottom: 10px;
		background-color: #f5f5f5;
		padding: 10px;
		box-sizing: border-box;
	}
	.error {
		color: #fff;
		background-color: #f00 !important;
	}
	#messageBanner p {
		margin-top: 0.25em;
		margin-bottom: 0.25em;
	}
	#messageBanner h3 {
		margin-top: 0.25em;
		margin-bottom: 0.25em;
	}
	.spinner {
		display: block;
		width: 120px;
		height: 120px;
		margin-left: auto;
		margin-right: auto;
	}
	#otp-error-message {
		margin-top: 10px;
		position: relative;
		background-color: #f5f5f5;
		text-align: center;
		width: 300px;
		margin-left: 56px;
		padding: 12px;
	}
	#otp-error-message:after {
		content: '''';
		position: absolute;
		top: 0;
		left: 0px;
		width: 0;
		height: 0;
		border: 10px solid transparent;
		border-bottom-color: #f5f5f5;
		border-top: 0;
		margin-left: 166px;
		margin-top: -10px;
	}
	#otp-error-message p {
		color: #d00;
	}
	#meansSelect {
		padding-top: 10px;
		padding-bottom: 10px;
		text-align: center;
	}
	.autharea {
		display: flex;
		flex-direction: row;
		align-items: center;
		padding-top: 10px;
		padding-bottom: 10px;
	}
	#tan_input_ctrl {
		display: flex;
		flex-direction: row;
		align-items: center;
	}
	#phototan_ctrl {
		align-content: center;
	}
	#mtan_ctrl {
		align-content: center;
	}
	#itan_ctrl {
		align-content: center;
	}
	#phototanImg {
		text-align: center;
		margin-top: 12px;
		margin-bottom: 12px;
	}
	@media (max-width: 560px) {
		#main-container {
			width: auto;
		}
		body {
			font-size: 14px;
		}
		#header {
			height: 65px;
		}
		.transactiondetails ul li {
			text-align: left;
		}
		.transactiondetails ul li label {
			display: block;
			float: left;
			width: 50%;
			text-align: right;
			font-size: 14px;
			color: #909090;
			margin-right: 0.5em;
		}
		.transactiondetails ul li span.value {
			clear: both;
			text-align: left;
			margin-left: 0.5em;
		}
		.mtan-input {
			display: flex;
			flex-direction: column;
			width: 100%;
			padding-bottom: 1em;
			padding-top: 1em;
		}
		.resendTan {
			margin-left: 0px;
			flex-grow: 2;
		}
		.resendTan a {
			color: #06c2d4;
			margin-left: 90px;
			padding-left: 16px;
		}
		.mtan-label {
			flex: 0 0 90px;
		}
		.input-label {
		}
		.otp-field {
			display: inline;
		}
		.otp-field input {
		}
		#main-container #footer {
			width: 100%;
			clear: both;
			margin-top: 3em;
			background-image: none;
		}
		.help-link {
			width: 100%;
			order: 2;
			text-align: center;
			padding-top: 1em;
		}
		.contact {
			width: 100%;
			order: 1;
		}
		#footer .small-font {
			font-size: 0.75em;
		}
		#otp-error-message {
			margin-top: 0px;
			position: relative;
			background-color: #f5f5f5;
			text-align: center;
			width: 100%;
			margin-left: 0px;
			margin-bottom: 16px;
			box-sizing: border-box;
		}
		#otp-error-message:after {
			content: '''';
			position: absolute;
			top: 0;
			left: 0px;
			width: 0;
			height: 0;
			border: 10px solid transparent;
			border-bottom-color: #f5f5f5;
			border-top: 0;
			margin-left: 50%;
			margin-top: -10px;
		}
	}


</style>
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
  <span id="info-icon" class="col-xs-12 col-sm-1 fa fa-info-circle"></span>
  <custom-text id="headingTxt" custom-text-key="$parent.heading"></custom-text>
  <custom-text id="message" custom-text-key="$parent.message"></custom-text>

  <style>
	span#info-icon {
		left: auto;
	}
	#headingTxt {
		font-size : large;
		font-weight : bold;
		width : 80%;
		margin : auto;
		display : block;
	}
  </style>

  ' WHERE `fk_id_layout` = @layoutId;

SET @pageType = 'HELP_PAGE';
SET @layoutId = (SELECT id FROM CustomPageLayout WHERE pageType = @pageType AND  description = 'Help Page (Comdirect)');

UPDATE `CustomComponent` SET `value` = '
	<div id="main-container">
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
		flex-direction: row;
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
	#cancelButton {
		background-color: #f4f4f4;
		border-radius: 20px;
		border: 0px;
		height: 40px;
		width: 120px;
		margin-left: 10px;
		align-content: flex-start;
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
		padding: 7px 10px 5px;
		height: 20px;
		box-shadow: rgba(0, 0, 0, 0.15) 1px 1px 3px 0 inset;
	}
	.spinner-container {
		display: block;
		width: 100%;
	}
	#messageBanner {
		width: 100%;
		border-radius: 10px;
		margin-left: 0px;
		margin-right: 0px;
		margin-top: 10px;
		margin-bottom: 10px;
		background-color: #f5f5f5;
		padding: 10px;
		box-sizing: border-box;
	}
	.error {
		color: #fff;
		background-color: #f00 !important;
	}
	#messageBanner p {
		margin-top: 0.25em;
		margin-bottom: 0.25em;
	}
	#messageBanner h3 {
		margin-top: 0.25em;
		margin-bottom: 0.25em;
	}
	.spinner {
		display: block;
		width: 120px;
		height: 120px;
		margin-left: auto;
		margin-right: auto;
	}
	#otp-error-message {
		margin-top: 10px;
		position: relative;
		background-color: #f5f5f5;
		text-align: center;
		width: 300px;
		margin-left: 56px;
		padding: 12px;
	}
	#otp-error-message:after {
		content: '''';
		position: absolute;
		top: 0;
		left: 0px;
		width: 0;
		height: 0;
		border: 10px solid transparent;
		border-bottom-color: #f5f5f5;
		border-top: 0;
		margin-left: 166px;
		margin-top: -10px;
	}
	#otp-error-message p {
		color: #d00;
	}
	#meansSelect {
		padding-top: 10px;
		padding-bottom: 10px;
		text-align: center;
	}
	.autharea {
		display: flex;
		flex-direction: row;
		align-items: center;
		padding-top: 10px;
		padding-bottom: 10px;
	}
	#tan_input_ctrl {
		display: flex;
		flex-direction: row;
		align-items: center;
	}
	#phototan_ctrl {
		align-content: center;
	}
	#mtan_ctrl {
		align-content: center;
	}
	#itan_ctrl {
		align-content: center;
	}
	#phototanImg {
		text-align: center;
		margin-top: 12px;
		margin-bottom: 12px;
	}
	@media (max-width: 560px) {
		#main-container {
			width: auto;
		}
		body {
			font-size: 14px;
		}
		#header {
			height: 65px;
		}
		.transactiondetails ul li {
			text-align: left;
		}
		.transactiondetails ul li label {
			display: block;
			float: left;
			width: 50%;
			text-align: right;
			font-size: 14px;
			color: #909090;
			margin-right: 0.5em;
		}
		.transactiondetails ul li span.value {
			clear: both;
			text-align: left;
			margin-left: 0.5em;
		}
		.mtan-input {
			display: flex;
			flex-direction: column;
			width: 100%;
			padding-bottom: 1em;
			padding-top: 1em;
		}
		.resendTan {
			margin-left: 0px;
			flex-grow: 2;
		}
		.resendTan a {
			color: #06c2d4;
			margin-left: 90px;
			padding-left: 16px;
		}
		.mtan-label {
			flex: 0 0 90px;
		}
		.input-label {
		}
		.otp-field {
			display: inline;
		}
		.otp-field input {
		}
		#main-container #footer {
			width: 100%;
			clear: both;
			margin-top: 3em;
			background-image: none;
		}
		.help-link {
			width: 100%;
			order: 2;
			text-align: center;
			padding-top: 1em;
		}
		.contact {
			width: 100%;
			order: 1;
		}
		#footer .small-font {
			font-size: 0.75em;
		}
		#otp-error-message {
			margin-top: 0px;
			position: relative;
			background-color: #f5f5f5;
			text-align: center;
			width: 100%;
			margin-left: 0px;
			margin-bottom: 16px;
			box-sizing: border-box;
		}
		#otp-error-message:after {
			content: '''';
			position: absolute;
			top: 0;
			left: 0px;
			width: 0;
			height: 0;
			border: 10px solid transparent;
			border-bottom-color: #f5f5f5;
			border-top: 0;
			margin-left: 50%;
			margin-top: -10px;
		}
	}


</style>
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

			<custom-text custom-text-key="''network_means_pageType_2''" id="paragraph1"></custom-text>
		</div>
	</div>

	<div id="footer">

		<val-button id="validateButton"></val-button>
	</div>

</div>
  ' WHERE `fk_id_layout` = @layoutId;


SET @locale = 'de';
SET @updateState =  'PUSHED_TO_CONFIG';
SET @networkVName = (SELECT `name` FROM `Network` WHERE `code` = 'VISA');


SET @customItemSetRefusal = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_16600_DEFAULT_REFUSAL');
SET @pageType = 'REFUSAL_PAGE';

SET @ordinal = 22;
SET @textValue = 'Die Zahlung ist nicht möglich.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetRefusal AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 23;
SET @textValue = 'Die Zahlung konnte nicht durchgeführt werden. Bei Fragen wenden Sie sich bitte telefonisch an unsere Kundenbetreuung unter 04106 – 708 25 00.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetRefusal AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 32;
SET @textValue = 'Technischer Fehler.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetRefusal AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 33;
SET @textValue = 'Es ist ein technischer Fehler aufgetreten. Wir arbeiten schnellstmöglich an der Behebung des Problems. Bei Fragen wenden Sie sich bitte telefonisch an unsere Kundenbetreuung unter 04106 – 708 25 00.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetRefusal AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 16;
SET @textValue = 'Der Zugang wurde gesperrt.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetRefusal AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 17;
SET @textValue = 'Aus Sicherheitsgründen haben wir Ihren Zugang zu Visa Secure und dem comdirect Online-Banking gesperrt. Für Fragen zur Entsperrung wenden Sie sich bitte telefonisch an unsere Kundenbetreuung unter 04106 – 708 25 00.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetRefusal AND ordinal = @ordinal AND pageTypes = @pageType;

SET @pageType = 'HELP_PAGE';
SET @ordinal = 1;
SET @textValue = 'Hilfe 1';
SET @customItemSetRefusalFraud = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_16600_FRAUD_REFUSAL');
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN(@customItemSetRefusal, @customItemSetRefusalFraud) AND ordinal = @ordinal AND pageTypes = @pageType;
DELETE FROM `CustomItem` WHERE `fk_id_customItemSet` IN(@customItemSetRefusal, @customItemSetRefusalFraud) AND `ordinal` = 3 AND `pageTypes` = 'HELP_PAGE';


SET @customItemSetPassword = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_16600_PASSWORD');
SET @pageType = 'OTP_FORM_PAGE';

SET @ordinal = 2;
SET @textValue = '<b>Bitte bestätigen Sie folgende Zahlung</b>';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetPassword AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 1;
SET @textValue = '<b>Bitte geben Sie zunächst Ihre 6-stellige Online-Banking PIN ein:</b>';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetPassword AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 42;
SET @textValue = 'Freigeben';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetPassword AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 12;
SET @textValue = 'Authentifizierung läuft';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetPassword AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 13;
SET @textValue = 'Bitte warten Sie ein paar Sekunden, um Ihre  Eingabe zu überprüfen.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetPassword AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 14;
SET @textValue = 'Die Zahlung wurde abgebrochen';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetPassword AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 15;
SET @textValue = 'Starten Sie den Bezahlvorgang erneut, wenn Sie die Zahlung abschließen möchten.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetPassword AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 26;
SET @textValue = 'Authentifizierung wird fortgesetzt.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetPassword AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 27;
SET @textValue = '';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetPassword AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 30;
SET @textValue = 'Die Session ist abgelaufen.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetPassword AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 31;
SET @textValue = 'Sie haben einige Zeit keine Eingabe vorgenommen, daher wurde die Zahlung abgebrochen. Starten Sie den Bezahlvorgang erneut, wenn Sie die Zahlung abschließen möchten.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetPassword AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 32;
SET @textValue = 'Technischer Fehler.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetPassword AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 33;
SET @textValue = 'Es ist ein technischer Fehler aufgetreten. Wir arbeiten schnellstmöglich an der Behebung des Problems. Bei Fragen wenden Sie sich bitte telefonisch an unsere Kundenbetreuung unter 04106– 708 25 00.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetPassword AND ordinal = @ordinal AND pageTypes = @pageType;

SET @currentAuthentMean = 'EXT_PASSWORD';
SET @currentPageType = 'EXT_PASSWORD_OTP_FORM_PAGE';

DELETE FROM `CustomItem` WHERE `fk_id_customItemSet` = @customItemSetPassword AND `ordinal` = 41 AND `pageTypes` = 'OTP_FORM_PAGE';
DELETE FROM `CustomItem` WHERE `fk_id_customItemSet` = @customItemSetPassword AND `ordinal` = 1 AND `pageTypes` = 'HELP_PAGE';
DELETE FROM `CustomItem` WHERE `fk_id_customItemSet` = @customItemSetPassword AND `ordinal` = 3 AND `pageTypes` = 'HELP_PAGE';

SET @pageType = 'FAILURE_PAGE';
SET @ordinal = 16;
SET @textValue = 'Der Zugang wurde gesperrt.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetPassword AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 17;
SET @textValue = 'Aus Sicherheitsgründen haben wir Ihren Zugang zu Visa Secure und dem comdirect Online-Banking gesperrt. Für Fragen zur Entsperrung wenden Sie sich bitte telefonisch an unsere Kundenbetreuung unter 04106 – 708 25 00.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetPassword AND ordinal = @ordinal AND pageTypes = @pageType;

SET @pageType = 'ALL';
SET @ordinal = 175;
SET @textValue = 'Zurück zum Händler';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetPassword AND ordinal = @ordinal AND pageTypes = @pageType;



SET @customItemSetPhotoTan_1 = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_16600_PHOTOTAN_1');
SET @customItemSetPhotoTan_2 = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_16600_PHOTOTAN_2');
SET @pageType = 'OTP_FORM_PAGE';

SET @ordinal = 1;
SET @textValue = 'Bitte bestätigen Sie folgende Zahlung.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN(@customItemSetPhotoTan_1, @customItemSetPhotoTan_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 12;
SET @textValue = 'Authentifizierung läuft';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN(@customItemSetPhotoTan_1, @customItemSetPhotoTan_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 13;
SET @textValue = 'Bitte warten Sie ein paar Sekunden, um Ihre  Eingabe zu überprüfen.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN(@customItemSetPhotoTan_1, @customItemSetPhotoTan_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 14;
SET @textValue = 'Die Zahlung wurde abgebrochen';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN(@customItemSetPhotoTan_1, @customItemSetPhotoTan_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 15;
SET @textValue = 'Starten Sie den Bezahlvorgang erneut, wenn Sie die Zahlung abschließen möchten.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN(@customItemSetPhotoTan_1, @customItemSetPhotoTan_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 26;
SET @textValue = 'Authentifizierung erfolgreich';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN(@customItemSetPhotoTan_1, @customItemSetPhotoTan_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 27;
SET @textValue = 'Sie wurden erfolgreich authentifiziert und werden automatisch zum Händler weitergeleitet.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN(@customItemSetPhotoTan_1, @customItemSetPhotoTan_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 30;
SET @textValue = 'Die Session ist abgelaufen.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN(@customItemSetPhotoTan_1, @customItemSetPhotoTan_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 31;
SET @textValue = 'Sie haben einige Zeit keine Eingabe vorgenommen, daher wurde die Zahlung abgebrochen. Starten Sie den Bezahlvorgang erneut, wenn Sie die Zahlung abschließen möchten.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN(@customItemSetPhotoTan_1, @customItemSetPhotoTan_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 32;
SET @textValue = 'Technischer Fehler.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN(@customItemSetPhotoTan_1, @customItemSetPhotoTan_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 33;
SET @textValue = 'Es ist ein technischer Fehler aufgetreten. Wir arbeiten schnellstmöglich an der Behebung des Problems. Bei Fragen wenden Sie sich bitte telefonisch an unsere Kundenbetreuung unter 04106– 708 25 00.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN(@customItemSetPhotoTan_1, @customItemSetPhotoTan_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @pageType = 'FAILURE_PAGE';
SET @ordinal = 16;
SET @textValue = 'Der Zugang wurde gesperrt.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN(@customItemSetPhotoTan_1, @customItemSetPhotoTan_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 17;
SET @textValue = 'Aus Sicherheitsgründen haben wir Ihren Zugang zu Visa Secure und dem comdirect Online-Banking gesperrt. Für Fragen zur Entsperrung wenden Sie sich bitte telefonisch an unsere Kundenbetreuung unter 04106 – 708 25 00.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN(@customItemSetPhotoTan_1, @customItemSetPhotoTan_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 30;
SET @textValue = 'Die Session ist abgelaufen.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN(@customItemSetPhotoTan_1, @customItemSetPhotoTan_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 31;
SET @textValue = 'Sie haben einige Zeit keine Eingabe vorgenommen, daher wurde die Zahlung abgebrochen. Starten Sie den Bezahlvorgang erneut, wenn Sie die Zahlung abschließen möchten.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN(@customItemSetPhotoTan_1, @customItemSetPhotoTan_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 32;
SET @textValue = 'Technischer Fehler.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN(@customItemSetPhotoTan_1, @customItemSetPhotoTan_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 33;
SET @textValue = 'Es ist ein technischer Fehler aufgetreten. Wir arbeiten schnellstmöglich an der Behebung des Problems. Bei Fragen wenden Sie sich bitte telefonisch an unsere Kundenbetreuung unter 04106– 708 25 00.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN(@customItemSetPhotoTan_1, @customItemSetPhotoTan_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @pageType = 'ALL';
SET @currentPageType = 'OTP_FORM_PAGE';
SET @currentAuthentMean_1 = 'PHOTOTAN_1';
SET @currentAuthentMean_2 = 'PHOTOTAN_2';
SET @ordinal = 5;
SET @textValue = '';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetPhotoTan_1 AND ordinal = @ordinal AND pageTypes = @pageType;
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetPhotoTan_2 AND ordinal = @ordinal AND pageTypes = @pageType;



SET @pageType = 'HELP_PAGE';
SET @ordinal = 1;
SET @textValue = '';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetPhotoTan_1 AND ordinal = @ordinal AND pageTypes = @pageType;
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetPhotoTan_2 AND ordinal = @ordinal AND pageTypes = @pageType;
DELETE FROM `CustomItem` WHERE `fk_id_customItemSet` IN (@customItemSetPhotoTan_1, @customItemSetPhotoTan_2) AND `ordinal` = 3 AND `pageTypes` = 'HELP_PAGE';


SET @customItemSetSMS_1 = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_16600_SMS_1');
SET @customItemSetSMS_2 = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_16600_SMS_2');
SET @pageType = 'OTP_FORM_PAGE';

SET @ordinal = 1;
SET @textValue = 'Bitte bestätigen Sie folgende Zahlung.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN (@customItemSetSMS_1, @customItemSetSMS_2)  AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 12;
SET @textValue = 'Authentifizierung läuft';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet  IN (@customItemSetSMS_1, @customItemSetSMS_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 13;
SET @textValue = 'Bitte warten Sie ein paar Sekunden, um Ihre  Eingabe zu überprüfen.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN (@customItemSetSMS_1, @customItemSetSMS_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 14;
SET @textValue = 'Die Zahlung wurde abgebrochen';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN (@customItemSetSMS_1, @customItemSetSMS_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 15;
SET @textValue = 'Starten Sie den Bezahlvorgang erneut, wenn Sie die Zahlung abschließen möchten.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN (@customItemSetSMS_1, @customItemSetSMS_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 26;
SET @textValue = 'Authentifizierung erfolgreich';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN (@customItemSetSMS_1, @customItemSetSMS_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 27;
SET @textValue = 'Sie wurden erfolgreich authentifiziert und werden automatisch zum Händler weitergeleitet.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN (@customItemSetSMS_1, @customItemSetSMS_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 30;
SET @textValue = 'Die Session ist abgelaufen.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN (@customItemSetSMS_1, @customItemSetSMS_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 31;
SET @textValue = 'Sie haben einige Zeit keine Eingabe vorgenommen, daher wurde die Zahlung abgebrochen. Starten Sie den Bezahlvorgang erneut, wenn Sie die Zahlung abschließen möchten.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN (@customItemSetSMS_1, @customItemSetSMS_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 32;
SET @textValue = 'Technischer Fehler.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN (@customItemSetSMS_1, @customItemSetSMS_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 33;
SET @textValue = 'Es ist ein technischer Fehler aufgetreten. Wir arbeiten schnellstmöglich an der Behebung des Problems. Bei Fragen wenden Sie sich bitte telefonisch an unsere Kundenbetreuung unter 04106– 708 25 00.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN (@customItemSetSMS_1, @customItemSetSMS_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @pageType = 'FAILURE_PAGE';
SET @ordinal = 16;
SET @textValue = 'Der Zugang wurde gesperrt.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN (@customItemSetSMS_1, @customItemSetSMS_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 17;
SET @textValue = 'Aus Sicherheitsgründen haben wir Ihren Zugang zu Visa Secure und dem comdirect Online-Banking gesperrt. Für Fragen zur Entsperrung wenden Sie sich bitte telefonisch an unsere Kundenbetreuung unter 04106 – 708 25 00.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN (@customItemSetSMS_1, @customItemSetSMS_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 30;
SET @textValue = 'Die Session ist abgelaufen.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN (@customItemSetSMS_1, @customItemSetSMS_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 31;
SET @textValue = 'Sie haben einige Zeit keine Eingabe vorgenommen, daher wurde die Zahlung abgebrochen. Starten Sie den Bezahlvorgang erneut, wenn Sie die Zahlung abschließen möchten.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN (@customItemSetSMS_1, @customItemSetSMS_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 32;
SET @textValue = 'Technischer Fehler.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN (@customItemSetSMS_1, @customItemSetSMS_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 33;
SET @textValue = 'Es ist ein technischer Fehler aufgetreten. Wir arbeiten schnellstmöglich an der Behebung des Problems. Bei Fragen wenden Sie sich bitte telefonisch an unsere Kundenbetreuung unter 04106– 708 25 00.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN (@customItemSetSMS_1, @customItemSetSMS_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @pageType = 'ALL';
SET @ordinal = 5;
SET @textValue = 'Zurück zum Händler';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN (@customItemSetSMS_1, @customItemSetSMS_2) AND ordinal = @ordinal AND pageTypes = @pageType;

SET @pageType = 'HELP_PAGE';
SET @ordinal = 1;
SET @textValue = '';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet IN (@customItemSetSMS_1, @customItemSetSMS_2) AND ordinal = @ordinal AND pageTypes = @pageType;
DELETE FROM `CustomItem` WHERE `fk_id_customItemSet` IN(@customItemSetSMS_1,@customItemSetSMS_2) AND `ordinal` = 3 AND `pageTypes` = 'HELP_PAGE';


SET @customItemSetApp = (SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_16600_APP_1');
SET @pageType = 'POLLING_PAGE';

SET @ordinal = 1;
SET @textValue = 'Bitte bestätigen Sie folgende Zahlung';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetApp AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 2;
SET @textValue = 'Freigabe mit photoTAN App';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetApp AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 3;
SET @textValue = 'Öffnen Sie jetzt die photoTAN App, um die Zahlung dort freizugeben.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetApp AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 14;
SET @textValue = 'Die Zahlung wurde abgebrochen';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetApp AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 15;
SET @textValue = 'Starten Sie den Bezahlvorgang erneut, wenn Sie die Zahlung abschließen möchten.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetApp AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 26;
SET @textValue = 'Authentifizierung erfolgreich';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetApp AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 27;
SET @textValue = 'Sie wurden erfolgreich authentifiziert und werden automatisch zum Händler weitergeleitet.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetApp AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 30;
SET @textValue = 'Die Session ist abgelaufen.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetApp AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 31;
SET @textValue = 'Sie haben einige Zeit keine Eingabe vorgenommen, daher wurde die Zahlung abgebrochen. Starten Sie den Bezahlvorgang erneut, wenn Sie die Zahlung abschließen möchten.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetApp AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 32;
SET @textValue = 'Technischer Fehler.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetApp AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 33;
SET @textValue = 'Es ist ein technischer Fehler aufgetreten. Wir arbeiten schnellstmöglich an der Behebung des Problems. Bei Fragen wenden Sie sich bitte telefonisch an unsere Kundenbetreuung unter 04106– 708 25 00.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetApp AND ordinal = @ordinal AND pageTypes = @pageType;

SET @pageType = 'FAILURE_PAGE';
SET @ordinal = 16;
SET @textValue = 'Der Zugang wurde gesperrt.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetApp AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 17;
SET @textValue = 'Aus Sicherheitsgründen haben wir Ihren Zugang zu Visa Secure und dem comdirect Online-Banking gesperrt. Für Fragen zur Entsperrung wenden Sie sich bitte telefonisch an unsere Kundenbetreuung unter 04106 – 708 25 00.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetApp AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 32;
SET @textValue = 'Technischer Fehler.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetApp AND ordinal = @ordinal AND pageTypes = @pageType;

SET @ordinal = 33;
SET @textValue = 'Es ist ein technischer Fehler aufgetreten. Wir arbeiten schnellstmöglich an der Behebung des Problems. Bei Fragen wenden Sie sich bitte telefonisch an unsere Kundenbetreuung unter 04106– 708 25 00.';
UPDATE CustomItem SET value = @textValue WHERE fk_id_customItemSet = @customItemSetApp AND ordinal = @ordinal AND pageTypes = @pageType;

DELETE FROM `CustomItem` WHERE `fk_id_customItemSet`= @customItemSetApp  AND `ordinal` = 41 AND `pageTypes` = 'POLLING_PAGE';
DELETE FROM `CustomItem` WHERE `fk_id_customItemSet`= @customItemSetApp  AND `ordinal` = 175 AND `pageTypes` = 'ALL';
DELETE FROM `CustomItem` WHERE `fk_id_customItemSet`= @customItemSetApp  AND `ordinal` = 1 AND `pageTypes` = 'HELP_PAGE';
DELETE FROM `CustomItem` WHERE `fk_id_customItemSet`= @customItemSetApp  AND `ordinal` = 3 AND `pageTypes` = 'HELP_PAGE';
