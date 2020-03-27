USE `U5G_ACS_BO`;

SET @pageType = 'PHOTO_TAN_OTP_FORM_PAGE';
SET @description = 'Photo Tan Page (Consorsbank)';

/* CustomPageLayout */
INSERT INTO `CustomPageLayout` (`pageType`, `description`) VALUES (@pageType, @description);

SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `pageType`= @pageType  and `description`= @description);

INSERT INTO `CustomComponent` ( `type`, `value`, `fk_id_layout`) VALUES ( 'div', '
<div id="main-container">
        <div id="headerLayout">
          <div id="pageHeader">
          <div id="pageHeaderLeft">
              <custom-image id="issuerLogo" alt-key="''network_means_pageType_1_IMAGE_ALT''" image-key="''network_means_pageType_1_IMAGE_DATA''" straight-mode="false"></custom-image>
          </div>
          <div id="pageHeaderRight">
              <custom-image id="networkLogo" alt-key="''network_means_pageType_2_IMAGE_ALT''" image-key="''network_means_pageType_2_IMAGE_DATA''" straight-mode="false"></custom-image>
              </div>
          </div>
      </div>
      <div id="content">
              <message-banner></message-banner>
              <div id="contentHeader">
              <h2>
                  <custom-text custom-text-key="''network_means_pageType_1''" id="paragraph1"></custom-text>
              </h2>
              </div>

              <div id="transactionDetails">
                  <side-menu></side-menu>
              </div>
              <span class="clear"></span>

              <div id="contentMain">
              <h2>
                  <custom-text custom-text-key="''network_means_pageType_3''" id="paragraph1"></custom-text>
              </h2>

              <div id="qrcontrols">
                <div id="form-input">
                      <div><custom-text custom-text-key="''network_means_pageType_11''" id="paragraph1"></custom-text></div>
                      <div id="otp-input">
                          <custom-text custom-text-key="''network_means_pageType_18''" id="paragraph1"></custom-text>
                          <otp-form></otp-form>
                      </div>
                      <div id="val-button-container"><val-button id="validateButton" val-label="''network_means_pageType_19''"></val-button></div>
                </div>
                <div id="qr-display">
                      <external-image></external-image>
                </div>

          </div>
        </div>

          <div id="form-controls">
            <div id="form-controls-container">
                  <div class="back-link">
                      <span class="fa fa-angle-left"></span>
                      <cancel-button cn-label="''network_means_pageType_55''" id="cancelButton" ></cancel-button>
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
  <style>
  /* Switchpoints: 780, */
   :root {
       font-family: proximaLight, Times;
       padding:0px;
       margin:0px;
  }
   #main-container {
       width:100%;
       margin-left:auto;
       margin-right:auto;
       padding-left:10px;
       padding-right:10px;
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
          #main-container .leftMenuLayout {
              clear:both
          }
          #main-container   #content #contentHeader {
              margin-bottom:0.25em;
              margin-top:0.25em;

          }

          #main-container   #content  #transactionDetails {
                  margin-bottom: 1em;
                  width: 100%;
          }

          #main-container .clear {
            clear:both;
            display:block;
           }

          #main-container #content #contentMain {
                margin-top:1em;
                background-color: #f7f7f7;
                border-radius:0.25em;
                padding:1em;
          }

          #main-container #qrcontrols {
            display:flex;
            flex-direction:row;
          }

          #main-container #form-input {
                align-items: start;
                display: flex;
                flex-direction: column;
           }

          #main-container #otp-input {
                display: flex;
            flex-direction: row;
            justify-content: flex-end;
            margin-top: 10px;
            align-self: flex-end;
          }

          #main-container #otp-form {
            margin-left:10px;
          }

          #main-container #qr-display {
            display:flex;
            justify-content:center;
          }


   #content {
       text-align:left;
  }
   #content h2 {
       font-size:1.25em;
        margin-top:0px;
        margin-bottom:0.25em;
  }

          #main-container   #footer {
              width:100%;
              background-color: #f7f7f7;
              margin-top:1em;
              border-radius: 1em;
              background-image:none;
              height: auto;
          }
          #main-container   #footer:after {
              content: "";
              height:100%;
              display: table;

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

            #main-container .externalImage {
                padding: 1em;
                width:100%;
                min-width:268px;
                margin-left:auto;
                margin-right:auto;
            }
    p {
        margin-bottom:10px;
   }
     .splashtext {
        width:80%;
        margin-left:auto;
        margin-right:auto
   }
    input {
        border: 1px solid #d1d1d1;
        border-radius: 6px;
        color: #464646;
        padding: 7px 10px 5px;
        height: 20px;
        box-shadow: rgba(0,0,0,0.15) 1px 1px 3px 0 inset;
   }
    #main-container .row button {
        font-size: 16px;
        height: 38px;
        border-radius: 6px;
        background: linear-gradient(#4dbed3,#007ea5);
        box-shadow:none;
        border:0px;
        color:#FFF;
   }
    #main-container .row button:hover:enabled {
        background: linear-gradient(#2fa8be,#005772);
   }

    a {
        color:#000;
        text-decoration:none;
   }
    a:hover {
        color:#000;
        border-bottom:1px dotted black;
   }
    #main-container .row .left {
        float:left;
        width:180px;
        text-align:right;
   }

    #main-container .row .left span {
        margin-right:0.5em
   }

    #main-container #form-controls-container {
        display:flex;
        justify-content: space-between;
    }

    #form-controls {

    }

   #main-container   #form-controls .back-link button:hover {
       background: linear-gradient(#2fa8be,#005772);
   }

    #main-container #form-controls .back-link {
        text-align:left;

   }

   #main-container   #form-controls .back-link button {
               border-style:none;
               background:none;
               padding:0px;
               color:#06c2d4;
           }
    #main-container #form-controls .back-link span {
        text-align:left;
        margin-left:0.5em;
   }
   #main-container   #form-controls .back-link span.fa-ban {
               display:none;
           }

    #main-container #form-controls .submit-btn {
        text-align:right;

   }

    .mtan-input {
        padding-top:25px;
        padding-bottom:10px;
   }
    .resendTan {
        display: block;
        margin-left:196px;
        margin-top: 10px;
        margin-bottom: 25px;
   }
    .input-label {
        display:flex;
        flex-direction: row;
        align-items: center;
   }
    .resendTan a {
        color:#06c2d4;
   }
    .mtan-label {
        text-align:right;
        flex: 0 0 180px
   }
    .otp-field input {
        margin-left:16px;
   }
    .otp-field input:focus {
        outline:none;
   }

    .help-link {
        width:30%;
        order:2;
        text-align:right
   }
    .contact {
        width:70%;
        order:1;
   }
    #otp-error-message {
        margin-top: 10px;
        position: relative;
        background-color: #F5F5F5;
        text-align: center;
        width:300px;
        margin-left:56px;
        padding:12px;
   }
    #otp-error-message:after {
        content: '';
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

        #main-container #validateButton {
            margin-top:10px;
            margin-bottom:10px;
        }

		#main-container #validateButton button {
            font-size: 16px;
            height: 30px;
            line-height:1.0;
            border-radius: 6px;
            background: linear-gradient(#4dbed3,#007ea5);
            box-shadow: none;
            border: 0px;
            color: #FFF;
            width:163px;
        }

    #main-container   #validateButton span.fa-check-square{
        display:none;
    }


    #main-container #val-button-container {
        align-self: flex-end;
        margin-top: 10px;
        margin-bottom: 10px;
    }

    @media (max-width: 760px) {
        #main-container {
            width:auto;
       }
        body {
            font-size:14px;
       }
        #header {
            height:65px;
       }
        #networkLogo {
            width:100px;
       }
        #schemeLogo {
            margin-top:1em;
            width:70px;
            height:70px;
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
        .row {
            width:auto;
            clear:none;
       }
        .row .back-link {
            float:none;
            text-align:center;
            padding-top:0.5em;
       }
        .row .submit-btn {
            float:none;
            text-align:center;
            padding-bottom:0.5em;
       }
        .row button {
            width:100%;
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
            text-align: center;
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
            justify-content: center;
       }
        .otp-field {
            display:inline;
       }
        .otp-field input {
       }
        #main-container #footer {
            width:100%;
            background-image:none;
            background-color:#F5F5F5;
            height:unset;
       }
        #main-container #footer .help-area {
            display:flex;
            flex-direction: column;
            padding:16px;
            text-align:center;
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
        #main-container #footer .small-font {
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
            content: '';
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

       #main-container #qrcontrols {
            display:flex;
            flex-direction:column;
          }
   }
    </style>
', @layoutId);

