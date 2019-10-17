package com.worldline.acs.crypto.hsm;

import com.worldline.acs.crypto.CryptoService;
import com.worldline.acs.crypto.builder.Hmac3DHsmRequestBuilder;
import com.worldline.acs.crypto.builder.HmacHsmRequestBuilder;
import com.worldline.acs.crypto.dto.SignatureRequestBuilder;
import com.worldline.acs.crypto.exception.CryptoOperationFailedException;
import com.worldline.acs.service.utils.clients.ClientsProperties;
import com.worldline.acs.test.utils.TestUtils;
import com.worldline.acs.utils.properties.PropertiesKeys;
import net.wl.crys.hsm.api.CryptoServiceFactory;
import net.wl.crys.hsm.api.RequestParameters;
import net.wl.crys.hsm.api.ResponseParameters;
import net.wl.crys.hsm.api.bean.CrysRequest;
import net.wl.crys.hsm.api.bean.CrysResponse;
import net.wl.crys.hsm.api.exception.ConfigurationException;
import net.wl.crys.hsm.api.exception.CryptoException;
import net.wl.crys.hsm.api.util.MultiValueMap;
import net.wl.crys.hsm.bull.MessageBuildingUtils;
import net.wl.crys.hsm.bull.ResponseTagsMapping;
import org.apache.commons.codec.DecoderException;
import org.apache.commons.codec.binary.Base64;
import org.apache.commons.codec.binary.Hex;
import org.apache.commons.lang3.StringUtils;
import org.bouncycastle.jce.provider.BouncyCastleProvider;
import org.junit.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.math.BigInteger;
import java.nio.charset.StandardCharsets;
import java.security.*;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.MGF1ParameterSpec;
import java.security.spec.PSSParameterSpec;
import java.security.spec.RSAPublicKeySpec;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.junit.Assert.assertNotNull;

/**
 *
 * @author a187875
 *
 */
@Ignore
public class GenericCryptoServiceTestCase {

	private static final Logger LOGGER = LoggerFactory.getLogger(GenericCryptoServiceTestCase.class);

	private static CryptoService cryptoService;
	private static net.wl.crys.hsm.api.CryptoService hsmCryptoService;
	private static PublicKey rsaPublicKey; //from private Key identifier : ED11223344554B544F525F42434D435F5F5F00

	private static final String pubModulus = "DCD56537E523B5B75875FCB16A3CA42F2210516CFFAA0920AF9D80A87AEA33FE7C34FC8B547BB3B4EFBC6FFA2918EBD5A330E451D9A5F63F78427041336A1B1D13EDF7C08ADAE3FEAE83075D55C3E7D111D3CD5AC3608637014DF7F7A06BFEEEBD404CB20C7A1FB128D9CDF0DFD23D6BC0470F5FA487C3ED38C146C2688274C139762185F4C391A8011B3F5E38CB9CF74BEBE7E554D017F41AC1923886E279DD9810C8DFC3BBEB5EC31AA528FA3C1C06E746B9239661A5E0CFCC2A5C9BF51CAAFEAB32FC16C83318077AF8E1930554D1169C9FC8737D8C9102E757D3DCF078666D0244B27B643C0C9D555F4997E7CB27241C9ACA702F0B405D2B088F3A7A2E1B";
	private static final String pubEexponent = "010001";

	@BeforeClass
	public static void init() throws ConfigurationException, NoSuchFieldException, IllegalAccessException, NoSuchProviderException, NoSuchAlgorithmException, InvalidKeySpecException {
		hsmCryptoService = CryptoServiceFactory.getNewDefaultInstance();
		hsmCryptoService.init("bnt.properties");
		Security.addProvider(new BouncyCastleProvider());
		cryptoService = new GenericCryptoService();
		TestUtils.setFieldValue(cryptoService, "hsmCryptoService", hsmCryptoService);
		PropertiesKeys.freeInstance();
		PropertiesKeys.recordProperties(new ClientsProperties());
		PropertiesKeys.validate();

		rsaPublicKey = KeyFactory.getInstance("RSA", "BC").generatePublic(new RSAPublicKeySpec(new BigInteger(pubModulus, 16),new BigInteger(pubEexponent, 16)));
	}

