USE `U5G_ACS_BO`;

SET @locale = "de";
SET @idCustomItemSetSMSFBK =(SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_18502_PB_SMS_Choice');
SET @idCustomItemSetTAFBK =(SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_18502_PB_TA_Choice');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
VALUES
('T' ,'A762688' , NOW() ,NULL ,'MASTERCARD_OTP_SMS_APP_VIEW_MEAN_SELECT_9' ,'PUSHED_TO_CONFIG' ,@locale ,9 ,'APP_VIEW_MEAN_SELECT' ,'mobileTAN' ,NULL , NULL ,@idCustomItemSetSMSFBK),
('T' ,'A762688' , NOW() ,NULL ,'MASTERCARD_MOBILE_APP_APP_VIEW_MEAN_SELECT_9' ,'PUSHED_TO_CONFIG' ,@locale ,9 ,'APP_VIEW_MEAN_SELECT' ,'Kreditkarten-Ident' ,NULL , NULL ,@idCustomItemSetTAFBK);

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
VALUES
('T' ,'A762688' , NOW() ,NULL ,'VISA_OTP_SMS_APP_VIEW_MEAN_SELECT_9' ,'PUSHED_TO_CONFIG' ,@locale ,9 ,'APP_VIEW_MEAN_SELECT' ,'mobileTAN' ,NULL , NULL ,@idCustomItemSetSMSFBK),
('T' ,'A762688' , NOW() ,NULL ,'VISA_MOBILE_APP_APP_VIEW_MEAN_SELECT_9' ,'PUSHED_TO_CONFIG' ,@locale ,9 ,'APP_VIEW_MEAN_SELECT' ,'Kreditkarten-Ident' ,NULL , NULL ,@idCustomItemSetTAFBK);


SET @idCustomItemSetSMSEBK =(SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_18501_PB_SMS_Choice');
SET @idCustomItemSetTAEBK =(SELECT id FROM `CustomItemSet` WHERE `name` = 'customitemset_18501_PB_MOBILE_APP_Choice');

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
VALUES
('T' ,'A762688' , NOW() ,NULL ,'MASTERCARD_OTP_SMS_APP_VIEW_MEAN_SELECT_9' ,'PUSHED_TO_CONFIG' ,@locale ,9 ,'APP_VIEW_MEAN_SELECT' ,'mobileTAN' ,NULL , NULL ,@idCustomItemSetSMSEBK),
('T' ,'A762688' , NOW() ,NULL ,'MASTERCARD_MOBILE_APP_APP_VIEW_MEAN_SELECT_9' ,'PUSHED_TO_CONFIG' ,@locale ,9 ,'APP_VIEW_MEAN_SELECT' ,'BestSign' ,NULL , NULL ,@idCustomItemSetTAEBK);

INSERT INTO `CustomItem` (`DTYPE`, `createdBy`, `creationDate`, `description`, `name`, `updateState`, `locale`, `ordinal`, `pageTypes`, `value`, `fk_id_network`, `fk_id_image`, `fk_id_customItemSet`)
VALUES
('T' ,'A762688' , NOW() ,NULL ,'VISA_OTP_SMS_APP_VIEW_MEAN_SELECT_9' ,'PUSHED_TO_CONFIG' ,@locale ,9 ,'APP_VIEW_MEAN_SELECT' ,'mobileTAN' ,NULL , NULL ,@idCustomItemSetSMSEBK),
('T' ,'A762688' , NOW() ,NULL ,'VISA_MOBILE_APP_APP_VIEW_MEAN_SELECT_9' ,'PUSHED_TO_CONFIG' ,@locale ,9 ,'APP_VIEW_MEAN_SELECT' ,'BestSign' ,NULL , NULL ,@idCustomItemSetTAEBK);