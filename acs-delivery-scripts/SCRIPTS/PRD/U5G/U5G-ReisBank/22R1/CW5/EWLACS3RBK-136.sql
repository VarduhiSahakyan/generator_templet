use U5G_ACS_BO;
set @issuerCode = '10300';

start transaction;

select count(*) as count_specificsReports_Issuer_before_insert from `SpecificReports_Issuer`;
INSERT INTO `SpecificReports_Issuer` (`id_specificReport`, `id_issuer`)
SELECT r.id, i.id
FROM `SpecificReports` r, `Issuer` i
WHERE r.name = 'KPI_MC_REPORT_PROTOCOL_2' and i.code = @issuerCode;

INSERT INTO `SpecificReports_Issuer` (`id_specificReport`, `id_issuer`)
SELECT r.id, i.id
FROM `SpecificReports` r, `Issuer` i
WHERE r.name = 'KPI_VISA_REPORT_PROTOCOL_2' and i.code = @issuerCode;
select count(*) as count_specificsReports_Issuer_after_insert from `SpecificReports_Issuer`;

commit;