USE U5G_ACS_BO;

SET @createdBy = 'A758582';

UPDATE SubIssuer SET hubMaintenanceModeEnabled = TRUE
WHERE code IN ('16900', '16901');
