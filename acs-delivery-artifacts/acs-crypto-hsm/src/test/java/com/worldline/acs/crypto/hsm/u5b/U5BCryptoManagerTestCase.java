package com.worldline.acs.crypto.hsm.u5b;

import com.worldline.acs.crypto.CryptoManager;
import com.worldline.acs.crypto.CryptoService;
import com.worldline.acs.crypto.av.AVData;
import com.worldline.acs.crypto.av.AVProtocolData;
import com.worldline.acs.crypto.av.AVTransactionStatus;
import com.worldline.acs.crypto.av.avMethod.U5BAVMethod;
import com.worldline.acs.crypto.av.factories.AvAlgorithm;
import com.worldline.acs.crypto.av.factories.CryptoInputFactory;
import com.worldline.acs.crypto.av.strategies.genericAlgorithms.CVVWithATN;
import com.worldline.acs.crypto.av.strategies.genericAlgorithms.HMACMastercardSPA;
import com.worldline.acs.crypto.av.strategies.genericAlgorithms.MastercardSPA;
import com.worldline.acs.crypto.av.strategies.genericAlgorithms.MastercardSPA2;
import com.worldline.acs.crypto.av.strategies.u5b.U5BHMACMastercardSPA;
import com.worldline.acs.crypto.av.strategies.u5b.U5BMastercardSPA2;
import com.worldline.acs.crypto.av.vef.VisaCavvFieldCustomizer;
import com.worldline.acs.crypto.dto.ParametersFromConfig;
import com.worldline.acs.crypto.dto.ParametersFromSession;
import com.worldline.acs.crypto.exception.CryptoOperationFailedException;
import com.worldline.acs.crypto.hsm.GenericCryptoManager;
import com.worldline.acs.crypto.hsm.GenericCryptoService;
import com.worldline.acs.service.utils.clients.ClientsProperties;
import com.worldline.acs.test.utils.TestUtils;
import com.worldline.acs.utils.enums.AuthentMeans;
import com.worldline.acs.utils.enums.CAVVAlgorithm;
import com.worldline.acs.utils.enums.ProtocolVersion;
import com.worldline.acs.utils.enums.TrnSeqNumGenerationMethod;
import com.worldline.acs.utils.properties.PropertiesKeys;
import net.wl.crys.hsm.api.CryptoServiceFactory;
import net.wl.crys.hsm.api.exception.CryptoException;
import org.apache.commons.codec.DecoderException;
import org.jose4j.lang.BouncyCastleProviderHelp;
import org.junit.AfterClass;
import org.junit.Assert;
import org.junit.BeforeClass;
import org.junit.Test;

import java.io.IOException;
import java.util.Base64;

public class U5BCryptoManagerTestCase {

    private static CryptoManager cryptoManager ;
    private static CryptoService cryptoService;
    private static net.wl.crys.hsm.api.CryptoService hsmCryptoService;

    private static U5BCryptoManager u5bCryptoManager;
    private static U5BMastercardSPA2 u5bMastercardSPA2;
    private static U5BHMACMastercardSPA u5BHMACMastercardSPA;
    private static U5BCryptoService u5BCryptoService;
    private static U5BAVMethod u5BAVMethod;

    private static CVVWithATN cvvWithATN;
    private static VisaCavvFieldCustomizer visaCavvFieldCustomizer;
    private static MastercardSPA mastercardSPA;
    private static MastercardSPA2 mastercardSPA2;
    private static HMACMastercardSPA hmacMastercardSPA;

    private static String identifierCavvKeyMutuVisaAndMastercard = "2411223344554B434156565F4C42505F5F5F01";
    private static String identifierCavvKeyBCMC = "251122334455554341465F424E5050465F5F02";

