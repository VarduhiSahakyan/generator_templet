
INSERT INTO `SpecificReports` (`name`, `dateFormat`, `displayType`)
VALUES ('PA_YES_BY_AUTHENT_MEANS', 'MMMM YYYY', 'MONTH_ONLY');

INSERT INTO `SpecificReports_Issuer` (`id_specificReport`, `id_issuer`) VALUES
((SELECT id FROM SpecificReports WHERE name = 'PA_YES_BY_AUTHENT_MEANS'), (SELECT id FROM Issuer WHERE code = '18079')),
((SELECT id FROM SpecificReports WHERE name = 'PA_YES_BY_AUTHENT_MEANS'), (SELECT id FROM Issuer WHERE code = '18719')),
((SELECT id FROM SpecificReports WHERE name = 'PA_YES_BY_AUTHENT_MEANS'), (SELECT id FROM Issuer WHERE code = '40618'));