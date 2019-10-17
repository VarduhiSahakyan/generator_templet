package com.worldline.acs.crypto.hsm;

import com.worldline.acs.crypto.CryptoService;
import com.worldline.acs.crypto.builder.AvHsmRequestBuilder;
import com.worldline.acs.crypto.builder.Hmac3DHsmRequestBuilder;
import com.worldline.acs.crypto.builder.HmacHsmRequestBuilder;
import com.worldline.acs.crypto.dto.SignatureRequestBuilder;
import com.worldline.acs.crypto.exception.CryptoOperationFailedException;
import com.worldline.acs.crypto.hystrix.CryptoRequestCommand;
import com.worldline.acs.crypto.logs.LogErrors;
import com.worldline.acs.service.utils.ACSInstance;
import com.worldline.acs.utils.logs.error.details.LogErrorDetails;
import net.wl.crys.hsm.api.RequestParameters;
import net.wl.crys.hsm.api.ResponseParameters;
import net.wl.crys.hsm.api.bean.CrysRequest;
import net.wl.crys.hsm.api.bean.CrysResponse;
import net.wl.crys.hsm.api.exception.CryptoException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;

/**
 * Implementation of {CryptoService}.
 * 
 * @author a187875
 *
 */
@ApplicationScoped
@ACSInstance
public class GenericCryptoService implements CryptoService {

    private static final Logger LOGGER = LoggerFactory.getLogger(GenericCryptoService.class);

    private static final String RETURN_CODE = "0000";
    private static final String INITIALIZATION_VECTOR = "00000000000000000000000000000000";

    @Inject
	private net.wl.crys.hsm.api.CryptoService hsmCryptoService;

	/**
	 * default constructor
	 */
	public GenericCryptoService() {
		super();
	}

	@Override
	public String encrypt(String keyIdentifier, String plainText, String initializationVector) throws CryptoOperationFailedException {
		final CrysRequest crysRequestParameters = new CrysRequest();

		crysRequestParameters.addParameter(RequestParameters.Name.PADDING_METHOD, RequestParameters.Value.PADDING_METHOD_PKCS)
				.addParameter(RequestParameters.Name.CIPHER_BLOCK_MODE, RequestParameters.Value.CIPHER_BLOCK_MODE_CBC)
				.addParameter(RequestParameters.Name.KEY_IDENTIFIER, keyIdentifier)
				.addParameter(RequestParameters.Name.INITIALIZATION_VECTOR, initializationVector)
				.addParameter(RequestParameters.Name.SYMMETRIC_CIPHER_DATA, plainText);
		CrysResponse crysResponse = new CryptoRequestCommand<>(() -> {
			try {
				return hsmCryptoService.cipherWithSymmetric(crysRequestParameters);
			} catch (CryptoException e) {
				LOGGER.error(LogErrors.CRYPTO_SERVICE_EXCEPTION_CAUSE_ERROR.getFullMessage("encrypt  (AES)", e.getMessage()));
				LogErrorDetails.errorDetails(e);
				throw new CryptoOperationFailedException(e);
			}
		}).execute();
		return crysResponse.getFirstValueForResponseElementName(ResponseParameters.Name.SYMMETRIC_DATA_CIPHERED);
	}

	@Override
	public String encryptDes(String keyIdentifier, String plainText) throws CryptoOperationFailedException {
		final CrysRequest crysRequestParameters = new CrysRequest();

		crysRequestParameters.addParameter(RequestParameters.Name.PADDING_METHOD, RequestParameters.Value.PADDING_METHOD_1)
				.addParameter(RequestParameters.Name.CIPHER_BLOCK_MODE, RequestParameters.Value.CIPHER_BLOCK_MODE_ECB)
				.addParameter(RequestParameters.Name.KEY_IDENTIFIER, keyIdentifier)
				.addParameter(RequestParameters.Name.INITIALIZATION_VECTOR, INITIALIZATION_VECTOR)
				.addParameter(RequestParameters.Name.SYMMETRIC_CIPHER_DATA, plainText);

		CrysResponse crysResponse = new CryptoRequestCommand<>(() -> {
			try {
				return hsmCryptoService.cipherWithSymmetric(crysRequestParameters);
			} catch (CryptoException e) {
				LOGGER.error(LogErrors.CRYPTO_SERVICE_EXCEPTION_CAUSE_ERROR.getFullMessage("encryptDes", e.getMessage()));
				LogErrorDetails.errorDetails(e);
				throw new CryptoOperationFailedException(e);
			}
		}).execute();
		return crysResponse.getFirstValueForResponseElementName(ResponseParameters.Name.SYMMETRIC_DATA_CIPHERED);
	}

