package com.worldline.acs.crypto.hsm;

import com.worldline.acs.crypto.CryptoManager;
import com.worldline.acs.crypto.CryptoService;
import com.worldline.acs.crypto.av.AVData;
import com.worldline.acs.crypto.av.AVProtocolData;
import com.worldline.acs.crypto.av.AVTransactionStatus;
import com.worldline.acs.crypto.av.avMethod.GenericAVMethod;
import com.worldline.acs.crypto.av.factories.CryptoInputFactory;
import com.worldline.acs.crypto.av.strategies.genericAlgorithms.CVVWithATN;
import com.worldline.acs.crypto.av.strategies.genericAlgorithms.HMACMastercardSPA;
import com.worldline.acs.crypto.av.strategies.genericAlgorithms.MastercardSPA;
import com.worldline.acs.crypto.av.strategies.genericAlgorithms.MastercardSPA2;
import com.worldline.acs.crypto.av.vef.VisaCavvFieldCustomizer;
import com.worldline.acs.crypto.builder.AvHsmRequestBuilder;
import com.worldline.acs.crypto.dto.JwsDto;
import com.worldline.acs.crypto.dto.ParametersFromConfig;
import com.worldline.acs.crypto.dto.ParametersFromSession;
import com.worldline.acs.crypto.exception.CryptoOperationFailedException;
import com.worldline.acs.service.utils.clients.ClientsProperties;
import com.worldline.acs.test.utils.TestUtils;
import com.worldline.acs.utils.enums.AuthentMeans;
import com.worldline.acs.utils.enums.CAVVAlgorithm;
import com.worldline.acs.utils.enums.ProtocolVersion;
import com.worldline.acs.utils.enums.TrnSeqNumGenerationMethod;
import com.worldline.acs.utils.properties.PropertiesKeys;
import net.wl.crys.hsm.api.CryptoServiceFactory;
import net.wl.crys.hsm.api.RequestParameters;
import net.wl.crys.hsm.api.ResponseParameters;
import net.wl.crys.hsm.api.bean.CrysRequest;
import net.wl.crys.hsm.api.bean.CrysResponse;
import net.wl.crys.hsm.api.exception.CryptoException;
import net.wl.crys.hsm.api.util.MultiValueMap;
import net.wl.crys.hsm.bull.MessageBuildingUtils;
import org.jose4j.jws.JsonWebSignature;
import org.jose4j.lang.BouncyCastleProviderHelp;
import org.junit.AfterClass;
import org.junit.Assert;
import org.junit.BeforeClass;
import org.junit.Test;

import java.io.IOException;
import java.math.BigInteger;
import java.security.KeyFactory;
import java.security.PublicKey;
import java.security.spec.RSAPublicKeySpec;
import java.util.Arrays;
import java.util.Base64;

/**
 *
 * @author a187875
 *
 */
public class GenericCryptoManagerTestCase {

    private static CryptoManager cryptoManager ;
    private static CryptoService cryptoService;
    private static net.wl.crys.hsm.api.CryptoService hsmCryptoService;
    private static CVVWithATN cvvWithATN;
    private static VisaCavvFieldCustomizer visaCavvFieldCustomizer;
    private static MastercardSPA mastercardSPA;
    private static MastercardSPA2 mastercardSPA2;
    private static HMACMastercardSPA hmacMastercardSPA;
    private static PublicKey rsaPublicKey;
    private static GenericAVMethod genericAVMethod;

    private static String identifierSignatureKey = "ED11223344554B544F525F42434D435F5F5F00";
    private static String identifierCavvKeyMutuVisaAndMastercard = "2411223344554B434156565F4C42505F5F5F01";

