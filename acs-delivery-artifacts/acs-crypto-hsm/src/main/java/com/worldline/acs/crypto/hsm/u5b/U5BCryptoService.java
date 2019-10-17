package com.worldline.acs.crypto.hsm.u5b;

import com.worldline.acs.crypto.CryptoService;
import com.worldline.acs.crypto.builder.AvHsmRequestBuilder;
import com.worldline.acs.crypto.builder.Hmac3DHsmRequestBuilder;
import com.worldline.acs.crypto.builder.HmacHsmRequestBuilder;
import com.worldline.acs.crypto.dto.SignatureRequestBuilder;
import com.worldline.acs.crypto.exception.CryptoOperationFailedException;
import com.worldline.acs.crypto.hsm.GenericCryptoService;
import com.worldline.acs.service.utils.ACSInstance;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;

@ACSInstance("U5B")
@ApplicationScoped
public class U5BCryptoService implements CryptoService {

    @Inject
    @ACSInstance
    private GenericCryptoService genericCryptoService;

    @Override
    public boolean getStatus() {
        return genericCryptoService.getStatus();
    }

    @Override
    public String generateCavvOrCvx2(AvHsmRequestBuilder builder) throws CryptoOperationFailedException {
        return genericCryptoService.generateCavvOrCvx2(builder);
    }

    @Override
    public boolean checkCavvOrCvx2(AvHsmRequestBuilder builder, String cavvToVerify) throws CryptoOperationFailedException {
        return genericCryptoService.checkCavvOrCvx2(builder,cavvToVerify);
    }

    @Override
    public String generateHmac(HmacHsmRequestBuilder input) throws CryptoOperationFailedException {
        return genericCryptoService.generateHmac(input);
    }

    @Override
    public String generateHmacSpa3D(Hmac3DHsmRequestBuilder builder) throws CryptoOperationFailedException {
        return genericCryptoService.generateHmacSpa3D(builder);
    }

    @Override
    public String sign(SignatureRequestBuilder input) throws CryptoOperationFailedException {
        return genericCryptoService.sign(input);
    }

    @Override
    public String encrypt(String keyIdentifier, String plainText, String initializationVector) throws CryptoOperationFailedException {
        return genericCryptoService.encrypt(keyIdentifier,plainText,initializationVector);
    }

    @Override
    public String decrypt(String keyIdentifier, String encryptedText, String initializationVector) throws CryptoOperationFailedException {
        return genericCryptoService.decrypt(keyIdentifier,encryptedText,initializationVector);
    }

    @Override
    public String encryptDes(String keyIdentifier, String plainText) throws CryptoOperationFailedException {
        return genericCryptoService.encryptDes(keyIdentifier,plainText);
    }
}
