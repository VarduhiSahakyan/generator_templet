package com.worldline.acs.crypto.hsm;

import com.worldline.acs.crypto.CryptoBoxDependencyResolver;
import com.worldline.acs.crypto.CryptoService;
import com.worldline.acs.crypto.annotations.CryptoServiceAnnotation;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;

/**
 * It would create dependency of CRYPTO BOX; it will ping crypto box and set status accordingly
 * 
 * @author a187875
 *
 */
@ApplicationScoped
public class CryptoBoxDependencyResolverHsm implements CryptoBoxDependencyResolver {

	@Inject
    @CryptoServiceAnnotation
	private CryptoService cryptoService;

	@Override
	public CryptoService getCryptoService() {
		return cryptoService;
	}
}