    @BeforeClass
    public static void init() throws Exception {
        hsmCryptoService = CryptoServiceFactory.getNewDefaultInstance();
        hsmCryptoService.init("bnt.properties");


        //Initialize CryptoService
        cryptoService = new GenericCryptoService();
        TestUtils.setFieldValue(cryptoService, "hsmCryptoService", hsmCryptoService);


        //Initialize CVVWithATN bean
        cvvWithATN = new CVVWithATN();
        TestUtils.setFieldValue(cvvWithATN, "cryptoService", cryptoService);
        visaCavvFieldCustomizer = new VisaCavvFieldCustomizer();
        TestUtils.setFieldValue(cvvWithATN, "fieldCustomizer", visaCavvFieldCustomizer);

        //Initialize MastercardSPA bean
        mastercardSPA = new MastercardSPA();
        TestUtils.setFieldValue(mastercardSPA, "cryptoService", cryptoService);

        //Initialize HMACMastercardSPA bean
        hmacMastercardSPA = new HMACMastercardSPA();
        TestUtils.setFieldValue(hmacMastercardSPA, "cryptoService", cryptoService);

        //Initialize MastercardSPA2 bean
        mastercardSPA2 = new MastercardSPA2();
        TestUtils.setFieldValue(mastercardSPA2, "cryptoService", cryptoService);

        //Initialize generic GenericAVMethod
        genericAVMethod = new GenericAVMethod();
        TestUtils.setFieldValue(genericAVMethod, "cvvWithATN", cvvWithATN);
        TestUtils.setFieldValue(genericAVMethod, "hmacMastercardSPA", hmacMastercardSPA);
        TestUtils.setFieldValue(genericAVMethod, "mastercardSPA", mastercardSPA);
        TestUtils.setFieldValue(genericAVMethod, "mastercardSPA2", mastercardSPA2);

        //Initialize generic CryptoManager
        cryptoManager = new GenericCryptoManager();
        TestUtils.setFieldValue(cryptoManager, "cryptoService", cryptoService);
        TestUtils.setFieldValue(cryptoManager, "genericAVMethod", genericAVMethod);


        PropertiesKeys.freeInstance();
        PropertiesKeys.recordProperties(new ClientsProperties());
        PropertiesKeys.validate();
        Assert.assertTrue(BouncyCastleProviderHelp.enableBouncyCastleProvider());
        // Build public Key coming from key Identifier ED11223344554B544F525F42434D435F5F5F00 (identifierSignatureKey)
        final BigInteger modulus = new BigInteger("DCD56537E523B5B75875FCB16A3CA42F2210516CFFAA0920AF9D80A87AEA33FE7C34FC8B547BB3B4EFBC6FFA2918EBD5A330E451D9A5F63F78427041336A1B1D13EDF7C08ADAE3FEAE83075D55C3E7D111D3CD5AC3608637014DF7F7A06BFEEEBD404CB20C7A1FB128D9CDF0DFD23D6BC0470F5FA487C3ED38C146C2688274C139762185F4C391A8011B3F5E38CB9CF74BEBE7E554D017F41AC1923886E279DD9810C8DFC3BBEB5EC31AA528FA3C1C06E746B9239661A5E0CFCC2A5C9BF51CAAFEAB32FC16C83318077AF8E1930554D1169C9FC8737D8C9102E757D3DCF078666D0244B27B643C0C9D555F4997E7CB27241C9ACA702F0B405D2B088F3A7A2E1B", 16);
        final BigInteger exponent = new BigInteger("010001", 16);
        rsaPublicKey = KeyFactory.getInstance("RSA", "BC").generatePublic(new RSAPublicKeySpec(modulus,exponent));
    }

	@AfterClass
	public static void tearDown() throws IOException {
		hsmCryptoService.close();
	}

	@Test
	public void itShouldBuildPublicKey() throws Exception{
		final CrysRequest crysRequestParameters = new CrysRequest();
		crysRequestParameters.addParameter(RequestParameters.Name.KEY_IDENTIFIER, identifierSignatureKey)
				.addParameter(RequestParameters.Name.KEY_EXTERNALIZATION_FORMAT_PUBLIC_KEY_IDENTIFIER, "01");

		CrysResponse crysResponse =  hsmCryptoService.exportAsymmetricPublicKey(crysRequestParameters);

		MultiValueMap<ResponseParameters.Name, String> values = MessageBuildingUtils.getSubParametersAndValuesForResponseParameterName(crysResponse, ResponseParameters.Name.RSA_PUBLIC_KEY);
		String rsaPublicKeyModulus = values.getFirst(ResponseParameters.Name.EMV_RSA_KEY_MODULUS);
		String rsaPublicKeyExponent = values.getFirst(ResponseParameters.Name.EMV_RSA_KEY_PAIR_GENERATION_PUBLIC_KEY_EXPONENT);

		PublicKey publicKey = KeyFactory.getInstance("RSA", "BC").generatePublic(new RSAPublicKeySpec(new BigInteger(rsaPublicKeyModulus, 16),new BigInteger(rsaPublicKeyExponent, 16)));
		Assert.assertTrue(Arrays.equals(publicKey.getEncoded(), rsaPublicKey.getEncoded()));
	}

