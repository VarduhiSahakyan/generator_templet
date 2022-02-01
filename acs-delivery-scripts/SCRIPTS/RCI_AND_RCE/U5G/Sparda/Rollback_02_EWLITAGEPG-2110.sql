USE U5G_ACS_BO;

SET @createdBy = 'A758582';

SET @BankB = 'Spardabank';

SET @id_layout = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Chiptan OTP Form Page (', @BankB, ')%') );

UPDATE `CustomComponent` SET `value` = '<style>
	div#optGblPage {
		font-family: Arial, bold;
		color: #333333;
		font-size: 14px;
	}

	/* Start Bootstrap reset */
	.col-sm-1, .col-sm-2, .col-sm-3, .col-sm-4, .col-sm-5, .col-sm-6, .col-sm-7, .col-xs-1, .col-xs-2, .col-xs-3, .col-xs-4, .col-xs-5, .col-xs-6, .col-xs-7 {
		margin:0;
		width:auto;
		float:none;
		position:static;
	}

	.col-sm-offset-1, .col-sm-offset-2, .col-xs-offset-1, .col-xs-offset-2  {
		margin:0;
		float:none;
		position:static;
	}

	.text-right, .text-center, .text-left {
		text-align: unset;
	}
	/* End Bootstrap reset */

	#helpButton {
		text-align: left;
		/*padding-left: 52.5em;
		padding-right: 0.5em;*/
	}
	#helpButton button {
		display: inline-block;
		cursor: pointer;
		text-align: left;
		text-decoration: none;
		outline: none;
		color: #fff;
		background-color: #FF8C00;
		border: none;
		border-radius: 5px;
		box-shadow: 0 2px #999;
	}
	#helpButton button:hover {
		background-color: #FFA500
	}
	#helpButton button:active {
		background-color: #FF8C00;
		box-shadow: 0 3px #666;
		transform: translateY(2px);
	}
	#helpButton button span:before {
		content:'''';
	}
	#helpButton button custom-text {
	}
	#cancelButton {
		/*flex: 1 1 50%;
		text-align:right;
		padding-right:0.5em;*/
	}
	#cancelButton button {
		display: inline-block;
		cursor: pointer;
		text-align: center;
		text-decoration: none;
		outline: none;
		color: #fff;
		background-color: #FF8C00;
		border: none;
		border-radius: 5px;
		box-shadow: 0 2px #999;
	}

	#cancelButton button:hover {
		background-color: #FFA500
	}

	#cancelButton button:active {
		background-color: #FF8C00;
		box-shadow: 0 3px #666;
		transform: translateY(2px);
	}

	/* reset for default styles */
	#valButton button.btn.disabled {
		opacity:1;
	}

	#valButton {
		/*flex: 1 1 50%;
		padding-left:0.5em;*/
	}

	#valButton button.btn[disabled] {
		opacity:1;
	}

	#valButton button div {
		display:inline;
	}

	#valButton button {
		display: inline-block;
		cursor: pointer;
		text-align: center;
		text-decoration: none;
		outline: none;
		color: #fff;
		background-color: #FF8C00;
		border: none;
		border-radius: 5px;
		box-shadow: 0 2px #999;
	}

	#valButton button:hover {
		background-color: #FFA500
	}

	#valButton button:active {
		background-color: #FF8C00;
		box-shadow: 0 3px #666;
		transform: translateY(2px);
	}

	#i18n-container {
		width: 100%;
		clear: both;
	}

	#issuerLogo {
		max-height: 64px;
		max-width: 100%;
	}

	#networkLogo {
		max-height: 64px;
		max-width: 100%;
	}

	#pageHeader {
		width: 100%;
		height: 96px;
		border-bottom: 1px solid #DCDCDC;
		display: flex;
		justify-content: space-between;
	}

	#pageHeaderLeft {
		padding-left: 0.5em;
		padding-top: 0.5em;
	}

	#pageHeaderRight {
		padding-right: 0.5em;
		padding-top: 0.5em;
	}

	.paragraph {
		text-align: center;
		margin-top: -2px;
		margin-bottom: 5px;
	}

	.topColumn {
		padding:0.5em;
	}

	.bottomColumn {
		display:block;
		text-align: left;
		padding-left: 1em;
	}

	.contentRow {
		width: 100%;
		padding: 0;
		clear: both;
		text-align: center;
	}

	side-menu .menu-elements div div div {
		display:flex;
		flex-direction:row;
		width:max-context;
	}

	side-menu .menu-elements div div div span {
		flex: 1 1 50%;
		text-align:right;
	}

	side-menu .menu-elements div div div span + span {
		flex: 1 1 50%;
		text-align:left;
	}

	#optGblPage > div.contentRow > div.bottomColumn > side-menu > div > div.menu-elements > div:nth-child(5) {
		display:none;
	}
	.tanContainer {
		width:100%;
		display:flex;
		justify-content:space-evenly;
	}

	#tanLabel {
		text-align:right;
		flex: 1 1 50%;
	}

	#otpForm {
		flex: 1 1 50%;
		text-align:left;
		padding-left: 5px;
	}

	#footerDiv {
		height: 40px;
		background-color: #F7F8F8;
		width:100%;
		margin-top:1em;
		padding-top:0.5em;
		padding-bottom:0.5em;
		display:block;
		text-align:center;
	}
</style>
<div id="optGblPage">
	<div id="pageHeader" ng-style="style" class="ng-scope">
		<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
			<custom-image alt-key="''network_means_pageType_1_IMAGE_ALT''" image-key="''network_means_pageType_1_IMAGE_DATA''" id="issuerLogo" straight-mode="false"></custom-image>
		</div>
		<div id="pageHeaderRight" ng-style="style" class="ng-scope" >
			<custom-image alt-key="''network_means_pageType_2_IMAGE_ALT''"  image-key="''network_means_pageType_2_IMAGE_DATA''" id="networkLogo" straight-mode="false"></custom-image>
		</div>
	</div>

	<message-banner close-button="''network_means_pageType_174''" back-button="''network_means_pageType_175''"></message-banner>

	<div id="i18n-container" class="text-center">
		<div id="i18n-inner">
			<i18n></i18n>
		</div>
	</div>
	<div id="displayLayout" class="row">
		<div id="green-banner"></div>
	</div>
	<style>
	div#green-banner {
		height: 50px !important;
		background-color: #FFFFFF;
		border-bottom: 5px solid #FFFFFF;
		width: 100%;
	}
	</style>
	<div class="contentRow">
		<div class="topColumn">
			<div class="paragraph">
				<custom-text custom-text-key="''network_means_pageType_1''" id="paragraph1"></custom-text>
			</div>
			<div class="paragraph">
				<custom-text custom-text-key="''network_means_pageType_2''" id="paragraph2"></custom-text>
			</div>
		</div>
		<div x-ms-format-detection="none" class="bottomColumn">
			<side-menu></side-menu>
		</div>
		<div class="display-challenge">
			<chiptan speed-label="''network_means_pageType_4''"
			zoom-label="''network_means_pageType_5''"
			manual-link-label1="''network_means_pageType_6''"
			manual-link-label2="''network_means_pageType_7''"
			manual-description="''network_means_pageType_9''">
			</chiptan>
		</div>
		<div class="tanContainer">
			<div id = "tanLabel">
				<custom-text custom-text-key="''network_means_pageType_3''"></custom-text>
			</div>
			<div id = "otpForm" >
				<otp-form></otp-form>
			</div>
		</div>
	</div>
	<div  id="footerDiv">
		<help help-label="''network_means_pageType_41''" id="helpButton"></help>
		<cancel-button cn-label="''network_means_pageType_40''" id="cancelButton" ></cancel-button>
		<val-button val-label="''network_means_pageType_42''" id="valButton" ></val-button>
	</div>
</div>' WHERE `fk_id_layout` = @id_layout;

SET @id_layout = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('SMS OTP Form Page (', @BankB, ')%') );

UPDATE `CustomComponent` SET `value` = '<style>
	div#optGblPage {
		font-family: Arial, bold;
		color: #333333;
		font-size: 14px;
	}

	/* Start Bootstrap reset */
	.col-sm-1, .col-sm-2, .col-sm-3, .col-sm-4, .col-sm-5, .col-sm-6, .col-sm-7, .col-xs-1, .col-xs-2, .col-xs-3, .col-xs-4, .col-xs-5, .col-xs-6, .col-xs-7 {
		margin:0;
		width:auto;
		float:none;
		position:static;
	}

	.col-sm-offset-1, .col-sm-offset-2, .col-xs-offset-1, .col-xs-offset-2  {
		margin:0;
		float:none;
		position:static;
	}

	.text-right, .text-center, .text-left {
		text-align: unset;
	}
	/* End Bootstrap reset */

	#helpButton {
		text-align: left;
		/*padding-left: 52.5em;
		padding-right: 0.5em;*/
	}
	#helpButton button {
		display: inline-block;
		cursor: pointer;
		text-align: left;
		text-decoration: none;
		outline: none;
		color: #fff;
		background-color: #FF8C00;
		border: none;
		border-radius: 5px;
		box-shadow: 0 2px #999;
	}
	#helpButton button:hover {
		background-color: #FFA500
	}
	#helpButton button:active {
		background-color: #FF8C00;
		box-shadow: 0 3px #666;
		transform: translateY(2px);
	}
	#helpButton button span:before {
		content:'''';
	}
	#helpButton button custom-text {
	}
	#cancelButton {
		/*flex: 1 1 50%;
		text-align:right;
		padding-right:0.5em;*/
	}
	#cancelButton button {
		display: inline-block;
		cursor: pointer;
		text-align: center;
		text-decoration: none;
		outline: none;
		color: #fff;
		background-color: #FF8C00;
		border: none;
		border-radius: 5px;
		box-shadow: 0 2px #999;
	}

	#cancelButton button:hover {
		background-color: #FFA500
	}

	#cancelButton button:active {
		background-color: #FF8C00;
		box-shadow: 0 3px #666;
		transform: translateY(2px);
	}

	/* reset for default styles */
	#valButton button.btn.disabled {
		opacity:0.65;
	}

	#valButton {
		/*flex: 1 1 50%;
		padding-left:0.5em;*/
	}

	#valButton button.btn[disabled] {
		opacity:1;
	}

	#valButton button div {
		display:inline;
	}

	#valButton button {
		display: inline-block;
		text-align: center;
		text-decoration: none;
		outline: none;
		color: #fff;
		background-color: #FF8C00;
		border: none;
		border-radius: 5px;
		box-shadow: 0 2px #999;
	}

	#valButton button:hover {
		background-color: #FFA500
	}

	#valButton button:active {
		background-color: #FF8C00;
		box-shadow: 0 3px #666;
		transform: translateY(2px);
	}

	#i18n-container {
		width: 100%;
		clear: both;
	}

	#issuerLogo {
		max-height: 64px;
		max-width: 100%;
	}

	#networkLogo {
		max-height: 64px;
		max-width: 100%;
	}

	#pageHeader {
		width: 100%;
		height: 96px;
		border-bottom: 1px solid #DCDCDC;
		display: flex;
		justify-content: space-between;
	}

	#pageHeaderLeft {
		padding-left: 0.5em;
		padding-top: 0.5em;
	}

	#pageHeaderRight {
		padding-right: 0.5em;
		padding-top: 0.5em;
	}

	.paragraph {
		text-align: center;
		margin-top: -2px;
		margin-bottom: 5px;
	}

	.topColumn {
		padding:0.5em;
	}

	.bottomColumn {
		display:block;
		text-align: left;
		padding-left: 1em;
	}

	.contentRow {
		width: 100%;
		padding: 0;
		clear: both;
		text-align: center;
	}

	side-menu .menu-elements div div div {
		display:flex;
		flex-direction:row;
		width:max-context;
	}

	side-menu .menu-elements div div div span {
		flex: 1 1 50%;
		text-align:right;
	}

	side-menu .menu-elements div div div span + span {
		flex: 1 1 50%;
		text-align:left;
	}

	.tanContainer {
		width:100%;
		display:flex;
		justify-content:space-evenly;
		margin-top: 0px;
		padding-left: 3px;
	}

	#tanLabel {
		text-align:right;
		flex: 1 1 50%;
	}

	#otpForm {
		flex: 1 1 50%;
		text-align:left;
		padding-left: 5px;
	}

	#phNumber {
		margin-left: 7px;
	}

	#footerDiv {
		height: 40px;
		background-color: #F7F8F8;
		width:100%;
		margin-top:1em;
		padding-top:0.5em;
		padding-bottom:0.5em;
		display:block;
		text-align:center;
	}
	div.ng-scope:nth-child(5) > div:nth-child(1) > div:nth-child(1) > span:nth-child(1) > label:nth-child(1) > custom-text:nth-child(1) > span:nth-child(1) {
		display:none;
	}
	div.ng-scope:nth-child(5) > div:nth-child(1) > div:nth-child(1) > span:nth-child(2) {
		display:none;
	}
	#sideLayout {
		margin-left: 677px;
		margin-top: -30px;
	}
