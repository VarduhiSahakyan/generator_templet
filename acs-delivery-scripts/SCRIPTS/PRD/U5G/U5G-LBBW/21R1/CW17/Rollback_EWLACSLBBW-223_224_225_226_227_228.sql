USE U5G_ACS_BO;

SET @BankUB = 'LBBW';

##LBBW-223
SET @customItemSetPassword = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_PASSWORD_UNIFIED'));
SET @currentPageType = 'OTP_FORM_PAGE';
UPDATE `CustomItem` SET `value` = 'Sie haben das BW&#8209;Secure Passwort vergessen? Vergeben Sie online ein neues Passwort auf der Seite:<a href="https://sicheres-bezahlen.bw-bank.de/" target="_blank">https://sicheres-bezahlen.bw-bank.de/</a>'
WHERE `fk_id_customItemSet` = @customItemSetPassword AND
	  `pageTypes` = @currentPageType AND
	  `ordinal` = 3;


SET @customItemSetSMSNormal = (SELECT id FROM `CustomItemSet` WHERE `name` = CONCAT('customitemset_', @BankUB, '_OTP_SMS'));

UPDATE `CustomItem` SET `value` = 'Ihre Mobilfunknummer hat sich geändert? Registrieren Sie die neue Mobilfunknummer direkt auf der Seite:<a href="https://sicheres-bezahlen.bw-bank.de/" target="_blank">https://sicheres-bezahlen.bw-bank.de/</a>'
WHERE `fk_id_customItemSet` = @customItemSetSMSNormal AND
		`pageTypes` = @currentPageType AND
		`ordinal` = 5;


##LBBW-224

UPDATE `CustomItem` SET `value` = 'Bitte warten Sie ein paar Sekunden, Ihre Eingabe wird geprüft.' WHERE
						`fk_id_customItemSet` in (@customItemSetPassword,@customItemSetSMSNormal) AND
						`pageTypes` = @currentPageType AND
						`ordinal` = 13;

##LBBW-226

UPDATE `CustomItem` SET `value` = 'Das eingegebene Passwort und/oder die mTAN war(en) nicht korrekt. Bitte prüfen Sie die Eingaben und versuchen Sie es erneut. Sie haben noch @trialsLeft Versuche.' WHERE
		`fk_id_customItemSet` in (@customItemSetPassword,@customItemSetSMSNormal) AND
		`pageTypes` = @currentPageType AND
		`ordinal` = 29;


##LBBW-225,LBBW-227,LBBW-228,

SET @customPageLayoutDesc = 'OTP Form Page for Landesbank Baden-Württemberg';
SET @pageType = 'OTP_FORM_PAGE';
SET @idPageLayout= (select id
					  from `CustomPageLayout`
					  where `pageType` = @pageType
						and DESCRIPTION = @customPageLayoutDesc);

