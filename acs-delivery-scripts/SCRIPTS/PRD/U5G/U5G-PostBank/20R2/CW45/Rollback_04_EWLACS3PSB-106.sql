
USE `U5G_ACS_BO`;

DELETE FROM `Condition_MeansProcessStatuses` WHERE `id_condition`=470 AND `id_meansProcessStatuses`=526;
INSERT INTO `Condition_MeansProcessStatuses` (`id_condition`, `id_meansProcessStatuses`) VALUES (470, 525);
