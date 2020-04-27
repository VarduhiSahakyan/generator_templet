/* Select schema where the SQL commands will be launched */
USE `U5G_ACS_BO`;

SET @pageType = 'FAILURE_PAGE';
SET @description = 'Failure Page (Consorsbank)';

/* CustomPageLayout */
INSERT INTO `CustomPageLayout` (`pageType`, `description`) VALUES (@pageType, @description);

SET @layoutOTPFORM = (SELECT id FROM `CustomPageLayout` WHERE `pageType`= @pageType  and `description`=@description);

INSERT INTO `CustomComponent` ( `type`, `value`, `fk_id_layout`) VALUES ( 'div', '

	<div id="main-container" ng-style="style" class="ng-scope">
		<div id="headerLayout">
			<div id="pageHeader" >
				<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
					<custom-image alt-key="''network_means_pageType_1_IMAGE_ALT''" image-key="''network_means_pageType_1_IMAGE_DATA''" id="issuerLogo" straight-mode="false"></custom-image>
				</div>
				<div id="pageHeaderRight" ng-style="style" class="ng-scope" >
					<custom-image alt-key="''network_means_pageType_2_IMAGE_ALT''"  image-key="''network_means_pageType_2_IMAGE_DATA''" id="networkLogo" straight-mode="false"></custom-image>
				</div>
			</div>
        </div>
		<message-banner></message-banner>
		<div id="mainLayout" class="row">
			<div id="content">
				<div class="paragraph">
					<custom-text custom-text-key="''network_means_pageType_1''" id="paragraph1"></custom-text>
				</div>
				<div  id="leftMenuLayout" class=" col-xs-12 col-sm-4 col-md-4 col-lg-4">
					<div>
						<side-menu menu-title="''TRANSACTION_SUMMARY''"></side-menu>
					</div>
				</div>
			</div>
			<div id="footer">
				<div class="help-area">
					<div class="help-link">
						<help help-label="''network_means_pageType_5''" id="helpButton" class="helpButtonClass"></help>
					    <span class="fa fa-angle-right"></span>

					</div>
					<div class="contact">
						<div class="line bottom-margin">
                            <custom-text custom-text-key="''network_means_pageType_6''"></custom-text>

						</div>
						<div class="line small bold">

							<div class=""><custom-text custom-text-key="''network_means_pageType_7''"></custom-text></div>
						</div>
						<div class="line small grey">
							<div class=""><custom-text custom-text-key="''network_means_pageType_8''"></custom-text></div>
						</div>
					</div>
				</div>
				<div id="copyright" class="extra-small">
					<div><span><custom-text custom-text-key="''network_means_pageType_9''"></custom-text></span></div>
					<div><span><custom-text custom-text-key="''network_means_pageType_10''"></custom-text></span></div>
				</div>
			</div>
		</div>
	</div>
	<style>
        :root {
             font-family: proximaLight, Times;
             padding:0px;
             margin:0px;
        }

        #main-container {
            width: 480px;
            max-width: 480px;
            margin-left: auto;
            margin-right: auto;
            padding-left: 10px;
            padding-right: 10px;
        }

		#main-container  #issuerLogo {
			max-height: 72px;
			padding-left: 0px;
			padding-right: 0px;
		}
		#main-container   #networkLogo {
			max-height: 33px;
            max-width: 100%;
		}
            #main-container #pageHeader {
                display: flex;
                justify-content: space-between;
                align-items: center;
                width: 100%;
                height: 76px;
                padding-bottom: 4px;
                margin-top: 8px;
                margin-bottom: 0px;
                border-bottom: 1px solid #DCDCDC;
            }

		#main-container   #pageHeaderLeft {

            text-align:left;
		}
		#main-container   #pageHeaderRight {

			text-align: right;
		}

        #main-container   #centerPieceLayout {
            padding: 5px 10px 0px;
            min-height: 200px;
        }
        #main-container   #content {
            text-align:left;
        }

        #main-container   #content contentHeaderLeft {
            font-size:1.25em;
            margin-bottom:0.25em;
            margin-top:0.25em;
        }
        #main-container   .paragraph {
            display: block;
            margin-block-start: 1em;
            margin-block-end: 1em;
            margin-inline-start: 0px;
            margin-inline-end: 0px;
            margin-bottom: 10px;
        }

        #main-container .menu-title {
            display:none;
        }

        #main-container #resend button span{
            color:#06c2d4;
        }

        #main-container #resend button {
            border-style: none;
            padding:0px
        }

        #main-container   .help-link {
            width: 30%;
            order: 2;
            text-align: right;
        }
        #main-container   .contact {
            width: 70%;
            order: 1;
        }
        #main-container   .mtan-input {
            padding-top:25px;
            padding-bottom:10px;
        }

        #main-container   .resendTan {
            display:block;
            margin-left:196px;
            margin-top:10px;
            margin-bottom: 25px;
        }

        #main-container   .input-label {
            display:flex;
            flex-direction: row;
            align-items: center;
        }

        #main-container   .resendTan a {
            color:#06c2d4;
        }

        #main-container   .mtan-label {
            text-align:right;
            flex: 0 0 180px
        }

        #main-container   .otp-field input {
            margin-left:16px;
        }

        #main-container   .otp-field input:focus {
            outline:none;
        }
        #main-container   div#footer {
            background-image:none;
            height:100%;
        }
		#main-container   #footer {
			width:100%;
			background-color: #f7f7f7;
            border-radius: 1em;
			clear:both;
			margin-top:1em;
		}
        #main-container   #footer:after {
            content: "";
            height:100%;
            display: table;
            clear: both;
            padding-bottom: 0.5em;
        }
        #main-container   #footer .extra-small {
            font-size:0.7em;
        }
        #main-container   #footer .small {
            font-size:0.8em;
        }
        #main-container   #footer .bold {
            font-weight: bold;
        }

       #main-container   #footer .grey {
           color: #6b6b6b;
        }

        #main-container   #footer .bottom-margin {
	margin-bottom:10px;
         }
        #main-container   #footer #copyright {
            width:100%;
            border-top : 1px solid #6b6b6b;
            padding-top:0.5em;
            padding-bottom:1em;
            display:flex;
            flex-direction: row;
        }
        #main-container   #footer #copyright div:nth-child(1) {
            order:1;
            text-align:left;
            width:50%;
            padding-left:12px;
        }
        #main-container   #footer #copyright div:nth-child(2) {
            order:2;
            text-align: right;
            width:50%;
            padding-right:12px;
        }
        #main-container  #footer .help-area {
            display: flex;
            flex-direction: row;
            padding: 16px;
        }

        #main-container #helpButton  button span{
            color:#06c2d4;
            background-color: #f7f7f7;
        }

        #main-container #helpButton  button {
            border-style: none;
            padding:0px
        }

        #main-container #helpButton .fa-info {
            display:none;
        }
        #main-container   .col-lg-4 {
            width: 100%;
            margin-bottom: 20px;
        }
        #main-container   .col-md-4 {
            width: 100%;
            margin-bottom: 20px;
        }
        #main-container   .col-sm-4 {
            width: 100%;
            margin-bottom: 20px;
        }
        #main-container   .col-xs-12 {
            width: 100%;
            margin-bottom: 20px;
        }
        #main-container   message-banner {
            display: block;
            width: 100%;
            position: relative;
        }
        #main-container   .row .left {
            float:left;
            width:180px;
            text-align:right;
        }
        #main-container   .row .left span {
            margin-right:0.5em
        }
        #main-container   .row .back-link {
            text-align:left;
            float:left;
        }

        #main-container   .row .back-link button {
            border-style:none;
            padding:0px;
            color:#06c2d4;
        }
        #main-container   .row .back-link span {
            text-align:left;
            margin-left:0.5em;
        }

        #main-container   .row .back-link span.fa-ban {
            display:none;
        }

        #main-container   .row .submit-btn {
            text-align:right;
            float:right;
        }
        #main-container   #validateButton {
            font-size: 16px;
            height: 38px;
            border-radius: 6px;
            box-shadow: none;
            border: 0px;
        }

        #main-container   #validateButton span.fa-check-square{
            display:none;
        }

        #main-container #validateButton button:disabled {
            font-size: 16px;
            height: 38px;
            border-radius: 6px;
            background: linear-gradient(#4dbed3,#007ea5);
            box-shadow: none;
            border: 0px;
            color: #FFF;
        }

        #main-container .halfdivsRight {
            width:50%;
            float: right;
        }

        #main-container  .halfdivsLeft{
            width:50%;
            float: left;
        }


	</style>
', @layoutOTPFORM);