UPDATE `CustomComponent` SET `value` = '<style>
	div#optGblPage {
		font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
		font-size: 14px;
		overflow: auto;
	}
	#helpButton button {
		font: 300 16px/20px "Helvetica Neue", Helvetica, Arial, sans-serif;
		display: inline-block;
		white-space: nowrap;
		text-align: center;
		height: 40px;
		background: #fff;
		color: #323232;
		border: 1px solid rgba(0, 0, 0, .25);
		min-width: 15rem;
		border-radius: 20px;
		font-size: 16px;
		padding-left: 0px !important;
	}
	#cancelButton button {
		font: 300 16px/20px "Helvetica Neue", Helvetica, Arial, sans-serif;
		display: inline-block;
		white-space: nowrap;
		text-align: center;
		height: 40px;
		background: #fff;
		color: #323232;
		border: 1px solid rgba(0, 0, 0, .25);
		min-width: 15rem;
		border-radius: 20px;
		font-size: 16px;
		padding-left: 0px !important;
	}
	#cancelButton button:focus {outline: 0;border-color: #ff6a10;outline: #6e6e6e 1px dotted;}
	#helpButton button:focus {outline: 0;border-color: #ff6a10;outline: #6e6e6e 1px dotted;}
	#cancelButton button:hover:enabled {
		border-color: rgba(255, 106, 16, .75);
	}
	#cancelButton button:active {
		background-image: linear-gradient(rgba(0, 0, 0, .05), rgba(0, 0, 0, .05));
		border-color: rgba(0, 0, 0, .25) rgba(0, 0, 0, .2) rgba(0, 0, 0, .15);
		box-shadow: none;
		outline: 0px;
	}
	#cancelButton button custom-text {
		vertical-align: 8px;
	}
	#helpButton button:hover {
		border-color: rgba(255, 106, 16, .75);
	}
	#helpButton button:active {
		background-image: linear-gradient(rgba(0, 0, 0, .05), rgba(0, 0, 0, .05));
		border-color: rgba(0, 0, 0, .25) rgba(0, 0, 0, .2) rgba(0, 0, 0, .15);
		box-shadow: none;
		outline: 0px;
	}
	#helpButton button custom-text {
		vertical-align: 8px;
	}
	div#footer {
		padding-top: 12px;
		padding-bottom: 12px;
		clear: both;
		width: 100%;
		background-color: rgb(18, 50, 80);
		text-align: center;
		margin-top: 15px;
		margin-bottom: 15px;
	}
	div#footer #helpButton button span:before {
		content: '''';
	}
	div#footer #cancelButton button span:before {
		content: '''';
	}
	div#footer #helpButton button span.fa {
		background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAAXNSR0IArs4c6QAAAppJREFUeAHtmr9Kw1AUxptEjASxtA/g4iBU0E0cnRwVxDrpom6CHXyBvkBpCY5uImJXVx2Egj6FxV2aFBVba1u/W5twucR2qDkXzAmk91/a75zfPTn3JjSV4oMJMAEmwASYABNgAkyACSSSgKHL62KxONVoNA6gv2wYxmOlUrlE2ae2Z4paMNCD81eo74h2v98/LhQKq6ieiDbloSUC4Ow8nH6WHcXsf5mmOVculz/k/rjrZtwCUb8PR6Miz0yn01bU9XH2aQGAWX6CU7eyY4iIS+SFN7mPoh41ExS6qWw2u4U8cIrQX4HgQy6Xc0mEWYQJMAEmwASYABNgAkMCZM8C2OVNN5vNdez4nF6vh/2PYYoPtA1sjT+xDb771ztB7PouAH03CD04Lp4CB81ut5vC+D0a68E4VUn5LLA4xqm1MeOxDJM9C1iWdYTQP4UXMzjF1PdwiltgG6U4KCfjRxGfZDkgVJQq1WrVqtVqX8Ouruu6ZBMSmKGFeiCez+dFFASHFlu0iAYei0UgqKPUEo1aAQjnASGMAiyD5PaQC0ozPqgiCYZRgJci5FGgHQAohBHgeR65PeSCagTIANrtNrk95IIqADkH1Ot1cnvIBVUAcgRgs0RuD7mgCkBOgngoIreHXFAFIEeA4zjJWwXkHOD7PvmEkAuOigDAILeHXHAUgMTngKRGQLgV7nQ6yUuC8iqgIwJiJ44/QyzDyT04Nx1x/4v3goc4Z8UYcsA5infpOh+bo7NSqfQi9f1pleINzA0cFP8IGWs4XpkdqRfhewvo21f7/6pNsQq8TmjspN8fKR97BNi2vdFqtTZhhf2LJTZujyXMdB3jnnKNn8lkrpU+bjIBJsAEmAATYAJMgAkwASbABJgAE5iQwDdkTa4cGFRLBAAAAABJRU5ErkJggg==);
		width: 24px;
		height: 26px;
		background-position-y: -1px;
		background-position-x: -2px;
		background-size: 115%;
		display: inline-block;
	}
	#helpCloseButton button {
		padding-left: 0px !important;
	}
	#helpCloseButton button span.fa {
		background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAAXNSR0IArs4c6QAAAppJREFUeAHtmr9Kw1AUxptEjASxtA/g4iBU0E0cnRwVxDrpom6CHXyBvkBpCY5uImJXVx2Egj6FxV2aFBVba1u/W5twucR2qDkXzAmk91/a75zfPTn3JjSV4oMJMAEmwASYABNgAkyACSSSgKHL62KxONVoNA6gv2wYxmOlUrlE2ae2Z4paMNCD81eo74h2v98/LhQKq6ieiDbloSUC4Ow8nH6WHcXsf5mmOVculz/k/rjrZtwCUb8PR6Miz0yn01bU9XH2aQGAWX6CU7eyY4iIS+SFN7mPoh41ExS6qWw2u4U8cIrQX4HgQy6Xc0mEWYQJMAEmwASYABNgAkMCZM8C2OVNN5vNdez4nF6vh/2PYYoPtA1sjT+xDb771ztB7PouAH03CD04Lp4CB81ut5vC+D0a68E4VUn5LLA4xqm1MeOxDJM9C1iWdYTQP4UXMzjF1PdwiltgG6U4KCfjRxGfZDkgVJQq1WrVqtVqX8Ouruu6ZBMSmKGFeiCez+dFFASHFlu0iAYei0UgqKPUEo1aAQjnASGMAiyD5PaQC0ozPqgiCYZRgJci5FGgHQAohBHgeR65PeSCagTIANrtNrk95IIqADkH1Ot1cnvIBVUAcgRgs0RuD7mgCkBOgngoIreHXFAFIEeA4zjJWwXkHOD7PvmEkAuOigDAILeHXHAUgMTngKRGQLgV7nQ6yUuC8iqgIwJiJ44/QyzDyT04Nx1x/4v3goc4Z8UYcsA5infpOh+bo7NSqfQi9f1pleINzA0cFP8IGWs4XpkdqRfhewvo21f7/6pNsQq8TmjspN8fKR97BNi2vdFqtTZhhf2LJTZujyXMdB3jnnKNn8lkrpU+bjIBJsAEmAATYAJMgAkwASbABJgAE5iQwDdkTa4cGFRLBAAAAABJRU5ErkJggg==);
		width: 24px;
		height: 26px;
		background-position-x: -2px;
		background-size: 115%;
		display: inline-block;
	}
	#helpCloseButton button span + span {
		margin-top: 1px;
	}
	div#footer #cancelButton button span.fa {
		background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAAXNSR0IArs4c6QAACLxJREFUeAHtmw1oVlUYx92mbjqbH03TID8rQaGZpnNSFlhWFpaRkYFYEChYOud0ToUUbTrn/NgoEkwIykBMy+yDjLIy076I1FmZlkFTVNxKfZ06t37P630ux3f33ve979cGvRfunnPOPec5////nHPPOfe8a9cudaUUSCmQUiClwP9XgbRkUN+yZUvGnj17hqWnp49pamoanJaWdmtzc3MvbBfqz+IOED+PreU+Qr7DGRkZeyorK38hntArYQJUVVVlHjt27BEIT4HBeO4cv0wQ6BTC7Gjfvv3mnJycL5YsWdLk10e4/HEXoLS0tOfFixdfBPhM7h7hAET6HDH+JG9l9+7dNyFEINJy4fLFTQBAZZ09e7YEoCUQ7+RQ8SWe7Sb9J+xJ8pygq58kXN/Y2JiL7cPdmx4jtoB8+eRJD/XDs1OkLVy3bt0mws2hz/3G4yLArFmzxgFmI4D7hwA4TfoO7p10412rV6++EPLcNSo9KRAIPEyGR7kn4Ds7JPO3CPgsQhwOSfcVjUkAWr19XV3dUmpcENJadZAup7tWx6O7FhcX96KXLKR3zKCuTINhABFelN5gpPkKRi0AoLKvXLnyDsQf1BohfYH4uk6dOlWUl5f/o+nxsrNnz+6L/5fwN407w/Bb3aNHj0LE9v2SjEqAuXPn5tIiHwJmpAGihqnrsbVr1/5upCUkiBBjqXsrzntqBYj//aBBg+5mOF7StEhsi5dMuEKo3MWB/PtZWVmjk0Fe8K1fv/7LDh06jIT0AcWLIHcdPXr0E6yvRvUlgDXmt5otD4gyut/jq1atOqdgkmGp9wz1XDfMwDW2sLCw0k/95jgKWy4vL6+MSmT8BS9ALKc1Fu/evTvm6Uh9RmKt948MwXsc8hdw/bZv376DDs9aJEXcXebMmTP+6tWrH+NBy7wH+UmI0FrkxyobhKhkNngIO9RK+zczM3N4RUXFUc3jZiMaAnT9zkxBG3ESJA/pQ4z5qW2BPJhWVFdXF3fs2PEx8Jy1iOZcvnx5gxtpMz0iAZjrS1H3FilIJedQe2Kyx7zR7e2WB84K9hwLBZfV2k9LWC7wjuN98OS1mPvfsALMmzevN87mqQvClbztj2k8GTYcecXAkNxFA23XOFjLZSeqcScbVgC6UiEFg6svnJ+h669xcpSotEjJa/0suReDM7ggQoCBbMMn6zMn6ymAVE4hWX4GLxyvSGbX90teQPINoQbzZhDwtT/FRrhF0FMAFjwTUbGrlIL8iW7dur3awkOCEqIhr1BYJC0hfNWKj2DlOkSfhVpPASD/jBYgvI3ZoEHjibSxkBdc7Dr/oMG+UYw0pHyUcbxcBYBsR0jfr6VY5+/UcCJtrOQNbDZeeDxipF8XdBWAqW8UOeV7nXT/CwMGDPj8upIJiDiRp+4yner8VAnpDzQ/PvJKSkqCQ1nT1LoKgIMxmonwp353WVo2UutGnqltUaQ+zHyIdpD4cUkDf3pDQ8No87mGXQUgw2DNhII/ajgRNt7kFSO4f9Aw1uZjpLXzEuA2I+MJIxzXYKLIWyBPGmBNPnaylwA3aS6WvqYjTY7ZJpi84LMbjmHQywmwlwByaKGX7UgTYrVJIC8vb7vhCN/ghNlLAPvTNsvLOqfC0aYlg7xgo9Vt3ISDM1ooZlcBUCygmdkP5Go4Vpss8oIT0jcqXpOPpol1FYBn5zUj74DeGo7FJpO8hbOPgdfmY6R5CmCPe74EmY7M8hGHW4G8vAPMhrP5mKC9esARzYijmARoDfKCnSFg4rb5KC+xXgKYR075ZiE/4VYkT7ulyXI+eBH+RcOmdRWAcf+1ZkTJ+4SIxiO1rUVe8HF4Mlx7AOQbmcn2O+F2FaBr166y/NUXRyZbygecHLiltSZ5C5Mcqur1g9vBrKsAbIcbUe4j9cBXYdctpeZR2wbIywvQFoDw+4ot1LoKIBkpuNkoMGn+/PmOqykjT7u2QF6+ANH9RygueLyt4VDrKcDAgQOlB5y2Ct3IlrIo1IEZbwvkBQ/DdTlGD3C+8vqK7SmAfANAvSqDZBE/XLBXV0Z6m2h5wcMJ1ihaf5Ji40tWhYadrKcAUoCz/lcQ4ZxVOIdfbZSGOmorLS+4eFeVKT5wH1yzZs1OjTvZsAKsXLlSNhTLtDDqziwqKsrTeFsiT+s/Bb5xig1bhAieZ5c6TowyLYMbNmzoUFNTcwDng62nx7Ozs0fyC5EAt5zS2sdVVFgW7WesljVHnsIx2DBaX9YunaUUOLaD44lwHsL2AHEwffr0K5hp3GLl6sdQ2MYu8aO2QF5+UAX5d8Gl5E8hwMwg0jB/PM/NzLL79+//Oz8//xJpuiDqS7if5mmtlpfeWVtbK+Nch2UzL77J/HDqJ8XmZSMaAuqA1k6jq72FnaJpYiFfTndbYKYlI8x8n8sQ3Epd92p9YCkFy0qNh7MRDQF1gvPmIUOGTMOG7qzGyimy5kuGZa1/B/P9d9Rlkq/yQ15w+hJACsj7gKlRdoc/S1wuekQB74PvATXyWkpi/1rn/nupt79RUzXdXk6yfV2+hoDpWcbeoUOHXidtqpEuB5Jv0EOW0hJ/GelxCTL93snHmZchLr8g1auZnesiyK/QBD82agG0Elr9BQCtJp6padhLgHqNLWgZuzD5bW9MF8Rvp7vLWkTO+m3MCH2GuqdxCvRhtBXYzqJ1IOWsOVh+Q2RvQCx/DYD8jHsnQD/w0ytY1AxlapMd3aOULcCGzljy28QZ/F6h1qorKhMXAaRmts/p/Fr8ecguA7DjIQTP5L0R/LU49gQETzJl1WNzifehXG/y9CFcQLg/tsXF8195VhRLq5tO4yaAOkWIrPr6+ucEJPetmh6rhbh80angB9jbqaMpVn9aPu4CqGOxDI0CWlfWDBO4B0lapBeEmxDwAO+SHfSSzYn695mECmCS5WPKzUyVYyB1O+m3ccsw6UI8C7IBwucJ10JY1hiHGd97rY0Y0dSVUiClQEqBlAIJUeA/Mi9ovi9iSQYAAAAASUVORK5CYII=);
		width: 24px;
		height: 26px;
		background-position-y: 1px;
		background-position-x: -2px;
		background-size: contain;
		display: inline-block;
		margin-right: 3px;
	}
	#cancelButton button span:before {
		content: '''';
	}
	#validateButton button span:before {
		content: '''';
	}
	.paragraph {
		text-align: left;
		margin-top: -2px;
		margin-bottom: 20px;
	}
	#issuerLogo {
		max-height: 64px;
		padding-left: 0px;
		padding-right: 0px;
	}
	#networkLogo {
		max-height: 82px;
		padding-top: 16px;
		padding-right: 16px;
	}
	#pageHeader {
		width: 100%;
		height: 95px;
		border-bottom: 1px solid #dcdcdc;
	}
	#pageHeaderLeft {
		width: 50%;
		float: left;
		padding-left: 16px;
		padding-top: 16px;
	}
	#pageHeaderCenter {
		width: 60%;
		float: left;
		text-align: center;
		line-height: 70px;
		padding-top: 16px;
	}
	#pageHeaderRight {
		width: 50%;
		float: right;
		text-align: right;
		padding-left: 16px;
	}
	.valbtn {
		margin: 3px 12px 25px 50px;
		text-align: center;
	}
	.leftColumn {
		width: 40%;
		display: block;
		float: left;
		padding: 1em;
	}
	.rightColumn {
		width: 60%;
		margin-left: 40%;
		display: block;
		text-align: left;
		padding: 20px 10px;
	}
	.contentRow {
		width: 100%;
		padding: 1em;
		padding: 0px;
		padding-top: 1em;
		clear: both;
	}
	side-menu div.text-center {
		text-align: left;
	}
	div.side-menu div.menu-title::before {
		display: inline;
	}
	div.side-menu div.menu-title::after {
		display: inline;
	}
	div.side-menu div.menu-title {
		display: inline;
		padding-left: 50.9%;
		text-align: left;
		font-size: 18px;
		font-weight : bold;
	}
	div.side-menu div.menu-elements {
		margin-top: 5px;
	}
	#otp-form {
		display: inline-block;
		padding-top: 12px;
	}
	#otp-form input {
		box-sizing: content-box;
		padding: 5px 10px 3px;
		background-color: #fff;
		border: 1px solid rgba(0, 0, 0, .2);
		border-radius: 2px;
		box-shadow: inset 1px 1px 0 0 rgba(0, 0, 0, .1);
		font: 300 18px "Helvetica Neue", Helvetica, Arial, sans-serif;
		font-size: 1.8rem;
		line-height: 25px;
		min-height: 35px;
	}
	#otp-form input:disabled {
		color: #bebebe !important;
		background-color: #dcdcdc !important;
		border-color: rgba(0, 0, 0, .05) !important;
		box-shadow: none !important;
	}
	#otp-form input:focus {
		border-color: #ff6a10 !important;
		outline-color: #ff6a10;
	}
	div#otp-fields-container {
		width: 70%;
		text-align: center;
		margin-top: 10px;
		margin-bottom: 10px;
	}
	div#otp-fields {
		display: inline-block;
	}
	div#otp-form div.tooltips {
		background: #545454;
	}
	div#otp-form div.tooltips span {
		background: #545454;
	}
	div#otp-form div.tooltips span:after {
		border-top: 8px solid #545454;
	}
	#validateButton {
		display: inline-block;
		padding-top: 10px;
		margin-left: 1em;
		vertical-align: 4px;
	}
	#validateButton button {
		font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
		font-size: 16px;
		border-radius: 30px;
		color: #fff;
		background: #00ac32;
		padding: 10px 10px 5px 10px;
		border: solid #e0e0e0 1px;
		text-decoration: none;
		min-width: 150px;
		height: 40px;
		text-align: center;
		white-space: nowrap;
		display: inline-block;
	}
	#validateButton button:disabled {
		font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
		font-size: 16px;
		border-radius: 30px;
		color: #969696;
		background: #fff;
		border-color: #dcdcdc;
		padding: 10px 10px 5px 10px;
		border: solid #e0e0e0 1px;
		text-decoration: none;
		min-width: 150px;
		height: 40px;
		text-align: center;
		white-space: nowrap;
		display: inline-block;
	}
	.col-sm-offset-1 {
		margin-left: 9.33%;
	}
	.col-sm-6 {
		width: 49%;
	}
	#mtan {
		padding-right: 3px;
	}
	#validateButton span.custom-text.ng-binding {
		position: relative;
		bottom: 25px;
	}
	#validateButton span.fa.fa-check-square {
		position: relative;
		right: 28px;
		bottom: 3px;
	}
	.resendButton {
		position: relative;
		color: #f7f7f7;
		padding-top: 1px;
	}
	.resendButton button {
		border: 0px;
	}
	@media all and (max-width: 1199px) and (min-width: 701px) {
		h1 {font-size: 24px;}
		#issuerLogo {max-height: 64px; max-width: 100%; }
		#networkLogo {max-height: 72px;px; max-width: 100%; }
		div#optGblPage { font-size: 14px;}
		.paragraph { text-align: center;}
		.leftColumn { display: block; float: none; width: 100%; padding-bottom: 84px;}
		.rightColumn { display: block; float: none; width: 100%; margin-left: 0px; text-align: center; }
		div.side-menu div.menu-title { padding-left: 115px; text-align: center; font-weight : bold; }
		side-menu div.text-center { text-align: center; }
		#otp-form { display: block; width: 200px; margin-left: auto; margin-right: auto; }
		#otp-form input { width: 100%; }
		div#otp-fields { width: 100%; }
		#validateButton { display: block; width: 150px; margin-left: auto; margin-right: auto; }
		#validateButton button { width: 100%; }
		.valbtn { margin: 0px 30px 10px 30px; text-align: justify; }
		div#otp-fields-container { width: 100%; text-align: center; margin-top: 10px; margin-bottom: 10px; }
	}
	@media all and (max-width: 768px) {
		.col-sm-offset-1 {margin-left: 0.33%;}
	}
	@media all and (max-width: 700px) and (min-width: 481px) {
		h1 { font-size: 18px; }
		div#optGblPage { font-size: 14px;}
		#issuerLogo {max-height: 54px; max-width: 100%; }
		#networkLogo {max-height: 67px; max-width: 100%;}
		.paragraph { text-align: center;}
		.leftColumn { display: block; float: none; width: 100%; padding-bottom: 84px;}
		.rightColumn { margin-left: 0px; display: block; float: none; width: 100%; text-align: center; }
		div.side-menu div.menu-title { padding-left: 105px; text-align: center; font-size: 18px; font-weight : bold; }
		side-menu div.text-center { text-align: center; }
		#otp-form { display: block; width: 200px; margin-left: auto; margin-right: auto; }
		#otp-form input { width: 100%; }
		div#otp-fields { width: 100%; }
		#validateButton { display: block; width: 150px; margin-left: auto; margin-right: auto; }
		#validateButton button { width: 100%; }
		.valbtn { margin: 0px 25px 10px 27px; text-align: justify; }
		div#otp-fields-container { width: 100%; text-align: center; margin-top: 10px; margin-bottom: 10px; }
	}
	@media all and (max-width: 480px) {
		h1 {font-size: 16px;}
		div.side-menu div.menu-title { display: inline; }
		div#optGblPage { font-size: 14px;}
		#issuerLogo { max-height: 42px; max-width: 100%; }
		#networkLogo {max-height: 62px; max-width: 100%; }
		.leftColumn { display: block; float: none; width: 100%; padding-bottom: 115px;}
		.paragraph { text-align: center;}
		.rightColumn { display: block; float: none; width: 100%; margin-left: 0px; text-align: center; }
		div.side-menu div.menu-title { padding-left: 95px; text-align: center; font-size: 16px; font-weight : bold; }
		side-menu div.text-center { text-align: center; }
		#otp-form { display: block; width: 200px; margin-left: auto; margin-right: auto; }
		#otp-form input { width: 100%; padding: 0px; }
		div#otp-fields { width: 100%; }
		#validateButton { display: block; width: 150px; margin-left: auto; margin-right: auto; }
		#validateButton button { width: 100%; }
		.valbtn { margin-left: auto; margin-right: auto; }
		div#otp-fields-container { width: 100%; text-align: center; margin-top: 10px; margin-bottom: 10px; }
		#pageHeader { height: 70px; }
	}
	@media all and (max-width: 390px) {
		h1 {font-size: 14px;}
		div.side-menu div.menu-title { display: inline; }
		div#optGblPage { font-size: 12px; max-width: 390px;}
		#issuerLogo { max-height: 32px; max-width: 100%; }
		#networkLogo {max-height: 52px; max-width: 100%; }
		.leftColumn { display: block; float: none; width: 100%; padding-bottom: 95px;}
		.paragraph { text-align: center;}
		.rightColumn { display: block; float: none; width: 100%; margin-left: 0px; text-align: center; }
		div.side-menu div.menu-title { padding-left: 95px; text-align: center; font-size: 14px; font-weight : bold; }
		side-menu div.text-center { text-align: center; }
		#otp-form { display: block; width: 200px; margin-left: auto; margin-right: auto; }
		#otp-form input { width: 100%; padding: 0px; }
		div#otp-fields { width: 100%; }
		#validateButton { display: block; width: 150px; margin-left: auto; margin-right: auto; }
		#validateButton button { width: 100%; }
		.valbtn { margin-left: auto; margin-right: auto; }
		div#otp-fields-container { width: 100%; text-align: center; margin-top: 10px; margin-bottom: 10px; }
		#pageHeader { height: 70px; }
	}
	@media all and (max-width: 347px) {
		div#optGblPage { font-size: 12px; max-width: 347px;}
		.paragraph { text-align: center;}
		.leftColumn { display: block; float: none; width: 100%; padding-bottom: 220px;}
		.rightColumn { display: block; float: none; width: 100%; margin-left: 0px; text-align: center; margin-top: -130px; }
		#validateButton { display: block; margin-left: auto; margin-right: auto; }
		#validateButton button { width: 80%; }
		.valbtn { width: 80%; margin-left: auto; margin-right: auto; }
		div#otp-fields-container { width: 100%; text-align: center; margin-top: 10px; margin-bottom: 10px; }
		#issuerLogo { max-height: 32px; max-width: 100%; }
		#networkLogo {max-height: 42px; max-width: 100%; }
	}
	@media all and (max-width: 309px) {
		div#optGblPage { font-size: 10px; max-width: 309px;}
		.leftColumn { display: block; float: none; width: 100%; padding-bottom: 220px;}
		.rightColumn { display: block; float: none; width: 100%; margin-left: 0px; text-align: center; margin-top: -140px; }
		div#otp-fields-container { width: 100%; text-align: center; margin-top: 10px; margin-bottom: 10px; }
		#issuerLogo { max-height: 32px; max-width: 100%; }
		#networkLogo {max-height: 42px; max-width: 100%; }
	}
	@media all and (max-width: 250px) {
		div#optGblPage { font-size: 08px; max-width: 250px;}
		.leftColumn { display: block; float: none; width: 100%; padding-bottom: 200px;}
		#issuerLogo { max-height: 25px; max-width: 100%; }
		#networkLogo {max-height: 35px; max-width: 100%; }
	}