</style>
<div id="optGblPage">
	<div id="pageHeader" ng-style="style" class="ng-scope">
		<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
			<custom-image alt-key="''network_means_pageType_1_IMAGE_ALT''" image-key="''network_means_pageType_1_IMAGE_DATA''" id="issuerLogo" straight-mode="false"></custom-image>
		</div>
		<div id="pageHeaderRight" ng-style="style" class="ng-scope" >
			<custom-image alt-key="''network_means_pageType_2_IMAGE_ALT''"  image-key="''network_means_pageType_2_IMAGE_DATA''" id="networkLogo" straight-mode="false"></custom-image>
		</div>
	</div>
	<div id="displayLayout" class="row">
		<div id="grey-banner"></div>
	</div>
	<message-banner  close-button="''network_means_pageType_174''" back-button="''network_means_pageType_175''"></message-banner>

	<div class="contentRow">
		<div class="topColumn">
			<div class="paragraph">
				<custom-text custom-text-key="''network_means_pageType_1''" id="paragraph1"></custom-text>
			</div>
			<div class="paragraph">
				<custom-text custom-text-key="''network_means_pageType_2''" id="paragraph2"></custom-text>
			</div>
		</div>
		<div x-ms-format-detection="none" class="bottomColumn">
			<side-menu></side-menu>
		</div>
		<div class="tanContainer">
			<div id = "tanLabel">
				<div>
					<custom-text custom-text-key="''network_means_pageType_104''"></custom-text>
				</div>
				<custom-text custom-text-key="''network_means_pageType_3''"></custom-text>
			</div>
			<div id = "otpForm" >
				<div id = "phNumber">
					<custom-text custom-text-key="''network_means_pageType_4''"></custom-text>
				</div>
				<otp-form></otp-form>
			</div>
		</div>
	</div>
	<div id="footerDiv">
		<help help-label="''network_means_pageType_41''" id="helpButton"></help>
		<cancel-button cn-label="''network_means_pageType_40''" id="cancelButton" ></cancel-button>
		<val-button val-label="''network_means_pageType_42''" id="valButton" ></val-button>
	</div>
</div>' WHERE `fk_id_layout` = @id_layout;

SET @id_layout = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Refusal Page (', @BankB, ')%') );

