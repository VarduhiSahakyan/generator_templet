use `U5G_ACS_BO`;
set @BankUB = '16600';

start transaction;

update CustomItem
set value = 'Sie haben eine ungültige mobileTAN eingegeben. Nach der dritten falschen TAN-Eingabe in Folge wird Ihr Konto aus Sicherheitsgründen gesperrt. Bitte geben Sie die Ihnen zugesandte mobileTAN erneut ein.'
where fk_id_customItemSet in (select id
                              from `CustomItemSet`
                              where `name` in (CONCAT('customitemset_', @BankUB, '_SMS_1'),
                                               CONCAT('customitemset_', @BankUB, '_SMS_2')))
  and ordinal = 29
  and pageTypes = 'OTP_FORM_PAGE'
  and DTYPE = 'T';

commit;