</style>
<div id="optGblPage">
	<div id="pageHeader" ng-style="style" class="ng-scope">
		<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
			<custom-image alt-key="''network_means_pageType_1_IMAGE_ALT''" image-key="''network_means_pageType_1_IMAGE_DATA''" id="issuerLogo" straight-mode="false"></custom-image>
		</div>
		<div id="pageHeaderRight" ng-style="style" class="ng-scope" >
			<custom-image alt-key="''network_means_pageType_2_IMAGE_ALT''"	image-key="''network_means_pageType_2_IMAGE_DATA''" id="networkLogo" straight-mode="false"></custom-image>
		</div>
	</div>
	<message-banner close-button="''network_means_pageType_174''" back-button="''network_means_pageType_175''"></message-banner>

	<div id="displayLayout" class="row">
		<div id="blue-banner"></div>
	</div>
	<style>
		div#blue-banner {
			height: 50px !important;
			background-color: rgb(18,50,80);
			border-bottom: 5px solid rgb(18,50,80);
			width: 100%;
		}
	</style>
	<div class="contentRow">
		<div x-ms-format-detection="none" class="leftColumn">
			<side-menu menu-title="''network_means_pageType_42''"></side-menu>
		</div>
		<div class="rightColumn">
			<div class="paragraph">
				<strong><custom-text custom-text-key="''network_means_pageType_43''"></custom-text></strong>
			</div>
			<div class="paragraph">
				<custom-text custom-text-key="''network_means_pageType_1''"></custom-text>
			</div>
			<div id="otp-fields-container">
				<div x-ms-format-detection="none" id="otp-fields">
					<custom-text custom-text-key="''network_means_pageType_2''" id="mtan"></custom-text>
					<otp-form></otp-form>
					<div class="resendButton">
						<re-send-otp rso-label="''network_means_pageType_4''"></re-send-otp>
					</div>
					<div class="valbtn">
						<val-button id="validateButton" val-label="''network_means_pageType_3''"></val-button>
					</div>
					<div class="paragraph">
						<custom-text custom-text-key="''network_means_pageType_5''" id="paragraph3">
						</custom-text>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="footer">
		<div ng-style="style" class="style">
			<cancel-button cn-label="''network_means_pageType_6''" id="cancelButton" ></cancel-button>
			<help help-label="''network_means_pageType_7''" id="helpButton" ></help>
		</div>
	</div>
