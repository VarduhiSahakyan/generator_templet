USE `U5G_ACS_BO`;

set @id_layout = (SELECT id from `CustomPageLayout` where `description` LIKE ('%Comdirect%') and `pageType` = 'OTP_FORM_PAGE');

UPDATE `CustomComponent` SET `value` = '
<div id="main-container">

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

.fa-ban { display:none; }

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

.fa-check-square {display:none}
.fa-ban { display:none; }

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

input {
border: 1px solid #d1d1d1;
border-radius: 6px;
color: #464646;
height: 20px;
box-shadow: rgba(0,0,0,0.15) 1px 1px 3px 0 inset;
}

/* message banner overrides */

message-banner #spinner-row {
	height: 50px;
    padding-top: 25px;
    margin-bottom: 10px;
}

.spinner-container {
	display:block;
	width:100%;
}

#messageBanner {
	width:100%;
	margin-left:0px;
	margin-right:0px;
	margin-top:10px;
	background-color:#F5F5F5;
	box-sizing:border-box;
}

#messageBanner p {
	margin-top:0.25em;
	margin-bottom:0.25em;
}

#messageBanner h3 {
	margin-top:0.25em;
	margin-bottom:0.25em;
}

div#message-controls {
	padding-top:0px;
}

#close-button-row, #return-button-row {
	margin-bottom:10px;
	margin-top:10px;
}

.error {
	color:#FFF;
	background-color: #F00 !important;
}


.spinner {
	display:block;
	width:120px;
	height:120px;
}



	#otp-error-message {
		margin-top:10px;
		position: relative;
		background-color: #F5F5F5;
		text-align:center;
		width:300px;
		margin-left:56px;
		padding:12px;
	}

	#otp-error-message:after {
		content: \'\';
		position: absolute;
		top: 0;
		left: 0px;
		width: 0;
		height: 0;
		border: 10px solid transparent;
		border-bottom-color: #F5F5F5;
		border-top: 0;
		margin-left: 166px;
		margin-top: -10px;
	}

	#otp-error-message p {
		color:#D00;
	}


	#meansSelect {
		padding-top:10px;
		padding-bottom:10px;
		text-align: center;
	}

	#tan_input_ctrl {
		align-items: center;
	}

	.autharea {
		padding-top:10px;
		padding-bottom:10px;
	}

	external-image {
	    margin-left: auto;
	    margin-right: auto;
	    display: block;
	    width: 214px;
    }

	#phototan_ctrl {
		align-content:center;
	}

    #mtan_ctrl {
		align-content:center;
    }

    #itan_ctrl {
		align-content:center;
    }

	span#tan-label {
		padding-right:5px;
		padding-left:5px;
		margin-left: 8.33333333%;
		width: 41.66666667%;
		text-align:right;
		float:left;
		font-weight:700;
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
		width:auto;
	}

	body {
		font-size:14px;
	}

	#header {
		height:65px;
	}

	.transactiondetails ul li {
		text-align:left;
	}

	.transactiondetails ul li label {
	display:block;
	float:left;
	width:50%;
	text-align: right;
	font-size:14px;
	color: #909090;
	margin-right:0.5em;
	}

	.transactiondetails ul li span.value {
		clear:both;
		text-align: left;
		margin-left:0.5em;
	}

	.mtan-input {
		display: flex;
    	flex-direction: column;
		width:100%;
		padding-bottom:1em;
		padding-top:1em;
	}

	.resendTan {
		margin-left: 0px;
		flex-grow: 2;

	}

	.resendTan a {
		color:#06c2d4;
    	margin-left: 90px;
    	padding-left: 16px;
	}

	.mtan-label {
		flex: 0 0 90px;
	}

	.input-label {
	}


	.otp-field {
		display:inline;
	}

	.otp-field input {
	}

	#main-container #footer {
		width:100%;
		clear:both;
		margin-top:3em;
		background-image:none;
	}

	.help-link {
		width:100%;
		order:2;
		text-align:center;
		padding-top:1em;
	}

	.contact {
		width:100%;
		order:1;
	}

	#footer .small-font {
		font-size:0.75em;
	}

	#otp-error-message {
		margin-top:0px;
		position: relative;
		background-color: #F5F5F5;
		text-align:center;
		width:100%;
		margin-left:0px;
		margin-bottom:16px;
		box-sizing:border-box;
	}

	#otp-error-message:after {

		content: \'\';
		position: absolute;
		top: 0;
		left: 0px;
		width: 0;
		height: 0;
		border: 10px solid transparent;
		border-bottom-color: #F5F5F5;
		border-top: 0;
		margin-left: 50%;
		margin-top: -10px;
	}
}

	</style>
	<div id="header">
		<div id="banklogo">
			<custom-image id="issuerLogo"
                                  alt-key="\'network_means_pageType_170_IMAGE_ALT\'"
                                  image-key="\'network_means_pageType_170_IMAGE_DATA\'"
                                  straight-mode="false">
                    </custom-image>


		</div>
		<div id="schemeLogo">
			 <custom-image id="networkLogo"
                                  alt-key="\'network_means_pageType_171_IMAGE_ALT\'"
                                  image-key="\'network_means_pageType_171_IMAGE_DATA\'"
                                  straight-mode="false">
             </custom-image>
		</div>
	</div>
	<message-banner back-button="\'network_means_pageType_5\'"></message-banner>
	<div id="content">
		<div class="transactiondetails">
			<h3>
				<custom-text custom-text-key="\'network_means_pageType_1\'" id="paragraph1"></custom-text>
			</h3>
			<side-menu></side-menu>
		</div>
		<div class="autharea">

				<div id="tan_input_ctrl">
					<span id="tan-label">
					  <custom-text custom-text-key="\'network_means_pageType_2\'"></custom-text>
					  <custom-text custom-text-key="\'network_means_pageType_4\'"></custom-text>
					</span>
					<div class="otp-field">
					          <otp-form></otp-form>
					</div>
				</div>

		</div>
	</div>

	<div id="footer">
		<cancel-button cn-label="\'network_means_pageType_40\'" id="cancelButton" ></cancel-button>
		<val-button val-label="\'network_means_pageType_6\'" id="validateButton"></val-button>
	</div>