UPDATE `CustomComponent` SET `value` = '<style>
	div#optGblPage {
		font-family: Arial, bold;
		color: #333333;
		font-size: 14px;
	}

	/* Start Bootstrap reset */
	.col-sm-1, .col-sm-2, .col-sm-3, .col-sm-4, .col-sm-5, .col-sm-6, .col-sm-7, .col-xs-1, .col-xs-2, .col-xs-3, .col-xs-4, .col-xs-5, .col-xs-6, .col-xs-7 {
		margin:0;
		width:auto;
		float:none;
		position:static;
	}

	.col-sm-offset-1, .col-sm-offset-2, .col-xs-offset-1, .col-xs-offset-2  {
		margin:0;
		float:none;
		position:static;
	}

	.text-right, .text-center, .text-left {
		text-align: unset;
	}
	/* End Bootstrap reset */

	#cancelButton {
		/*flex: 1 1 50%;
		text-align:right;
		padding-right:0.5em;*/
	}
	#cancelButton button {
		display: inline-block;
		cursor: pointer;
		text-align: center;
		text-decoration: none;
		outline: none;
		color: #fff;
		background-color: #FF8C00;
		border: none;
		border-radius: 5px;
		box-shadow: 0 2px #999;
	}

	#cancelButton button:hover {
		background-color: #FFA500
	}

	#cancelButton button:active {
		background-color: #FF8C00;
		box-shadow: 0 3px #666;
		transform: translateY(2px);
	}

	/* reset for default styles */
	#valButton button.btn.disabled {
		opacity:1;
	}

	#valButton {
		/*flex: 1 1 50%;
		padding-left:0.5em;*/
	}

	#valButton button.btn[disabled] {
		opacity:1;
	}

	#valButton button div {
		display:inline;
	}

	#valButton button {
		display: inline-block;
		cursor: pointer;
		text-align: center;
		text-decoration: none;
		outline: none;
		color: #fff;
		background-color: #FF8C00;
		border: none;
		border-radius: 5px;
		box-shadow: 0 2px #999;
	}

	#valButton button:hover {
		background-color: #FFA500
	}

	#valButton button:active {
		background-color: #FF8C00;
		box-shadow: 0 3px #666;
		transform: translateY(2px);
	}

	#i18n-container {
		width: 100%;
		clear: both;
	}

	#issuerLogo {
		max-height: 64px;
		max-width: 100%;
	}

	#networkLogo {
		max-height: 64px;
		max-width: 100%;
	}

	#pageHeader {
		width: 100%;
		height: 96px;
		border-bottom: 1px solid #DCDCDC;
		display: flex;
		justify-content: space-between;
	}

	#pageHeaderLeft {
		padding-left: 0.5em;
		padding-top: 0.5em;
	}

	#pageHeaderRight {
		padding-right: 0.5em;
		padding-top: 0.5em;
	}

	.paragraph {
		text-align: center;
		margin-top: -2px;
		margin-bottom: 5px;
	}

	.topColumn {
		padding:0.5em;
	}

	.bottomColumn {
		display:block;
		text-align: left;
		padding-left: 1em;
	}

	.contentRow {
		width: 100%;
		padding: 0;
		clear: both;
		text-align: center;
	}

	side-menu .menu-elements div div div {
		display:flex;
		flex-direction:row;
		width:max-context;
	}

	side-menu .menu-elements div div div span {
		flex: 1 1 50%;
		text-align:right;
	}

	side-menu .menu-elements div div div span + span {
		flex: 1 1 50%;
		text-align:left;
	}

	.tanContainer {
		width:100%;
		display:flex;
		justify-content:space-evenly;
	}

	#tanLabel {
		text-align:right;
		flex: 1 1 50%;
	}

	#otpForm {
		flex: 1 1 50%;
		text-align:left;
		padding-left: 5px;
	}

	#footerDiv {
		height: 40px;
		background-color: #F7F8F8;
		width:100%;
		margin-top:1em;
		padding-top:0.5em;
		padding-bottom:0.5em;
		display:block;
		text-align: center;
	}

</style>
<div id="optGblPage">
	<div id="pageHeader" ng-style="style" class="ng-scope">
		<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
			<custom-image alt-key="''network_means_pageType_1_IMAGE_ALT''" image-key="''network_means_pageType_1_IMAGE_DATA''" id="issuerLogo" straight-mode="false"></custom-image>
		</div>
		<div id="pageHeaderRight" ng-style="style" class="ng-scope" >
			<custom-image alt-key="''network_means_pageType_2_IMAGE_ALT''"  image-key="''network_means_pageType_2_IMAGE_DATA''" id="networkLogo" straight-mode="false"></custom-image>
		</div>
	</div>

	<message-banner close-button="''network_means_pageType_174''" back-button="''network_means_pageType_175''"></message-banner>

	<div id="i18n-container" class="text-center">
		<div id="i18n-inner">
			<i18n></i18n>
		</div>
	</div>
	<div class="contentRow">
		<div class="topColumn">
			<div class="paragraph">
				<custom-text custom-text-key="''network_means_pageType_1''" id="paragraph1"></custom-text>
			</div>
			<div class="paragraph">
				<custom-text custom-text-key="''network_means_pageType_2''" id="paragraph2"></custom-text>
			</div>
			<div class="paragraph">
				<custom-text custom-text-key="''network_means_pageType_3''" id="paragraph3"></custom-text>
			</div>
			<div class="paragraph">
				<custom-text custom-text-key="''network_means_pageType_4''" id="paragraph4"></custom-text>
			</div>
		</div>
		<div x-ms-format-detection="none" class="bottomColumn">
			<side-menu></side-menu>
		</div>
	</div>
	<div id="footerDiv" class="cn">	</div>
</div>' WHERE `fk_id_layout` = @id_layout;

SET @id_layout = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Failure Page (', @BankB, ')%') );

UPDATE `CustomComponent` SET `value` = '<style>
	div#optGblPage {
		font-family: Arial, bold;
		color: #333333;
		font-size: 14px;
	}

	/* Start Bootstrap reset */
	.col-sm-1, .col-sm-2, .col-sm-3, .col-sm-4, .col-sm-5, .col-sm-6, .col-sm-7, .col-xs-1, .col-xs-2, .col-xs-3, .col-xs-4, .col-xs-5, .col-xs-6, .col-xs-7 {
		margin:0;
		width:auto;
		float:none;
		position:static;
	}

	.col-sm-offset-1, .col-sm-offset-2, .col-xs-offset-1, .col-xs-offset-2  {
		margin:0;
		float:none;
		position:static;
	}

	.text-right, .text-center, .text-left {
		text-align: unset;
	}
	/* End Bootstrap reset */

	#cancelButton {
		/*flex: 1 1 50%;
		text-align:right;
		padding-right:0.5em;*/
	}
	#cancelButton button {
		display: inline-block;
		cursor: pointer;
		text-align: center;
		text-decoration: none;
		outline: none;
		color: #fff;
		background-color: #FF8C00;
		border: none;
		border-radius: 5px;
		box-shadow: 0 2px #999;
	}

	#cancelButton button:hover {
		background-color: #FFA500
	}

	#cancelButton button:active {
		background-color: #FF8C00;
		box-shadow: 0 3px #666;
		transform: translateY(2px);
	}

	/* reset for default styles */
	#valButton button.btn.disabled {
		opacity:1;
	}

	#valButton {
		/*flex: 1 1 50%;
		padding-left:0.5em;*/
	}

	#valButton button.btn[disabled] {
		opacity:1;
	}

	#valButton button div {
		display:inline;
	}

	#valButton button {
		display: inline-block;
		cursor: pointer;
		text-align: center;
		text-decoration: none;
		outline: none;
		color: #fff;
		background-color: #FF8C00;
		border: none;
		border-radius: 5px;
		box-shadow: 0 2px #999;
	}

	#valButton button:hover {
		background-color: #FFA500
	}

	#valButton button:active {
		background-color: #FF8C00;
		box-shadow: 0 3px #666;
		transform: translateY(2px);
	}

	#i18n-container {
		width: 100%;
		clear: both;
	}

	#issuerLogo {
		max-height: 64px;
		max-width: 100%;
	}

	#networkLogo {
		max-height: 64px;
		max-width: 100%;
	}

	#pageHeader {
		width: 100%;
		height: 96px;
		border-bottom: 1px solid #DCDCDC;
		display: flex;
		justify-content: space-between;
	}

	#pageHeaderLeft {
		padding-left: 0.5em;
		padding-top: 0.5em;
	}

	#pageHeaderRight {
		padding-right: 0.5em;
		padding-top: 0.5em;
	}

	.paragraph {
		text-align: center;
		margin-top: -2px;
		margin-bottom: 5px;
	}

	.topColumn {
		padding:0.5em;
	}

	.bottomColumn {
		display:block;
		text-align: left;
		padding-left: 1em;
	}

	.contentRow {
		width: 100%;
		padding: 0;
		clear: both;
		text-align: center;
	}

	side-menu .menu-elements div div div {
		display:flex;
		flex-direction:row;
		width:max-context;
	}

	side-menu .menu-elements div div div span {
		flex: 1 1 50%;
		text-align:right;
	}

	side-menu .menu-elements div div div span + span {
		flex: 1 1 50%;
		text-align:left;
	}

	.tanContainer {
		width:100%;
		display:flex;
		justify-content:space-evenly;
	}

	#tanLabel {
		text-align:right;
		flex: 1 1 50%;
	}

	#otpForm {
		flex: 1 1 50%;
		text-align:left;
		padding-left: 5px;
	}

	#footerDiv {
		height: 40px;
		background-color: #F7F8F8;
		width:100%;
		margin-top:1em;
		padding-top:0.5em;
		padding-bottom:0.5em;
		display:block;
		text-align: center;
	}

