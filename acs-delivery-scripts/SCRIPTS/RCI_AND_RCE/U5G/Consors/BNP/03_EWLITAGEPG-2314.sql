USE `U5G_ACS_BO`;

SET @pageLayoutId_Banner = (select id from `CustomPageLayout` where `pageType` = 'MESSAGE_BANNER' and DESCRIPTION = 'Message Banner (BNP_WM)');

UPDATE `CustomComponent`
SET `value` = '
<custom-font straight-mode="false" mime-type-key="''network_means_pageType_301_FONT_MIME_TYPE''"
			 title-key="''network_means_pageType_301_FONT_TITLE''"
			 font-key="''network_means_pageType_301_FONT_DATA''"></custom-font>
<custom-font straight-mode="false" mime-type-key="''network_means_pageType_302_FONT_MIME_TYPE''"
			 title-key="''network_means_pageType_302_FONT_TITLE''"
			 font-key="''network_means_pageType_302_FONT_DATA''"></custom-font>
<custom-font straight-mode="false" mime-type-key="''network_means_pageType_303_FONT_MIME_TYPE''"
			 title-key="''network_means_pageType_303_FONT_TITLE''"
			 font-key="''network_means_pageType_303_FONT_DATA''"></custom-font>
<style>
	@font-face {
		font-family: "BNPPSans";
		src: url(data:font/truetype;charset=utf-8;base64,<<copied base64 string>>) format(''''truetype'''');
		font-weight: normal;
		font-style: normal;
	}
	#message-container {
		position: relative;
	}
	div#message-container {
		padding-top: 5px;
	}
	div#message-container.info {
		background-color: #f5f5f5;
		font-size: 12px;
		color: #403f3d;
	}
	div#message-container.success {
		background-color: #f5f5f5;
		font-size: 12px;
		color: #7f9c90;
	}
	div#message-container.error {
		background-color: #f5f5f5;
		font-size: 12px;
		color: #ab7270;
	}
	div#message-container.warn {
		background-color: #f5f5f5;
		font-size: 12px;
		color: #403f3d;
	}
	div#message-content {
		text-align: center;
		background-color: inherit;
		padding-bottom: 5px;
	}
	#message {
		text-align: center;
	}
	span#message {
		font-family: "BNPPSansExpanded";
		font-size: 20px;
		font-weight: normal;
		text-align: center;
		width: 100%;
		padding-left: 25px;
		padding: 0px;
	}
	custom-text#headingTxt {
		font-family: "BNPPSansExpandedLight";
		padding-left: 8px;
		display: grid;
		font-weight: bold;
		font-size: 35px;
		text-align: center;
		text-transform: uppercase;
	}
	div#message-controls {
		padding-top: 5px;
	}
	#return-button-row button {
		font-weight: normal;
		color: white;
		font-size: 15px;
		font-family: BNPPSans;
		text-align: center;
		background-color: #5b7f95;
	}
	#close-button-row button {
		font-weight: normal;
		color: white;
		font-size: 15px;
		font-family: BNPPSans;
		text-align: center;
		background-color: #5b7f95;
	}
	div.message-button {
		font-family: OpenSansRegular;
		font-size: 15px;
		padding-top: 0px;
		padding-left: 25px;
	}
	button span.fa {
		padding-right: 7px;
		display: none;
	}
	.btn {
		border-radius: 0px;
	}
    @media all and (max-width: 251px) {
        custom-text#headingTxt {
            font-size: 16px;
        }
        span#message {
            font-size: 14px;
        }
        div#message-controls {
            padding-right: 0px;
        }
    }
    @media all and (max-width: 252px) {
        custom-text#headingTxt {
            font-size: 18px;
        }
        span#message {
            font-size: 14px;
        }
    }
    @media all and (min-width: 252px) and (max-width: 392px) {
         custom-text#headingTxt {
            font-size: 20px;
        }
        span#message {
            font-size: 16px;
        }
    }
    @media all and (min-width: 392px) and (max-width: 502px) {
        custom-text#headingTxt {
            font-size: 24px;
        }
        span#message {
            font-size: 18px;
        }
    }
    @media all and (min-width: 502px) and (max-width: 602px) {
        custom-text#headingTxt {
            font-size: 30px;
        }
        span#message {
            font-size: 20px;
        }
    }