</div>' WHERE `fk_id_layout` = @idPageLayout;



SET @customPageLayoutDesc = 'Password OTP Form Page for Landesbank Baden-Württemberg';
SET @pageType = 'PASSWORD_OTP_FORM_PAGE';
SET @idPageLayout= (select id
					from `CustomPageLayout`
					where `pageType` = @pageType
					  and DESCRIPTION = @customPageLayoutDesc);

UPDATE `CustomComponent` SET `value` = '<style>
	div#optGblPage {
		font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
		font-size: 14px;
		overflow: auto;
	}
	#helpButton button {
		font: 300 16px/20px "Helvetica Neue", Helvetica, Arial, sans-serif;
		display: inline-block;
		white-space: nowrap;
		text-align: center;
		height: 40px;
		background: #fff;
		color: #323232;
		border: 1px solid rgba(0, 0, 0, .25);
		min-width: 15rem;
		border-radius: 20px;
		font-size: 16px;
		padding-left: 0px !important;
	}
	#cancelButton button {
		font: 300 16px/20px "Helvetica Neue", Helvetica, Arial, sans-serif;
		display: inline-block;
		white-space: nowrap;
		text-align: center;
		height: 40px;
		background: #fff;
		color: #323232;
		border: 1px solid rgba(0, 0, 0, .25);
		min-width: 15rem;
		border-radius: 20px;
		font-size: 16px;
		padding-left: 0px !important;
	}
	#cancelButton button:focus {outline: 0;border-color: #ff6a10;outline: #6e6e6e 1px dotted;}
	#helpButton button:focus {outline: 0;border-color: #ff6a10;outline: #6e6e6e 1px dotted;}
	#cancelButton button:hover:enabled {
		border-color: rgba(255, 106, 16, .75);
	}
	#cancelButton button:active {
		background-image: linear-gradient(rgba(0, 0, 0, .05), rgba(0, 0, 0, .05));
		border-color: rgba(0, 0, 0, .25) rgba(0, 0, 0, .2) rgba(0, 0, 0, .15);
		box-shadow: none;
		outline: 0px;
	}
	#cancelButton button custom-text {
		vertical-align: 8px;
	}
	#helpButton button:hover {
		border-color: rgba(255, 106, 16, .75);
	}
	#helpButton button:active {
		background-image: linear-gradient(rgba(0, 0, 0, .05), rgba(0, 0, 0, .05));
		border-color: rgba(0, 0, 0, .25) rgba(0, 0, 0, .2) rgba(0, 0, 0, .15);
		box-shadow: none;
		outline: 0px;
	}
	#helpButton button custom-text {
		vertical-align: 8px;
	}
	div#footer {
		padding-top: 12px;
		padding-bottom: 12px;
		clear: both;
		width: 100%;
		background-color: rgb(18, 50, 80);
		text-align: center;
		margin-top: 15px;
		margin-bottom: 15px;
	}
	div#footer #helpButton button span:before {
		content: '''';
	}
	div#footer #cancelButton button span:before {
		content: '''';
	}
	div#footer #helpButton button span.fa {
		background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAAXNSR0IArs4c6QAAAppJREFUeAHtmr9Kw1AUxptEjASxtA/g4iBU0E0cnRwVxDrpom6CHXyBvkBpCY5uImJXVx2Egj6FxV2aFBVba1u/W5twucR2qDkXzAmk91/a75zfPTn3JjSV4oMJMAEmwASYABNgAkyACSSSgKHL62KxONVoNA6gv2wYxmOlUrlE2ae2Z4paMNCD81eo74h2v98/LhQKq6ieiDbloSUC4Ow8nH6WHcXsf5mmOVculz/k/rjrZtwCUb8PR6Miz0yn01bU9XH2aQGAWX6CU7eyY4iIS+SFN7mPoh41ExS6qWw2u4U8cIrQX4HgQy6Xc0mEWYQJMAEmwASYABNgAkMCZM8C2OVNN5vNdez4nF6vh/2PYYoPtA1sjT+xDb771ztB7PouAH03CD04Lp4CB81ut5vC+D0a68E4VUn5LLA4xqm1MeOxDJM9C1iWdYTQP4UXMzjF1PdwiltgG6U4KCfjRxGfZDkgVJQq1WrVqtVqX8Ouruu6ZBMSmKGFeiCez+dFFASHFlu0iAYei0UgqKPUEo1aAQjnASGMAiyD5PaQC0ozPqgiCYZRgJci5FGgHQAohBHgeR65PeSCagTIANrtNrk95IIqADkH1Ot1cnvIBVUAcgRgs0RuD7mgCkBOgngoIreHXFAFIEeA4zjJWwXkHOD7PvmEkAuOigDAILeHXHAUgMTngKRGQLgV7nQ6yUuC8iqgIwJiJ44/QyzDyT04Nx1x/4v3goc4Z8UYcsA5infpOh+bo7NSqfQi9f1pleINzA0cFP8IGWs4XpkdqRfhewvo21f7/6pNsQq8TmjspN8fKR97BNi2vdFqtTZhhf2LJTZujyXMdB3jnnKNn8lkrpU+bjIBJsAEmAATYAJMgAkwASbABJgAE5iQwDdkTa4cGFRLBAAAAABJRU5ErkJggg==);
		width: 24px;
		height: 26px;
		background-position-y: -1px;
		background-position-x: -2px;
		background-size: 115%;
		display: inline-block;
	}
	#helpCloseButton button {
		padding-left: 0px !important;
	}
	#helpCloseButton button span.fa {
		background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAAXNSR0IArs4c6QAAAppJREFUeAHtmr9Kw1AUxptEjASxtA/g4iBU0E0cnRwVxDrpom6CHXyBvkBpCY5uImJXVx2Egj6FxV2aFBVba1u/W5twucR2qDkXzAmk91/a75zfPTn3JjSV4oMJMAEmwASYABNgAkyACSSSgKHL62KxONVoNA6gv2wYxmOlUrlE2ae2Z4paMNCD81eo74h2v98/LhQKq6ieiDbloSUC4Ow8nH6WHcXsf5mmOVculz/k/rjrZtwCUb8PR6Miz0yn01bU9XH2aQGAWX6CU7eyY4iIS+SFN7mPoh41ExS6qWw2u4U8cIrQX4HgQy6Xc0mEWYQJMAEmwASYABNgAkMCZM8C2OVNN5vNdez4nF6vh/2PYYoPtA1sjT+xDb771ztB7PouAH03CD04Lp4CB81ut5vC+D0a68E4VUn5LLA4xqm1MeOxDJM9C1iWdYTQP4UXMzjF1PdwiltgG6U4KCfjRxGfZDkgVJQq1WrVqtVqX8Ouruu6ZBMSmKGFeiCez+dFFASHFlu0iAYei0UgqKPUEo1aAQjnASGMAiyD5PaQC0ozPqgiCYZRgJci5FGgHQAohBHgeR65PeSCagTIANrtNrk95IIqADkH1Ot1cnvIBVUAcgRgs0RuD7mgCkBOgngoIreHXFAFIEeA4zjJWwXkHOD7PvmEkAuOigDAILeHXHAUgMTngKRGQLgV7nQ6yUuC8iqgIwJiJ44/QyzDyT04Nx1x/4v3goc4Z8UYcsA5infpOh+bo7NSqfQi9f1pleINzA0cFP8IGWs4XpkdqRfhewvo21f7/6pNsQq8TmjspN8fKR97BNi2vdFqtTZhhf2LJTZujyXMdB3jnnKNn8lkrpU+bjIBJsAEmAATYAJMgAkwASbABJgAE5iQwDdkTa4cGFRLBAAAAABJRU5ErkJggg==);
		width: 24px;
		height: 26px;
		background-position-x: -2px;
		background-size: 115%;
		display: inline-block;
	}
	#helpCloseButton button span + span {
		margin-top: 1px;
	}
	div#footer #cancelButton button span.fa {
		background-image: url(data:image/png;base64,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);
		width: 24px;
		height: 26px;
		background-position-y: 1px;
		background-position-x: -2px;
		background-size: contain;
		display: inline-block;
		margin-right: 3px;
	}
	#cancelButton button span:before {
		content: '''';
	}
	#validateButton button span:before {
		content: '''';
	}
	.paragraph {
		text-align: left;
		margin-top: -2px;
		margin-bottom: 20px;
	}
	#issuerLogo {
		max-height: 64px;
		padding-left: 0px;
		padding-right: 0px;
	}
	#networkLogo {
		max-height: 82px;
		padding-top: 16px;
		padding-right: 16px;
	}
	#pageHeader {
		width: 100%;
		height: 95px;
		border-bottom: 1px solid #dcdcdc;
	}
	#pageHeaderLeft {
		width: 50%;
		float: left;
		padding-left: 16px;
		padding-top: 16px;
	}
	#pageHeaderCenter {
		width: 60%;
		float: left;
		text-align: center;
		line-height: 70px;
		padding-top: 16px;
	}
	#pageHeaderRight {
		width: 50%;
		float: right;
		text-align: right;
		padding-left: 16px;
	}
	.valbtn {
		margin: 3px 12px 25px 50px;
		text-align: center;
	}
	.leftColumn {
		width: 40%;
		display: block;
		float: left;
		padding: 1em;
	}
	.rightColumn {
		width: 60%;
		margin-left: 40%;
		display: block;
		text-align: left;
		padding: 20px 10px;
	}
	.contentRow {
		width: 100%;
		padding: 1em;
		padding: 0px;
		padding-top: 1em;
		clear: both;
	}
	side-menu div.text-center {
		text-align: left;
	}
	div.side-menu div.menu-title::before {
		display: inline;
	}
	div.side-menu div.menu-title::after {
		display: inline;
	}
	div.side-menu div.menu-title {
		display: inline;
		padding-left: 50.9%;
		text-align: left;
		font-size: 18px;
		font-weight : bold;
	}
	div.side-menu div.menu-elements {
		margin-top: 5px;
	}
	#otp-form {
		display: inline-block;
		padding-top: 12px;
	}
	#otp-form input {
		box-sizing: content-box;
		padding: 5px 10px 3px;
		background-color: #fff;
		border: 1px solid rgba(0, 0, 0, .2);
		border-radius: 2px;
		box-shadow: inset 1px 1px 0 0 rgba(0, 0, 0, .1);
		font: 300 18px "Helvetica Neue", Helvetica, Arial, sans-serif;
		font-size: 1.8rem;
		line-height: 25px;
		min-height: 35px;
	}
	#otp-form input:disabled {
		color: #bebebe !important;
		background-color: #dcdcdc !important;
		border-color: rgba(0, 0, 0, .05) !important;
		box-shadow: none !important;
	}
	#otp-form input:focus {
		border-color: #ff6a10 !important;
		outline-color: #ff6a10;
	}
	div#otp-fields-container {
		width: 70%;
		text-align: center;
		margin-top: 10px;
		margin-bottom: 10px;
	}
	div#otp-fields {
		display: inline-block;
	}
	div#otp-form div.tooltips {
		background: #545454;
	}
	div#otp-form div.tooltips span {
		background: #545454;
	}
	div#otp-form div.tooltips span:after {
		border-top: 8px solid #545454;
	}
	#validateButton {
		display: inline-block;
		padding-top: 10px;
		margin-left: 1em;
		vertical-align: 4px;
	}
	#validateButton button {
		font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
		font-size: 16px;
		border-radius: 30px;
		color: #fff;
		background: #00ac32;
		padding: 10px 10px 5px 10px;
		border: solid #e0e0e0 1px;
		text-decoration: none;
		min-width: 150px;
		height: 40px;
		text-align: center;
		white-space: nowrap;
		display: inline-block;
	}
	#validateButton button:disabled {
		font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
		font-size: 16px;
		border-radius: 30px;
		color: #969696;
		background: #fff;
		border-color: #dcdcdc;
		padding: 10px 10px 5px 10px;
		border: solid #e0e0e0 1px;
		text-decoration: none;
		min-width: 150px;
		height: 40px;
		text-align: center;
		white-space: nowrap;
		display: inline-block;
	}
	.col-sm-offset-1 {
		margin-left: 9.33%;
	}
	.col-sm-6 {
		width: 49%;
	}
	#mtan {
		padding-right: 3px;
	}
	#validateButton span.custom-text.ng-binding {
		position: relative;
		bottom: 25px;
	}
	#validateButton span.fa.fa-check-square {
		position: relative;
		right: 28px;
		bottom: 3px;
	}
	.resendButton {
		position: relative;
		color: #f7f7f7;
		padding-top: 1px;
	}
	.resendButton button {
		border: 0px;
	}
	@media all and (max-width: 1199px) and (min-width: 701px) {
		h1 {font-size: 24px;}
		#issuerLogo {max-height: 64px; max-width: 100%; }
		#networkLogo {max-height: 72px;px; max-width: 100%; }
		div#optGblPage { font-size: 14px;}
		.paragraph { text-align: center;}
		.leftColumn { display: block; float: none; width: 100%; padding-bottom: 84px;}
		.rightColumn { display: block; float: none; width: 100%; margin-left: 0px; text-align: center; }
		div.side-menu div.menu-title { padding-left: 115px; text-align: center; font-weight : bold; }
		side-menu div.text-center { text-align: center; }
		#otp-form { display: block; width: 200px; margin-left: auto; margin-right: auto; }
		#otp-form input { width: 100%; }
		div#otp-fields { width: 100%; }
		#validateButton { display: block; width: 150px; margin-left: auto; margin-right: auto; }
		#validateButton button { width: 100%; }
		.valbtn { margin: 0px 30px 10px 30px; text-align: justify; }
		div#otp-fields-container { width: 100%; text-align: center; margin-top: 10px; margin-bottom: 10px; }
	}
	@media all and (max-width: 768px) {
		.col-sm-offset-1 {margin-left: 0.33%;}
	}
	@media all and (max-width: 700px) and (min-width: 481px) {
		h1 { font-size: 18px; }
		div#optGblPage { font-size: 14px;}
		#issuerLogo {max-height: 54px; max-width: 100%; }
		#networkLogo {max-height: 67px; max-width: 100%;}
		.paragraph { text-align: center;}
		.leftColumn { display: block; float: none; width: 100%; padding-bottom: 84px;}
		.rightColumn { margin-left: 0px; display: block; float: none; width: 100%; text-align: center; }
		div.side-menu div.menu-title { padding-left: 105px; text-align: center; font-size: 18px; font-weight : bold; }
		side-menu div.text-center { text-align: center; }
		#otp-form { display: block; width: 200px; margin-left: auto; margin-right: auto; }
		#otp-form input { width: 100%; }
		div#otp-fields { width: 100%; }
		#validateButton { display: block; width: 150px; margin-left: auto; margin-right: auto; }
		#validateButton button { width: 100%; }
		.valbtn { margin: 0px 25px 10px 27px; text-align: justify; }
		div#otp-fields-container { width: 100%; text-align: center; margin-top: 10px; margin-bottom: 10px; }
	}
	@media all and (max-width: 480px) {
		h1 {font-size: 16px;}
		div.side-menu div.menu-title { display: inline; }
		div#optGblPage { font-size: 14px;}
		#issuerLogo { max-height: 42px; max-width: 100%; }
		#networkLogo {max-height: 62px; max-width: 100%; }
		.leftColumn { display: block; float: none; width: 100%; padding-bottom: 115px;}
		.paragraph { text-align: center;}
		.rightColumn { display: block; float: none; width: 100%; margin-left: 0px; text-align: center; }
		div.side-menu div.menu-title { padding-left: 95px; text-align: center; font-size: 16px; font-weight : bold; }
		side-menu div.text-center { text-align: center; }
		#otp-form { display: block; width: 200px; margin-left: auto; margin-right: auto; }
		#otp-form input { width: 100%; padding: 0px; }
		div#otp-fields { width: 100%; }
		#validateButton { display: block; width: 150px; margin-left: auto; margin-right: auto; }
		#validateButton button { width: 100%; }
		.valbtn { margin-left: auto; margin-right: auto; }
		div#otp-fields-container { width: 100%; text-align: center; margin-top: 10px; margin-bottom: 10px; }
		#pageHeader { height: 70px; }
	}
	@media all and (max-width: 390px) {
		h1 {font-size: 14px;}
		div.side-menu div.menu-title { display: inline; }
		div#optGblPage { font-size: 12px; max-width: 390px;}
		#issuerLogo { max-height: 32px; max-width: 100%; }
		#networkLogo {max-height: 52px; max-width: 100%; }
		.leftColumn { display: block; float: none; width: 100%; padding-bottom: 95px;}
		.paragraph { text-align: center;}
		.rightColumn { display: block; float: none; width: 100%; margin-left: 0px; text-align: center; }
		div.side-menu div.menu-title { padding-left: 95px; text-align: center; font-size: 14px; font-weight : bold; }
		side-menu div.text-center { text-align: center; }
		#otp-form { display: block; width: 200px; margin-left: auto; margin-right: auto; }
		#otp-form input { width: 100%; padding: 0px; }
		div#otp-fields { width: 100%; }
		#validateButton { display: block; width: 150px; margin-left: auto; margin-right: auto; }
		#validateButton button { width: 100%; }
		.valbtn { margin-left: auto; margin-right: auto; }
		div#otp-fields-container { width: 100%; text-align: center; margin-top: 10px; margin-bottom: 10px; }
		#pageHeader { height: 70px; }
	}
	@media all and (max-width: 347px) {
		div#optGblPage { font-size: 12px; max-width: 347px;}
		.paragraph { text-align: center;}
		.leftColumn { display: block; float: none; width: 100%; padding-bottom: 220px;}
		.rightColumn { display: block; float: none; width: 100%; margin-left: 0px; text-align: center; margin-top: -130px; }
		#validateButton { display: block; margin-left: auto; margin-right: auto; }
		#validateButton button { width: 80%; }
		.valbtn { width: 80%; margin-left: auto; margin-right: auto; }
		div#otp-fields-container { width: 100%; text-align: center; margin-top: 10px; margin-bottom: 10px; }
		#issuerLogo { max-height: 32px; max-width: 100%; }
		#networkLogo {max-height: 42px; max-width: 100%; }
	}
	@media all and (max-width: 309px) {
		div#optGblPage { font-size: 10px; max-width: 309px;}
		.leftColumn { display: block; float: none; width: 100%; padding-bottom: 220px;}
		.rightColumn { display: block; float: none; width: 100%; margin-left: 0px; text-align: center; margin-top: -140px; }
		div#otp-fields-container { width: 100%; text-align: center; margin-top: 10px; margin-bottom: 10px; }
		#issuerLogo { max-height: 32px; max-width: 100%; }
		#networkLogo {max-height: 42px; max-width: 100%; }
	}
	@media all and (max-width: 250px) {
		div#optGblPage { font-size: 08px; max-width: 250px;}
		.leftColumn { display: block; float: none; width: 100%; padding-bottom: 200px;}
		#issuerLogo { max-height: 25px; max-width: 100%; }
		#networkLogo {max-height: 35px; max-width: 100%; }
	}