	@AfterClass
	public static void tearDown() throws IOException {
		hsmCryptoService.close();
	}

	@Test
	public void itShouldGenerateHMACWithSHA256_CompleteStep() throws Exception {
        HmacHsmRequestBuilder requestBuilder = HmacHsmRequestBuilder.builder()
                        .addKeyIdentifier("E9112233445544454B5F504F535442414E4B05")
                        .addHmacData("2226400099919520FFFFB495EB7FB46B170F835AF4618695BBE6943C94EF4F24")
                        .useSha256()
                        .useStepComplete();

		String response = cryptoService.generateHmac(requestBuilder);

		assertNotNull(response);
	}

	@Test
	public void itShouldGenerateHmacSpa3D() throws Exception {
        Hmac3DHsmRequestBuilder builder = Hmac3DHsmRequestBuilder.builder()
                    .addKeyIdentifier("251122334455554341465F4D5554555F414301")
                    .useSha1()
                    .addHmacData("2226400099919520FFFFB495EB7FB46B170F835AF4618695BBE6943C94EF4F24");
		String crysResponse = cryptoService.generateHmacSpa3D(builder);
		System.out.println(crysResponse);
		assertNotNull(crysResponse);
	}

	/**
	 * Cipher AES
	 *
	 * @throws Exception
	 */
	@Test
	public void encryptAESTest() throws Exception {
		// When
		String crysResponse = cryptoService.encrypt("EC11223344554B544F4B5F4D5554555F414301", "112233445566778899001122", "00000000000000000000000000000000");

		// Then
		assertNotNull(crysResponse);
		String decrypt = cryptoService.decrypt("EC11223344554B544F4B5F4D5554555F414301", crysResponse, "00000000000000000000000000000000");
		assertNotNull(decrypt);
	}

	@Test
	public void encryptDESTest() throws Exception {
		// When
		String crysResponse = cryptoService.encryptDes("EC11223344554B544F4B5F4145535F74657300", "112233445566778899001122");

		// Then
		assertNotNull(crysResponse);
		//		String decrypt = cryptoService.decrypt("EC11223344554B544F4B5F4145535F74657300", crysResponse, "00000000000000000000000000000000");
		//		assertNotNull(decrypt);
	}

    @Test
    public void itShouldSignWithRSASSAwithSHA1() throws Exception{
        String tobeSigned = "<PARes id=\"PARes80655\">" + "<version>1.0.2</version>" + "<Merchant>"
            + "<acqBIN>700004</acqBIN>" + "<merID>700004000000148</merID>" + "</Merchant>"
            + "<Purchase><currency>978</currency><date>20151130 15:58:08</date><exponent>2</exponent><purchAmount>1795</purchAmount><xid>MTgxNDQ4ODk5MDg4NTYxMAAAAAA=</xid></Purchase>"
            + "<pan>1448899088704342323</pan>"
            + "<TX><cavv>CAVV HARD CODED VALUE</cavv><cavvAlgorithm>0</cavvAlgorithm><eci>0</eci><status>Y</status><time>1448899088704342323389752821</time></TX>"
            + "<IReq><vendorCode>VendorCode HARD CODED</vendorCode><iReqCode>Req</iReqCode><iReqDetail>ReqDetail HARD CODED</iReqDetail></IReq>"
            + "</PARes>";

        SignatureRequestBuilder builder = SignatureRequestBuilder.builder().addDataToBeSigned(tobeSigned.getBytes())
            .addHashAlgorithm("RSA_SHA1").defaultRsassaParameters().addKeyIdentifier("ED11223344554B544F525F42434D435F5F5F00");

        String signature = cryptoService.sign(builder);

        Signature signatureVerif = Signature.getInstance("SHA1withRSA", new BouncyCastleProvider());
        signatureVerif.initVerify(rsaPublicKey);
        signatureVerif.update(tobeSigned.getBytes());
        Assert.assertTrue(signatureVerif.verify(Hex.decodeHex(signature)));
    }

