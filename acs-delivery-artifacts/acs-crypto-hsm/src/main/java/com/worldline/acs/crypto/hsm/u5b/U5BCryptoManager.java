package com.worldline.acs.crypto.hsm.u5b;

import com.worldline.acs.crypto.CryptoManager;
import com.worldline.acs.crypto.av.AVData;
import com.worldline.acs.crypto.av.avMethod.U5BAVMethod;
import com.worldline.acs.crypto.av.factories.CryptoInputFactory;
import com.worldline.acs.crypto.dto.JwsDto;
import com.worldline.acs.crypto.exception.CryptoOperationFailedException;
import com.worldline.acs.crypto.hsm.GenericCryptoManager;
import com.worldline.acs.service.utils.ACSInstance;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;

@ACSInstance({"U5B"})
@ApplicationScoped
public class U5BCryptoManager implements CryptoManager {

    @Inject
    @ACSInstance
    private GenericCryptoManager genericCryptoManager;

    @Inject
    private U5BAVMethod u5BAVMethod;

    @Override
    public AVData generateAV(CryptoInputFactory factory) throws CryptoOperationFailedException {
        return u5BAVMethod.generateAV(factory);
    }

    @Override
    public String createJWS(JwsDto jwsDto) throws CryptoOperationFailedException {
        return genericCryptoManager.createJWS(jwsDto);
    }
}
