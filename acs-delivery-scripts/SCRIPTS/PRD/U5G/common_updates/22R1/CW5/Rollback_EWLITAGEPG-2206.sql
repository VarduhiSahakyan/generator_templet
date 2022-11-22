use U5G_ACS_BO;

start transaction;
SELECT restricted as restricted_before_update FROM Permission WHERE name = 'INSTANCE:WRITE';
UPDATE Permission p
SET restricted = 1
WHERE p.name = 'INSTANCE:WRITE';
SELECT restricted as restricted_after_update FROM Permission WHERE name = 'INSTANCE:WRITE';
commit;