	@Test
	public void itShouldSignWithRSASSAwithSHA256() throws Exception{
        String tobeSigned = "<PARes id=\"PARes80655\">" + "<version>1.0.2</version>" + "<Merchant>"
            + "<acqBIN>700004</acqBIN>" + "<merID>700004000000148</merID>" + "</Merchant>"
            + "<Purchase><currency>978</currency><date>20151130 15:58:08</date><exponent>2</exponent><purchAmount>1795</purchAmount><xid>MTgxNDQ4ODk5MDg4NTYxMAAAAAA=</xid></Purchase>"
            + "<pan>1448899088704342323</pan>"
            + "<TX><cavv>CAVV HARD CODED VALUE</cavv><cavvAlgorithm>0</cavvAlgorithm><eci>0</eci><status>Y</status><time>1448899088704342323389752821</time></TX>"
            + "<IReq><vendorCode>VendorCode HARD CODED</vendorCode><iReqCode>Req</iReqCode><iReqDetail>ReqDetail HARD CODED</iReqDetail></IReq>"
            + "</PARes>";

        SignatureRequestBuilder builder = SignatureRequestBuilder.builder().addDataToBeSigned(tobeSigned.getBytes())
            .addHashAlgorithm("RSA_SHA256").defaultRsassaParameters().addKeyIdentifier("ED11223344554B544F525F42434D435F5F5F00");


        String signature = cryptoService.sign(builder);

		Signature signatureVerif = Signature.getInstance("SHA256withRSA", new BouncyCastleProvider());
		signatureVerif.initVerify(rsaPublicKey);
		signatureVerif.update(tobeSigned.getBytes());
		Assert.assertTrue(signatureVerif.verify(Hex.decodeHex(signature)));
	}

	@Test
	public void itShouldSignPS256WithLongMessage() throws Exception {
		//This method tests RSASSA-PSS with SHA-256 & MGK-256
		StringBuilder message = new StringBuilder();

		for(int i = 0; i<50; i++){
			message.append("Test PS256 : RSASSA-PSS with SHA-256 & MGK-256 & length salt = 32");
		}

        SignatureRequestBuilder builder = SignatureRequestBuilder.builder().addDataToBeSigned(message.toString().getBytes(StandardCharsets.UTF_8))
            .defaultRssaPss256Parameters().addKeyIdentifier("ED11223344554B544F525F42434D435F5F5F00");


        String signature = cryptoService.sign(builder);

        Signature signatureVerif = Signature.getInstance("SHA256withRSA/PSS", new BouncyCastleProvider());
        signatureVerif.setParameter(new PSSParameterSpec("SHA-256", "MGF1", new MGF1ParameterSpec("SHA-256"), 32, 1));
        signatureVerif.initVerify(rsaPublicKey);
        signatureVerif.update(message.toString().getBytes());
        Assert.assertTrue(signatureVerif.verify(Hex.decodeHex(signature)));
	}

    @Test
    public void itShouldSignPS256WithShortMessage() throws NoSuchAlgorithmException, CryptoOperationFailedException, InvalidAlgorithmParameterException, InvalidKeyException, SignatureException, DecoderException {
        //This method tests RSASSA-PSS with SHA-256 & MGK-256
        StringBuilder message = new StringBuilder().append("Test PS256 : RSASSA-PSS with SHA-256 & MGK-256 & length salt = 32");

        SignatureRequestBuilder builder = SignatureRequestBuilder.builder().addDataToBeSigned(message.toString().getBytes(StandardCharsets.UTF_8))
            .defaultRssaPss256Parameters().addKeyIdentifier("ED11223344554B544F525F42434D435F5F5F00");


        String signature = cryptoService.sign(builder);

        Signature signatureVerif = Signature.getInstance("SHA256withRSA/PSS", new BouncyCastleProvider());
        signatureVerif.setParameter(new PSSParameterSpec("SHA-256", "MGF1", new MGF1ParameterSpec("SHA-256"), 32, 1));
        signatureVerif.initVerify(rsaPublicKey);
        signatureVerif.update(message.toString().getBytes());
        Assert.assertTrue(signatureVerif.verify(Hex.decodeHex(signature)));
    }