</div>' WHERE `fk_id_layout` = @id_layout;


set @id_layout = (SELECT id from `CustomPageLayout` where `description` LIKE ('%Comdirect%') and `pageType` = 'PHOTO_TAN_OTP_FORM_PAGE');

UPDATE `CustomComponent` SET `value` = '
	<div id="main-container">

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

    .fa-ban { display:none; }
    .fa-check-square {
        display:none;
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

input {
border: 1px solid #d1d1d1;
border-radius: 6px;
color: #464646;
height: 20px;
box-shadow: rgba(0,0,0,0.15) 1px 1px 3px 0 inset;
}

/* message banner overrides */

message-banner #spinner-row {
	height: 50px;
    padding-top: 25px;
    margin-bottom: 10px;
}

.spinner-container {
	display:block;
	width:100%;
}

#messageBanner {
	width:100%;
	margin-left:0px;
	margin-right:0px;
	margin-top:10px;
	background-color:#F5F5F5;
	box-sizing:border-box;
}

#messageBanner p {
	margin-top:0.25em;
	margin-bottom:0.25em;
}

#messageBanner h3 {
	margin-top:0.25em;
	margin-bottom:0.25em;
}

div#message-controls {
	padding-top:0px;
}

#close-button-row, #return-button-row {
	margin-bottom:10px;
	margin-top:10px;
}

.error {
	color:#FFF;
	background-color: #F00 !important;
}