</style>
<div id="messageBanner">
	<custom-text id="headingTxt" custom-text-key="$parent.heading"></custom-text>
	<custom-text id="message" custom-text-key="$parent.message"></custom-text>
</div>'
WHERE fk_id_layout = @pageLayoutId_Banner;



SET @pageLayoutId_Polling = (select id from `CustomPageLayout` where `pageType` = 'POLLING_PAGE' and DESCRIPTION = 'Polling Page (BNP_WM)');

UPDATE `CustomComponent`
SET `value` = '
<custom-font straight-mode="false" mime-type-key="''network_means_pageType_301_FONT_MIME_TYPE''"
			 title-key="''network_means_pageType_301_FONT_TITLE''"
			 font-key="''network_means_pageType_301_FONT_DATA''"></custom-font>
<custom-font straight-mode="false" mime-type-key="''network_means_pageType_304_FONT_MIME_TYPE''"
			 title-key="''network_means_pageType_304_FONT_TITLE''"
			 font-key="''network_means_pageType_304_FONT_DATA''"></custom-font>
<custom-font straight-mode="false" mime-type-key="''network_means_pageType_305_FONT_MIME_TYPE''"
			 title-key="''network_means_pageType_305_FONT_TITLE''"
			 font-key="''network_means_pageType_305_FONT_DATA''"></custom-font>
<custom-font straight-mode="false" mime-type-key="''network_means_pageType_306_FONT_MIME_TYPE''"
			 title-key="''network_means_pageType_306_FONT_TITLE''"
			 font-key="''network_means_pageType_306_FONT_DATA''"></custom-font>
<div id="main-container">
	<div id="header" class="row-flex">
		<div id="bankLogo">
			<custom-image id="issuerLogo" alt-key="''network_means_pageType_1_IMAGE_ALT''" image-key="''network_means_pageType_1_IMAGE_DATA''" straight-mode="false"></custom-image>
		</div>
		<div id="schemeLogo">
			<custom-image id="networkLogo" alt-key="''network_means_pageType_2_IMAGE_ALT''" image-key="''network_means_pageType_2_IMAGE_DATA''" straight-mode="false">
		</div>
	</div>
	<div id="content">
		<message-banner close-button="''network_means_pageType_174''" back-button="''network_means_pageType_175''"></message-banner>
        <custom-text id="title" custom-text-key="''network_means_pageType_1''"></custom-text>
        <div class="transaction-details">
            <side-menu></side-menu>
        </div>
        <div class="mobile-app-info-title">
            <custom-text custom-text-key="''network_means_pageType_3''"></custom-text>
        </div>
        <div class="mobile-app-info-text">
            <span>
                <custom-text custom-text-key="''network_means_pageType_4''"></custom-text>
            </span>
        </div>
        <div class="mobile-app-img">
            <custom-image id="mobileAppLogo" alt-key="''network_means_pageType_3_IMAGE_ALT''" image-key="''network_means_pageType_3_IMAGE_DATA''" straight-mode="false">
        </div>
	</div>
    <div class="row">
        <div class="back-link">
            <span class="fa fa-angle-left"></span>
            <cancel-button cn-label="''network_means_pageType_11''" id="cancelButton" ></cancel-button>
        </div>
    </div>
	<div id="footer">
        <div class="row-flex">
            <div class="contact">
                <div class="contact-text">
                      <custom-text custom-text-key="''network_means_pageType_6''"></custom-text>
                </div>
                <div class="contact-text">
                    <div class=""><custom-text custom-text-key="''network_means_pageType_7''"></custom-text></div>
                </div>
                <div class="contact-text-small">
                    <div class=""><custom-text custom-text-key="''network_means_pageType_8''"></custom-text></div>
                </div>
            </div>
            <div class="help-area">
                <div class="help-link">
                     <help help-label="''network_means_pageType_5''" id="helpButton" class="helpButtonClass"></help>
                    <span class="fa fa-angle-right"></span>
                </div>
            </div>
        </div>
        <div id="copyright" class="row-flex small">
            <div class="copyright-left">
                <span><custom-text custom-text-key="''network_means_pageType_9''"></custom-text></span>
            </div>
            <div class="copyright-right">
                <div class="copyright-right-content">
                    <span><custom-text custom-text-key="''network_means_pageType_44''"></custom-text></span>
                </div>
            </div>
        </div>
	</div>
