/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

USE `U2M_ACS_MONITOR`;

DROP TABLE IF EXISTS `SERVICE_INFO`;
CREATE TABLE `SERVICE_INFO` (
  `SERVICE_NAME` VARCHAR(45) NOT NULL,
  `SITE_NAME` VARCHAR(45) NOT NULL,
  `ACS_ID` VARCHAR(45) NOT NULL DEFAULT 'ANY',
  `ADDITIONAL_INFO` TEXT NULL,
  `SCOPE` INT(11) NULL DEFAULT '0',
  PRIMARY KEY (`SERVICE_NAME`, `SITE_NAME`, `ACS_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*
   - In internal acceptance, there is only one site ('Vendome')
   - Pay close attention to the hazelcast's "hazelcast.client.addresses", mostly the ports to be used
     (in internal acceptance, use the port 8207	(matched to u2h	fo-hazelcast)
   - Also pay attention to the "authent.hub" and its serviceUrl/serverUrl
*/
/*!40000 ALTER TABLE `SERVICE_INFO` DISABLE KEYS */;
INSERT INTO `SERVICE_INFO` (`SERVICE_NAME`, `SITE_NAME`, `ACS_ID`, `SCOPE`, `ADDITIONAL_INFO`) VALUES
  ('authent.hub', 'Vendome', 'U5G', 0, '{
  "machineInfo": {
    "tqacsk02v": {
      "additionalInfo": {
        "hub.jks.truststore.file": "SSLKeysRCT.jks",
        "hub.p12.truststore.file": "test-acs.wlp-acs.com.p12",
        "hub.temp.configuration.file": "hub-configs.properties",
        "hub.proxy.host": "proxy-prod.priv.atos.fr",
        "hub.proxy.port": "3128"
      },
      "serviceUrl": "https://ssl-qlf-h0g-fo-hub-cpr-h5g.ita.stg.as8677.net/proxy/rest",
      "servicePort": null,
      "proxyHost": null,
      "proxyPort": null,
      "serverUrl": "https://ssl-qlf-h0g-fo-hub-cpr-h5g.ita.stg.as8677.net/proxy/rest",
      "serviceStatus": "OK",
      "serviceStatusInfo": null,
      "serviceDependencies": [],
      "version": "1.1.22-ICG"
    },
    "tqacsk01v": {
      "additionalInfo": {
        "hub.jks.truststore.file": "SSLKeysRCT.jks",
        "hub.p12.truststore.file": "test-acs.wlp-acs.com.p12",
        "hub.temp.configuration.file": "hub-configs.properties",
        "hub.proxy.host": "proxy-prod.priv.atos.fr",
        "hub.proxy.port": "3128"
      },
      "serviceUrl": "https://ssl-qlf-h0g-fo-hub-cpr-h5g.ita.stg.as8677.net/proxy/rest",
      "servicePort": null,
      "proxyHost": null,
      "proxyPort": null,
      "serverUrl": "https://ssl-qlf-h0g-fo-hub-cpr-h5g.ita.stg.as8677.net/proxy/rest",
      "serviceStatus": "OK",
      "serviceStatusInfo": null,
      "serviceDependencies": [],
      "version": "1.1.22-ICG"
    }
  }
}'),
  ('flash', 'Vendome', 'U5G', 0, '{
  "machineInfo": {
    "tqacsk02v": {
      "additionalInfo": {
        "flash.server.url": "http://flash.ext.ita.rocks/flash",
        "flash.proxy.host": "",
        "flash.proxy.port": "",
        "flash.connect.timeout": "300",
        "flash.read.timeout": "300",
        "flash.key.store.file": "/MIDDLE/u5g_wlpacs/u5g-fo-acs-hzcmod/jboss/modules/acs3/com/worldline/acs/configuration/session/main/properties/test-acs.wlp-acs.com.p12",
        "flash.key.store.type": "PKCS12",
        "flash.key.store.password": "eXepbED4hIjdMrhysqkj",
        "flash.initial.delay": "1000",
        "flash.min.aleatory": "10",
        "flash.max.aleatory": "100",
        "flash.max.tryouts": "20",
        "flash.coefficient": "2.0",
        "flash.unsecure.mode": "true",
        "flash.collection.id.pages": "acs-ux-rbu3-u5g",
        "flash.collection.id.session": "acs-authentication-rbu3-u5g"
      },
      "serviceUrl": "http://flash.ext.ita.rocks/flash",
      "servicePort": null,
      "proxyHost": "proxy-prod.priv.atos.fr",
      "proxyPort": "3128",
      "serverUrl": "http://flash.ext.ita.rocks/flash",
      "serviceStatus": "OK",
      "version": "2.5.1",
      "serviceStatusInfo": null,
      "serviceDependencies": []
    },
    "tqacsk01v": {
      "additionalInfo": {
        "flash.server.url": "http://flash.ext.ita.rocks/flash",
        "flash.proxy.host": "",
        "flash.proxy.port": "",
        "flash.connect.timeout": "300",
        "flash.read.timeout": "300",
        "flash.key.store.file": "/MIDDLE/u5g_wlpacs/u5g-fo-acs-hzcmod/jboss/modules/acs3/com/worldline/acs/configuration/session/main/properties/test-acs.wlp-acs.com.p12",
        "flash.key.store.type": "PKCS12",
        "flash.key.store.password": "eXepbED4hIjdMrhysqkj",
        "flash.initial.delay": "1000",
        "flash.min.aleatory": "10",
        "flash.max.aleatory": "100",
        "flash.max.tryouts": "20",
        "flash.coefficient": "2.0",
        "flash.unsecure.mode": "true",
        "flash.collection.id.pages": "acs-ux-rbu3-u5g",
        "flash.collection.id.session": "acs-authentication-rbu3-u5g"
      },
      "serviceUrl": "http://flash.ext.ita.rocks/flash",
      "servicePort": null,
      "proxyHost": "proxy-prod.priv.atos.fr",
      "proxyPort": "3128",
      "serverUrl": "http://flash.ext.ita.rocks/flash",
      "serviceStatus": "OK",
      "version": "2.5.1",
      "serviceStatusInfo": null,
      "serviceDependencies": []
    }
  }
}'),
  ('hazelcast', 'Vendome', 'U5G', 0, '{
  "machineInfo": {
    "tqacsk01v": {
      "additionalInfo": {
        "hazelcast.client.reconnection.timeout": "5000",
        "hazelcast.client.addresses": "10.72.38.52:8207;10.72.39.5:8207",
        "hazelcast.client.shuffle.addresses": "false",
        "hazelcast.client.group.pass": "dev-pass",
        "hazelcast.client.reconnection.attempts.limit": "10",
        "hazelcast.client.connection.timeout": "3000",
        "hazelcast.client.update.automatic": "true",
        "hazelcast.client.connection.attempts.limit": "3",
        "hazelcast.client.group.name": "dev"
      },
      "serviceUrl": "http://10.72.38.52",
      "serverUrl": "http://10.72.38.52",
      "servicePort": null,
      "proxyHost": null,
      "proxyPort": null,
      "serviceStatus": "OK",
      "version": "2.5.1"
    },
    "tqacsk02v": {
      "additionalInfo": {
        "hazelcast.client.reconnection.timeout": "5000",
        "hazelcast.client.addresses": "10.72.38.52:8207;10.72.39.5:8207",
        "hazelcast.client.shuffle.addresses": "false",
        "hazelcast.client.group.pass": "dev-pass",
        "hazelcast.client.reconnection.attempts.limit": "10",
        "hazelcast.client.connection.timeout": "3000",
        "hazelcast.client.update.automatic": "true",
        "hazelcast.client.connection.attempts.limit": "3",
        "hazelcast.client.group.name": "dev"
      },
      "serviceUrl": "http://10.72.39.5",
      "serverUrl": "http://10.72.39.5",
      "servicePort": null,
      "proxyHost": null,
      "proxyPort": null,
      "serviceStatus": "OK",
      "version": "2.5.1"
    }
  }
}') ,
  ('babel.ua', 'Vendome', 'ANY', 0,
                                   '{
  "machineInfo": {
    "tqacsk01v": {
      "additionalInfo": {},
      "serviceUrl": "http://babel.int.ita.rocks/user-agent/rest",
      "serverUrl": "http://babel.int.ita.rocks/user-agent/rest",
      "servicePort": null,
      "proxyHost": null,
      "proxyPort": null,
      "serviceStatus": "OK",
      "version": "1.2.3"
    },
    "tqacsk02v": {
      "additionalInfo": {},
      "serviceUrl": "http://babel.int.ita.rocks/user-agent/rest",
      "serverUrl": "http://babel.int.ita.rocks/user-agent/rest",
      "servicePort": null,
      "proxyHost": null,
      "proxyPort": null,
      "serviceStatus": "OK",
      "version": "1.2.3"
    }
  }
}') ,
  ('babel.rates', 'Vendome', 'ANY', 0,
                                   '{
  "machineInfo": {
    "tqacsk01v": {
      "additionalInfo": {},
      "serviceUrl": "http://babel.int.ita.rocks/currency-rate/rest",
      "serverUrl": "http://babel.int.ita.rocks/currency-rate/rest",
      "servicePort": null,
      "proxyHost": null,
      "proxyPort": null,
      "serviceStatus": "OK",
      "version": "1.2.3"
    },
    "tqacsk02v": {
      "additionalInfo": {},
      "serviceUrl": "http://babel.int.ita.rocks/currency-rate/rest",
      "serverUrl": "http://babel.int.ita.rocks/currency-rate/rest",
      "servicePort": null,
      "proxyHost": null,
      "proxyPort": null,
      "serviceStatus": "OK",
      "version": "1.2.3"
    }
  }
}') ,
  ('babel.ip', 'Vendome', 'ANY',  0,
   '{
  "machineInfo": {
    "tqacsk01v": {
      "additionalInfo": {},
      "serviceUrl": "http://babel.int.ita.rocks/ip-to-location/rest",
      "serverUrl": "http://babel.int.ita.rocks/ip-to-location/rest",
      "servicePort": null,
      "proxyHost": null,
      "proxyPort": null,
      "serviceStatus": "OK",
      "version": "1.2.3"
    },
    "tqacsk02v": {
      "additionalInfo": {},
      "serviceUrl": "http://babel.int.ita.rocks/ip-to-location/rest",
      "serverUrl": "http://babel.int.ita.rocks/ip-to-location/rest",
      "servicePort": null,
      "proxyHost": null,
      "proxyPort": null,
      "serviceStatus": "OK",
      "version": "1.2.3"
    }
  }
}'),
  ('babel.currencies', 'Vendome', 'ANY', 0,
   '{
  "machineInfo": {
    "tqacsk01v": {
      "additionalInfo": {},
      "serviceUrl": "http://babel.int.ita.rocks/currency/rest",
      "serverUrl": "http://babel.int.ita.rocks/currency/rest",
      "servicePort": null,
      "proxyHost": null,
      "proxyPort": null,
      "serviceStatus": "OK",
      "version": "1.2.3"
    },
    "tqacsk02v": {
      "additionalInfo": {},
      "serviceUrl": "http://babel.int.ita.rocks/currency/rest",
      "serverUrl": "http://babel.int.ita.rocks/currency/rest",
      "servicePort": null,
      "proxyHost": null,
      "proxyPort": null,
      "serviceStatus": "OK",
      "version": "1.2.3"
    }
  }
}'
  );

/*!40000 ALTER TABLE `SERVICE_INFO` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;