</style>
<div id="optGblPage">
	<div id="pageHeader" ng-style="style" class="ng-scope">
		<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
			<custom-image alt-key="''network_means_pageType_1_IMAGE_ALT''" image-key="''network_means_pageType_1_IMAGE_DATA''" id="issuerLogo" straight-mode="false"></custom-image>
		</div>
		<div id="pageHeaderRight" ng-style="style" class="ng-scope" >
			<custom-image alt-key="''network_means_pageType_2_IMAGE_ALT''"  image-key="''network_means_pageType_2_IMAGE_DATA''" id="networkLogo" straight-mode="false"></custom-image>
		</div>
	</div>

	<message-banner close-button="''network_means_pageType_174''" back-button="''network_means_pageType_175''"></message-banner>

	<div id="i18n-container" class="text-center">
		<div id="i18n-inner">
			<i18n></i18n>
		</div>
	</div>
	<div id="displayLayout" class="row">
		<div id="green-banner"></div>
	</div>
	<style>
		div#green-banner {
			height: 50px !important;
			background-color: #FFFFFF;
			border-bottom: 5px solid #FFFFFF;
			width: 100%;
		}
	</style>
	<div class="contentRow">
		<div class="topColumn">
			<div class="paragraph">
				<custom-text custom-text-key="''network_means_pageType_1''" id="paragraph1"></custom-text>
			</div>
			<div class="paragraph">
				<custom-text custom-text-key="''network_means_pageType_2''" id="paragraph2"></custom-text>
			</div>
			<div class="paragraph">
				<custom-text custom-text-key="''network_means_pageType_3''" id="paragraph3"></custom-text>
			</div>
		</div>
		<div x-ms-format-detection="none" class="bottomColumn">
			<side-menu></side-menu>
		</div>
	</div>
	<div id="footerDiv" class="cn">	</div>
</div>' WHERE `fk_id_layout` = @id_layout;

SET @id_layout = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Polling Page (', @BankB, ')%') );