    @BeforeClass
    public static void init() throws Exception {
        hsmCryptoService = CryptoServiceFactory.getNewDefaultInstance();
        hsmCryptoService.init("bnt.properties");


        //Initialize CryptoService
        cryptoService = new GenericCryptoService();
        TestUtils.setFieldValue(cryptoService, "hsmCryptoService", hsmCryptoService);

        //Initialize U5B_CryptoService
        u5BCryptoService = new U5BCryptoService();
        TestUtils.setFieldValue(u5BCryptoService, "genericCryptoService", cryptoService);


        //Initialize CVVWithATN bean
        cvvWithATN = new CVVWithATN();
        visaCavvFieldCustomizer = new VisaCavvFieldCustomizer();
        TestUtils.setFieldValue(cvvWithATN, "cryptoService", cryptoService);
        TestUtils.setFieldValue(cvvWithATN, "fieldCustomizer", visaCavvFieldCustomizer);

        //Initialize MastercardSPA bean
        mastercardSPA = new MastercardSPA();
        TestUtils.setFieldValue(mastercardSPA, "cryptoService", cryptoService);

        //Initialize MastercardSPA bean
        mastercardSPA2 = new MastercardSPA2();
        TestUtils.setFieldValue(mastercardSPA2, "cryptoService", cryptoService);

        //Initialize HMACMastercardSPA bean
        hmacMastercardSPA = new HMACMastercardSPA();
        TestUtils.setFieldValue(hmacMastercardSPA, "cryptoService", cryptoService);

        //Initialize U5BHMACMastercardSPA (BEPAF) bean
        u5BHMACMastercardSPA = new U5BHMACMastercardSPA();
        TestUtils.setFieldValue(u5BHMACMastercardSPA, "cryptoService", u5BCryptoService);

        //Initialize MastercardSPA2 bean
        u5bMastercardSPA2 = new U5BMastercardSPA2();
        TestUtils.setFieldValue(u5bMastercardSPA2, "cryptoService", u5BCryptoService);


        //Initialize specific method pattern for U5B
        u5BAVMethod = new U5BAVMethod();
        TestUtils.setFieldValue(u5BAVMethod, "cvvWithATN", cvvWithATN);
        TestUtils.setFieldValue(u5BAVMethod, "mastercardSPA", mastercardSPA);
        TestUtils.setFieldValue(u5BAVMethod, "hmacMastercardSPA", hmacMastercardSPA);
        TestUtils.setFieldValue(u5BAVMethod, "mastercardSPA2", mastercardSPA2);

        TestUtils.setFieldValue(u5BAVMethod, "u5BMastercardSPA2", u5bMastercardSPA2);
        TestUtils.setFieldValue(u5BAVMethod, "u5BHMACMastercardSPA", u5BHMACMastercardSPA);


        //Initialize generic CryptoManager
        cryptoManager = new GenericCryptoManager();
        TestUtils.setFieldValue(cryptoManager, "cryptoService", cryptoService);
        TestUtils.setFieldValue(cryptoManager, "genericAVMethod", null);


        //Initialize U5B cryptoManager
        u5bCryptoManager = new U5BCryptoManager();
        TestUtils.setFieldValue(u5bCryptoManager, "u5BAVMethod", u5BAVMethod);
        TestUtils.setFieldValue(u5bCryptoManager, "genericCryptoManager", cryptoManager);

        PropertiesKeys.freeInstance();
        PropertiesKeys.recordProperties(new ClientsProperties());
        PropertiesKeys.validate();
        Assert.assertTrue(BouncyCastleProviderHelp.enableBouncyCastleProvider());

    }

    @AfterClass
    public static void tearDown() throws IOException {
        hsmCryptoService.close();
    }

