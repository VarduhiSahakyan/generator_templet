SELECT id INTO @id_ACCEPT FROM AuthentMeans WHERE NAME = 'ACCEPT';

UPDATE Profile
SET fk_id_AuthentMeans=@id_ACCEPT
WHERE NAME = 'BNP_WM_ACCEPT_01';