    @Override
	public String generateCavvOrCvx2(AvHsmRequestBuilder builder) {
		final CrysRequest crysRequest = builder.build();
        
		CrysResponse crysResponse = new CryptoRequestCommand<>(() -> {
			try {
				return hsmCryptoService.generateCavvOrCvx2(crysRequest);
			} catch (CryptoException e) {
				LOGGER.error(LogErrors.CRYPTO_SERVICE_EXCEPTION_CAUSE_ERROR.getFullMessage("generateCavvOrCvx2", e.getMessage()));
				LogErrorDetails.errorDetails(e);
				throw new CryptoOperationFailedException(e);
			}
		}).execute();
		return crysResponse.getFirstValueForResponseElementName(ResponseParameters.Name.CRYPTOGRAM_CAVV_CVX2);
	}

	@Override
	public boolean checkCavvOrCvx2(AvHsmRequestBuilder builder, String cavvToVerify) {
		final CrysRequest crysRequestParameters = builder.build();
        crysRequestParameters.addParameter(RequestParameters.Name.CVV_CVX2_CRYPTOGRAM, cavvToVerify);

        CrysResponse crysResponse = new CryptoRequestCommand<>(() -> {
			try {
				return hsmCryptoService.ckeckCavvOrCvx2(crysRequestParameters);
			} catch (CryptoException e) {
				LOGGER.error(LogErrors.CRYPTO_SERVICE_EXCEPTION_CAUSE_ERROR.getFullMessage("ckeckCavvOrCvx2", e.getMessage()));
				LogErrorDetails.errorDetails(e);
				throw new CryptoOperationFailedException(e);
			}
		}).execute();
		if ((crysResponse.getFirstValueForResponseElementName(ResponseParameters.Name.RETURN_CODE).equals(RETURN_CODE))) {
			return true;
		}
		return false;
	}

	@Override
	public String generateHmac(HmacHsmRequestBuilder builderRequest) {
		final CrysRequest crysRequest = builderRequest.build();

		CrysResponse crysResponse;
		crysResponse = new CryptoRequestCommand<>(() -> {
			try {
				return hsmCryptoService.generateHmac(crysRequest);
			} catch (CryptoException e) {
				LOGGER.error(LogErrors.CRYPTO_SERVICE_EXCEPTION_CAUSE_ERROR.getFullMessage("generateHmac", e.getMessage()));
				LogErrorDetails.errorDetails(e);
				throw new CryptoOperationFailedException(e);
			}
		}).execute();
		return crysResponse.getFirstValueForResponseElementName(ResponseParameters.Name.MAC_VALUE);
	}

	@Override
	public String generateHmacSpa3D(Hmac3DHsmRequestBuilder builder) throws CryptoOperationFailedException {
        LOGGER.debug("generateHmacSpa3D, hmacData length = {}", builder.getHmacData().length());

		final CrysRequest crysRequestParameters = builder.build();

		CrysResponse crysResponse;
		crysResponse = new CryptoRequestCommand<>(() -> {
			try {
				return hsmCryptoService.generateHmacSpa3D(crysRequestParameters);
			} catch (CryptoException e) {
				LOGGER.error(LogErrors.CRYPTO_SERVICE_EXCEPTION_CAUSE_ERROR.getFullMessage("generateHmacSpa3D", e.getMessage()));
				LogErrorDetails.errorDetails(e);
				throw new CryptoOperationFailedException(e);
			}
		}).execute();
		return crysResponse.getFirstValueForResponseElementName(ResponseParameters.Name.HMAC_SPA_3D_VALUE);
	}