UPDATE `CustomComponent` SET `value` = '<style>
	div#optGblPage {
		font-family: Arial, bold;
		color: #333333;
		font-size: 14px;
	}

	/* Start Bootstrap reset */
	.col-sm-1, .col-sm-2, .col-sm-3, .col-sm-4, .col-sm-5, .col-sm-6, .col-sm-7, .col-xs-1, .col-xs-2, .col-xs-3, .col-xs-4, .col-xs-5, .col-xs-6, .col-xs-7 {
		margin:0;
		width:auto;
		float:none;
		position:static;
	}

	.col-sm-offset-1, .col-sm-offset-2, .col-xs-offset-1, .col-xs-offset-2  {
		margin:0;
		float:none;
		position:static;
	}

	.text-right, .text-center, .text-left {
		text-align: unset;
	}
	/* End Bootstrap reset */

	#helpButton {
		text-align: left;
		/*padding-left: 52.5em;
		padding-right: 0.5em;*/
	}
	#helpButton button {
		display: inline-block;
		cursor: pointer;
		text-align: left;
		text-decoration: none;
		outline: none;
		color: #fff;
		background-color: #FF8C00;
		border: none;
		border-radius: 5px;
		box-shadow: 0 2px #999;
	}
	#helpButton button:hover {
		background-color: #FFA500
	}
	#helpButton button:active {
		background-color: #FF8C00;
		box-shadow: 0 3px #666;
		transform: translateY(2px);
	}
	#helpButton button span:before {
		content:'''';
	}
	#helpButton button custom-text {
	}
	#cancelButton {
		/*flex: 1 1 50%;
		text-align:right;
		padding-right:0.5em;*/
	}
	#cancelButton button {
		display: inline-block;
		cursor: pointer;
		text-align: center;
		text-decoration: none;
		outline: none;
		color: #fff;
		background-color: #FF8C00;
		border: none;
		border-radius: 5px;
		box-shadow: 0 2px #999;
	}

	#cancelButton button:hover {
		background-color: #FFA500
	}

	#cancelButton button:active {
		background-color: #FF8C00;
		box-shadow: 0 3px #666;
		transform: translateY(2px);
	}

	/* reset for default styles */
	#valButton button.btn.disabled {
		opacity:1;
	}

	#valButton {
		/*flex: 1 1 50%;
		padding-left:0.5em;*/
	}

	#valButton button.btn[disabled] {
		opacity:1;
	}

	#valButton button div {
		display:inline;
	}

	#valButton button {
		display: inline-block;
		cursor: pointer;
		text-align: center;
		text-decoration: none;
		outline: none;
		color: #fff;
		background-color: #FF8C00;
		border: none;
		border-radius: 5px;
		box-shadow: 0 2px #999;
	}

	#valButton button:hover {
		background-color: #FFA500
	}

	#valButton button:active {
		background-color: #FF8C00;
		box-shadow: 0 3px #666;
		transform: translateY(2px);
	}

	#i18n-container {
		width: 100%;
		clear: both;
	}

	#issuerLogo {
		max-height: 64px;
		max-width: 100%;
	}

	#networkLogo {
		max-height: 64px;
		max-width: 100%;
	}

	#pageHeader {
		width: 100%;
		height: 96px;
		border-bottom: 1px solid #DCDCDC;
		display: flex;
		justify-content: space-between;
	}

	#pageHeaderLeft {
		padding-left: 0.5em;
		padding-top: 0.5em;
	}

	#pageHeaderRight {
		padding-right: 0.5em;
		padding-top: 0.5em;
	}

	.paragraph {
		text-align: center;
		margin-top: -2px;
		margin-bottom: 5px;
	}

	.topColumn {
		padding:0.5em;
	}

	.bottomColumn {
		display:block;
		text-align: left;
		padding-left: 1em;
	}

	.contentRow {
		width: 100%;
		padding: 0;
		clear: both;
		text-align: center;
	}

	side-menu .menu-elements div div div {
		display:flex;
		flex-direction:row;
		width:max-context;
	}

	side-menu .menu-elements div div div span {
		flex: 1 1 50%;
		text-align:right;
	}

	side-menu .menu-elements div div div span + span {
		flex: 1 1 50%;
		text-align:left;
	}

	.tanContainer {
		width:100%;
		display:flex;
		justify-content:space-evenly;
	}

	#tanLabel {
		text-align:right;
		flex: 1 1 50%;
	}

	#otpForm {
		flex: 1 1 50%;
		text-align:left;
		padding-left: 5px;
	}

	#footerDiv {
		height: 40px;
		background-color: #F7F8F8;
		width:100%;
		margin-top:1em;
		padding-top:0.5em;
		padding-bottom:0.5em;
		display:block;
		text-align:center;
	}

</style>
<div id="optGblPage">
	<div id="pageHeader" ng-style="style" class="ng-scope">
		<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
			<custom-image alt-key="''network_means_pageType_1_IMAGE_ALT''" image-key="''network_means_pageType_1_IMAGE_DATA''" id="issuerLogo" straight-mode="false"></custom-image>
		</div>
		<div id="pageHeaderRight" ng-style="style" class="ng-scope" >
			<custom-image alt-key="''network_means_pageType_2_IMAGE_ALT''"  image-key="''network_means_pageType_2_IMAGE_DATA''" id="networkLogo" straight-mode="false"></custom-image>
		</div>
	</div>
	<message-banner  close-button="''network_means_pageType_174''" back-button="''network_means_pageType_175''"></message-banner>
	<div id="i18n-container" class="text-center">
		<div id="i18n-inner">
			<i18n></i18n>
		</div>
	</div>
	<div class="contentRow">
		<div class="topColumn">
			<div class="paragraph">
				<custom-text custom-text-key="''network_means_pageType_1''" id="paragraph1"></custom-text>
			</div>
			<div class="paragraph">
				<custom-text custom-text-key="''network_means_pageType_2''" id="paragraph2"></custom-text>
			</div>
			<means-choice-menu></means-choice-menu>
		</div>
		<div x-ms-format-detection="none" class="bottomColumn">
			<side-menu></side-menu>
		</div>
		<div class="additionalMenuContainer">
			<div id = "additionalMenuLabel">
				<custom-text custom-text-key="''network_means_pageType_3''"></custom-text>
			</div>
			<div id = "additionalMenuValue" >
				<custom-text custom-text-key="''network_means_pageType_4''"></custom-text>
			</div>
		</div>
	</div>
	<div id="footerDiv">
		<help help-label="''network_means_pageType_41''" id="helpButton"></help>
		<cancel-button cn-label="''network_means_pageType_40''" id="cancelButton" ></cancel-button>
	</div>
</div>
' WHERE `fk_id_layout` = @id_layout;

SET @id_layout = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Polling Choice Page (', @BankB, ')%') );

UPDATE `CustomComponent` SET `value` = '<style>
	div#optGblPage {
		font-family: Arial, bold;
		color: #333333;
		font-size: 14px;
	}

	/* Start Bootstrap reset */
	.col-sm-1, .col-sm-2, .col-sm-3, .col-sm-4, .col-sm-5, .col-sm-6, .col-sm-7, .col-xs-1, .col-xs-2, .col-xs-3, .col-xs-4, .col-xs-5, .col-xs-6, .col-xs-7 {
		margin:0;
		width:auto;
		float:none;
		position:static;
	}

	.col-sm-offset-1, .col-sm-offset-2, .col-xs-offset-1, .col-xs-offset-2  {
		margin:0;
		float:none;
		position:static;
	}

	.text-right, .text-center, .text-left {
		text-align: unset;
	}
	/* End Bootstrap reset */

	#helpButton {
		text-align: left;
		/*padding-left: 52.5em;
		padding-right: 0.5em;*/
	}
	#helpButton button {
		display: inline-block;
		cursor: pointer;
		text-align: left;
		text-decoration: none;
		outline: none;
		color: #fff;
		background-color: #FF8C00;
		border: none;
		border-radius: 5px;
		box-shadow: 0 2px #999;
	}
	#helpButton button:hover {
		background-color: #FFA500
	}
	#helpButton button:active {
		background-color: #FF8C00;
		box-shadow: 0 3px #666;
		transform: translateY(2px);
	}
	#helpButton button span:before {
		content:'''';
	}
	#helpButton button custom-text {
	}
	#cancelButton {
		/*flex: 1 1 50%;
		text-align:right;
		padding-right:0.5em;*/
	}
	#cancelButton button {
		display: inline-block;
		cursor: pointer;
		text-align: center;
		text-decoration: none;
		outline: none;
		color: #fff;
		background-color: #FF8C00;
		border: none;
		border-radius: 5px;
		box-shadow: 0 2px #999;
	}

	#cancelButton button:hover {
		background-color: #FFA500
	}

	#cancelButton button:active {
		background-color: #FF8C00;
		box-shadow: 0 3px #666;
		transform: translateY(2px);
	}

	/* reset for default styles */
	#valButton button.btn.disabled {
		opacity:1;
	}

	#valButton {
		/*flex: 1 1 50%;
		padding-left:0.5em;*/
	}

	#valButton button.btn[disabled] {
		opacity:1;
	}

	#valButton button div {
		display:inline;
	}

	#valButton button {
		display: inline-block;
		cursor: pointer;
		text-align: center;
		text-decoration: none;
		outline: none;
		color: #fff;
		background-color: #FF8C00;
		border: none;
		border-radius: 5px;
		box-shadow: 0 2px #999;
	}

	#valButton button:hover {
		background-color: #FFA500
	}

	#valButton button:active {
		background-color: #FF8C00;
		box-shadow: 0 3px #666;
		transform: translateY(2px);
	}

	#i18n-container {
		width: 100%;
		clear: both;
	}

	#issuerLogo {
		max-height: 64px;
		max-width: 100%;
	}

	#networkLogo {
		max-height: 64px;
		max-width: 100%;
	}

	#pageHeader {
		width: 100%;
		height: 96px;
		border-bottom: 1px solid #DCDCDC;
		display: flex;
		justify-content: space-between;
	}

	#pageHeaderLeft {
		padding-left: 0.5em;
		padding-top: 0.5em;
	}

	#pageHeaderRight {
		padding-right: 0.5em;
		padding-top: 0.5em;
	}

	.paragraph {
		text-align: center;
		margin-top: -2px;
		margin-bottom: 5px;
	}

	.topColumn {
		padding:0.5em;
	}

	.bottomColumn {
		display:block;
		text-align: left;
		padding-left: 1em;
	}

	.contentRow {
		width: 100%;
		padding: 0;
		clear: both;
		text-align: center;
	}

	side-menu .menu-elements div div div {
		display:flex;
		flex-direction:row;
		width:max-context;
	}

	side-menu .menu-elements div div div span {
		flex: 1 1 50%;
		text-align:right;
	}

	side-menu .menu-elements div div div span + span {
		flex: 1 1 50%;
		text-align:left;
	}

	.tanContainer {
		width:100%;
		display:flex;
		justify-content:space-evenly;
	}

	#tanLabel {
		text-align:right;
		flex: 1 1 50%;
	}

	#otpForm {
		flex: 1 1 50%;
		text-align:left;
		padding-left: 5px;
	}

	#footerDiv {
		height: 40px;
		background-color: #F7F8F8;
		width:100%;
		margin-top:1em;
		padding-top:0.5em;
		padding-bottom:0.5em;
		display:block;
		text-align:center;
	}

</style>
<div id="optGblPage">
	<div id="pageHeader" ng-style="style" class="ng-scope">
		<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
			<custom-image alt-key="''network_means_pageType_1_IMAGE_ALT''" image-key="''network_means_pageType_1_IMAGE_DATA''" id="issuerLogo" straight-mode="false"></custom-image>
		</div>
		<div id="pageHeaderRight" ng-style="style" class="ng-scope" >
			<custom-image alt-key="''network_means_pageType_2_IMAGE_ALT''"  image-key="''network_means_pageType_2_IMAGE_DATA''" id="networkLogo" straight-mode="false"></custom-image>
		</div>
	</div>

	<message-banner close-button="''network_means_pageType_174''" back-button="''network_means_pageType_175''"></message-banner>

	<div id="i18n-container" class="text-center">
		<div id="i18n-inner">
			<i18n></i18n>
		</div>
	</div>
	<div class="contentRow">
		<div class="topColumn">
			<div class="paragraph">
				<custom-text custom-text-key="''network_means_pageType_1''" id="paragraph1"></custom-text>
			</div>
			<div class="paragraph">
				<custom-text custom-text-key="''network_means_pageType_2''" id="paragraph2"></custom-text>
			</div>
		</div>
		<div x-ms-format-detection="none" class="bottomColumn">
			<side-menu></side-menu>
		</div>
		<div class="deviceSelect">
			<device-select devices="deviceSelectValues" select-box-style-enabled="true"></device-select>
		</div>
	</div>
	<div id="footerDiv">
		<help help-label="''network_means_pageType_41''" id="helpButton"></help>
		<cancel-button cn-label="''network_means_pageType_40''" id="cancelButton" ></cancel-button>
		<val-button val-label="''network_means_pageType_42''" id="valButton" ></val-button>
	</div>
