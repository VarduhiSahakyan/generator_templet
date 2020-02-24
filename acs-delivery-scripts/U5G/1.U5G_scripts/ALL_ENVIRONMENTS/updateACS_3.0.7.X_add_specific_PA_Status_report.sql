UPDATE `SpecificReports`
SET `name` = "STATUS_PA_BY_PROFILESET" 
WHERE  `name`= "STATUS_PA_REPORT";

INSERT INTO `SpecificReports` (`name`, `dateFormat`, `displayType`)
SELECT 'STATUS_PA_BY_PROFILESET', 'MMMM YYYY', 'MONTH_ONLY' FROM dual
WHERE NOT EXISTS (SELECT * FROM `SpecificReports` WHERE `name` = 'STATUS_PA_BY_PROFILESET');


INSERT INTO `SpecificReports_Issuer` select s.id, i.id FROM `SpecificReports` s, `Issuer` i where
s.name="STATUS_PA_BY_PROFILESET" AND i.code='18079' 
 AND NOT EXISTS (
					SELECT * FROM `SpecificReports_Issuer` si, `SpecificReports` s, `Issuer` i
					WHERE si.id_specificReport =s.id AND si.id_issuer=i.id
					AND s.`name` = 'STATUS_PA_BY_PROFILESET' AND i.code = '18079'
				);
INSERT INTO `SpecificReports_Issuer` select s.id, i.id FROM `SpecificReports` s, `Issuer` i where
s.name="STATUS_PA_BY_PROFILESET" AND i.code='18719' 
 AND NOT EXISTS (
					SELECT * FROM `SpecificReports_Issuer` si, `SpecificReports` s, `Issuer` i
					WHERE si.id_specificReport =s.id AND si.id_issuer=i.id 
                    AND s.`name` = 'STATUS_PA_BY_PROFILESET' AND i.code = '18719'
				);	
INSERT INTO `SpecificReports_Issuer` select s.id, i.id FROM `SpecificReports` s, `Issuer` i where
s.name="STATUS_PA_BY_PROFILESET" AND i.code='40618' 
 AND NOT EXISTS (
					SELECT * FROM `SpecificReports_Issuer` si, `SpecificReports` s, `Issuer` i
					WHERE si.id_specificReport =s.id AND si.id_issuer=i.id
					AND s.`name` = 'STATUS_PA_BY_PROFILESET' AND i.code = '40618'
				);		