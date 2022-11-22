USE U5G_ACS_BO;

SELECT * FROM CustomItem c WHERE c.name="VISA_DEFAULT_REFUSAL_HELP_PAGE_3" AND c.fk_id_customItemSet IN (SELECT cis.id FROM CustomItemSet cis, SubIssuer s WHERE cis.fk_id_subIssuer=s.id AND s.code="16600" AND cis.name="customitemset_16600_DEFAULT_REFUSAL");

UPDATE CustomItem c SET c.name=NULL, lastUpdateDate=NOW(),lastUpdateBy="EWLACS3CDT-199" WHERE c.name="VISA_DEFAULT_REFUSAL_HELP_PAGE_3" AND c.fk_id_customItemSet IN (SELECT cis.id FROM CustomItemSet cis, SubIssuer s WHERE cis.fk_id_subIssuer=s.id AND s.code="16600" AND cis.name="customitemset_16600_DEFAULT_REFUSAL");

SELECT * FROM CustomItem c WHERE c.name="VISA_DEFAULT_REFUSAL_HELP_PAGE_3" AND c.fk_id_customItemSet IN (SELECT cis.id FROM CustomItemSet cis, SubIssuer s WHERE cis.fk_id_subIssuer=s.id AND s.code="16600" AND cis.name="customitemset_16600_DEFAULT_REFUSAL");
SELECT * FROM CustomItem c WHERE c.fk_id_customItemSet IN (SELECT cis.id FROM CustomItemSet cis, SubIssuer s WHERE cis.fk_id_subIssuer=s.id AND s.code="16600" AND cis.name="customitemset_16600_DEFAULT_REFUSAL");