.spinner {
	display:block;
	width:120px;
	height:120px;
}



	#otp-error-message {
		margin-top:10px;
		position: relative;
		background-color: #F5F5F5;
		text-align:center;
		width:300px;
		margin-left:56px;
		padding:12px;
	}

	#otp-error-message:after {
		content: \'\';
		position: absolute;
		top: 0;
		left: 0px;
		width: 0;
		height: 0;
		border: 10px solid transparent;
		border-bottom-color: #F5F5F5;
		border-top: 0;
		margin-left: 166px;
		margin-top: -10px;
	}

	#otp-error-message p {
		color:#D00;
	}


	#meansSelect {
		padding-top:10px;
		padding-bottom:10px;
		text-align: center;
	}

	#tan_input_ctrl {
		align-items: center;
	}

	.autharea {
		padding-top:10px;
		padding-bottom:10px;
	}

	external-image {
	    margin-left: auto;
	    margin-right: auto;
	    display: block;
	    width: 214px;
    }

	#phototan_ctrl {
		align-content:center;
	}

    #mtan_ctrl {
		align-content:center;
    }

    #itan_ctrl {
		align-content:center;
    }

	span#tan-label {
		padding-right:5px;
		padding-left:5px;
		margin-left: 8.33333333%;
		width: 41.66666667%;
		text-align:right;
		float:left;
		font-weight:700;
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
		width:auto;
	}

	body {
		font-size:14px;
	}

	#header {
		height:65px;
	}

	.transactiondetails ul li {
		text-align:left;
	}

	.transactiondetails ul li label {
	display:block;
	float:left;
	width:50%;
	text-align: right;
	font-size:14px;
	color: #909090;
	margin-right:0.5em;
	}

	.transactiondetails ul li span.value {
		clear:both;
		text-align: left;
		margin-left:0.5em;
	}

	.mtan-input {
		display: flex;
    	flex-direction: column;
		width:100%;
		padding-bottom:1em;
		padding-top:1em;
	}

	.resendTan {
		margin-left: 0px;
		flex-grow: 2;

	}

	.resendTan a {
		color:#06c2d4;
    	margin-left: 90px;
    	padding-left: 16px;
	}

	.mtan-label {
		flex: 0 0 90px;
	}

	.input-label {
	}


	.otp-field {
		display:inline;
	}

	.otp-field input {
	}

	#main-container #footer {
		width:100%;
		clear:both;
		margin-top:3em;
		background-image:none;
	}

	.help-link {
		width:100%;
		order:2;
		text-align:center;
		padding-top:1em;
	}

	.contact {
		width:100%;
		order:1;
	}

	#footer .small-font {
		font-size:0.75em;
	}

	#otp-error-message {
		margin-top:0px;
		position: relative;
		background-color: #F5F5F5;
		text-align:center;
		width:100%;
		margin-left:0px;
		margin-bottom:16px;
		box-sizing:border-box;
	}

	#otp-error-message:after {

		content: \'\';
		position: absolute;
		top: 0;
		left: 0px;
		width: 0;
		height: 0;
		border: 10px solid transparent;
		border-bottom-color: #F5F5F5;
		border-top: 0;
		margin-left: 50%;
		margin-top: -10px;
	}
}

	</style>
	<div id="header">
		<div id="banklogo">
			<custom-image id="issuerLogo"
                                  alt-key="\'network_means_pageType_170_IMAGE_ALT\'"
                                  image-key="\'network_means_pageType_170_IMAGE_DATA\'"
                                  straight-mode="false">
                    </custom-image>


		</div>
		<div id="schemeLogo">
			 <custom-image id="networkLogo"
                                  alt-key="\'network_means_pageType_171_IMAGE_ALT\'"
                                  image-key="\'network_means_pageType_171_IMAGE_DATA\'"
                                  straight-mode="false">
             </custom-image>
		</div>
	</div>
	<message-banner back-button="\'network_means_pageType_5\'"></message-banner>
	<div id="content">
		<div class="transactiondetails">
			<h3>
				<custom-text custom-text-key="\'network_means_pageType_1\'" id="paragraph1"></custom-text>
			</h3>
			<side-menu></side-menu>
		</div>
		<div class="autharea">

				<div id="tan_input_ctrl">
				  <custom-text custom-text-key="\'network_means_pageType_2\'" id="tan-label"></custom-text>
				  <!-- output for photo tan -->


					<div class="otp-field">
					          <otp-form></otp-form>
					</div>
					</div>

					<external-image></external-image>

		</div>
	</div>

	<div id="footer">
		<cancel-button cn-label="\'network_means_pageType_40\'" id="cancelButton" ></cancel-button>
		<val-button val-label="\'network_means_pageType_6\'" id="validateButton"></val-button>
	</div>

</div>' WHERE `fk_id_layout` = @id_layout;