    @Test
    public void itShouldCreateJwsWithPS256() throws Exception {
        JwsDto jwsDto = new JwsDto();
        jwsDto.setSigningCertificate("a");
        jwsDto.setAuthorityCertificate("a");
        jwsDto.setRootCertificate("a");
        jwsDto.setKey(identifierSignatureKey);
        jwsDto.setDataForJws("test".getBytes());

        String acsSignedContent = cryptoManager.createJWS(jwsDto);

        JsonWebSignature jsonWebSignature = new JsonWebSignature();
        jsonWebSignature.setCompactSerialization(acsSignedContent);
        jsonWebSignature.setKey(rsaPublicKey);
        Assert.assertTrue(jsonWebSignature.verifySignature());
    }

	@Test
	public void itShouldCreateCavvVisaProtocol3DS1() throws CryptoOperationFailedException {
		ParametersFromConfig parametersFromConfig = new ParametersFromConfig();
		parametersFromConfig.setCavvAlgorithm(CAVVAlgorithm.CVV_WITH_ATN);
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
		avProtocolData.setPan("4970375784986949");

		ParametersFromSession parametersFromSession = new ParametersFromSession();
		parametersFromSession.setAuthentMeans(AuthentMeans.OTP_PHONE);
		parametersFromSession.setConvertedAmount("29900");
		parametersFromSession.setIpCountryCode("999");
		parametersFromSession.setMerchantName("MyTestMerchantACS3");
		parametersFromSession.setNetwork("VISA");
		parametersFromSession.setPrincipalNetwork("VISA");
		parametersFromSession.setProtocolVersion(ProtocolVersion.VERSION_1_0_2.getVersion());
		parametersFromSession.setIpValue("127.0.0.1");

		CryptoInputFactory visaFactory = CryptoInputFactory.getInputFactory(parametersFromConfig,avProtocolData, parametersFromSession);

		AVData avData = cryptoManager.generateAV(visaFactory);

		String cavvDecoded = toHex(Base64.getDecoder().decode(avData.getCavv()));

		String authenticationResultCode3DSecure = "00";
		String secondFactorAuthentication = "00";
		String keyIndicator = "01";

		Assert.assertEquals(authenticationResultCode3DSecure, cavvDecoded.substring(0,2));
		Assert.assertEquals(secondFactorAuthentication, cavvDecoded.substring(2,4));
		Assert.assertEquals(keyIndicator, cavvDecoded.substring(4,6));

		String unpredictableNumberOverrided = cavvDecoded.substring(14,26);

		Assert.assertEquals("999", unpredictableNumberOverrided.substring(7,10));
		Assert.assertEquals("4", unpredictableNumberOverrided.substring(10,11));
	}

	@Test
	public void itShouldCreateCavvVisaProtocol3DS2_OTP_SMS() throws CryptoOperationFailedException {
		ParametersFromConfig parametersFromConfig = new ParametersFromConfig();
		parametersFromConfig.setCavvAlgorithm(CAVVAlgorithm.CVV_WITH_ATN);
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
		avProtocolData.setPan("4970375784986949");

		ParametersFromSession parametersFromSession = new ParametersFromSession();
		parametersFromSession.setAuthentMeans(AuthentMeans.OTP_SMS);
		parametersFromSession.setConvertedAmount("29900");
		parametersFromSession.setIpCountryCode("999");
		parametersFromSession.setMerchantName("MyTestMerchantACS3");
		parametersFromSession.setNetwork("VISA");
		parametersFromSession.setPrincipalNetwork("VISA");
		parametersFromSession.setProtocolVersion(ProtocolVersion.VERSION_2_X.getVersion());

		CryptoInputFactory visaFactory = CryptoInputFactory.getInputFactory(parametersFromConfig,avProtocolData, parametersFromSession);

		AVData avData = cryptoManager.generateAV(visaFactory);

		String cavvDecoded = toHex(Base64.getDecoder().decode(avData.getCavv()));

		String authenticationResultCode3DSecure = "00";
		String secondFactorAuthentication = "02";
		String keyIndicator = "01";

		Assert.assertEquals(authenticationResultCode3DSecure, cavvDecoded.substring(0,2));
		Assert.assertEquals(secondFactorAuthentication, cavvDecoded.substring(2,4));
		Assert.assertEquals(keyIndicator, cavvDecoded.substring(4,6));


        AvHsmRequestBuilder avBuilder = AvHsmRequestBuilder.builder()
            .addAccountNumber("4970375784986949")
            .addKeyParameter(identifierCavvKeyMutuVisaAndMastercard)
            .addServiceCode("002")
            .addUnpredictableNumber(cavvDecoded.substring(10,14))
            .useVisaAlgorithm();

		Assert.assertTrue(cryptoService.checkCavvOrCvx2(avBuilder, cavvDecoded.substring(7,10)));
	}