</div>
<style>
	@font-face {
		font-family: "BNPPSans";
		src: url(data:font/truetype;charset=utf-8;base64,<<copied base64 string>>) format(''truetype'');
		font-weight: normal;
		font-style: normal;
	}
    .row-flex {
        display: flex;
    }
	#main-container {
		font-family: BNPPSans;
		font-size: 15px;
		color: #403f3d;
		width: 480px;
		margin-left: auto;
		margin-right: auto;
	}
	#header {
        align-items: center;
	}
    #bankLogo {
        width: 50%;
        height: 72px;
    }
	#schemeLogo {
        width: 50%;
        height: 40px;
        text-align: end;
	}
	#issuerLogo {
		max-height: 100%;
	}
	#networkLogo {
		max-height: 100%;
	}
	.spinner-container {
		display: block;
		width: 100%;
	}
	#content {
		text-align: left;
		color: #403f3d;
		background-color: #f7f7f7;
	}
	custom-text#title {
		font-weight: bold;
		font-size: 25px;
		font-family: BNPPSans;
		color: #403f3d;
	}
    .transaction-details {
        height: 100px;
        margin-top: 10px;
    }
	.side-menu .text-left, .side-menu .text-right {
		font-family: BNPPSans;
		font-size: 15px;
		color: #403f3d;
	}
	.mobile-app-info-title {
        display: inline-block;
		font-family: BNPPSansLight;
		font-size: 25px;
		color: #403f3d;
	}
	.mobile-app-info-text {
        margin-top: 5px;
        margin-bottom: 5px;
	}
	.mobile-app-img {
		text-align: center;
	}
    .back-link {
        padding-top: 10px;
        padding-bottom: 10px;
		text-align: left;
        background-color: #f7f7f7;
		color: #749bb3;
	}
    .back-link button {
		border-style: none;
        border-radius: 0px;
		background: none;
		padding: 0px;
		background-color: #f7f7f7;
        color: #749bb3;
	}
	#main-container .row button:hover:enabled {
		background-color: #5b7f95;
	}
	.back-link span.fa-ban {
		display: none;
	}
    div#footer {
		height: auto;
        padding: 10px;
        background-color: #d1d1d1;
		background-image: none;
    }
    .contact {
        width: 70%;
    }
    .contact-text {
		font-size: 15px;
		font-weight: bold;
		color: #403f3d;
	}
    .contact-text-small {
		font-size: 12px;
		font-weight: normal;
        color: #6b6b6b;
    }
    .help-area {
       width: 30%;
       text-align: end;
    }
    #helpButton button {
        padding: 2px;
		border-style: none;
        border-radius: 0px;
		background-color: #5b7f95;
	}
	#main-container #helpButton button span {
		font-family: BNPPSans;
		font-size: 15px;
		color: white;
	}
    #helpButton .fa-info {
		display: none;
	}
    #footer .small {
		font-size: 12px;
		font-weight: normal;
	}
    #footer .grey {
		color: #6b6b6b;
		font-weight: normal;
	}
    #footer #copyright {
        border-top: 1px solid #6b6b6b;
        margin-top: 10px;
        padding-top: 5px;
    }
    #copyright .copyright-left {
        width: 60%;
    }
    #copyright .copyright-right {
        width: 40%;
        text-align: end;
    }

    @media all and (max-width: 252px) {
        #main-container {
            font-size: 12px;
            width: 98%;
            margin-left: auto;
            margin-right: auto;
        }
        #bankLogo {
            height: 52px;
        }
        #schemeLogo {
            height: 30px;
        }
        custom-text#title {
            font-size: 14px;
        }
        .transaction-details {
            height: 70px;
            margin-top: 8px;
        }
        .side-menu .text-left, .side-menu .text-right {
            font-family: BNPPSans;
            font-size: 10px;
            color: #403f3d;
        }
        .mobile-app-info-title {
            display: inline-block;
            font-size: 18px;
        }
        .mobile-app-img img {
            height: 50px;
        }
        #main-container .back-link button span {
            font-size: 11px;
        }
        .contact-text {
            font-size: 11px;
        }
        #main-container #helpButton button span {
            font-size: 10px;
        }
    }
    @media all and (min-width: 252px) and (max-width: 392px) {
        #main-container {
            font-size: 12px;
            width: 96%;
            margin-left: auto;
            margin-right: auto;
        }
        #bankLogo {
            height: 52px;
        }
        #schemeLogo {
            height: 30px;
        }
        custom-text#title {
            font-size: 16px;
        }
        .transaction-details {
            height: 70px;
        }
        .side-menu .text-left, .side-menu .text-right {
            font-size: 12px;
        }
        .mobile-app-info-title {
            display: inline-block;
            margin-top: 10px;
            font-size: 20px;
        }
        .mobile-app-img img {
            height: 60px;
        }
        #main-container .back-link button span {
            font-size: 12px;
        }
        .contact-text {
            font-size: 11px;
        }
        #main-container #helpButton button span {
            font-size: 11px;
        }
    }
    @media all and (min-width: 392px) and (max-width: 502px) {
        #main-container {
            width: 96%;
            margin-left: auto;
            margin-right: auto;
        }
        custom-text#title {
            font-size: 20px;
        }
        .mobile-app-img img {
            height: 68px;
        }
    }