	@Test
	public void itShouldCheckCVX2WithHSM() throws CryptoException {
		System.out.println(Hex.encodeHex(Base64.decodeBase64("AJkDBDVXmAAAABVYQ1eYAAAAAAA=")));

		CrysRequest crysRequestParameters = new CrysRequest();
		crysRequestParameters.addParameter(RequestParameters.Name.KEY_IDENTIFIER, "241122334455434156565F4D5554555F414302")
				.addParameter(RequestParameters.Name.CVV_CVX2_ALGORITHM, RequestParameters.Value.CVV_CVX2_ALGORITHM_VISA)
				.addParameter(RequestParameters.Name.PRIMARY_ACCOUNT_NUMBER, "4012000000020022")
				.addParameter(RequestParameters.Name.PAN_EXPIRATION_DATE, "5798")
				.addParameter(RequestParameters.Name.CVV_CVX2_SERVICE_CODE, "099")
				.addParameter(RequestParameters.Name.CVV_CVX2_CRYPTOGRAM, "435");
		CrysResponse resp = hsmCryptoService.ckeckCavvOrCvx2(crysRequestParameters);

		checkAndDisplayResponse(resp);
		assertNotNull(resp);
	}

    @Test
    public void itShouldGenerateHMACSPA2() throws Exception {
        Hmac3DHsmRequestBuilder requestBuilder = Hmac3DHsmRequestBuilder.builder()
            .addKeyIdentifier("251122334455554341465F4D5554555F414301")
            .addHmacData("2226400099919520FFFFB495EB7FB46B170F835AF4618695BBE6943C94EF4F24")
            .useSha256()
            ;

        String response = cryptoService.generateHmacSpa3D(requestBuilder);

        assertNotNull(response);
    }

	private void checkAndDisplayResponse(CrysResponse crysResponse) {
		String responseCode = crysResponse.getFirstValueForResponseElementName(ResponseParameters.Name.RETURN_CODE);
		Assert.assertEquals(ResponseTagsMapping.getResponseParameterValueForTag(ResponseParameters.Value.RETURN_CODE_OK), responseCode);
		for (ResponseParameters.Name responseParameterName : crysResponse.getResponseElementMap().keySet()) {
			if (MessageBuildingUtils.getSubTagsForResponseParameterName(responseParameterName) == null) {
				final List<String> values = crysResponse.getValueForResponseElementName(responseParameterName);
				for (String value : values) {
					Object valueResponse = ResponseTagsMapping.getTagForResponseParameterValue(responseParameterName, value);
					LOGGER.debug("{}({}): {}{}", responseParameterName.name(), ResponseTagsMapping.getResponseParameterNameForTag(responseParameterName), ResponseTagsMapping.getTagForResponseParameterValue(responseParameterName, value)
							.toString(), valueResponse instanceof String ? StringUtils.EMPTY : "(" + value + ")");
				}
			} else {
				final List<ResponseParameters.Name> subTagsForResponseParameterName = MessageBuildingUtils.getSubTagsForResponseParameterName(responseParameterName);
				final List<String> completeValues = crysResponse.getValueForResponseElementName(responseParameterName);
				for (final String completeValue : completeValues) {
					final Map<String, Integer> indexesMap = new HashMap<>();
					final MultiValueMap<ResponseParameters.Name, String> composedObject = MessageBuildingUtils.parseTLV(completeValue);
					LOGGER.debug("{}({}) -> {}", responseParameterName.name(), ResponseTagsMapping.getResponseParameterNameForTag(responseParameterName), completeValue);
					for (ResponseParameters.Name name : subTagsForResponseParameterName) {
						Integer index = indexesMap.get(name.name()) == null ? 0 : indexesMap.get(name.name());
						Object value = composedObject.get(name) == null ? null : composedObject.get(name).get(index);
						Object valueResponse = ResponseTagsMapping.getTagForResponseParameterValue(name, (String) value);
						if (value != null) {
							LOGGER.debug("\t{}({}): {}{}", name.name(), ResponseTagsMapping.getResponseParameterNameForTag(name), valueResponse.toString(), valueResponse instanceof String ?
									StringUtils.EMPTY :
									"(" + value + ")");
						}
						indexesMap.put(name.name(), index + 1);
					}
				}
			}
		}
	}
}