</div>' WHERE `fk_id_layout` = @id_layout;

SET @id_layout = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Password OTP Form Page (', @BankB, ')%') );

UPDATE `CustomComponent` SET `value` = '<style>
	div#optGblPage {
		font-family: Arial, bold;
		color: #333333;
		font-size: 14px;
	}

	/* Start Bootstrap reset */
	.col-sm-1, .col-sm-2, .col-sm-3, .col-sm-4, .col-sm-5, .col-sm-6, .col-sm-7, .col-xs-1, .col-xs-2, .col-xs-3, .col-xs-4, .col-xs-5, .col-xs-6, .col-xs-7 {
		margin:0;
		width:auto;
		float:none;
		position:static;
	}

	.col-sm-offset-1, .col-sm-offset-2, .col-xs-offset-1, .col-xs-offset-2  {
		margin:0;
		float:none;
		position:static;
	}

	.text-right, .text-center, .text-left {
		text-align: unset;
	}
	/* End Bootstrap reset */

	#helpButton {
		text-align: left;
		/*padding-left: 52.5em;
		padding-right: 0.5em;*/
	}
	#helpButton button {
		display: inline-block;
		cursor: pointer;
		text-align: left;
		text-decoration: none;
		outline: none;
		color: #fff;
		background-color: #FF8C00;
		border: none;
		border-radius: 5px;
		box-shadow: 0 2px #999;
	}
	#helpButton button:hover {
		background-color: #FFA500
	}
	#helpButton button:active {
		background-color: #FF8C00;
		box-shadow: 0 3px #666;
		transform: translateY(2px);
	}
	#helpButton button span:before {
		content:'''';
	}
	#helpButton button custom-text {
	}
	#cancelButton {
		/*flex: 1 1 50%;
		text-align:right;
		padding-right:0.5em;*/
	}
	#cancelButton button {
		display: inline-block;
		cursor: pointer;
		text-align: center;
		text-decoration: none;
		outline: none;
		color: #fff;
		background-color: #FF8C00;
		border: none;
		border-radius: 5px;
		box-shadow: 0 2px #999;
	}

	#cancelButton button:hover {
		background-color: #FFA500
	}

	#cancelButton button:active {
		background-color: #FF8C00;
		box-shadow: 0 3px #666;
		transform: translateY(2px);
	}

	/* reset for default styles */
	#valButton button.btn.disabled {
		opacity:0.65;
	}

	#valButton {
		/*flex: 1 1 50%;
		padding-left:0.5em;*/
	}

	#valButton button.btn[disabled] {
		opacity:1;
	}

	#valButton button div {
		display:inline;
	}

	#valButton button {
		display: inline-block;
		text-align: center;
		text-decoration: none;
		outline: none;
		color: #fff;
		background-color: #FF8C00;
		border: none;
		border-radius: 5px;
		box-shadow: 0 2px #999;
	}

	#valButton button:hover {
		background-color: #FFA500
	}

	#valButton button:active {
		background-color: #FF8C00;
		box-shadow: 0 3px #666;
		transform: translateY(2px);
	}

	#i18n-container {
		width: 100%;
		clear: both;
	}

	#issuerLogo {
		max-height: 64px;
		max-width: 100%;
	}

	#networkLogo {
		max-height: 64px;
		max-width: 100%;
	}

	#pageHeader {
		width: 100%;
		height: 96px;
		border-bottom: 1px solid #DCDCDC;
		display: flex;
		justify-content: space-between;
	}

	#pageHeaderLeft {
		padding-left: 0.5em;
		padding-top: 0.5em;
	}

	#pageHeaderRight {
		padding-right: 0.5em;
		padding-top: 0.5em;
	}

	.paragraph {
		text-align: center;
		margin-top: -2px;
		margin-bottom: 5px;
	}

	.topColumn {
		padding:0.5em;
	}

	.bottomColumn {
		display:block;
		text-align: left;
		padding-left: 1em;
	}

	.contentRow {
		width: 100%;
		padding: 0;
		clear: both;
		text-align: center;
	}

	side-menu .menu-elements div div div {
		display:flex;
		flex-direction:row;
		width:max-context;
	}

	side-menu .menu-elements div div div span {
		flex: 1 1 50%;
		text-align:right;
	}

	side-menu .menu-elements div div div span + span {
		flex: 1 1 50%;
		text-align:left;
	}

	.tanContainer {
		width:100%;
		display:flex;
		justify-content:space-evenly;
		margin-top: 0px;
		padding-left: 3px;
	}

	#tanLabel {
		text-align:right;
		flex: 1 1 50%;
	}

	#otpForm {
		flex: 1 1 50%;
		text-align:left;
		padding-left: 5px;
	}

	#phNumber {
		margin-left: 7px;
	}

	#footerDiv {
		height: 40px;
		background-color: #F7F8F8;
		width:100%;
		margin-top:1em;
		padding-top:0.5em;
		padding-bottom:0.5em;
		display:block;
		text-align:center;
	}
	div.ng-scope:nth-child(5) > div:nth-child(1) > div:nth-child(1) > span:nth-child(1) > label:nth-child(1) > custom-text:nth-child(1) > span:nth-child(1) {
		display:none;
	}
	div.ng-scope:nth-child(5) > div:nth-child(1) > div:nth-child(1) > span:nth-child(2) {
		display:none;
	}
	#sideLayout {
		margin-left: 677px;
		margin-top: -30px;
	}
</style>
<div id="optGblPage">
	<div id="pageHeader" ng-style="style" class="ng-scope">
		<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
			<custom-image alt-key="''network_means_pageType_1_IMAGE_ALT''" image-key="''network_means_pageType_1_IMAGE_DATA''" id="issuerLogo" straight-mode="false"></custom-image>
		</div>
		<div id="pageHeaderRight" ng-style="style" class="ng-scope" >
			<custom-image alt-key="''network_means_pageType_2_IMAGE_ALT''"  image-key="''network_means_pageType_2_IMAGE_DATA''" id="networkLogo" straight-mode="false"></custom-image>
		</div>
	</div>
	<div id="displayLayout" class="row">
		<div id="grey-banner"></div>
	</div>
	<message-banner  close-button="''network_means_pageType_174''" back-button="''network_means_pageType_175''"></message-banner>

	<div class="contentRow">
		<div class="topColumn">
			<div class="paragraph">
				<custom-text custom-text-key="''network_means_pageType_1''" id="paragraph1"></custom-text>
			</div>
			<div class="paragraph">
				<custom-text custom-text-key="''network_means_pageType_2''" id="paragraph2"></custom-text>
			</div>
		</div>
		<div x-ms-format-detection="none" class="bottomColumn">
			<side-menu></side-menu>
		</div>
		<div class="tanContainer">
			<div id = "tanLabel">
				<div>
					<custom-text custom-text-key="''network_means_pageType_3''"></custom-text>
				</div>
				<custom-text custom-text-key="''network_means_pageType_4''"></custom-text>
			</div>
			<div id = "otpForm" >
				<div id = "phNumber">
					<custom-text custom-text-key="''network_means_pageType_5''"></custom-text>
				</div>
				<pwd-form></pwd-form>
			</div>
		</div>
	</div>
	<div id="footerDiv">
		<help help-label="''network_means_pageType_41''" id="helpButton"></help>
		<cancel-button cn-label="''network_means_pageType_40''" id="cancelButton" ></cancel-button>
		<val-button val-label="''network_means_pageType_42''" id="valButton" ></val-button>
	</div>
</div>' WHERE `fk_id_layout` = @id_layout;

SET @id_layout = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Means Page (', @BankB, ')%') );

UPDATE `CustomComponent` SET `value` = '<style>
	div#optGblPage {
		font-family: Arial, bold;
		color: #333333;
		font-size: 14px;
	}
	#optGblPage #selection-group switch-means-button:nth-child(1) button {
		margin-right: 16px;
	}
	#optGblPage #selection-group switch-means-button:nth-child(2) button {
		margin-right: 16px;
	}
	#optGblPage #selection-group switch-means-button:nth-child(2) button span:before {
		content:'''';
	}
	#optGblPage #selection-group switch-means-button:nth-child(1) button span:before {
		content:'''';
	}
	#optGblPage #selection-group switch-means-button:nth-child(1) button:hover:enabled {
		background-color: #fafafa;
		border-color: #ff6a10;
	}
	#optGblPage #selection-group switch-means-button:nth-child(1) button:active {
		background-image: linear-gradient(rgba(0,0,0,.05),rgba(0,0,0,.05));
		box-shadow: none;
		background-color: #f0f0f0;
		outline: #6e6e6e 1px dotted;
		border-color: #ff6a10;
	}
	#optGblPage #selection-group switch-means-button:nth-child(2) button:hover:enabled {
		background-color: #fafafa;
		border-color: #ff6a10;
	}
	#optGblPage #selection-group switch-means-button:nth-child(2) button:active {
		background-image: linear-gradient(rgba(0,0,0,.05),rgba(0,0,0,.05));
		box-shadow: none;
		background-color: #f0f0f0;
		outline: #6e6e6e 1px dotted;
		border-color: #ff6a10;
	}
	#optGblPage #selection-group switch-means-button:nth-child(3) button:hover:enabled {
		background-color: #fafafa;
		border-color: #ff6a10;
	}
	#optGblPage #selection-group switch-means-button:nth-child(3) button:active {
		background-image: linear-gradient(rgba(0,0,0,.05),rgba(0,0,0,.05));
		box-shadow: none;
		background-color: #f0f0f0;
		outline: #6e6e6e 1px dotted;
		border-color: #ff6a10;
	}
	#switch-means-mobile_app_ext-img {
		width:60px;
		height:60px;
		background-size:contain;
		display: block;
		margin-left: 10px;
		margin-right: 25px;
		margin-bottom : 8px;
		margin-top : 8px;
	}
	#switch-means-otp_sms_ext_message-img {
		width:60px;
		height:60px;
		background-size:contain;
		display: block;
		margin-left: 10px;
		margin-right: 25px;
		margin-bottom : 8px;
		margin-top : 8px;
	}
	#switch-means-chip_tan-img {
		width:60px;
		height:60px;
		background-size:contain;
		display: block;
		margin-left: 10px;
		margin-right: 25px;
		margin-bottom : 8px;
		margin-top : 8px;
	}
	#optGblPage #selection-group switch-means-button:nth-child(1) button:focus {outline:0;border-color: #ff6a10;outline: #6e6e6e 1px dotted;}
	#optGblPage #selection-group switch-means-button:nth-child(2) button:focus {outline:0;border-color: #ff6a10;outline: #6e6e6e 1px dotted;}
	#optGblPage #selection-group switch-means-button:nth-child(3) button:focus {outline:0;border-color: #ff6a10;outline: #6e6e6e 1px dotted;}

	/* Start Bootstrap reset */
	.col-sm-1, .col-sm-2, .col-sm-3, .col-sm-4, .col-sm-5, .col-sm-6, .col-sm-7, .col-xs-1, .col-xs-2, .col-xs-3, .col-xs-4, .col-xs-5, .col-xs-6, .col-xs-7 {
		margin:0;
		width:auto;
		float:none;
		position:static;
	}

	.col-sm-offset-1, .col-sm-offset-2, .col-xs-offset-1, .col-xs-offset-2  {
		margin:0;
		float:none;
		position:static;
	}

	.text-center {
		text-align: center;
	}

	.text-right,.text-left {
		text-align: unset;
	}
	/* End Bootstrap reset */

	#helpButton {
		text-align: left;
		/*padding-left: 52.5em;
		padding-right: 0.5em;*/
	}
	#helpButton button {
		display: inline-block;
		cursor: pointer;
		text-align: left;
		text-decoration: none;
		outline: none;
		color: #fff;
		background-color: #FF8C00;
		border: none;
		border-radius: 5px;
		box-shadow: 0 2px #999;
	}
	#helpButton button:hover {
		background-color: #FFA500
	}
	#helpButton button:active {
		background-color: #FF8C00;
		box-shadow: 0 3px #666;
		transform: translateY(2px);
	}
	#helpButton button span:before {
		content:'''';
	}
	#helpButton button custom-text {
	}
	#cancelButton {
		/*flex: 1 1 50%;
		text-align:right;
		padding-right:0.5em;*/
	}
	#cancelButton button {
		display: inline-block;
		cursor: pointer;
		text-align: center;
		text-decoration: none;
		outline: none;
		color: #fff;
		background-color: #FF8C00;
		border: none;
		border-radius: 5px;
		box-shadow: 0 2px #999;
	}

	#cancelButton button:hover {
		background-color: #FFA500
	}

	#cancelButton button:active {
		background-color: #FF8C00;
		box-shadow: 0 3px #666;
		transform: translateY(2px);
	}

	/* reset for default styles */
	#valButton button.btn.disabled {
		opacity:1;
	}

	#valButton {
		/*flex: 1 1 50%;
		padding-left:0.5em;*/
	}

	#valButton button.btn[disabled] {
		opacity:1;
	}

	#valButton button div {
		display:inline;
	}

	#valButton button {
		display: inline-block;
		cursor: pointer;
		text-align: center;
		text-decoration: none;
		outline: none;
		color: #fff;
		background-color: #FF8C00;
		border: none;
		border-radius: 5px;
		box-shadow: 0 2px #999;
	}

	#valButton button:hover {
		background-color: #FFA500
	}

	#valButton button:active {
		background-color: #FF8C00;
		box-shadow: 0 3px #666;
		transform: translateY(2px);
	}

	#i18n-container {
		width: 100%;
		clear: both;
	}

	#issuerLogo {
		max-height: 64px;
		max-width: 100%;
	}

	#networkLogo {
		max-height: 64px;
		max-width: 100%;
	}

	#pageHeader {
		width: 100%;
		height: 96px;
		border-bottom: 1px solid #DCDCDC;
		display: flex;
		justify-content: space-between;
	}

	#pageHeaderLeft {
		padding-left: 0.5em;
		padding-top: 0.5em;
	}

	#pageHeaderRight {
		padding-right: 0.5em;
		padding-top: 0.5em;
	}

	.paragraph {
		text-align: center;
		margin-top: -2px;
		margin-bottom: 5px;
	}

	.topColumn {
		padding:0.5em;
	}

	.bottomColumn {
		display:block;
		text-align: left;
		padding-left: 1em;
	}

	.contentRow {
		width: 100%;
		padding: 0;
		clear: both;
		text-align: center;
	}

	side-menu .menu-elements div div div {
		display:flex;
		flex-direction:row;
		width:max-context;
	}

	side-menu .menu-elements div div div span {
		flex: 1 1 50%;
		text-align:right;
	}

	side-menu .menu-elements div div div span + span {
		flex: 1 1 50%;
		text-align:left;
	}

	.tanContainer {
		width:100%;
		display:flex;
		justify-content:space-evenly;
	}

	#tanLabel {
		text-align:right;
		flex: 1 1 50%;
	}

	#otpForm {
		flex: 1 1 50%;
		text-align:left;
		padding-left: 5px;
	}

	.meansSelect {
		display:flex;
		flex-direction:row;
	}

	.meansSelectLabel {
		flex:1 1 50%;
		text-align:right;
		padding-right:5px;
	}

	.meansSelectValue {
		flex:1 1 50%;
		text-align:left;
		padding-left:5px;
		display:flex;
	}

	#footerDiv {
		height: 40px;
		background-color: #F7F8F8;
		width:100%;
		margin-top:1em;
		padding-top:0.5em;
		padding-bottom:0.5em;
		display:block;
		text-align:center;
		justify-content:center;
	}