</style>' WHERE fk_id_layout = @pageLayoutId_Polling;


SET @pageLayoutId_Failure = (select id from `CustomPageLayout` where `pageType` = 'FAILURE_PAGE' and DESCRIPTION = 'Failure Page (BNP_WM)');

UPDATE `CustomComponent`
SET `value` = '
<custom-font straight-mode="false" mime-type-key="''''network_means_pageType_301_FONT_MIME_TYPE''''"
			 title-key="''''network_means_pageType_301_FONT_TITLE''''"
			 font-key="''''network_means_pageType_301_FONT_DATA''''"></custom-font>
<custom-font straight-mode="false" mime-type-key="''''network_means_pageType_304_FONT_MIME_TYPE''''"
			 title-key="''''network_means_pageType_304_FONT_TITLE''''"
			 font-key="''''network_means_pageType_304_FONT_DATA''''"></custom-font>
<custom-font straight-mode="false" mime-type-key="''''network_means_pageType_305_FONT_MIME_TYPE''''"
			 title-key="''''network_means_pageType_305_FONT_TITLE''''"
			 font-key="''''network_means_pageType_305_FONT_DATA''''"></custom-font>
<custom-font straight-mode="false" mime-type-key="''''network_means_pageType_306_FONT_MIME_TYPE''''"
			 title-key="''''network_means_pageType_306_FONT_TITLE''''"
			 font-key="''''network_means_pageType_306_FONT_DATA''''"></custom-font>
