package com.worldline.acs.crypto.hsm;

import java.io.InputStream;

import javax.enterprise.context.ApplicationScoped;
import javax.enterprise.inject.Produces;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.worldline.acs.utils.logs.error.details.LogErrorDetails;

import net.wl.crys.hsm.api.CryptoService;
import net.wl.crys.hsm.api.CryptoServiceFactory;
import net.wl.crys.hsm.api.exception.ConfigurationException;
import net.wl.crys.hsm.api.exception.CryptoException;

/**
 * provide instance of crypto hsm service.
 * 
 * @author a187875
 *
 */
public class HsmCryptoServiceProducer {
	
	private static final String FILE_NAME = "bnt.properties";
	private static final Logger LOGGER = LoggerFactory.getLogger(HsmCryptoServiceProducer.class);
	
	/**
	 * default constructor
	 */
	public HsmCryptoServiceProducer()
	{
		//default constructor
	}
	
	/**
	 * provide instance of crypto hsm service.
	 * 
	 * @return
	 * @throws CryptoException
	 */
	@Produces
	@ApplicationScoped
	public CryptoService getCryptoService() throws CryptoException
	{
		try {
			CryptoService hsmCryptoService = CryptoServiceFactory.getNewDefaultInstance();
			InputStream resourceAsStream = Thread.currentThread().getContextClassLoader().getResourceAsStream(FILE_NAME);
			LOGGER.info(" in HsmCryptoServiceProducer..." +resourceAsStream);
			hsmCryptoService.init(resourceAsStream);
			return hsmCryptoService;
		} catch (ConfigurationException e) {
			LogErrorDetails.errorDetails(e);
			throw new CryptoException(e.getMessage());
		}
	}
}
