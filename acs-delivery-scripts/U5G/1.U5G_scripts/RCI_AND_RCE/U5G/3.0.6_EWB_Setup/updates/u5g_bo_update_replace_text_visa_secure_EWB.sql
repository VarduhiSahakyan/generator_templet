use `U5G_ACS_BO`;

set @issuerCode = '00062';
set @updateBy = 'A707825';

set @masterOld = 'Mastercard SecureCode';
set @masterNew = 'Mastercard Identity Check';
set @visaOld = 'Verified by Visa';
set @visaNew = 'VisaSecure';

start transaction;
update CustomItem
set value          = replace(replace(value, @masterOld, @masterNew), @visaOld, @visaNew),
	lastUpdateBy   = @updateBy,
	lastUpdateDate = now()
where fk_id_customItemSet in (select id
							  from `CustomItemSet`
							  where fk_id_subIssuer in (select id
														from SubIssuer
														where fk_id_issuer = (select id from Issuer where code = @issuerCode)))
  and (value like CONCAT('%', @visaOld, '%') or value like CONCAT('%', @masterOld, '%'))
  and DTYPE = 'T';
commit;