</style>
<div id="optGblPage">
	<div id="pageHeader" ng-style="style" class="ng-scope">
		<div id="pageHeaderLeft" ng-style="style" class="ng-scope">
			<custom-image alt-key="''network_means_pageType_1_IMAGE_ALT''" image-key="''network_means_pageType_1_IMAGE_DATA''" id="issuerLogo" straight-mode="false"></custom-image>
		</div>
		<div id="pageHeaderRight" ng-style="style" class="ng-scope" >
			<custom-image alt-key="''network_means_pageType_2_IMAGE_ALT''"	image-key="''network_means_pageType_2_IMAGE_DATA''" id="networkLogo" straight-mode="false"></custom-image>
		</div>
	</div>
	<message-banner close-button="''network_means_pageType_174''" back-button="''network_means_pageType_175''"></message-banner>

	<div id="displayLayout" class="row">
		<div id="blue-banner"></div>
	</div>
	<style>
		div#blue-banner {
			height: 50px !important;
			background-color: rgb(18,50,80);
			border-bottom: 5px solid rgb(18,50,80);
			width: 100%;
		}
	</style>
	<div class="contentRow">
		<div x-ms-format-detection="none" class="leftColumn">
			<side-menu menu-title="''network_means_pageType_11''"></side-menu>
		</div>
		<div class="rightColumn">
			<div class="paragraph">
				<custom-text custom-text-key="''network_means_pageType_1''"></custom-text>
			</div>
			<div class="paragraph">
				<custom-text custom-text-key="''network_means_pageType_2''"></custom-text>
			</div>
			<div id="otp-fields-container">
				<div x-ms-format-detection="none" id="otp-fields">
					<pwd-form hide-input="true" min-length="8"></pwd-form>
					<div class="valbtn">
						<val-button id="validateButton" val-label="''network_means_pageType_42''"></val-button>
					</div>
					<div class="paragraph">
						<custom-text custom-text-key="''network_means_pageType_3''" id="paragraph3">
						</custom-text>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="footer">
		<div ng-style="style" class="style">
			<cancel-button cn-label="''network_means_pageType_40''" id="cancelButton"></cancel-button>
			<help help-label="''network_means_pageType_41''" id="helpButton"></help>
		</div>
	</div>
</div>' WHERE `fk_id_layout` = @idPageLayout;