</style>
<div id="optGblPage">
	<div id="pageHeader" ng-style="style" class="ng-scope">
		<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
			<custom-image alt-key="''network_means_pageType_1_IMAGE_ALT''" image-key="''network_means_pageType_1_IMAGE_DATA''" id="issuerLogo" straight-mode="false"></custom-image>
		</div>
		<div id="pageHeaderRight" ng-style="style" class="ng-scope" >
			<custom-image alt-key="''network_means_pageType_2_IMAGE_ALT''"  image-key="''network_means_pageType_2_IMAGE_DATA''" id="networkLogo" straight-mode="false"></custom-image>
		</div>
	</div>

	<message-banner close-button="''network_means_pageType_174''" back-button="''network_means_pageType_175''"></message-banner>

	<div class="contentRow">
		<div class="topColumn">
			<div class="paragraph">
				<custom-text custom-text-key="''network_means_pageType_1''" id="paragraph1"></custom-text>
			</div>
			<div class="paragraph">
				<custom-text custom-text-key="''network_means_pageType_2''" id="paragraph2"></custom-text>
			</div>
		</div>
		<div x-ms-format-detection="none" class="bottomColumn">
			<side-menu></side-menu>
		</div>
		<div class="meansSelect">
			<div class = "meansSelectLabel">
				<custom-text custom-text-key="''network_means_pageType_3''"></custom-text>
			</div>
			<div class = "meansSelectValue">
				<div id="meanchoice">
					<means-select means-choices="meansChoices"></means-select>
				</div>
			</div>
		</div>
	</div>
	<div  id="footerDiv">
		<help help-label="''network_means_pageType_41''" id="helpButton"></help>
		<cancel-button cn-label="''network_means_pageType_40''" id="cancelButton" ></cancel-button>
	</div>
