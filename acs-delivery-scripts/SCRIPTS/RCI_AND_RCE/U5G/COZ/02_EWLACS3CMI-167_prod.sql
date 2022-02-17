USE U5G_ACS_BO;

set @customPageLayoutDesc_appView = 'EXT_PASSWORD_App_View (COZ)';
set @pageType = 'EXT_PASSWORD_APP_VIEW';

set @idAppViewPage = (select id
					  from `CustomPageLayout`
					  where `pageType` = @pageType
						and DESCRIPTION = @customPageLayoutDesc_appView);

UPDATE `CustomComponent`
SET `value` = '
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
    .acs-container {
        padding: 0em;
    }
    .scrollbar{
        overflow: auto;
        height: 90vh;
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
        min-height: 22em !important;
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
    img.warn-image {
        vertical-align: middle;
        float: left;
        padding-left: 5px;
    }
    .acs-challengeInfoText {
        margin-bottom: 2em;
        white-space: pre-line;
    }
    .acs-footer {
        font-size: 0.9em;
        padding-bottom: 2em;
    }
    .acs-footer-icon {
        text-align: right;
    }
    .sides-padding {
        margin-right: 15px;
        margin-left: 15px;
    }
    .leftPadding {
        padding-left: 15px;
    }
    .col-md-12,
    .col-md-10,
    .col-md-6,
    .col-md-2 {
        position: relative;
        min-height: 1px;
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
    .challenge-form {
        text-align: center;
    }
    label#challenge-form-label {
        float: left !important;
        text-align: left;
    }
    .challenge-submit-button {
        width: auto !important;
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
    #show:checked~#content {display:block;}
    .div-left {
        float:left;
        padding-left:10px;
    }
    .div-right {
        float:right;
        padding-right:10px;
    }

    /* Tooltip container */
    .tooltip {
        float:right;
        padding-right:10px;
    }

    /* Tooltip text */
    .tooltip .tooltiptext {

        visibility: hidden;
        background-color: white;
        color: #000;
        text-align: center;
        padding: 9px 14px;
        border-radius: 6px;
        font-size: 14px;
        font-style: normal;
        font-weight: 400;
        line-height: 1.42857143;
        text-align: left;
        text-align: start;
        text-decoration: none;
        text-shadow: none;
        text-transform: none;
        letter-spacing: normal;
        word-break: normal;
        word-spacing: normal;
        word-wrap: normal;
        white-space: normal;
        background-color: #fff;
        -webkit-background-clip: padding-box;
        background-clip: padding-box;
        border: 1px solid #ccc;
        border: 1px solid rgba(0,0,0,.2);
        border-radius: 6px;
        -webkit-box-shadow: 0 5px 10px rgb(0 0 0 / 20%);
        box-shadow: 0 5px 10px rgb(0 0 0 / 20%);


        position: absolute;
        width: 70%;
        z-index: 1;
        bottom: 100%;
        left: 30%;
        margin-left: -60px;
    }

    /* Show the tooltip text when you mouse over the tooltip container */
    .tooltip:hover .tooltiptext {
        visibility: visible;
    }

    </style>
    </head>
    <body>
    <div class="acs-container">
            <div class="scrollbar col-md-12">
                <!-- ACS HEADER | Branding zone-->
                <div class="acs-header sides-padding branding-zone">
                    <div class="col-md-6">
                        <img src="network_means_pageType_251" alt="Issuer image" data-cy="ISSUER_IMAGE"/>
                    </div>
                    <div class="col-md-6 card-logo-container">
                        <img src="network_means_pageType_254" alt="Card network image" data-cy="CARD_NETWORK_IMAGE"/>
                    </div>
                </div>
                <!-- ACS BODY | Challenge/Processing zone -->
                <div class="acs-purchase-context col-md-12 challenge-processing-zone">
                    <div class="sides-padding">
                        <div class="acs-challengeInfoHeader col-md-12" data-cy="CHALLENGE_INFO_HEADER">
                            network_means_pageType_151
                        </div>
                        <div class="acs-challengeInfoText leftPadding" id="acs-challenge-info-text" data-cy="CHALLENGE_INFO_TEXT">
                            network_means_pageType_152
                        </div>
                        <div class="col-md-12">
                            <form action="HTTPS://EMV3DS/challenge" method="get" data-cy="CHALLENGE_FORM" class="challenge-form">
                                <div class="form-group">
                                    <label for="challenge-html-data-entry" data-cy="CHALLENGE_INFO_LABEL" id="challenge-form-label">
                                        network_means_pageType_153
                                    </label>
                                    <input id="challenge-html-data-entry" name="submitted-otp-value" type="text" class="form-control" data-cy="CHALLENGE_HTML_DATA_ENTRY" required>
                                </div>
                                <input type="submit" value="network_means_pageType_154" class="btn btn-primary challenge-submit-button" data-cy="CHALLENGE_HTML_DATA_ENTRY_FORM_SUBMIT"/>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <!-- ACS FOOTER | Information zone -->
            <div class="acs-footer col-md-12 information-zone">
                <div class="sides-padding">
                    <div class="div-left">network_means_pageType_156</div>
                    <input type="checkbox" id="show" class="div-right">
                    <div for="show" class="div-right tooltip">
                        <img class="plus-image" src="data:image/svg+xml;base64,PHN2ZyBhcmlhLWhpZGRlbj0idHJ1ZSIgZm9jdXNhYmxlPSJmYWxzZSIgZGF0YS1wcmVmaXg9ImZhcyIgZGF0YS1pY29uPSJwbHVzIiBjbGFzcz0ic3ZnLWlubGluZS0tZmEgZmEtcGx1cyBmYS13LTE0IiByb2xlPSJpbWciIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgdmlld0JveD0iMCAwIDQ0OCA1MTIiPjxwYXRoIGZpbGw9ImN1cnJlbnRDb2xvciIgZD0iTTQxNiAyMDhIMjcyVjY0YzAtMTcuNjctMTQuMzMtMzItMzItMzJoLTMyYy0xNy42NyAwLTMyIDE0LjMzLTMyIDMydjE0NEgzMmMtMTcuNjcgMC0zMiAxNC4zMy0zMiAzMnYzMmMwIDE3LjY3IDE0LjMzIDMyIDMyIDMyaDE0NHYxNDRjMCAxNy42NyAxNC4zMyAzMiAzMiAzMmgzMmMxNy42NyAwIDMyLTE0LjMzIDMyLTMyVjMwNGgxNDRjMTcuNjcgMCAzMi0xNC4zMyAzMi0zMnYtMzJjMC0xNy42Ny0xNC4zMy0zMi0zMi0zMnoiPjwvcGF0aD48L3N2Zz4=" alt="Plus" style="height:1em;">
                        <span class="tooltiptext">network_means_pageType_157</span>
                    </div>
                </div>
            </div>
        </div>
'
WHERE `fk_id_layout` = @idAppViewPage;



set @customPageLayoutDesc_appView = 'SMS_App_View (COZ)';
set @pageType = 'OTP_SMS_EXT_MESSAGE_APP_VIEW';

set @idAppViewPage = (select id
					  from `CustomPageLayout`
					  where `pageType` = @pageType
						and DESCRIPTION = @customPageLayoutDesc_appView);

UPDATE `CustomComponent`
SET `value` = '
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
    .acs-container {
        padding: 0em;
    }
    .scrollbar{
        overflow: auto;
        height: 90vh;
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
        min-height: 22em !important;
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
    img.warn-image {
        vertical-align: middle;
        float: left;
        padding-left: 5px;
    }
    .acs-challengeInfoText {
        margin-bottom: 2em;
        white-space: pre-line;
    }
    .acs-footer {
        font-size: 0.9em;
        padding-bottom: 2em;
    }
    .acs-footer-icon {
        text-align: right;
    }
    .sides-padding {
        margin-right: 15px;
        margin-left: 15px;
    }
    .leftPadding {
        padding-left: 15px;
    }
    .col-md-12,
    .col-md-10,
    .col-md-6,
    .col-md-2 {
        position: relative;
        min-height: 1px;
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
    .challenge-form {
        text-align: center;
    }
    label#challenge-form-label {
        float: left !important;
        text-align: left;
    }
    .challenge-submit-button {
        width: auto !important;
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
    #show:checked~#content {display:block;}
    .div-left {
        float:left;
        padding-left:10px;
    }
    .div-right {
        float:right;
        padding-right:10px;
    }

    /* Tooltip container */
    .tooltip {
        float:right;
        padding-right:10px;
    }

    /* Tooltip text */
    .tooltip .tooltiptext {

        visibility: hidden;
        background-color: white;
        color: #000;
        text-align: center;
        padding: 9px 14px;
        border-radius: 6px;
        font-size: 14px;
        font-style: normal;
        font-weight: 400;
        line-height: 1.42857143;
        text-align: left;
        text-align: start;
        text-decoration: none;
        text-shadow: none;
        text-transform: none;
        letter-spacing: normal;
        word-break: normal;
        word-spacing: normal;
        word-wrap: normal;
        white-space: normal;
        background-color: #fff;
        -webkit-background-clip: padding-box;
        background-clip: padding-box;
        border: 1px solid #ccc;
        border: 1px solid rgba(0,0,0,.2);
        border-radius: 6px;
        -webkit-box-shadow: 0 5px 10px rgb(0 0 0 / 20%);
        box-shadow: 0 5px 10px rgb(0 0 0 / 20%);


        position: absolute;
        width: 70%;
        z-index: 1;
        bottom: 100%;
        left: 30%;
        margin-left: -60px;
    }

    /* Show the tooltip text when you mouse over the tooltip container */
    .tooltip:hover .tooltiptext {
        visibility: visible;
    }

    </style>
    </head>
    <body>
    <div class="acs-container">
            <div class="scrollbar col-md-12">
                <!-- ACS HEADER | Branding zone-->
                <div class="acs-header sides-padding branding-zone">
                    <div class="col-md-6">
                        <img src="network_means_pageType_251" alt="Issuer image" data-cy="ISSUER_IMAGE"/>
                    </div>
                    <div class="col-md-6 card-logo-container">
                        <img src="network_means_pageType_254" alt="Card network image" data-cy="CARD_NETWORK_IMAGE"/>
                    </div>
                </div>
                <!-- ACS BODY | Challenge/Processing zone -->
                <div class="acs-purchase-context col-md-12 challenge-processing-zone">
                    <div class="sides-padding">
                        <div class="acs-challengeInfoHeader col-md-12" data-cy="CHALLENGE_INFO_HEADER">
                            network_means_pageType_151
                        </div>
                        <div class="acs-challengeInfoText leftPadding" id="acs-challenge-info-text" data-cy="CHALLENGE_INFO_TEXT">
                            network_means_pageType_152
                        </div>
                        <div class="col-md-12">
                            <form action="HTTPS://EMV3DS/challenge" method="get" data-cy="CHALLENGE_FORM" class="challenge-form">
                                <div class="form-group">
                                    <label for="challenge-html-data-entry" data-cy="CHALLENGE_INFO_LABEL" id="challenge-form-label">
                                        network_means_pageType_153
                                    </label>
                                    <input id="challenge-html-data-entry" name="submitted-otp-value" type="text" class="form-control" data-cy="CHALLENGE_HTML_DATA_ENTRY" required>
                                </div>
                                <input type="submit" value="network_means_pageType_154" class="btn btn-primary challenge-submit-button" data-cy="CHALLENGE_HTML_DATA_ENTRY_FORM_SUBMIT"/>
                            </form>
                            <form action="HTTPS://EMV3DS/challenge" method="get" class="challenge-form">
                                <div>
                                    <!-- The name and value attribute MUST NOT be changed -->
                                    <input type="hidden" name="challenge-resend" value="Y"/>
                                    <input type="submit" class="challenge-submit-button" value="network_means_pageType_155"/>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <!-- ACS FOOTER | Information zone -->
            <div class="acs-footer col-md-12 information-zone">
                <div class="sides-padding">
                    <div class="div-left">network_means_pageType_156</div>
                    <input type="checkbox" id="show" class="div-right">
                    <div for="show" class="div-right tooltip">
                        <img class="plus-image" src="data:image/svg+xml;base64,PHN2ZyBhcmlhLWhpZGRlbj0idHJ1ZSIgZm9jdXNhYmxlPSJmYWxzZSIgZGF0YS1wcmVmaXg9ImZhcyIgZGF0YS1pY29uPSJwbHVzIiBjbGFzcz0ic3ZnLWlubGluZS0tZmEgZmEtcGx1cyBmYS13LTE0IiByb2xlPSJpbWciIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgdmlld0JveD0iMCAwIDQ0OCA1MTIiPjxwYXRoIGZpbGw9ImN1cnJlbnRDb2xvciIgZD0iTTQxNiAyMDhIMjcyVjY0YzAtMTcuNjctMTQuMzMtMzItMzItMzJoLTMyYy0xNy42NyAwLTMyIDE0LjMzLTMyIDMydjE0NEgzMmMtMTcuNjcgMC0zMiAxNC4zMy0zMiAzMnYzMmMwIDE3LjY3IDE0LjMzIDMyIDMyIDMyaDE0NHYxNDRjMCAxNy42NyAxNC4zMyAzMiAzMiAzMmgzMmMxNy42NyAwIDMyLTE0LjMzIDMyLTMyVjMwNGgxNDRjMTcuNjcgMCAzMi0xNC4zMyAzMi0zMnYtMzJjMC0xNy42Ny0xNC4zMy0zMi0zMi0zMnoiPjwvcGF0aD48L3N2Zz4=" alt="Plus" style="height:1em;">
                        <span class="tooltiptext">network_means_pageType_157</span>
                    </div>
                </div>
            </div>
        </div>
'
WHERE `fk_id_layout` = @idAppViewPage;




set @customPageLayoutDesc_appView = 'MOBILE_APP_EXT_App_View (COZ)';
set @pageType = 'MOBILE_APP_EXT_APP_VIEW';

set @idAppViewPage = (select id
					  from `CustomPageLayout`
					  where `pageType` = @pageType
						and DESCRIPTION = @customPageLayoutDesc_appView);

UPDATE `CustomComponent`
SET `value` = '
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
    .acs-container {
        padding: 0em;
    }
    .scrollbar{
        overflow: auto;
        height: 90vh;
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
        min-height: 22em !important;
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
    img.warn-image {
        vertical-align: middle;
        float: left;
        padding-left: 5px;
    }
    .acs-challengeInfoText {
        margin-bottom: 2em;
        white-space: pre-line;
    }
    .acs-footer {
        font-size: 0.9em;
        padding-bottom: 2em;
    }
    .acs-footer-icon {
        text-align: right;
    }
    .sides-padding {
        margin-right: 15px;
        margin-left: 15px;
    }
    .leftPadding {
        padding-left: 15px;
    }
    .col-md-12,
    .col-md-10,
    .col-md-6,
    .col-md-2 {
        position: relative;
        min-height: 1px;
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
    .challenge-form {
        text-align: center;
    }
    label#challenge-form-label {
        float: left !important;
        text-align: left;
    }
    .challenge-submit-button {
        width: auto !important;
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
    #show:checked~#content {display:block;}
    .div-left {
        float:left;
        padding-left:10px;
    }
    .div-right {
        float:right;
        padding-right:10px;
    }

    /* Tooltip container */
    .tooltip {
        float:right;
        padding-right:10px;
    }

    /* Tooltip text */
    .tooltip .tooltiptext {

        visibility: hidden;
        background-color: white;
        color: #000;
        text-align: center;
        padding: 9px 14px;
        border-radius: 6px;
        font-size: 14px;
        font-style: normal;
        font-weight: 400;
        line-height: 1.42857143;
        text-align: left;
        text-align: start;
        text-decoration: none;
        text-shadow: none;
        text-transform: none;
        letter-spacing: normal;
        word-break: normal;
        word-spacing: normal;
        word-wrap: normal;
        white-space: normal;
        background-color: #fff;
        -webkit-background-clip: padding-box;
        background-clip: padding-box;
        border: 1px solid #ccc;
        border: 1px solid rgba(0,0,0,.2);
        border-radius: 6px;
        -webkit-box-shadow: 0 5px 10px rgb(0 0 0 / 20%);
        box-shadow: 0 5px 10px rgb(0 0 0 / 20%);


        position: absolute;
        width: 70%;
        z-index: 1;
        bottom: 100%;
        left: 30%;
        margin-left: -60px;
    }

    /* Show the tooltip text when you mouse over the tooltip container */
    .tooltip:hover .tooltiptext {
        visibility: visible;
    }

    </style>
    </head>
    <body>
    <div class="acs-container">
            <div class="scrollbar col-md-12">
                <!-- ACS HEADER | Branding zone-->
                <div class="acs-header sides-padding branding-zone">
                    <div class="col-md-6">
                        <img src="network_means_pageType_251" alt="Issuer image" data-cy="ISSUER_IMAGE"/>
                    </div>
                    <div class="col-md-6 card-logo-container">
                        <img src="network_means_pageType_254" alt="Card network image" data-cy="CARD_NETWORK_IMAGE"/>
                    </div>
                </div>
                <!-- ACS BODY | Challenge/Processing zone -->
                <div class="acs-purchase-context col-md-12 challenge-processing-zone">
                    <div class="sides-padding">
                        <div class="acs-challengeInfoHeader col-md-12" data-cy="CHALLENGE_INFO_HEADER">
                            network_means_pageType_151
                        </div>
                        <div class="acs-challengeInfoText leftPadding" id="acs-challenge-info-text" data-cy="CHALLENGE_INFO_TEXT">
                            network_means_pageType_152
                        </div>
                        <div class="col-md-12">
                            <form action="HTTPS://EMV3DS/challenge" method="get" class="challenge-form">
                              <input type="hidden" name="submitted-oob-continue-value" value="Y">
                              <input type="submit" value="network_means_pageType_165" class="btn btn-primary challenge-submit-button" data-cy="CHALLENGE_OOB_CONTINUE_FORM_SUBMIT"/>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <!-- ACS FOOTER | Information zone -->
            <div class="acs-footer col-md-12 information-zone">
                <div class="sides-padding">
                    <div class="div-left">network_means_pageType_156</div>
                    <input type="checkbox" id="show" class="div-right">
                    <div for="show" class="div-right tooltip">
                        <img class="plus-image" src="data:image/svg+xml;base64,PHN2ZyBhcmlhLWhpZGRlbj0idHJ1ZSIgZm9jdXNhYmxlPSJmYWxzZSIgZGF0YS1wcmVmaXg9ImZhcyIgZGF0YS1pY29uPSJwbHVzIiBjbGFzcz0ic3ZnLWlubGluZS0tZmEgZmEtcGx1cyBmYS13LTE0IiByb2xlPSJpbWciIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgdmlld0JveD0iMCAwIDQ0OCA1MTIiPjxwYXRoIGZpbGw9ImN1cnJlbnRDb2xvciIgZD0iTTQxNiAyMDhIMjcyVjY0YzAtMTcuNjctMTQuMzMtMzItMzItMzJoLTMyYy0xNy42NyAwLTMyIDE0LjMzLTMyIDMydjE0NEgzMmMtMTcuNjcgMC0zMiAxNC4zMy0zMiAzMnYzMmMwIDE3LjY3IDE0LjMzIDMyIDMyIDMyaDE0NHYxNDRjMCAxNy42NyAxNC4zMyAzMiAzMiAzMmgzMmMxNy42NyAwIDMyLTE0LjMzIDMyLTMyVjMwNGgxNDRjMTcuNjcgMCAzMi0xNC4zMyAzMi0zMnYtMzJjMC0xNy42Ny0xNC4zMy0zMi0zMi0zMnoiPjwvcGF0aD48L3N2Zz4=" alt="Plus" style="height:1em;">
                        <span class="tooltiptext">network_means_pageType_157</span>
                    </div>
                </div>
            </div>
        </div>
'
WHERE `fk_id_layout` = @idAppViewPage;



