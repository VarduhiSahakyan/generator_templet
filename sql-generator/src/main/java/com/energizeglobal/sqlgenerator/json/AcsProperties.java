package com.energizeglobal.sqlgenerator.json;

import com.energizeglobal.sqlgenerator.json.binrange.AcsBoBinRange;
import com.energizeglobal.sqlgenerator.json.binrange.BinRange;
import com.energizeglobal.sqlgenerator.json.conditionmeans.ConditionMeansProcessStatus;
import com.energizeglobal.sqlgenerator.json.conditionmeans.ConditionTransactionStatuses;
import com.energizeglobal.sqlgenerator.json.crypto.AcsBoCrypto;
import com.energizeglobal.sqlgenerator.json.customitemset.CustomItemSet;
import com.energizeglobal.sqlgenerator.json.general.AcsBoGeneral;
import com.energizeglobal.sqlgenerator.json.image.AcsBoImage;
import com.energizeglobal.sqlgenerator.json.profile.AcsBoProfile;
import com.energizeglobal.sqlgenerator.json.rule.Rule;
import com.energizeglobal.sqlgenerator.json.rule.RuleCondition;
import com.energizeglobal.sqlgenerator.json.subissuer.AcsBoSubIssuerConfig;
import com.energizeglobal.sqlgenerator.json.subissuer.SubIssuer;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.Setter;

import javax.xml.bind.annotation.XmlRootElement;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@XmlRootElement
@JsonIgnoreProperties(ignoreUnknown = true)
public class AcsProperties implements Serializable {

/////// 01_Configuration_IAT.json properties /////////
    @JsonProperty("propACS_BO_General")
    private AcsBoGeneral acsBoGeneral;

    @JsonProperty("propACS_BO_Issuer")
    private Issuer issuer;

    @JsonProperty("propACS_BO_Crypto")
    private AcsBoCrypto acsBoCrypto;

    @JsonProperty("propACS_BO_SUBISSUER")
    private SubIssuer subIssuer;

    @JsonProperty("propACS_BO_Subissuer_Config")
    private AcsBoSubIssuerConfig acsBoSubIssuerConfig;

    @JsonProperty("propACS_BO_BinRange")
    private AcsBoBinRange acsBoBinRange;

    @JsonProperty("propACS_BO_Image")
    private AcsBoImage acsBoImage;

//////// 02_Profiles.json properties ////////
    @JsonProperty("name")
    private String profileSetName;

    @JsonProperty("createdBy")
    private String createdBy;

    @JsonProperty("updateState")
    private String updateState;

    @JsonProperty("propACS_BO_CustomPageLayout")
    private List<CustomPageLayout> customPageLayout;

    @JsonProperty("propACS_BO_CustomComponent")
    private List<CustomComponent> customComponentList;

    @JsonProperty("propACS_BO_Profile")
    private List<AcsBoProfile> profileArrayList = new ArrayList<>();

    @JsonProperty("propACS_BO_CustomItemSet")
    private List<CustomItemSet> customItemSetList = new ArrayList<>();

    @JsonProperty("rules")
    private List<Rule> rules = new ArrayList<>();

    @JsonProperty("propACS_BO_RuleCondition")
    private List<RuleCondition> ruleConditionList = new ArrayList<>();

    @JsonProperty("propACS_BO_Condition_TransactionStatuses")
    private List<ConditionTransactionStatuses> conditionTransactionStatusesList;

    @JsonProperty("propACS_BO_Condition_MeansProcessStatuses")
    private List<ConditionMeansProcessStatus> conditionMeansProcessStatusList;

    @JsonProperty("propACS_BO_MerchantPivotList")
    private MerchantPivotList merchantPivotList;

    @JsonProperty("propACS_BO_customItem")
    private List<CustomItem> customItemList = new ArrayList<>();

    public String getBankNameShort() {
        String[] subStrings =  this.profileSetName.split("_");
        return subStrings[1];
    }

}
