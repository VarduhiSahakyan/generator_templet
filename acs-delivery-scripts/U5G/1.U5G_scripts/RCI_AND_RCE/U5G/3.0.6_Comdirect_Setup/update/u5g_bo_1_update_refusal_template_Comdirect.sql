USE U5G_ACS_BO;

SET @idRefusalPage=(SELECT id FROM `CustomPageLayout` WHERE `pageType`= 'REFUSAL_PAGE' and DESCRIPTION = 'Refusal Page (Comdirect)') ;

UPDATE CustomComponent SET value = '

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
            background: no-repeat url("../img/comdirect_Logo_Schwarz_Master_sRGB.svg")  ;
            background-size:contain;
            height:25px;
            margin-left:5px;
            margin-top:1em;
        }

        #networkLogo {
            background: no-repeat url("../img/verified_logo_white.png");
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

        input {
            border: 1px solid #d1d1d1;
            border-radius: 6px;
            color: #464646;
            padding: 7px 10px 5px;
            height: 20px;
            box-shadow: rgba(0,0,0,0.15) 1px 1px 3px 0 inset;
        }

        .spinner-container {
            display:block;
            width:100%;
        }

        #messageBanner {
            width:100%;
            border-radius: 10px;
            margin-left:0px;
            margin-right:0px;
            margin-top:10px;
            margin-bottom:10px;
            background-color:#F5F5F5;
            padding:10px;
            box-sizing:border-box;
        }

        .error {
            color:#FFF;
            background-color: #F00 !important;
        }

        #messageBanner p {
            margin-top:0.25em;
            margin-bottom:0.25em;
        }

        #messageBanner h3 {
            margin-top:0.25em;
            margin-bottom:0.25em;
        }

        div#message-content {
            padding:10px;
        }

        .spinner {
            display:block;
            width:120px;
            height:120px;
            margin-left:auto;
            margin-right: auto;
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

        .autharea {
            display:flex;
            flex-direction: row;
            align-items: center;
            padding-top:10px;
            padding-bottom:10px;
        }

        #tan_input_ctrl {
            display:flex;
            flex-direction: row;
            align-items: center;
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

        #phototanImg {
            text-align:center;
            margin-top: 12px;
            margin-bottom: 12px;
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
	<message-banner></message-banner>
	<div id="content">
		<div class="transactiondetails">
			<h3>
				<custom-text custom-text-key="\'network_means_pageType_1\'" id="paragraph1"></custom-text>
			</h3>
			<side-menu></side-menu>
		</div>
	</div>

	<div id="footer">
		<val-button id="validateButton"></val-button>
	</div>
</div>
' WHERE `fk_id_layout` = @idRefusalPage;
