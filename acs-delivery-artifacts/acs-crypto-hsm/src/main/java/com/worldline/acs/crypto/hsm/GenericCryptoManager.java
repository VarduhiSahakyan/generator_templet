package com.worldline.acs.crypto.hsm;

import com.worldline.acs.crypto.CryptoManager;
import com.worldline.acs.crypto.CryptoService;
import com.worldline.acs.crypto.annotations.CryptoServiceAnnotation;
import com.worldline.acs.crypto.av.AVData;
import com.worldline.acs.crypto.av.avMethod.GenericAVMethod;
import com.worldline.acs.crypto.av.factories.CryptoInputFactory;
import com.worldline.acs.crypto.dto.*;
import com.worldline.acs.crypto.enums.SignatureAlgorithm;
import com.worldline.acs.crypto.exception.CryptoOperationFailedException;
import com.worldline.acs.crypto.hsm.model.AcsSignedContent;
import com.worldline.acs.crypto.util.CryptoUtils;
import com.worldline.acs.service.utils.ACSInstance;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import java.nio.charset.StandardCharsets;

/**
 * This provides methods to use by PA and it would give call to HSM api internally
 * 
 * @author a187875
 *
 */
@ACSInstance
@ApplicationScoped
public class GenericCryptoManager implements CryptoManager {

	@Inject
    @CryptoServiceAnnotation
	private CryptoService cryptoService;

	@Inject
    private GenericAVMethod genericAVMethod;

	/**
	 * default constructor
	 */
	public GenericCryptoManager() {
		super();
	}

    @Override
    public AVData generateAV(CryptoInputFactory factory) throws CryptoOperationFailedException {
        return genericAVMethod.generateAV(factory);

    }

    @Override
    public String createJWS(JwsDto jwsDto) throws CryptoOperationFailedException {
        AcsSignedContent acsSignedContent = new AcsSignedContent();

        acsSignedContent.constructHeader(jwsDto.getSigningCertificate(),jwsDto.getAuthorityCertificate(),jwsDto.getRootCertificate(),
            SignatureAlgorithm.PS256.getAlgorithmName());

        acsSignedContent.setPayload(jwsDto.getDataForJws());

        SignatureRequestBuilder builder = SignatureRequestBuilder.builder().addDataToBeSigned(acsSignedContent.getSigningInputBytes())
            .defaultRssaPss256Parameters().addKeyIdentifier(jwsDto.getKey());



        final String signature = cryptoService.sign(builder);

        byte[] signatureValueBytes = CryptoUtils.string2Bytes(signature);

        acsSignedContent.setSignatureBytes(signatureValueBytes);

        return acsSignedContent.getCompactSerialization();
    }

}