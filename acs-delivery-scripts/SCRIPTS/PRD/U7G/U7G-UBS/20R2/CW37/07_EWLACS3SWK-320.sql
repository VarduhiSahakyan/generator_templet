use U7G_ACS_BO;
set @BankB = 'UBS';

set @layoutId = (select id
                 from `CustomPageLayout`
                 where `DESCRIPTION` like CONCAT('Polling Page (', @BankB, ')%'));

update CustomComponent
set value = '<style>
	#main-container {
		font-family: FrutigerforUBSWeb, sans-serif;
		max-width: 600px;
		max-height: 600px;
		margin-left: auto;
		margin-right: auto;
		padding-left: 16px;
		padding-right: 16px;
	}
	#main-container #pageHeader {
		width: 100%;
		height: 63px;
		padding-right: 0px;
		padding-left: 0px;
	}
	#main-container #pageHeaderLeft {
		width: 50%;
		float: left;
		height: 100%;
		display: flex;
		align-items: center;
	}
	#main-container #pageHeaderRight {
		width: 50%;
		float: right;
		height: 100%;
		display: flex;
		align-items: center;
		justify-content: flex-end;
	}
	#main-container #issuerLogo {
		max-height: 31px;
		max-width: 100%;
	}
	#main-container #networkLogo {
		max-height: 31px;
		max-width: 100%;
	}
	#main-container #content {
		text-align: left;
	}
	div#contentHeaderLeft h3 {
		font-family: FrutigerforUBSWeb-Lt, sans-serif;
		font-size: 24px;
		color: #1c1c1c;
		line-height: 28px;
		margin-bottom: 24px;
	}
	div#leftMenuLayout {
		font-size: 16px;
		letter-spacing: 0;
		line-height: 24px;
		padding-right: 0px;
		padding-left: 0px;
	}
	div#leftMenuLayout span.ng-binding {
		font-family: FrutigerforUBSWeb, sans-serif;
		font-weight: normal;
		font-size: 16px;
		color: #1c1c1c;
		letter-spacing: 0;
		line-height: 24px;
	}
	div#leftMenuLayout span.custom-text.ng-binding {
		font-family: FrutigerforUBSWeb, sans-serif;
		font-weight: normal;
		font-size: 16px;
		color: #646464;
		letter-spacing: 0;
		line-height: 24px;
	}
	#main-container .menu-title {
		display: none;
	}
	#main-container .me02
	nu-elements {
		width: 50%;
		white-space: nowrap;
	}
	#main-container .side-menu .menu-elements {
		line-height: 12px;
	}
	span.col-sm-5.col-xs-6.col-xs-offset-0.col-sm-offset-1.text-right.padding-left {
		padding: 0px;
	}
	span.col-sm-6.col-xs-6.text-left.padding-left {
		padding-left: 8px;
	}
	#main-container #contentBottom {
		padding-left: 0%;
		padding-right: 0px;
		width: 468px;
		float: right;
	}
	#main-container .tooltips:hover span {
		margin-bottom: 10px;
	}
	#main-container .mtan-input {
		padding-bottom: 8px;
	}
	#main-container .input-label {
		flex-direction: row;
		align-items: center;
	}
	#main-container .mtan-label {
		text-align: left;
		flex: 0 0 180px;
		font-family: FrutigerforUBSWeb, sans-serif;
		font-size: 12px;
		color: #646464;
		letter-spacing: 0;
		line-height: 16px
	}
	#main-container .otp-field input {
		font-size: 16px;
		color: #1c1c1c;
		background: #ffffff;
		margin-left: 0px;
		border: 1px solid #aaaaaa;
		width: 218px;
		height: 48px;
	}
	#main-container .otp-field input:focus {
		outline: none;
	}
	#main-container .row .left {
		float: left;
		width: 180px;
		text-align: right;
	}
	#main-container .row .left span {
		margin-right: 0.5em
	}
	#main-container #helpButton span.fa-info {
		display: none;
	}
	#main-container div#footer {
		background-image: none;
		height: 44px;
	}
	#main-container #footer {
		width: 100%;
		clear: both;
	}
	#main-container #footer:after {
		content: "";
		height: 100%;
		display: table;
		clear: both;
		padding-bottom: 0.5em;
	}
	#main-container #footer .help-area {
		display: flex;
		flex-direction: row;
		padding-top: 24px;
	}
	#main-container .help-link {
		font-size: 14px;
		line-height: 20px;
		width: 50%;
		order: 2;
		text-align: left;
		color: #007099;
	}
	#main-container #helpButton button {
		border-style: none;
		padding: 0px
	}
	#main-container #helpButton button span {
		color: #007099;
		background-color: #f7f7f7;
	}
	#main-container .col-lg-4 {
		width: 100%;
		margin-bottom: 20px;
	}
	#main-container .col-md-4 {
		width: 100%;
		margin-bottom: 20px;
	}
	#main-container .col-sm-4 {
		width: 100%;
		margin-bottom: 20px;
	}
	#main-container .col-sm-5 {
		width: 34%;
	}
	#main-container .col-sm-6 {
		width: 65%;
	}
	#main-container .col-xs-12 {
		width: 100%;
	}
	#main-container .col-sm-offset-1 {
		margin-left: 0%;
	}
	#main-container .side-menu .text-left, .side-menu .text-right {
		margin-bottom: 12px;
	}
	#accessApp {
		background: #f5f5f5;
		display: flex;
		text-align: left;
	}
	#accessAppLeft {
		min-width: 112px;
		height: 100%;
	}
	#accessAppRight {
		padding-bottom: 15px;
	}
	#circleBackground {
		width: 82px;
		height: 82px;
		background: #fff;
		border-radius: 50%;
		margin: auto;
		margin-top: 15px;
		display: flex;
		align-items: center;
		justify-content: center;
	}
	#accessAppLogo img {
		background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAAAXNSR0IArs4c6QAAA3lJREFUWAnFV81PE1EQZ9vSANHQ0NIaW0oDbWLShNqmHAApgieJHxfhgInxIInCyaPRP0A9SqIGL5JIDD15QNADab00MdFYbMTwkUht/aAkJtqE0i/qb6ALz027bneb8JLtmzcz+5vfm3k7u+UKhYK65hCH6hBj74bWVIuA1+s1JpNJJ/DSLpfrg9/vT0nB5pSWoKenRx+Pxx/s7OxcQkC+nHmVSjVtNptvhkKh32JEFJXA5/M1xWKxEDbRqdFoLptMpma9Xm9Rq9VXQGgAxN51d3c3ihGooQzIvVpbW29bLJZ1BDEKMXp7e5thi1mt1imhjV0rIkBAXV1dTSwgK4PgCEjkhoaGjrB6VlZUAkqtWI11Ot0buKgXFxfd5cpQlafA4XAMptPpUQTxUiDs8H19ff3jhoaGcHFdR3OpoZgA0vwIB26U47gXOHz3EVyF9elUKjWL6y2C5pCJSKnguzq2HpXKNpvtOmqctdvtF4T3gtg4bAVcc0Ibu5Z9BoLBIJfP5+9i1/dWV1df8jtEQzK3tbWNIAt3kJUM9J3Dw8Na3i6cZRMYGxs7gZ00otYzLOjGxkY0m80+RfBXsJ2BzRCJRE6yPqwsm0Aul7MRkMFgiLOAOHg+j8eji0aj14xG4yeywdfA+rCy7EOIzrdOQIlEwoMpSDKN5eXl0J60b6upra39wuuEs+wMLC0tfQbYx62trVt0HoTApCMb+RR9hS57a/ZEVirj9PfRU4B2+4xtxySTrviE9InhVtSK3W738ZaWltdOp9POg4LEeeh+IaCf15FMOjSoc7yu3Cy5BDhYps3NzQUA2VD//Xc9HsE5nPgF5JMtA1TcwsrKynzpvB9oJRHgg+M2FV63A+Fw+OcBhDLpvwTKBafUoxNeVRYeOxIDEAueyWRmUI5Osful2EQJoOazAPkn7bRzCo4aT6HZjEsJIuZTthFNTk4SORd9avE1FwS/IQYs1VaWwMTExDGAqEDgB4G1t7dfRI9/Xtx5VYITblkC29vbZnLAh8Y0nms96l2HL90nSHvVgosSwM6zeNU+hNM37Pq7VquNo88H6CbhgP0PXr+DHR0dDrKB7CmQnRP6lVor/l9AoP39/UfX1tbmQcRKaxD4ivNyNhAIJGktNqpCgALwJEiWGpx8q0aAwIgEzVJ2Tn40qkpgD7KyX9FGVBmUPO+/XdPZ4Qe7IckAAAAASUVORK5CYII=);
		background-repeat: no-repeat;
		width: 32px;
		height: 32px;
		padding-top: 12px;
		padding-bottom: 20px;
		background-size: 100%;
	}
	#accessAppTitle {
		font-family: FrutigerforUBSWeb, sans-serif;
		font-size: 18px;
		color: #1c1c1c;
		line-height: 24px;
		width: 240px;
		margin-top: 32px;
	}
	#accessAppText {
		font-family: FrutigerforUBSWeb, sans-serif;
		font-size: 14px;
		color: #1c1c1c;
		letter-spacing: 0;
		line-height: 20px;
		width: 340px;
		margin-top: 8px;
	}
	#cancelButtonDiv {
		padding-top: 16px;
	}
	#cancelButton button {
		border: 1px solid #919191;
		border-radius: 2px;
		width: 105px;
		height: 38px;
	}
	#cancelButton button:focus {outline: 0;border-color: #6e6e6e 1px dotted;}
	#cancelButton button:active {
		background-image: linear-gradient(rgba(0, 0, 0, .05), rgba(0, 0, 0, .05));
		border-color: rgba(0, 0, 0, .25) rgba(0, 0, 0, .2) rgba(0, 0, 0, .15);
		box-shadow: none;
		outline: 0px;
	}
	#cancelButton button custom-text {
		font-family: FrutigerforUBSWeb, sans-serif;
		font-size: 14px;
		color: #1c1c1c;
		text-align: center;
		line-height: 20px;
	}
	#cancelButton button span.fa {
		padding-right: 0px;
	}
	#cancelButton button span:before {
		content: '';
	}
	@media all and (max-width: 600px) {
		#main-container #contentBottom { width: 468px; float: right; }
		span#info-icon {display: inline;position: relative;font-size: 1em;top: 5px;left: 3px;float: left;margin-right: 3px;}
	}
	@media all and (max-width: 500px) {
		#main-container .menu-elements { width: 60%; }
		#main-container #contentBottom { width: 368px; float: right; }
		#accessApp { height: 204px; }
		#accessAppText { width: 240px; }
		#main-container .otp-field input { width: 218px; }
		span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
	}
	@media all and (max-width: 390px) {
		#main-container .menu-elements { width: 80%; }
		#main-container #contentBottom { width: 358px; }
		#accessAppTitle { width: 230px; }
		#accessAppText { width: 230px; }
		#main-container .otp-field input { width: 218px; }
		span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
	}
	@media all and (max-width: 250px) {
		#main-container #pageHeader {padding-left: 0px; }
		#main-container #pageHeaderLeft {padding-left: 0px; }
		#main-container #pageHeaderRight {padding-right: 0px; }
		#main-container #message-container {width: 218px; }
		#main-container #content { text-align: left; margin-left: 0em; }
		#main-container .ng-isolate-scope .text-right { text-align: left; padding-left: 0px;}
		#main-container .menu-elements { width: auto; }
		.break-word.ng-scope {width: 100%; display: inline-flex;}
		#main-container .col-sm-5 {width: auto; display: inline-table;}
		#main-container .col-sm-6 {width: auto; display: inline-table;}
		#main-container .col-sm-4 { margin-bottom: 0px; }
		#main-container #contentBottom { width: 218px; }
		#accessApp { height: 328px; display: inline-grid; width: 218px; text-align: center;}
		#accessAppRight {height: 100%; margin: auto;}
		#accessAppTitle { width: 186px; margin-top: 10px;}
		#accessAppText { width: 186px; }
		#main-container .otp-field input { width: 218px; }
		span#info-icon {position: relative;font-size: 0.8em;top: 7px;left: 5px;float: left;margin-right: 7px;}
		#main-container .help-link {width: 29%;text-align: left;}
	}

