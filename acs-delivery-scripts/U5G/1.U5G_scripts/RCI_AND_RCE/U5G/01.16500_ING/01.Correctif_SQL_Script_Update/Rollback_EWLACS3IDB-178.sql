USE `U5G_ACS_BO`;
-- OTP_FORM_PAGE
set @id_layout = (SELECT id from `CustomPageLayout` where `description` IN ('for ING 16500') and `pageType` = 'MESSAGE_BANNER');

UPDATE `CustomComponent` SET `value` = '
<div id="messageBanner">
  <span id="info-icon" class="fa fa-info-circle"></span>
  <custom-text id="headingTxt" custom-text-key="$parent.heading"></custom-text>
  <custom-text id="message" custom-text-key="$parent.message"></custom-text>
</div>
<style>
	#optGblPage{
		font-family: "INGme-Regular", Arial, Helvetica;
	}
	#messageBanner #headingTxt {
		font-size : large;
		font-weight : bold;
		width : 80%;
		margin : auto;
		display : block;
	}
	#messageBanner  #spinner-row {
		padding-top: 20px;
	}
	#messageBanner  .spinner {
		display:block;
		padding-top:15px;
		padding-bottom:15px;
	}
	#messageBanner {
		position: relative;
	}
	#message{
		display:block;
	}
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
		#messageBanner #headingTxt {
			font-size: 15px;
		}
	}
	@media all and (max-width: 347px) {
		#messageBanner #headingTxt {
			font-size: 15px;
		}
		span#info-icon {
			font-size: 2em;
			display: inline-block;
		}
	}
	@media all and (max-width: 309px) {
		#messageBanner #headingTxt {
			font-size: 12px;
		}
		span#info-icon {
			font-size: 1em;
			display: inline-block;
		}
	}
	@media all and (max-width: 250px) {
		#messageBanner #headingTxt {
			width: 100%;
			font-size: 8px;
		}
	}
</style>' WHERE `fk_id_layout` = @id_layout;