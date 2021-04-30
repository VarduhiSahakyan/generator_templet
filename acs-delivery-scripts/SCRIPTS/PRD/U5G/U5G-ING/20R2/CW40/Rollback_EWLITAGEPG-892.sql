USE `U0P_ACS_WS`;

UPDATE `Customer` SET `name` = 'ING'
				WHERE (`customerType` = 'ENTITY'
				AND `name` = 'ING-DE'
				AND `parent_id` = 1)
				OR (`code` = 16500);