USE `U5G_ACS_BO`;

SET @layoutId =(SELECT id FROM `CustomPageLayout` WHERE `DESCRIPTION` like '%for ING 16500' AND pageType ='MOBILE_APP_EXT_CHOICE_PAGE');


UPDATE CustomComponent
SET value ='<custom-font straight-mode="false" mime-type-key="''network_means_pageType_301_FONT_MIME_TYPE''" title-key="''network_means_pageType_301_FONT_TITLE''" font-key="''network_means_pageType_301_FONT_DATA''"></custom-font>

<div id="optGblPage">
<style>
	/* global styles */
	#optGblPage {
		background-color:#f7f7f7;
		margin:0px;
		padding:0px;
		padding-bottom:1.5em;
	}

	.background-default { background-color:#f7f7f7;}
	.primary-color { color:#ff6200; }
        @font-face {
    font-family: "INGme-Regular", Arial, Helvetica;
    src: url(data:font/truetype;charset=utf-8;base64,<<copied base64 string>>) format(''truetype'');
    font-weight: normal;
    font-style: normal;
}
    #optGblPage{
         font-family: "INGme-Regular", Arial, Helvetica;
    }
</style>

		<div id="header">

			<div>
				<custom-image id="issuerLogo"
					alt-key="''network_means_pageType_1_IMAGE_ALT''"
					image-key="''network_means_pageType_1_IMAGE_DATA''"
					straight-mode="false"> </custom-image>
			</div>
			<div>
				<custom-image id="networkLogo"
					alt-key="''network_means_pageType_2_IMAGE_ALT''"
					image-key="''network_means_pageType_2_IMAGE_DATA''"
					straight-mode="false"> </custom-image>
			</div>

		</div> <!-- header -->

	<style>
#header {
	background-color:#fff;
	display:flex;
	flex-direction:row;
	justify-content:space-between;
}

#issuerLogo {
max-height: 43px;
width: initial;
margin-top:1em;
margin-bottom:1em;
margin-left:1em;
}

#networkLogo {
	max-height: 43px;
	width: initial;
	margin-top:1em;
	margin-bottom:1em;
	margin-right:1em;
}

@media screen and (min-width: 701px) {
	#optGblPage{

		font-size: 18px;
	}
}

@media screen and (max-width: 700px) and (min-width: 361px) {
	#optGblPage{

		font-size: 14px;
	}
	
	#gerat {
		margin-top: -16px;
	}
}

@media screen and (max-width: 360px) {
	#optGblPage{

		font-size: 12px;
	}
	
	#gerat {
		margin-top: -12px;
	}
}

@media screen and (max-width: 1200px) and (min-width: 701px) {
	
	 #gerat {
		margin-top: -22px;
	}
}
</style>
<message-banner></message-banner>
<style>
message-banner {
	display: block;
	width: 100%;
	position: relative;
}
</style>
	<div id="content">
		<div>
			<custom-text
					custom-text-key="''network_means_pageType_1''"></custom-text>
		</div>

		<div>
			<help help-label="''network_means_pageType_11''" id="helpButton"
				class="helpButtonClass"></help>
			<hr>
		</div>
		<div id="mainLayout">
			<div class="row">
				<div class="col1 primary-color">
					<custom-text custom-text-key="''network_means_pageType_2''"></custom-text>
				</div>
				<div class="colwidth2">
					<side-menu></side-menu>
				</div>
			</div>

			<div class="row">
				<div class="col1" id="gerat">
					<custom-text custom-text-key="''network_means_pageType_3''"></custom-text>
				</div>

				<div class="col2 primary-color">
					<div class="img-text">
					<span class="mobapp-icon"></span>
					<custom-text custom-text-key="''network_means_pageType_18''"></custom-text>
					</div>
				</div>
				<div class="col3" id="deviceChoice"><device-select devices="deviceSelectValues" select-box-style-enabled="true"></device-select></div>

			</div>

			<div class="row">
							<div class="col1">

				</div>
				<div class="col2">

				</div>
				<div class="col3">
					<val-button val-label="''network_means_pageType_8''" id="validateButton"></val-button>
					<cancel-button cn-label="''network_means_pageType_7''"  id="cancelButton"></cancel-button>
				</div>
			</div>
		</div>

	</div>

<style>

#deviceChoice {
		margin-left: -5px;
	}
	
.text-center {
	text-align: justify;
	}

.img-text {
		display:flex;
	}
	
.img-text + span {
	flex:1;
}

.img-text custom-text {
	flex:1;
	margin-top: 4px;
}

.mobapp-icon {
	background-image:url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABMAAAAgCAYAAADwvkPPAAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAC4jAAAuIwF4pT92AAAAB3RJTUUH4wIIDwgS00wEfgAAAmpJREFUSMet1k2oVVUUB/Dfvu8+X4rwSBAFiRBx1KAiVFAEUyFolCNJlODgJKzAnAhCTZ2JICpoW9SkBAehg5o4cmAKEqEDiexDuEYJgork17u7ybpyPO9+GS7YcBZr7f9e67/W2vukUlmEr7EByWwpte9+9hmcxZ42TgVQP7mHb+J7GuuwuOEzgU2Yn0qlO+BE+DVly6FUluIk1gzwLe0hQPBqqXwWqS7CkiG+KZXqOU66eFjTW5iqcfc4fHr8TaLdc243iL4WqUwYLgWvYCPW9gN7ipyy/caUUvm7DtZq2CfDqblpXqymzKkr7b5M5mcgC/BOrC6ulsqVlP3Tb197SAoL8SV2NEwnS2V3ym6NBVYqU9gSQA9wOar3JrbhftjqnTCLs/oh2yO10ylbn7J3cTDsK0vltSjawMhSqUzjPSyLqDqlsgodHIixutlvVptgLazCiahUwU58hEMp24tPa3RMDkuz1+V3avr90P8d1XftPmA/RTQ5ODuG7/BXVPiTSPlsk7NZkaXsLs7hN8zFQvyMu/gcX2BX2LrjVHMGX8WMbsW3OI6Pw/5Dyn5vZtYaMAGP4tI8HBFsijWNo9g3TjXrgLdLZQ/OY3ls/AUXU9YZpwDd3qCnTMru4EypTCCl/DzhzQloNx6L6fqg16KcGZDARLPjS+2UW7g+pDAah7+OpYMiWzLinh8qrTH97r0MsA7exxv4ADdeZJzq8gBHUvZ9VLiDBTFmLxzZU/xRa5WCP/9vmvOxudcqcc99OLS8jUe4KU9wFRewAqtHcXYZKwfYJ/E23hrxGwE/tuKBuD6iOVsjwC5h139YPazyRgJrLAAAAABJRU5ErkJggg==);
		background-repeat: no-repeat;
		background-size: 1em;
		background-position-y:5px;
		margin-right:0.5em;
		width:1em;
	   height:2em;
}


