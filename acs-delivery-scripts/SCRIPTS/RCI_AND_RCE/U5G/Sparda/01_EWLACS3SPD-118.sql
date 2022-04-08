USE U5G_ACS_BO;

SET @pageLayoutId = (SELECT id FROM `CustomPageLayout` WHERE pageType = 'UNDEFINED_APP_VIEW_MEAN_SELECT' AND description = 'Choice_App_View (SPARDA)');

UPDATE `CustomComponent` SET `value` = '
<style>
    .header {
        margin-top: 10px;
        margin-bottom: 10px;
    }
	.scrollbar{
        height: 370px;
		overflow-y: auto;
        overflow-x: hidden;
	}
    .btn-submit {
        margin: 10px;
    }
    input[type=radio] {
        margin: 5px;
    }
    .help-text-container {
        padding-left: 20px;
    }
    .fa-plus-container {
        text-align: end;
        padding-right: 40px;
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
	  -moz-transform:    translate3d(0, 0, 0);
	  transform:         translate3d(0, 0, 0);
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
	  margin-left: -220px;
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
	  -moz-transform:    translateY(-12px);
	  transform:         translateY(-12px);
	}
</style>
<div class="container-fluid">
        <div class="row header">
            <div class="col-md-6">
                <img src="network_means_pageType_251" id="issuer-image" alt="Issuer image" data-cy="ISSUER_IMAGE" />
            </div>
            <div class="col-md-6 card-logo-container">
                <img src="network_means_pageType_254" id="payment-system-image" alt="Card network image" data-cy="CARD_NETWORK_IMAGE" />
            </div>
        </div>
        <!-- ACS BODY | Challenge/Processing zone -->
        <div class="scrollbar">
            <div class="row">
                <div class="col-md-12 acs-challengeInfoHeader" id="acs-challenge-info-header" data-cy="CHALLENGE_INFO_HEADER">
                    network_means_pageType_151
                </div>
            </div>
            <div class="row">
                <div class="acs-challengeInfoText col-md-12" id="acs-challenge-info-text" data-cy="CHALLENGE_INFO_TEXT">
                    network_means_pageType_152
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <!-- DO NOT change the id attribute of the form tag -->
                    <form id="select-means-form" action="HTTPS://EMV3DS/challenge" method="get">
                        <!-- The list of selectable values will be inserted here by the challenge-app service -->
                        <div class="btn-submit">
                            <input type="submit" id="select-means-submit" class="btn btn-primary btn-block" value="network_means_pageType_154" data-cy="CHALLENGE_MEANS_SELECT_FORM_SUBMIT"/>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    <!-- ACS FOOTER | Information zone -->
    <div class="row acs-footer">
        <div class="col-md-6 help-text-container">
            network_means_pageType_156
        </div>
        <div class="col-md-6 fa-plus-container">
            <input type=checkbox id="show" class="div-right">
            <label for="show">
                <a data-tooltip="network_means_pageType_157">
                    <i class="fa fa-plus"></i>
                </a>
            </label>
            <span id="content">network_means_pageType_157 </span>
        </div>
    </div>
</div>' where fk_id_layout = @pageLayoutId;