</div>' WHERE `fk_id_layout` = @id_layout;

SET @id_layout = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Message Banner (', @BankB, ')%') );

UPDATE `CustomComponent` SET `value` = '<div id="messageBanner">
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
			font-family: Arial,bold;
			color: #FFFFFF; font-size:14px;
			text-align:center;
		}
		span#message {
			font-size:14px;
		}
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
	</style>' WHERE `fk_id_layout` = @id_layout;

SET @id_layout = (SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like CONCAT('Help Page (', @BankB, ')%') );

UPDATE `CustomComponent` SET `value` = '<style>
div#optGblPage {
	font-family: Arial, bold;
	color: #333333;
	font-size: 14px;
}

/* Start Bootstrap reset */
.col-sm-1, .col-sm-2, .col-sm-3, .col-sm-4, .col-sm-5, .col-sm-6, .col-sm-7, .col-xs-1, .col-xs-2, .col-xs-3, .col-xs-4, .col-xs-5, .col-xs-6, .col-xs-7 {
	margin:0;
	width:auto;
	float:none;
	position:static;
}

.col-sm-offset-1, .col-sm-offset-2, .col-xs-offset-1, .col-xs-offset-2  {
	margin:0;
	float:none;
	position:static;
}

.text-right, .text-center, .text-left {
	text-align: unset;
}
/* End Bootstrap reset */

#helpCloseButton {
	flex: 1 1 50%;
	text-align:right;
	padding-right:0.5em;
}
#helpCloseButton button {
	display: inline-block;
	cursor: pointer;
	text-align: center;
	text-decoration: none;
	outline: none;
	color: #fff;
	background-color: #FF8C00;
	border: none;
	border-radius: 5px;
	box-shadow: 0 2px #999;
}

#helpCloseButton button:hover {
	background-color: #FFA500
}

#helpCloseButton button:active {
	background-color: #FF8C00;
	box-shadow: 0 3px #666;
	transform: translateY(2px);
}
/* reset for default styles */
#valButton button.btn.disabled {
	opacity:1;
}

#valButton {
	flex: 1 1 50%;
	padding-left:0.5em;
}

#valButton button.btn[disabled] {
	opacity:1;
}

#valButton button div {
	display:inline;
}

#valButton button {
	display: inline-block;
	cursor: pointer;
	text-align: center;
	text-decoration: none;
	outline: none;
	color: #fff;
	background-color: #FF8C00;
	border: none;
	border-radius: 5px;
	box-shadow: 0 2px #999;
}

#valButton button:hover {
	background-color: #FFA500
}

#valButton button:active {
	background-color: #FF8C00;
	box-shadow: 0 3px #666;
	transform: translateY(2px);
}

#i18n-container {
	width: 100%;
	clear: both;
}

#issuerLogo {
	max-height: 64px;
	max-width: 100%;}

#networkLogo {
	max-height: 64px;
	max-width: 100%;
}

#pageHeader {
	width: 100%;
	height: 96px;
	border-bottom: 1px solid #DCDCDC;
	display: flex;
	justify-content: space-between;
}

#pageHeaderLeft {

	padding-left: 0.5em;
	padding-top: 0.5em;
}

#pageHeaderRight {
	padding-right: 0.5em;
	padding-top: 0.5em;
}

.paragraph {
	text-align: left;
	margin-top: -2px;
	margin-bottom: 5px;
}

.topColumn {
	padding:0.5em;
}

.bottomColumn {
	display:block;
	text-align: left;
	padding-left: 1em;
}

.contentRow {
	width: 100%;
	padding: 0;
	clear: both;
	text-align: center;
}

side-menu .menu-elements div div div {
	display:flex;
	flex-direction:row;
	width:max-context;
}

side-menu .menu-elements div div div span {
	flex: 1 1 50%;
	text-align:right;
}

side-menu .menu-elements div div div span + span {
	flex: 1 1 50%;
	text-align:left;
}

.tanContainer {
	width:100%;
	display:flex;
	justify-content:space-evenly;
}

#tanLabel {
	text-align:right;
	flex: 1 1 50%;
}

#otpForm {
	flex: 1 1 50%;
	text-align:left;
	padding-left: 5px;
}

#footerDiv {
	height: 40px;
	background-color: #F7F8F8;
	width:100%;
	margin-top:1em;
	padding-top:0.5em;
	padding-bottom:0.5em;
	display:flex;
}

</style>
<div id="optGblPage">
	<div id="pageHeader" ng-style="style" class="ng-scope">
		<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
			<custom-image alt-key="''network_means_pageType_1_IMAGE_ALT''" image-key="''network_means_pageType_1_IMAGE_DATA''" id="issuerLogo" straight-mode="false"></custom-image>
		</div>
		<div id="pageHeaderRight" ng-style="style" class="ng-scope" >
			<custom-image alt-key="''network_means_pageType_2_IMAGE_ALT''"  image-key="''network_means_pageType_2_IMAGE_DATA''" id="networkLogo" straight-mode="false"></custom-image>
		</div>
	</div>

	<div class="contentRow">
		 <div class="topColumn">
			<div class="paragraph">
				<custom-text custom-text-key="''network_means_HELP_PAGE_1''" id="paragraph1"></custom-text>
			</div>
			<div class="paragraph">
				<custom-text custom-text-key="''network_means_HELP_PAGE_2''" id="paragraph2"></custom-text>
			</div>
		   <div class="paragraph">
				<custom-text custom-text-key="''network_means_HELP_PAGE_3''" id="paragraph3"></custom-text>
			</div>
		</div>
	</div>
	<div  id="footerDiv" class="cn">
			<help-close-button id="helpCloseButton" help-close-label="''network_means_HELP_PAGE_174''" ></help-close-button>
	</div>
</div>' WHERE `fk_id_layout` = @id_layout;





