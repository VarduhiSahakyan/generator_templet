
USE `U5G_ACS_BO`;

INSERT INTO `Thresholds` (`id`, `isAmountThreshold`, `reversed`, `thresholdType`, `value`, `fk_id_condition`) VALUES
	(2, b'0', b'0', 'UNDER_TRIAL_NUMBER_THRESHOLD', 3, 943),
	(3, b'0', b'0', 'UNDER_TRIAL_NUMBER_THRESHOLD', 2, 957),
	(4, b'0', b'0', 'UNDER_TRIAL_NUMBER_THRESHOLD', 99, 386),
	(5, b'0', b'0', 'UNDER_TRIAL_NUMBER_THRESHOLD', 10, 1016),
	(6, b'0', b'0', 'UNDER_TRIAL_NUMBER_THRESHOLD', 3, 1042);
