
USE `U5G_ACS_BO`;

Update `CustomItem` SET `value` = 'Sie haben eine ungültige TAN eingegeben. Bitte versuchen Sie es erneut.' where `fk_id_customItemSet` in (244,247) and `DTYPE` = 'T' and `ordinal` in (29);

Update `CustomItem` SET `value` = 'Sie haben eine ungültige PIN eingegeben. Bitte versuchen Sie es erneut.' where `fk_id_customItemSet` in (246) and `DTYPE` = 'T' and `ordinal` in (29);