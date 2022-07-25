USE `U5G_ACS_BO`;

SET @BankUB = '16500';

SET @customItemSetMobileApp = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_MOBILE_APP'));
SET @customItemSetPhotoTan = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_PHOTO_TAN'));
SET @customItemSetIngSms = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_ING_SMS'));
SET @customItemSetITan = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_ITAN'));

SET @otpFormPagePageType = 'OTP_FORM_PAGE';
SET @pollingPagePageType = 'POLLING_PAGE';

SET @textValue	= 'Bitte warten Sie!';

UPDATE CustomItem SET value = @textValue WHERE pageTypes = @pollingPagePageType AND	 ordinal = 26 AND fk_id_customItemSet = @customItemSetMobileApp;
UPDATE CustomItem SET value = @textValue WHERE pageTypes = @otpFormPagePageType AND	 ordinal = 26 AND fk_id_customItemSet = @customItemSetPhotoTan;
UPDATE CustomItem SET value = @textValue WHERE pageTypes = @otpFormPagePageType AND	 ordinal = 26 AND fk_id_customItemSet = @customItemSetIngSms;
UPDATE CustomItem SET value = @textValue WHERE pageTypes = @otpFormPagePageType AND	 ordinal = 26 AND fk_id_customItemSet = @customItemSetITan;


set @customPageLayoutDescIngBanner = 'for ING 16500';
set @pageType = 'MESSAGE_BANNER';

set @idAppViewPage = (select id
					  from `CustomPageLayout`
					  where `pageType` = @pageType
						and DESCRIPTION = @customPageLayoutDescIngBanner);

UPDATE `CustomComponent`
SET `value` ='
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
	#messageBanner #message {
		width : 90%;
		margin : auto;
		display : block;
	}
	#messageBanner	#spinner-row {
		padding-top: 20px;
	}
	#messageBanner	.spinner {
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

	div#message-container.success {
		background-color:#ec971f;
		font-family: "INGme-Regular", Arial, Helvetica;
		color: #ffffff;
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
</style>'
WHERE `fk_id_layout` = @idAppViewPage;

