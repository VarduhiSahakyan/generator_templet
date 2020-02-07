/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

USE `U2M_ACS_MONITOR`;

/*!40000 ALTER TABLE `SERVICE_INFO` DISABLE KEYS */;
INSERT INTO `SERVICE_INFO` (`SERVICE_NAME`, `SITE_NAME`, `ACS_ID`, `SCOPE`, `ADDITIONAL_INFO`) VALUES
  ('authent.hub.referential', 'Vendome', 'U5G', 0, '{
  "machineInfo": {
    "tsacsk02v": {
      "additionalInfo": {
        "hub.jks.truststore.file": "SSLKeysRCT.jks",
        "hub.p12.truststore.file": "test-acs.wlp-acs.com.p12",
        "hub.temp.configuration.file": "hub-configs.properties",
        "hub.proxy.host": "proxy-prod.priv.atos.fr",
        "hub.proxy.port": "3128"
      },
      "serviceUrl": "https://ssl-liv-h5g-fo-hub-cr.ita.stg.as8677.net/referential/rest/",
      "servicePort": null,
      "proxyHost": null,
      "proxyPort": null,
      "serverUrl": "https://ssl-liv-h5g-fo-hub-cr.ita.stg.as8677.net",
      "serviceStatus": "OK",
      "serviceStatusInfo": null,
      "serviceDependencies": [],
      "version": "1.1.22-ICG",
      "lastUpdate": 1519899429167
    },
    "tsacsk01v": {
      "additionalInfo": {
        "hub.jks.truststore.file": "SSLKeysRCT.jks",
        "hub.p12.truststore.file": "test-acs.wlp-acs.com.p12",
        "hub.temp.configuration.file": "hub-configs.properties",
        "hub.proxy.host": "proxy-prod.priv.atos.fr",
        "hub.proxy.port": "3128"
      },
      "serviceUrl": "https://ssl-liv-h5g-fo-hub-cr.ita.stg.as8677.net/referential/rest/",
      "servicePort": null,
      "proxyHost": null,
      "proxyPort": null,
      "serverUrl": "https://ssl-liv-h5g-fo-hub-cr.ita.stg.as8677.net",
      "serviceStatus": "OK",
      "serviceStatusInfo": null,
      "serviceDependencies": [],
      "version": "1.1.22-ICG",
      "lastUpdate": 1519899429167
    }
  }
}');

INSERT INTO `SERVICE_INFO` (`SERVICE_NAME`, `SITE_NAME`, `ACS_ID`, `SCOPE`, `ADDITIONAL_INFO`) VALUES
('authent.hub.referential', 'Seclin', 'U5G', 0, '{
  "machineInfo": {
    "tsacsk02s": {
      "additionalInfo": {
        "hub.jks.truststore.file": "SSLKeysRCT.jks",
        "hub.p12.truststore.file": "test-acs.wlp-acs.com.p12",
        "hub.temp.configuration.file": "hub-configs.properties",
        "hub.proxy.host": "proxy-prod.priv.atos.fr",
        "hub.proxy.port": "3128"
      },
      "serviceUrl": "https://ssl-liv-h5g-fo-hub-cr.ita.stg.as8677.net/referential/rest/",
      "servicePort": null,
      "proxyHost": null,
      "proxyPort": null,
      "serverUrl": "https://ssl-liv-h5g-fo-hub-cr.ita.stg.as8677.net",
      "serviceStatus": "OK",
      "serviceStatusInfo": null,
      "serviceDependencies": [],
      "version": "1.1.22-ICG",
      "lastUpdate": 1519899429167
    },
    "tsacsk01s": {
      "additionalInfo": {
        "hub.jks.truststore.file": "SSLKeysRCT.jks",
        "hub.p12.truststore.file": "test-acs.wlp-acs.com.p12",
        "hub.temp.configuration.file": "hub-configs.properties",
        "hub.proxy.host": "proxy-prod.priv.atos.fr",
        "hub.proxy.port": "3128"
      },
      "serviceUrl": "https://ssl-liv-h5g-fo-hub-cr.ita.stg.as8677.net/referential/rest/",
      "servicePort": null,
      "proxyHost": null,
      "proxyPort": null,
      "serverUrl": "https://ssl-liv-h5g-fo-hub-cr.ita.stg.as8677.net",
      "serviceStatus": "OK",
      "serviceStatusInfo": null,
      "serviceDependencies": [],
      "version": "1.1.22-ICG",
      "lastUpdate": 1519899429167
    }
  }
}');

/*!40000 ALTER TABLE `SERVICE_INFO` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;