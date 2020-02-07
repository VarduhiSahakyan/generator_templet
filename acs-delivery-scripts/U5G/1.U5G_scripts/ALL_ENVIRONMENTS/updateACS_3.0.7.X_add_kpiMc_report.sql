INSERT INTO `SpecificReports` (`name`, `dateFormat`, `displayType`) VALUES ('KPI_MC_REPORT', 'DD MMMM YYYY', 'DAY_TO_DAY');

INSERT INTO `SpecificReports_Issuer` (`id_specificReport`, `id_issuer`)
    SELECT r.id, i.id
    FROM `SpecificReports` r, `Issuer` i
    WHERE r.name = 'KPI_MC_REPORT';