	@Test
	public void itShouldCreateCavvVisaProtocol3DS2_FrictionLess() throws CryptoOperationFailedException {
		ParametersFromConfig parametersFromConfig = new ParametersFromConfig();
		parametersFromConfig.setCavvAlgorithm(CAVVAlgorithm.CVV_WITH_ATN);
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
		avProtocolData.setPan("4970375784986949");

		ParametersFromSession parametersFromSession = new ParametersFromSession();
		parametersFromSession.setAuthentMeans(null);
		parametersFromSession.setConvertedAmount("29900");
		parametersFromSession.setIpCountryCode("999");
		parametersFromSession.setMerchantName("MyTestMerchantACS3");
		parametersFromSession.setNetwork("VISA");
		parametersFromSession.setPrincipalNetwork("VISA");
		parametersFromSession.setProtocolVersion(ProtocolVersion.VERSION_2_X.getVersion());

		CryptoInputFactory visaFactory = CryptoInputFactory.getInputFactory(parametersFromConfig,avProtocolData, parametersFromSession);

		AVData avData = cryptoManager.generateAV(visaFactory);

		String cavvDecoded = toHex(Base64.getDecoder().decode(avData.getCavv()));

		String authenticationResultCode3DSecure = "00";
		String secondFactorAuthentication = "99";
		String keyIndicator = "01";

		Assert.assertEquals(authenticationResultCode3DSecure, cavvDecoded.substring(0,2));
		Assert.assertEquals(secondFactorAuthentication, cavvDecoded.substring(2,4));
		Assert.assertEquals(keyIndicator, cavvDecoded.substring(4,6));

        AvHsmRequestBuilder avBuilder = AvHsmRequestBuilder.builder()
            .addAccountNumber("4970375784986949")
            .addKeyParameter(identifierCavvKeyMutuVisaAndMastercard)
            .addServiceCode("099")
            .addUnpredictableNumber(cavvDecoded.substring(10,14))
            .useVisaAlgorithm();

		Assert.assertTrue(cryptoService.checkCavvOrCvx2(avBuilder, cavvDecoded.substring(7,10)));
	}

