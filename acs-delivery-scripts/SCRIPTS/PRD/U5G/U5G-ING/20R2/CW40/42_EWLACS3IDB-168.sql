USE `U5G_ACS_BO`;

SET @subIssuerId = (SELECT id FROM SubIssuer WHERE code = '16500');

UPDATE `ProfileSet` SET name = 'PS_16500_01' WHERE fk_id_subIssuer in (@subIssuerId);

INSERT INTO CustomPageLayout_ProfileSet (customPageLayout_id, profileSet_id)
select cpl.id, ps.id
  from CustomPageLayout cpl, ProfileSet ps
    where cpl.description = 'EXT_PASSWORD_APP_VIEW (ING)' and pageType = 'EXT_PASSWORD_APP_VIEW' and ps.name = 'PS_16500_01';
	
	
INSERT INTO CustomPageLayout_ProfileSet (customPageLayout_id, profileSet_id)
select cpl.id, ps.id
  from CustomPageLayout cpl, ProfileSet ps
    where cpl.description = 'MOBILE_APP_EXT_App_View (ING)' and pageType ='MOBILE_APP_EXT_APP_VIEW'and ps.name = 'PS_16500_01';

INSERT INTO CustomPageLayout_ProfileSet (customPageLayout_id, profileSet_id)
select cpl.id, ps.id
  from CustomPageLayout cpl, ProfileSet ps
    where cpl.description = 'SMS_App_View (ING)' and pageType = 'OTP_SMS_EXT_MESSAGE_APP_VIEW' and ps.name = 'PS_16500_01';

INSERT INTO CustomPageLayout_ProfileSet (customPageLayout_id, profileSet_id)
select cpl.id, ps.id
  from CustomPageLayout cpl, ProfileSet ps
    where cpl.description = 'DEVICE_Choice_App_View (ING)' and pageType = 'MOBILE_APP_EXT_APP_VIEW_DEVICE_SELECT' and ps.name = 'PS_16500_01';