    @Test
    public void itShouldGenerateAVWithSpecificMastercardSpa2() throws CryptoOperationFailedException, DecoderException {
        //TODO : adapt this test after put the specific algorithm MasterCardSpa2 in U5BMastercardSPA2
        ParametersFromConfig parametersFromConfig = new ParametersFromConfig();
        parametersFromConfig.setCavvAlgorithm(CAVVAlgorithm.U5B_MASTERCARD_SPA2);
        parametersFromConfig.setPrivateKey(identifierCavvKeyMutuVisaAndMastercard);
        parametersFromConfig.setGenerationMethod(TrnSeqNumGenerationMethod.STRING_TIMESTAMP);
        parametersFromConfig.setCavvKeyIndicator("01");
        parametersFromConfig.setSecondFactorAuthenticationCode("00");
        parametersFromConfig.setAcsIdForCrypto("0A");
        parametersFromConfig.setBinKeyIdentifier("1");

        AVProtocolData avProtocolData = new AVProtocolData();
        avProtocolData.setTransactionID("_1556033215267-1556033215259");
        avProtocolData.setPurchaseAmount("29900");
        avProtocolData.setTransactionStatus(AVTransactionStatus.AUTHENTICATION_SUCCESSFUL);
        avProtocolData.setPan("5130392860820599");

        ParametersFromSession parametersFromSession = new ParametersFromSession();
        parametersFromSession.setAuthentMeans(AuthentMeans.OTP_SMS);
        parametersFromSession.setConvertedAmount("29900");
        parametersFromSession.setIpCountryCode("999");
        parametersFromSession.setMerchantName("MyTestMerchantACS3");
        parametersFromSession.setNetwork("MASTERCARD");
        parametersFromSession.setPrincipalNetwork("MASTERCARD");
        parametersFromSession.setProtocolVersion(ProtocolVersion.VERSION_2_X.getVersion());

        CryptoInputFactory mastercardFactory = CryptoInputFactory.getInputFactory(parametersFromConfig,avProtocolData, parametersFromSession);

        AVData avData = u5bCryptoManager.generateAV(mastercardFactory);

        AVData avDataExpected = AVData.builder().addCavvValue("FFFFFFFFFFFFFFFFFFFFFFFFFFFF").addCAVVAlgorithm(AvAlgorithm.U5B_MASTERCARD_SPA2).build();

        Assert.assertEquals(avDataExpected.getCavv(),avData.getCavv());
    }

    @Test
    public void itShouldCreateCavvBancontact() throws CryptoOperationFailedException {
        ParametersFromConfig parametersFromConfig = new ParametersFromConfig();
        parametersFromConfig.setCavvAlgorithm(CAVVAlgorithm.U5B_HMAC_MASTERCARD_SPA);
        parametersFromConfig.setPrivateKey(identifierCavvKeyBCMC);
        parametersFromConfig.setGenerationMethod(TrnSeqNumGenerationMethod.HEX_TIMESTAMP);
        parametersFromConfig.setCavvKeyIndicator("02");
        parametersFromConfig.setSecondFactorAuthenticationCode("00");
        parametersFromConfig.setAcsIdForCrypto("03");
        parametersFromConfig.setBinKeyIdentifier("1");

        AVProtocolData avProtocolData = new AVProtocolData();
        avProtocolData.setTransactionID("_1556033215267-1556033215259");
        avProtocolData.setPurchaseAmount("29900");
        avProtocolData.setTransactionStatus(AVTransactionStatus.AUTHENTICATION_SUCCESSFUL);
        avProtocolData.setPan("4970375784986949");

        ParametersFromSession parametersFromSession = new ParametersFromSession();
        parametersFromSession.setAuthentMeans(AuthentMeans.CAP_UCR);
        parametersFromSession.setConvertedAmount("29900");
        parametersFromSession.setIpCountryCode("999");
        parametersFromSession.setMerchantName("MyTestMerchantACS3");
        parametersFromSession.setNetwork("MASTERCARD");
        parametersFromSession.setPrincipalNetwork("MASTERCARD");
        parametersFromSession.setProtocolVersion(ProtocolVersion.VERSION_1_0_2.getVersion());

        CryptoInputFactory banContactFactory = CryptoInputFactory.getInputFactory(parametersFromConfig, avProtocolData, parametersFromSession);

        AVData avData = u5bCryptoManager.generateAV(banContactFactory);

        String hmacDecoded = toHex(Base64.getDecoder().decode(avData.getCavv()));

        String aavField1To6WithoutUnpredictableNumber = "8C99493CC80ED63B7203215D6C";

        Assert.assertEquals((aavField1To6WithoutUnpredictableNumber + hmacDecoded.substring(26,30)), hmacDecoded.substring(0,30));

    }

