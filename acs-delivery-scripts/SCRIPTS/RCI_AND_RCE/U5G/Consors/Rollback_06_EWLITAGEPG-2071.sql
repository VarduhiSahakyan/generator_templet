USE U5G_ACS_BO;

SET @createdBy = 'A758582';

UPDATE SubIssuer SET hubMaintenanceModeEnabled = FALSE
WHERE code IN ('16900', '16901');
