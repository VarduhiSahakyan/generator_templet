use U5G_ACS_BO;
set @issuerCode = '10300';
set @issuerId = (select id from `Issuer` i where i.code = @issuerCode);
set @reportKPIVisaId = (select id from `SpecificReports` r where r.name = 'KPI_VISA_REPORT_PROTOCOL_2');
set @reportKPIMCId = (select id from `SpecificReports` r where r.name = 'KPI_MC_REPORT_PROTOCOL_2');

start transaction;

select count(*) as count_specificsReports_Issuer_before_delete from `SpecificReports_Issuer`;
DELETE FROM `SpecificReports_Issuer`
WHERE id_specificReport in (@reportKPIVisaId,@reportKPIMCId) and id_issuer = @issuerId;
select count(*) as count_specificsReports_Issuer_after_delete from `SpecificReports_Issuer`;

commit;