.field-desc {
	color:#AAA;
	font-size:0.6em;
}

.helpButtonClass button {
	border:0px;
}

.helpButtonClass span.fa-info:before {
    content:'''';
 }

.helpButtonClass .fa-info {
	background-image:url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAHZJREFUeNpiYEAD/5MYEoD4PRAbMBABmLCI9QOxABDvJ8YQbAY4AvEHYg1hxCYI1bQfagjIMEfGeQwXiDaAFEMY8TmPGEMYCQUSIUOYCBkAVYwSsIRigSTARI4X6BOIFEUjRQmJFM24ApFozbgMKCRWMwgABBgAKadBuXTsxLkAAAAASUVORK5CYII=);
	background-repeat: no-repeat;
	background-size: 1em;
	width:1em;
    height:1em;
}

.helpButtonClass span.custom-text {
    vertical-align:10%;
 }


hr {
	padding-left:2em;
	padding-right:2em;
}

#content {
	background-color:#FFF;
	border-radius:1em;
	margin:1.5em;
	padding:1.5em;
}

#optGblPage .row {
	display:flex;
	flex-direction:row;
	margin-top:1em;
}

.col1 {
	width:30%;

}

.col2 {
	width: 35%;

}

.col3 {
	width:35%;

}

.colwidth2 {
		width:70%;

}

/* overrides for the side-menu element */
div.side-menu div.menu-elements div div div  span  {

	text-align:left;
	padding-left:0px;
	padding-right:0px;
	margin-left:0px;
	width:50%;

}

div.side-menu div.menu-elements div div div span:nth-child(2)  {

	padding-left:0px;
	padding-right:0px;

}

.externalImage {
	margin:0px;
	padding:0px;
	margin-left:-15px;
	margin-top:-15px;
}

/* overrides for the cancel and validate button */
cancel-button button.btn {
	width:46%;
	height:30px;
	border:1px solid #000;
	line-height:12px;

}

cancel-button button.btn custom-text span {

	padding:0px;
}

cancel-button button.btn span.fa {
	display:none;
}

val-button button.btn {
 	width:46%;
	height:30px;
	background-color: #ff6200;
	color:#FFF;
	line-height:12px;
	border:1px solid #000;
}

val-button button.btn[disabled]:hover {
	background-color: #ff7210;
}

val-button button.btn:hover {
	background-color: #ff7210;
}

val-button button.btn span.fa:before {
    content:'''';
 }

val-button button.btn span.fa {
	background-image:url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH4wEYDx43k2lIoQAAADxJREFUOMtjYEAD////T/j////7////GzCQA6Ca/5NtyP///w1GDaGDIchyTAy0BhR5YSRqplZmIik7AwALvfe+TlwPXAAAAABJRU5ErkJggg==);
	background-repeat: no-repeat;
	background-size: 1em;
	width:1em;
    height:1em;
}

val-button button.btn div {
	display:inline;
}

val-button button.btn custom-text span {

	vertical-align:10%
}

#selection-group label {
	display:none;
}

@media screen and (max-width: 1200px) {

	#optGblPage .row {
		display:flex;
		flex-direction:column;
		margin-top:1em
	}

	/* overrides for the side-menu element */
	div.side-menu div.menu-elements div div div  span  {

		display:block;
		float:none;
		text-align:left;
		width:100%;

	}

	div.side-menu div.menu-elements div div div span:nth-child(2)  {

		padding-left:0px;
		padding-right:0px;
		display:block;
		width:100%;
		float:none;
	}


	cancel-button button.btn {
		display:block;
		float:none;
		width:100%;
		height:30px;
		border:1px solid #000;
		line-height:12px;
		margin-top:10px;
		margin-bottom:10px;

	}

	cancel-button button.btn custom-text span {

		padding:0px;
	}
	cancel-button button.btn span.fa {
		display:none;
	}

	val-button button.btn {
		display:block;
		float:none;
	 	width:100%;
		height:30px;
		background-color: #ff6200;
		color:#000;
		line-height:12px;
		border:1px solid #000;
		margin-top:10px;
		margin-bottom:10px;
	}

	val-button button.btn span.fa {
		display:none;
	}

	val-button button.btn custom-text span {

		padding:0px;
	}

	.col1 {
		display:block;
		width:100%;
	}

	.col2 {
		display:block;
		width:100%;
	}

	.col3 {
		display:block;
		width:100%;
	}

	.colwidth2 {
		display:block;
		width:100%;
	}

	#menu-separator {
		display:none;
	}

	.externalImage {
		margin:0px;
		padding:0px;
	}

}

</style>
</div>'
WHERE fk_id_layout =@layoutId;