	@Test
	public void itShouldCreateCavvMasterCardProtocol3DS1() throws CryptoOperationFailedException {
		ParametersFromConfig parametersFromConfig = new ParametersFromConfig();
		parametersFromConfig.setCavvAlgorithm(CAVVAlgorithm.MASTERCARD_SPA);
		parametersFromConfig.setPrivateKey(identifierCavvKeyMutuVisaAndMastercard);
		parametersFromConfig.setGenerationMethod(TrnSeqNumGenerationMethod.HEX_TIMESTAMP);
		parametersFromConfig.setCavvKeyIndicator("01");
		parametersFromConfig.setSecondFactorAuthenticationCode("00");
		parametersFromConfig.setAcsIdForCrypto("0A");
		parametersFromConfig.setBinKeyIdentifier("1");

		AVProtocolData avProtocolData = new AVProtocolData();
		avProtocolData.setTransactionID("_1556033215267-1556033215259");
		avProtocolData.setPurchaseAmount("29900");
		avProtocolData.setTransactionStatus(AVTransactionStatus.AUTHENTICATION_SUCCESSFUL);
		avProtocolData.setPan("4970375784986949");

		ParametersFromSession parametersFromSession = new ParametersFromSession();
		parametersFromSession.setAuthentMeans(AuthentMeans.OTP_PHONE);
		parametersFromSession.setConvertedAmount("29900");
		parametersFromSession.setIpCountryCode("999");
		parametersFromSession.setMerchantName("MyTestMerchantACS3");
		parametersFromSession.setNetwork("MASTERCARD");
		parametersFromSession.setPrincipalNetwork("MASTERCARD");
		parametersFromSession.setProtocolVersion(ProtocolVersion.VERSION_1_0_2.getVersion());

		CryptoInputFactory masterCardFactory = CryptoInputFactory.getInputFactory(parametersFromConfig,avProtocolData, parametersFromSession);

		AVData avData = cryptoManager.generateAV(masterCardFactory);

		String cavvDecoded = toHex(Base64.getDecoder().decode(avData.getCavv()));

		String authenticationResultCode3DSecure = "8C";
		String merchantName = "99493CC80ED63B72";
		String acsIdentifier = "0A";
		String binKeyIdentifier = "1";
		String authenticationMethod = "1";

		Assert.assertEquals(authenticationResultCode3DSecure, cavvDecoded.substring(0,2));
		Assert.assertEquals(merchantName, cavvDecoded.substring(2,18));
		Assert.assertEquals(acsIdentifier, cavvDecoded.substring(18,20));
		Assert.assertEquals(authenticationMethod, cavvDecoded.substring(20,21));
		Assert.assertEquals(binKeyIdentifier, cavvDecoded.substring(21,22));

	}

	@Test
	public void itShouldCreateUCAFWithMasterCardSpa2() throws  CryptoOperationFailedException{
		ParametersFromConfig parametersFromConfig = new ParametersFromConfig();
		parametersFromConfig.setCavvAlgorithm(CAVVAlgorithm.MASTERCARD_SPA2);
		parametersFromConfig.setPrivateKey("251122334455554341465F4D5554555F414301");
		parametersFromConfig.setGenerationMethod(TrnSeqNumGenerationMethod.HEX_TIMESTAMP);
		parametersFromConfig.setCavvKeyIndicator("03");
		parametersFromConfig.setSecondFactorAuthenticationCode("00");
		parametersFromConfig.setAcsIdForCrypto("0A");
		parametersFromConfig.setBinKeyIdentifier("1");

		AVProtocolData avProtocolData = new AVProtocolData();
		avProtocolData.setPurchaseAmount("29900");
		avProtocolData.setPan("2226400099919520");
		avProtocolData.setTransactionID("b495eb7f-b46b170f-835a-f4618695bbe6");
		avProtocolData.setTransactionStatus(AVTransactionStatus.AUTHENTICATION_SUCCESSFUL);

		ParametersFromSession parametersFromSession = new ParametersFromSession();
		parametersFromSession.setNetwork("MASTERCARD");
		parametersFromSession.setPrincipalNetwork("MASTERCARD");
		parametersFromSession.setProtocolVersion("2.X");
		parametersFromSession.setMerchantName("The Dodgy Dave And Jonty Shop");
		parametersFromSession.setConvertedAmount("123456");
		parametersFromSession.setDsTransId("b495eb7f-b46b170f-835a-f4618695bbe6");

		AVData avData = cryptoManager.generateAV(
				CryptoInputFactory.getInputFactory(parametersFromConfig, avProtocolData, parametersFromSession));

        Assert.assertEquals(28, avData.getCavv().length());
		Assert.assertEquals("xgTc8zXIAAAAAAAAAAAAAAAAAA==", avData.getCavv());

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

        AVData avData = cryptoManager.generateAV(
            CryptoInputFactory.getInputFactory(parametersFromConfig, avProtocolData, parametersFromSession));

        Assert.assertNotNull(avData.getCavv());

        String hmacDecoded = toHex(Base64.getDecoder().decode(avData.getCavv()));

        String aavField1To6WithoutUnpredictableNumber = "8C03F974DEAC2E189C0A115D83";

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

        AVData avData = cryptoManager.generateAV(
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