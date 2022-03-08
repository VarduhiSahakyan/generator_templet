USE U5G_ACS_BO;

SELECT * FROM CustomItem c WHERE c.name IS NULL AND c.fk_id_customItemSet IN (SELECT cis.id FROM CustomItemSet cis, SubIssuer s WHERE cis.fk_id_subIssuer=s.id AND s.code="16600" AND cis.name="customitemset_16600_FRAUD_REFUSAL");

UPDATE CustomItem c SET c.name="VISA_FRAUD_REFUSAL_HELP_PAGE_3", lastUpdateDate=NOW(),lastUpdateBy="EWLACS3CDT-199" WHERE c.name IS NULL AND c.fk_id_customItemSet IN (SELECT cis.id FROM CustomItemSet cis, SubIssuer s WHERE cis.fk_id_subIssuer=s.id AND s.code="16600" AND cis.name="customitemset_16600_FRAUD_REFUSAL");

SELECT * FROM CustomItem c WHERE c.name IS NULL AND c.fk_id_customItemSet IN (SELECT cis.id FROM CustomItemSet cis, SubIssuer s WHERE cis.fk_id_subIssuer=s.id AND s.code="16600" AND cis.name="customitemset_16600_FRAUD_REFUSAL");
SELECT * FROM CustomItem c WHERE c.fk_id_customItemSet IN (SELECT cis.id FROM CustomItemSet cis, SubIssuer s WHERE cis.fk_id_subIssuer=s.id AND s.code="16600" AND cis.name="customitemset_16600_FRAUD_REFUSAL");

