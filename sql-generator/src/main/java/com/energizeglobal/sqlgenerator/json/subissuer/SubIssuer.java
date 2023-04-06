package com.energizeglobal.sqlgenerator.json.subissuer;

import com.energizeglobal.sqlgenerator.json.SubIssuerAuthentMeans;
import com.energizeglobal.sqlgenerator.json.CurrencyFormat;
import com.energizeglobal.sqlgenerator.json.PaChallengePublicUrl;
import com.energizeglobal.sqlgenerator.json.ThreeDS2AdditionalInfo;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.Setter;

import javax.xml.bind.annotation.XmlRootElement;
import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@XmlRootElement
@JsonIgnoreProperties(ignoreUnknown = true)
public class SubIssuer {

    @JsonProperty("acsId")
    private String acsId;

    @JsonProperty("bankName")
    private String bankName;

    @JsonProperty("bankNameShort")
    private String bankNameShort;

    @JsonProperty("authenticationTimeOut")
    private Integer authenticationTimeOut;

    @JsonProperty("backupLanguages")
    private String backupLanguages;

    @JsonProperty("subIssuerCode")
    private String subIssuerCode;

    @JsonProperty("subIssuerCodeSvi")
    private String subIssuerCodeSvi;

    @JsonProperty("currencyCode")
    private String currencyCode;

    @JsonProperty("subIssuerName")
    private String subIssuerName;

    @JsonProperty("defaultLanguage")
    private String defaultLanguage;

    @JsonProperty("freshnessPeriod")
    private String freshnessPeriod;

    @JsonProperty("subIssuerLabel")
    private String subIssuerLabel;

    @JsonProperty("manageBackupsCombinedAmounts")
    private String manageBackupsCombinedAmounts;

    @JsonProperty("manageChoicesCombinedAmounts")
    private String manageChoicesCombinedAmounts;

    @JsonProperty("personnalDataStorage")
    private String personnalDataStorage;

    @JsonProperty("resetBackupsIfSuccess")
    private String resetBackupsIfSuccess;

    @JsonProperty("resetChoicesIfSuccess")
    private String resetChoicesIfSuccess;

    @JsonProperty("transactionTimeOut")
    private String transactionTimeOut;

    @JsonProperty("acs_URL1_VE_MC")
    private String acsUrl1VeMc;

    @JsonProperty("acs_URL2_VE_MC")
    private String acsUrl2VeMc;

    @JsonProperty("acs_URL1_VE_CB")
    private String acsUrl1VeCb;

    @JsonProperty("acs_URL2_VE_CB")
    private String acsUrl2VeCb;

    @JsonProperty("acs_URL1_VE_VISA")
    private String acsUrl1VeVisa;

    @JsonProperty("acs_URL2_VE_VISA")
    private String acsUrl2VeVisa;

    @JsonProperty("automaticDeviceSelection")
    private String automaticDeviceSelection;

    @JsonProperty("userChoiceAllowed")
    private String userChoiceAllowed;

    @JsonProperty("backupAllowed")
    private String backupAllowed;

    @JsonProperty("defaultDeviceChoice")
    private String defaultDeviceChoice;

    @JsonProperty("preferredAuthentMeans")
    private String preferredAuthentMeans;

    @JsonProperty("issuerCountry")
    private String issuerCountry;

    @JsonProperty("hubCallMode")
    private String hubCallMode;

    @JsonProperty("rbaThreshold")
    private String rbaThreshold;

    @JsonProperty("maskParams")
    private String maskParams;

    @JsonProperty("dateFormat")
    private String dateFormat;

    @JsonProperty("formattedDateJavaFormat")
    private String formattedDateJavaFormat;

    @JsonProperty("twoStepCancellation")
    private String twoStepCancellation;

    @JsonProperty("paChallengePublicUrl")
    private PaChallengePublicUrl paChallengePublicUrl;

    @JsonProperty("verifyCardStatus")
    private String verifyCardStatus;

    @JsonProperty("ThreeDS2AdditionalInfoVisaOperatorId")
    private String threeDS2AdditionalInfoVisaOperatorId;

    @JsonProperty("ThreeDS2AdditionalInfoVisaDsKeyAlias")
    private String threeDS2AdditionalInfoVisaDsKeyAlias;

    @JsonProperty("ThreeDS2AdditionalInfoMastercardOperatorId")
    private String threeDS2AdditionalInfoMastercardOperatorId;

    @JsonProperty("ThreeDS2AdditionalInfoMastercardDsKeyAlias")
    private String threeDS2AdditionalInfoMastercardDsKeyAlias;

    @JsonProperty("permanentStrongMeansCounter")
    private Boolean permanentStrongMeansCounter;

    @JsonProperty("digitalAuthFrameworkEnabled")
    private Boolean digitalAuthFrameworkEnabled = false;

    @JsonProperty("resendOTPThreshold")
    private String resendOTPThreshold;

    @JsonProperty("resendSameOTP")
    private String resendSameOTP;

    @JsonProperty("combinedAuthenticationAllowed")
    private String combinedAuthenticationAllowed;

    @JsonProperty("protocol2FlowMode")
    private String protocol2FlowMode;

    @JsonProperty("displayLanguageSelectPage")
    private String displayLanguageSelectPage;

    @JsonProperty("trustedBeneficiariesAllowed")
    private String trustedBeneficiariesAllowed;

    @JsonProperty("subIssuerAuthentMeans")
    private List<SubIssuerAuthentMeans> subIssuerAuthentMeans = new ArrayList<>();

    @JsonProperty("npaEnabled")
    private String npaEnabled;

    @JsonProperty("hubMaintenanceModeEnabled")
    private String hubMaintenanceModeEnabled;

    @JsonProperty("currencyFormat")
    private CurrencyFormat currencyFormat;

    @JsonProperty("ThreeDS2AdditionalInfo")
    private String threeDS2AdditionalInfo;

}