<style>
	@font-face {
		font-family: "BNPPSans";
		src: url(data:font/truetype;charset=utf-8;base64,<<copied base64 string>>) format(''truetype'');
		font-weight: normal;
		font-style: normal;
	}
    .row-flex {
        display: flex;
    }
	#main-container {
		font-family: BNPPSans;
		font-size: 15px;
		color: #403f3d;
		width: 480px;
		margin-left: auto;
		margin-right: auto;
	}
	#header {
        align-items: center;
	}
    #bankLogo {
        width: 50%;
        height: 72px;
    }
	#schemeLogo {
        width: 50%;
        height: 40px;
        text-align: end;
	}
	#issuerLogo {
		max-height: 100%;
	}
	#networkLogo {
		max-height: 100%;
	}
    span#headingTxt {
        font-size: 24px;
    }
	#content {
		text-align: left;
		color: #403f3d;
		background-color: #f7f7f7;
	}
	custom-text#title {
		font-weight: bold;
		font-size: 25px;
		font-family: BNPPSans;
		color: #403f3d;
	}
    .transaction-details {
        height: 100px;
    }
	div.menu-title {
		color: #403f3d;
	}
	.side-menu .text-left, .side-menu .text-right {
		font-family: BNPPSans;
		font-size: 15px;
		color: #403f3d;
	}
    div#footer {
		height: auto;
        padding: 10px;
        margin-top: 30px;
        background-color: #d1d1d1;
		background-image: none;
    }
    .contact {
        width: 70%;
    }
    .contact-text {
		font-size: 15px;
		font-weight: bold;
		color: #403f3d;
	}
    .contact-text-small {
		font-size: 12px;
		font-weight: normal;
        color: #6b6b6b;
    }
    .help-area {
       width: 30%;
       text-align: end;
    }
    #helpButton button {
        padding: 2px;
		border-style: none;
        border-radius: 0px;
		background-color: #5b7f95;
	}
	#main-container #helpButton button span {
		font-family: BNPPSans;
		font-size: 15px;
		color: white;
	}
    #helpButton .fa-info {
		display: none;
	}
    #footer .small {
		font-size: 12px;
		font-weight: normal;
	}
    #footer .grey {
		color: #6b6b6b;
		font-weight: normal;
	}
    #footer #copyright {
        border-top: 1px solid #6b6b6b;
        margin-top: 10px;
        padding-top: 5px;
    }
    #copyright .copyright-left {
        width: 60%;
    }
    #copyright .copyright-right {
        width: 40%;
        text-align: end;
    }
</style>
<div id="main-container">
	<div id="header" class="row-flex">
		<div id="bankLogo">
		    <custom-image id="issuerLogo"  alt-key="''network_means_pageType_1_IMAGE_ALT''" image-key="''network_means_pageType_1_IMAGE_DATA''" straight-mode="false"></custom-image>
		</div>
		<div id="schemeLogo">
		    <custom-image id="networkLogo" alt-key="''network_means_pageType_2_IMAGE_ALT''"  image-key="''network_means_pageType_2_IMAGE_DATA''" straight-mode="false"></custom-image>
		</div>
	</div>
	<div id="content">
	    <message-banner close-button="''network_means_pageType_174''" back-button="''network_means_pageType_175''"></message-banner>
		<custom-text id="title" custom-text-key="''network_means_pageType_1''"></custom-text>
        <div class="transaction-details">
		    <side-menu menu-title="''TRANSACTION_SUMMARY''"></side-menu>
		</div>
        <div id="footer">
            <div class="row-flex">
                <div class="contact">
                    <div class="contact-text">
                          <custom-text custom-text-key="''network_means_pageType_6''"></custom-text>
                    </div>
                    <div class="contact-text">
                        <div class=""><custom-text custom-text-key="''network_means_pageType_7''"></custom-text></div>
                    </div>
                    <div class="contact-text-small">
                        <div class=""><custom-text custom-text-key="''network_means_pageType_8''"></custom-text></div>
                    </div>
                </div>
                <div class="help-area">
                    <div class="help-link">
                         <help help-label="''network_means_pageType_5''" id="helpButton" class="helpButtonClass"></help>
                        <span class="fa fa-angle-right"></span>
                    </div>
                </div>
            </div>
            <div id="copyright" class="row-flex small">
                <div class="copyright-left">
                    <span><custom-text custom-text-key="''network_means_pageType_9''"></custom-text></span>
                </div>
                <div class="copyright-right">
                    <div class="copyright-right-content">
                        <span><custom-text custom-text-key="''network_means_pageType_10''"></custom-text></span>
                    </div>
                </div>
            </div>
		</div>
    </div>
</div>' WHERE fk_id_layout = @pageLayoutId_Failure