	@Override
	public String decrypt(String keyIdentifier, String encryptedText, String initializationVector) throws CryptoOperationFailedException {
		final CrysRequest crysRequestParameters = new CrysRequest();
		crysRequestParameters.addParameter(RequestParameters.Name.PADDING_RECOVERY_METHOD_INITIAL_DATA_LENGTH, RequestParameters.Value.PADDING_METHOD_PKCS)
				.addParameter(RequestParameters.Name.CIPHER_BLOCK_MODE, RequestParameters.Value.CIPHER_BLOCK_MODE_CBC)
				.addParameter(RequestParameters.Name.KEY_IDENTIFIER, keyIdentifier)
				.addParameter(RequestParameters.Name.INITIALIZATION_VECTOR, initializationVector)
				.addParameter(RequestParameters.Name.SYMMETRIC_DECIPHER_DATA, encryptedText);

		CrysResponse crysResponse;
		crysResponse = new CryptoRequestCommand<>(() -> {
			try {
				return hsmCryptoService.decipherWithSymmetric(crysRequestParameters);
			} catch (CryptoException e) {
				LOGGER.error(LogErrors.CRYPTO_SERVICE_EXCEPTION_CAUSE_ERROR.getFullMessage("decrypt (AES)", e.getMessage()));
				LogErrorDetails.errorDetails(e);
				throw new CryptoOperationFailedException(e);
			}
		}).execute();
		return crysResponse.getFirstValueForResponseElementName(ResponseParameters.Name.SYMMETRIC_DATA_DECIPHERED);
	}

	@Override
	public boolean getStatus() {
		final CrysRequest crysRequestParameters = new CrysRequest();
		crysRequestParameters.addParameter(RequestParameters.Name.HASH_DATA, "74657374").addParameter(RequestParameters.Name.HASH_ALGORITHM,
				RequestParameters.Value.HASH_ALGORITHM_SHA1);
		CrysResponse crysResponse = new CryptoRequestCommand<>(() -> {
			try {
				return hsmCryptoService.hash(crysRequestParameters);
			} catch (CryptoException e) {
				LOGGER.error(LogErrors.CRYPTO_SERVICE_EXCEPTION_CAUSE_ERROR.getFullMessage(e.getMessage()));
				LogErrorDetails.errorDetails(e);
				throw new CryptoOperationFailedException(e);
			}
		}).execute();

		if (!((crysResponse.getFirstValueForResponseElementName(ResponseParameters.Name.RETURN_CODE).equals(RETURN_CODE)))) {
			LOGGER.error(LogErrors.CRYPTO_SERVICE_BAD_RETURN_CODE.getFullMessage(RETURN_CODE,
					crysResponse.getFirstValueForResponseElementName(ResponseParameters.Name.RETURN_CODE)));
			return false;
		}
		return true;
	}

    @Override
    public String sign(SignatureRequestBuilder builder) throws CryptoOperationFailedException {
        final CrysRequest crysRequestParameters = builder.build();

        CrysResponse crysResponse;
        crysResponse = new CryptoRequestCommand<>(() -> {
            try {
                return hsmCryptoService.generateSignature(crysRequestParameters);
            } catch (CryptoException e) {
                LOGGER.error(LogErrors.CRYPTO_SERVICE_EXCEPTION_CAUSE_ERROR.getFullMessage("generateSignature", e.getMessage()));
                LogErrorDetails.errorDetails(e);
                throw new CryptoOperationFailedException(e);
            }
        }).execute();

        return crysResponse.getFirstValueForResponseElementName(ResponseParameters.Name.SIGNATURE_VALUE);
    }
}