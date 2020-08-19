USE `U7G_ACS_BO`;

SET @BankB = 'SWISSKEY';

SET @IssuerCode = '41001';
SET @SubIssuerCodeBEKB = '79000';

set @id_issuer = (SELECT ID from Issuer where CODE = @issuerCode);
set @id_subissuerBEKB = (SELECT ID from SubIssuer where FK_ID_ISSUER = @id_issuer and code = @SubIssuerCodeBEKB);

set @id_profile_setBEKB = (SELECT ID from ProfileSet where FK_ID_SUBISSUER = @id_subissuerBEKB);

SET @NetworkVID = (SELECT `id` FROM `Network` WHERE `code` = 'MASTERCARD');
SET @NetworkID = NULL;

SET FOREIGN_KEY_CHECKS = 0;
-- delete profiles and custom items for sub issuer

delete from CustomItem where FK_ID_CUSTOMITEMSET IS NULL OR id in (select id from (select ci.id from CustomItem ci,
																									 CustomItemSet cis,
																									 Profile p,
																									 Rule r,
																									 ProfileSet_Rule pr
																				   where ci.FK_ID_CUSTOMITEMSET = cis.ID
																					 and p.FK_ID_CUSTOMITEMSETCURRENT = cis.id
																					 and r.FK_ID_PROFILE = p.ID
																					 and pr.ID_RULE = r.ID
																					 and pr.ID_PROFILESET in
																						 (@id_profile_setBEKB)
																					 and (ci.fk_id_network is NULL or ci.fk_id_network = @NetworkVID)
																				  ) as temp);


delete from BinRange_SubIssuer where ID_BINRANGE in (select id from BinRange where FK_ID_PROFILESET in (@id_profile_setBEKB)
																			   and fk_id_network = @NetworkVID);

delete from BinRange where FK_ID_PROFILESET in (@id_profile_setBEKB)
					   and fk_id_network = @NetworkVID;
-- delete subissuer and issuer

delete from Network_SubIssuer where ID_SUBISSUER in (@id_subissuerBEKB)
								and id_network = @NetworkVID;
delete from SubIssuerNetworkCrypto where FK_ID_SUBISSUER in (@id_subissuerBEKB)
									 and fk_id_network = @NetworkVID;

SET FOREIGN_KEY_CHECKS = 1;