    @Test
    public void itShouldCreateUCAFWithHmacMastercardSpa() throws CryptoOperationFailedException, CryptoException {
        ParametersFromConfig parametersFromConfig = new ParametersFromConfig();
        parametersFromConfig.setCavvAlgorithm(CAVVAlgorithm.HMAC_MASTERCARD_SPA);
        parametersFromConfig.setPrivateKey("251122334455554341465F4D5554555F414301");
        parametersFromConfig.setAcsIdForCrypto("0A");
        parametersFromConfig.setBinKeyIdentifier("1");
        parametersFromConfig.setGenerationMethod(TrnSeqNumGenerationMethod.HEX_TIMESTAMP);

        AVProtocolData avProtocolData = new AVProtocolData();
        avProtocolData.setPan("2226400099919520");
        avProtocolData.setPurchaseAmount("29900");
        avProtocolData.setTransactionID("b495eb7f-b46b170f-835a-f4618695bbe6");
        avProtocolData.setTransactionStatus(AVTransactionStatus.AUTHENTICATION_SUCCESSFUL);

        ParametersFromSession parametersFromSession = new ParametersFromSession();
        parametersFromSession.setMerchantName("The Dodgy Dave And Jonty Shop");
        parametersFromSession.setAuthentMeans(AuthentMeans.OTP_SMS);

        AVData avData = u5bCryptoManager.generateAV(
            CryptoInputFactory.getInputFactory(parametersFromConfig, avProtocolData, parametersFromSession));

        Assert.assertNotNull(avData.getCavv());

        String hmacDecoded = toHex(Base64.getDecoder().decode(avData.getCavv()));

        String aavField1To6WithoutUnpredictableNumber = "8C03F974DEAC2E189C0A115D6C";

        Assert.assertEquals((aavField1To6WithoutUnpredictableNumber + hmacDecoded.substring(26,30)), hmacDecoded.substring(0,30));
    }

    @Test
    public void itShouldCreateUCAFWithHmacMastercardSpa_3DS2Frictionless() throws CryptoOperationFailedException, CryptoException {
        ParametersFromConfig parametersFromConfig = new ParametersFromConfig();
        parametersFromConfig.setCavvAlgorithm(CAVVAlgorithm.HMAC_MASTERCARD_SPA);
        parametersFromConfig.setPrivateKey("251122334455554341465F4D5554555F414301");
        parametersFromConfig.setAcsIdForCrypto("0A");
        parametersFromConfig.setBinKeyIdentifier("1");
        parametersFromConfig.setGenerationMethod(TrnSeqNumGenerationMethod.HEX_TIMESTAMP);

        AVProtocolData avProtocolData = new AVProtocolData();
        avProtocolData.setPan("2226400099919520");
        avProtocolData.setPurchaseAmount("29900");
        avProtocolData.setTransactionID("b495eb7f-b46b170f-835a-f4618695bbe6");
        avProtocolData.setTransactionStatus(AVTransactionStatus.AUTHENTICATION_SUCCESSFUL);

        ParametersFromSession parametersFromSession = new ParametersFromSession();
        parametersFromSession.setMerchantName("The Dodgy Dave And Jonty Shop");

        AVData avData = u5bCryptoManager.generateAV(
            CryptoInputFactory.getInputFactory(parametersFromConfig, avProtocolData, parametersFromSession));

        Assert.assertNotNull(avData.getCavv());

        String hmacDecoded = toHex(Base64.getDecoder().decode(avData.getCavv()));

        String aavField1To6WithoutUnpredictableNumber = "8C03F974DEAC2E189C0A015D83";

        Assert.assertEquals((aavField1To6WithoutUnpredictableNumber + hmacDecoded.substring(26,30)), hmacDecoded.substring(0,30));
    }

    private String toHex(byte[] byteArrayToConvert){
        StringBuilder result = new StringBuilder();

        for (byte currentByte : byteArrayToConvert) {
            String s = Integer.toHexString(currentByte & (0xff)).toUpperCase();
            if (s.length() == 1) {
                s = "0".concat(s);
            }
            result.append(s);
        }
        return result.toString();
    }
}
