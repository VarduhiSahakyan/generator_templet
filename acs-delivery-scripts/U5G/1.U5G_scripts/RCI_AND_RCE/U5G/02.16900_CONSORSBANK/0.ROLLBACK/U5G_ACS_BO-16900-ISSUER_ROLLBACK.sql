USE `U5G_ACS_BO`;

SET @issuer_code = '16900';
SET @Issuer_id = (SELECT id FROM `Issuer` WHERE `code` = @issuer_code);

SET @subissuer_code = '16900';
SET @subissuer_name = 'Consors';

SET @SubIssuer_id = (SELECT id FROM `SubIssuer` WHERE `code` = @subissuer_code);

-- 0. Standard cleaning procedure

DELETE FROM CustomItem where fk_id_customItemSet IS NULL;

/* 1.CustomItem */

DELETE ci FROM CustomItem ci
                   LEFT JOIN CustomItemSet cs ON ci.fk_id_customItemSet=cs.id
Where cs.fk_id_subIssuer=@SubIssuer_id;

-- delete images

DELETE im FROM Image im
WHERE im.name in ('Consorsbank', 'Consors Mobile APP Logo');



-- 6.ProfileSet_Rule

DELETE psr FROM ProfileSet_Rule psr
                    LEFT JOIN ProfileSet ps ON ps.id=psr.id_profileSet
Where ps.fk_id_subIssuer=@SubIssuer_id;

-- 5.Condition_TransactionStatuses  and Condition_MeansProcessStatuses

DELETE ct FROM Condition_TransactionStatuses ct
                   LEFT JOIN RuleCondition rc ON rc.id=ct.id_condition
                   LEFT JOIN Rule r ON rc.fk_id_rule=r.id
                   LEFT JOIN Profile p ON r.fk_id_profile=p.id
Where p.fk_id_subIssuer=@SubIssuer_id;


DELETE cmp FROM Condition_MeansProcessStatuses cmp
                    LEFT JOIN RuleCondition rc ON rc.id=cmp.id_condition
                    LEFT JOIN Rule r ON rc.fk_id_rule=r.id
                    LEFT JOIN Profile p ON r.fk_id_profile=p.id
Where p.fk_id_subIssuer=@SubIssuer_id;

--  4.RuleCondition and Thresholds
DELETE t FROM Thresholds t
WHERE t.fk_id_condition in (
    SELECT rc.id  FROM RuleCondition rc
                           LEFT JOIN Rule r ON rc.fk_id_rule=r.id
                           LEFT JOIN Profile p ON r.fk_id_profile=p.id
    Where p.fk_id_subIssuer=@SubIssuer_id
);

DELETE rc FROM RuleCondition rc
                   LEFT JOIN Rule r ON rc.fk_id_rule=r.id
                   LEFT JOIN Profile p ON r.fk_id_profile=p.id
Where p.fk_id_subIssuer=@SubIssuer_id;

-- 3.Rule

DELETE r FROM Rule r
                  LEFT JOIN Profile p ON r.fk_id_profile=p.id
Where p.fk_id_subIssuer=@SubIssuer_id;


-- 2.Profile

DELETE p FROM Profile p
Where p.fk_id_subIssuer=@SubIssuer_id;

-- 1.CustomItemSet

DELETE cs FROM CustomItemSet cs
Where cs.fk_id_subIssuer=@SubIssuer_id;

/* Using common image for all SMONEY Bank SubIssuers */

DELETE bs FROM BinRange_SubIssuer bs
Where bs.id_subIssuer=@SubIssuer_id;

DELETE br FROM BinRange br
                   LEFT JOIN ProfileSet ps ON ps.id=br.fk_id_profileSet
Where ps.fk_id_subIssuer=@SubIssuer_id;

SET @DESC_CPL = CONCAT('%',@subissuer_code,'%');
DELETE ccmp FROM CustomComponent ccmp
WHERE ccmp.fk_id_layout IN (SELECT cpl.id FROM CustomPageLayout cpl WHERE cpl.description LIKE @DESC_CPL);

DELETE cp FROM CustomPageLayout_ProfileSet cp
                   LEFT JOIN ProfileSet ps ON ps.id=cp.profileSet_id
Where ps.fk_id_subIssuer=@SubIssuer_id;

SET @DESC_CPL = CONCAT('%',@subissuer_name,'%');
DELETE cpl FROM CustomPageLayout cpl
WHERE cpl.description LIKE @DESC_CPL;

DELETE ps FROM ProfileSet ps
Where ps.fk_id_subIssuer=@SubIssuer_id;

DELETE snc FROM SubIssuerNetworkCrypto snc
Where snc.fk_id_subIssuer=@SubIssuer_id;

DELETE sc FROM SubIssuerCrypto sc
Where sc.fk_id_subIssuer=@SubIssuer_id;

DELETE ns FROM Network_SubIssuer ns
Where ns.id_subIssuer=@SubIssuer_id;

DELETE si FROM SubIssuer si
Where si.id=@SubIssuer_id;

DELETE i FROM Issuer i
Where i.id=@Issuer_id;
