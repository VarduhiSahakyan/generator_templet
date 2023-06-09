package com.energizeglobal.sqlgenerator.service;

import com.energizeglobal.sqlgenerator.json.*;
import com.energizeglobal.sqlgenerator.json.binrange.BinRange;
import com.energizeglobal.sqlgenerator.json.crypto.AcsBoCrypto;
import com.energizeglobal.sqlgenerator.json.crypto.ProtocolOne;
import com.energizeglobal.sqlgenerator.json.crypto.ProtocolTwo;
import com.energizeglobal.sqlgenerator.json.general.AcsBoGeneral;
import com.energizeglobal.sqlgenerator.json.image.CustomImage;
import com.energizeglobal.sqlgenerator.json.rule.Rule;
import com.energizeglobal.sqlgenerator.json.subissuer.AcsBoSubIssuerConfig;
import com.energizeglobal.sqlgenerator.json.subissuer.SubIssuer;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;
import org.thymeleaf.TemplateEngine;
import org.thymeleaf.context.Context;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;


@Service
@RequiredArgsConstructor
public class InitialScriptService {

    private final TemplateEngine textTemplateEngine;

    private AcsProperties getInitialScriptJsonData01(){
        AcsProperties acsProperties = null;
        try {
            acsProperties = new ObjectMapper().readValue(new ClassPathResource("json/01_Configuration_IAT.json").getFile(), AcsProperties.class);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return acsProperties;
    }

    public AcsProperties getInitialScriptJsonData02(){
        AcsProperties acsProperties = null;
        try {
            acsProperties = new ObjectMapper().readValue(new ClassPathResource("json/02_Profiles.json").getFile(), AcsProperties.class);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return acsProperties;
    }

    public String generateInitialScript01(String sqlMode){
        String initialScript1 = "";
        Context context = new Context();
        AcsProperties acsProperties = getInitialScriptJsonData01();

        AcsBoGeneral general = acsProperties.getAcsBoGeneral();
        context.setVariable("databaseAcsBo", general.getDatabaseAcsBo());
        context.setVariable("createdBy", general.getCreatedBy());
        context.setVariable("updateState", general.getUpdateState());
        context.setVariable("usedSchemes", general.getUsedScheme());
//Issuer
        Issuer issuer = acsProperties.getIssuer();
        context.setVariable("issuerCode", issuer.getCode());
        context.setVariable("issuerName", issuer.getName());
        context.setVariable("issuerLabel", issuer.getLabel());
        context.setVariable("updateMode", issuer.getUpdateMode());
        context.setVariable("issuerAvailaibleAuthentMean", issuer.getAvailaibleAuthentMean());
////CryptoConfig
        AcsBoCrypto crypto = acsProperties.getAcsBoCrypto();
        String protocolOne = crypto.getProtocolOne();
        context.setVariable("protocolOne", protocolOne);
//        context.setVariable("cavvKeyIndicator1", protocolOne.getCavvKeyIndicator());
//        context.setVariable("secondFactorAuthentication1", protocolOne.getSecondFactorAuthentication());
//        context.setVariable("cipherKeyIdentifier1", protocolOne.getCipherKeyIdentifier());
//        context.setVariable("acsIdForCrypto1", protocolOne.getAcsIdForCrypto());
//        context.setVariable("binKeyIdentifier1", protocolOne.getBinKeyIdentifier());
//        context.setVariable("hubAESKey1", protocolOne.getHubAESKey());
//        context.setVariable("informationalData1", protocolOne.getInformationalData());
//        context.setVariable("cardNetworkAlgorithmMapMasterCard1", protocolOne.getCardNetworkAlgorithmMap().getMASTERCARD());
//        context.setVariable("cardNetworkSeqGenerationMethodMapMasterCard1", protocolOne.getCardNetworkSeqGenerationMethodMap().getMASTERCARD());
//        context.setVariable("cardNetworkIdentifierMapMasterCard1", protocolOne.getCardNetworkIdentifierMap().getMASTERCARD());
//        context.setVariable("desCipherKeyIdentifier1", protocolOne.getDesCipherKeyIdentifier());
//        context.setVariable("desKeyId1", protocolOne.getDesKeyId());
//        context.setVariable("cardNetworkSignatureKeyMap1", protocolOne.getCardNetworkSignatureKeyMap().getMASTERCARD());
//        context.setVariable("signingCertificate1", protocolOne.getCardNetworkCertificateMap().getMasterCard().getSigningCertificate());
//        context.setVariable("authorityCertificate1", protocolOne.getCardNetworkCertificateMap().getMasterCard().getAuthorityCertificate());
//        context.setVariable("rootCertificate1", protocolOne.getCardNetworkCertificateMap().getMasterCard().getRootCertificate());

        String protocolTwo = crypto.getProtocolTwo();
        context.setVariable("protocolTwo", protocolTwo);
//        context.setVariable("cavvKeyIndicator2", protocolTwo.getCavvKeyIndicator());
//        context.setVariable("cipherKeyIdentifier2", protocolTwo.getCipherKeyIdentifier());
//        context.setVariable("acsIdForCrypto2", protocolTwo.getAcsIdForCrypto());
//        context.setVariable("binKeyIdentifier2", protocolTwo.getBinKeyIdentifier());
//        context.setVariable("hubAESKey2", protocolTwo.getHubAESKey());
//        context.setVariable("informationalData2", protocolTwo.getInformationalData());
//        context.setVariable("cardNetworkAlgorithmMapMasterCard2", protocolTwo.getCardNetworkAlgorithmMap().getMASTERCARD());
//        context.setVariable("cardNetworkSeqGenerationMethodMapMasterCard2", protocolTwo.getCardNetworkSeqGenerationMethodMap().getMASTERCARD());
//        context.setVariable("cardNetworkIdentifierMapMasterCard2", protocolTwo.getCardNetworkIdentifierMap().getMASTERCARD());
//        context.setVariable("acsSignedContentCertificateMap2", protocolTwo.getAcsSignedContentCertificateKeyMap().getMASTERCARD());
//        context.setVariable("signingCertificate2", protocolTwo.getCardNetworkCertificateMap().getMasterCard().getSigningCertificate());
//        context.setVariable("authorityCertificate2", protocolTwo.getCardNetworkCertificateMap().getMasterCard().getAuthorityCertificate());
//        context.setVariable("rootCertificate2", protocolTwo.getCardNetworkCertificateMap().getMasterCard().getRootCertificate());
          context.setVariable("cryptoDescription", crypto.getCryptoDescription());
//SubIssuer
        SubIssuer subIssuer = acsProperties.getSubIssuer();
        context.setVariable("subIssuer", subIssuer);
//SubIssuerConfig
        AcsBoSubIssuerConfig subIssuerConfig = acsProperties.getAcsBoSubIssuerConfig();
        context.setVariable("subIssuerConfig", subIssuerConfig);
//BinRange
        List<BinRange> binRangeList = acsProperties.getAcsBoBinRange().getBinRanges();
        context.setVariable("binRangeList", binRangeList);
//Image
        List<CustomImage> customImages = acsProperties.getAcsBoImage().getCustomImages();
        context.setVariable("customImages", customImages);
////MerchantPivotList
//        MerchantPivotList merchantPivotList = getInitialScriptJsonData01().getAcsProperties().getMerchantPivotList();
//        context.setVariable("merchantPivotList", merchantPivotList);

        if ("insert".equalsIgnoreCase(sqlMode)) {
            initialScript1 = textTemplateEngine.process("Insert_01_Configuration_IAT", context);
        }
        if ("update".equalsIgnoreCase(sqlMode)){
            initialScript1 = textTemplateEngine.process("Update_01_Configuration_IAT", context);
        }
        return initialScript1;
    }

    public String generateInitialScript02(String sqlMode){

        String initialScript = "";
        Context context = new Context();
        AcsProperties acsProperties = getInitialScriptJsonData02();

        context.setVariable("databaseAcsBo", "U5G_ACS_BO");
        context.setVariable("bankNameShort", acsProperties.getBankNameShort());
        context.setVariable("createdBy", acsProperties.getCreatedBy());
        context.setVariable("updateState", acsProperties.getUpdateState());

        List<Rule> rules = acsProperties.getRules();

        if ("insert".equalsIgnoreCase(sqlMode)) {
            context.setVariable("rules", rules);
            initialScript = textTemplateEngine.process("Insert_02_Profiles", context);
        }
        if ("update".equalsIgnoreCase(sqlMode)){
            for (Rule rule : rules){
                List<CustomItem> filteredItems = new ArrayList<>();
                if (!CollectionUtils.isEmpty(rule.getProfile().getCustomItems())){
                    for (CustomItem customItem : rule.getProfile().getCustomItems()){
                        if ("insert".equalsIgnoreCase(customItem.getUpdateMode()) || "update".equalsIgnoreCase(customItem.getUpdateMode())){
                            filteredItems.add(customItem);
                        }
                    }
                }
                rule.getProfile().setCustomItems(filteredItems);
            }
            context.setVariable("rules", rules);
            initialScript = textTemplateEngine.process("Update_02_Profiles", context);
        }
        return initialScript;
    }
}