</style>
<div id="main-container" class="" ng-style="style" class="ng-scope">
	<div id="headerLayout" class="row">
		<div id="pageHeader" class="text-center col-xs-12">
			<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
				<custom-image alt-key="''network_means_pageType_1_IMAGE_ALT''" image-key="''network_means_pageType_1_IMAGE_DATA''" id="issuerLogo" straight-mode="false"></custom-image>
			</div>
			<div id="pageHeaderRight" ng-style="style" class="ng-scope">
				<custom-image alt-key="''network_means_pageType_2_IMAGE_ALT''" image-key="''network_means_pageType_2_IMAGE_DATA''" id="networkLogo" straight-mode="false"></custom-image>
			</div>
		</div>
	</div>
	<message-banner close-button="''network_means_pageType_174''" back-button="''network_means_pageType_175''"></message-banner>
	<div id="content">
		<div id="contentHeaderLeft">
			<h3>
				<custom-text custom-text-key="''network_means_pageType_1''"></custom-text>
			</h3>
		</div>
		<div id="leftMenuLayout" class=" col-xs-12 col-sm-4 col-md-4 col-lg-4">
			<div>
				<side-menu menu-title="''TRANSACTION_SUMMARY''"></side-menu>
			</div>
		</div>
		<div id="contentBottom" class=" col-xs-12 col-sm-4 col-md-4 col-lg-4">
			<div id="accessApp">
				<div id="accessAppLeft">
					<div id="circleBackground">
						<custom-image id="accessAppLogo" straight-mode="false"></custom-image>
					</div>
				</div>
				<div id="accessAppRight">
					<div id="accessAppTitle">
						<custom-text custom-text-key="''network_means_pageType_2''"></custom-text>
					</div>
					<div id="accessAppText">
						<custom-text custom-text-key="''network_means_pageType_3''"></custom-text>
					</div>
				</div>
			</div>
			<div id="cancelButtonDiv">
				<cancel-button cn-label="''network_means_pageType_40''" id="cancelButton"></cancel-button>
			</div>
			<div id="footer">
				<div class="help-area">
					<div class="help-link">
						<span class="fa fa-angle-right"></span> <span id="helpButton" class="helpButtonClass"> <custom-text custom-text-key="''network_means_pageType_41''"></custom-text> </span>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>' where fk_id_layout = @layoutId;