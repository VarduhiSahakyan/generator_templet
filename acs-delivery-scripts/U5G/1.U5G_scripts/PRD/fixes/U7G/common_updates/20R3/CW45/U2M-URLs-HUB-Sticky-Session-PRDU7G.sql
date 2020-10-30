USE U2M_ACS_MONITOR;

DELETE FROM `SERVICE_INFO` WHERE `SERVICE_NAME` IN ('authent.hub.seclin', 'authent.hub.vendome') and `ACS_ID` IN ('U7G');

INSERT INTO `SERVICE_INFO` (`SERVICE_NAME`, `SITE_NAME`, `ACS_ID`, `ADDITIONAL_INFO`, `SCOPE`) VALUES ('authent.hub.seclin', 'Brussels', 'U7G', '{
	"machineInfo": {
	"tpacsk01b": {
		"additionalInfo": {
		"hub.jks.truststore.file": "EntrustJKS.jks",
		"hub.p12.truststore.file": "u7g.fo.wlp-acs.com.p12",
		"hub.temp.configuration.file": "hub-configs.properties",
		"hub.proxy.host": "proxy-prod-acs.brs.svc.meshcore.net",
		"hub.proxy.port": "3128"
		},
		"serviceUrl": "https://ssl-prd-h0g-fo-hub-cpr-sticky-scl.ita.stg.as8677.net/proxy/rest/",
		"servicePort": null,
		"proxyHost": null,
		"proxyPort": null,
		"serverUrl": "https://ssl-prd-h0g-fo-hub-cpr-sticky-scl.ita.stg.as8677.net/proxy/rest/",
		"serviceStatus": "OK",
		"serviceStatusInfo": null,
		"serviceDependencies": [

		],
		"version": "1.1.22-ICG"
	},
	"tpacsk02b": {
		"additionalInfo": {
		"hub.jks.truststore.file": "EntrustJKS.jks",
		"hub.p12.truststore.file": "u7g.fo.wlp-acs.com.p12",
		"hub.temp.configuration.file": "hub-configs.properties",
		"hub.proxy.host": "proxy-prod-acs.brs.svc.meshcore.net",
		"hub.proxy.port": "3128"
		},
		"serviceUrl": "https://ssl-prd-h0g-fo-hub-cpr-sticky-scl.ita.stg.as8677.net/proxy/rest/",
		"servicePort": null,
		"proxyHost": null,
		"proxyPort": null,
		"serverUrl": "https://ssl-prd-h0g-fo-hub-cpr-sticky-scl.ita.stg.as8677.net/proxy/rest/",
		"serviceStatus": "OK",
		"serviceStatusInfo": null,
		"serviceDependencies": [

		],
		"version": "1.1.22-ICG"
	},
	"tpacsk03b": {
		"additionalInfo": {
		"hub.jks.truststore.file": "EntrustJKS.jks",
		"hub.p12.truststore.file": "u7g.fo.wlp-acs.com.p12",
		"hub.temp.configuration.file": "hub-configs.properties",
		"hub.proxy.host": "proxy-prod-acs.brs.svc.meshcore.net",
		"hub.proxy.port": "3128"
		},
		"serviceUrl": "https://ssl-prd-h0g-fo-hub-cpr-sticky-scl.ita.stg.as8677.net/proxy/rest/",
		"servicePort": null,
		"proxyHost": null,
		"proxyPort": null,
		"serverUrl": "https://ssl-prd-h0g-fo-hub-cpr-sticky-scl.ita.stg.as8677.net/proxy/rest/",
		"serviceStatus": "OK",
		"serviceStatusInfo": null,
		"serviceDependencies": [

		],
		"version": "1.1.22-ICG"
	},
	"tpacsk04b": {
		"additionalInfo": {
		"hub.jks.truststore.file": "EntrustJKS.jks",
		"hub.p12.truststore.file": "u7g.fo.wlp-acs.com.p12",
		"hub.temp.configuration.file": "hub-configs.properties",
		"hub.proxy.host": "proxy-prod-acs.brs.svc.meshcore.net",
		"hub.proxy.port": "3128"
		},
		"serviceUrl": "https://ssl-prd-h0g-fo-hub-cpr-sticky-scl.ita.stg.as8677.net/proxy/rest/",
		"servicePort": null,
		"proxyHost": null,
		"proxyPort": null,
		"serverUrl": "https://ssl-prd-h0g-fo-hub-cpr-sticky-scl.ita.stg.as8677.net/proxy/rest/",
		"serviceStatus": "OK",
		"serviceStatusInfo": null,
		"serviceDependencies": [

		],
		"version": "1.1.22-ICG"
	}
	}
}', '0');

INSERT INTO `SERVICE_INFO` (`SERVICE_NAME`, `SITE_NAME`, `ACS_ID`, `ADDITIONAL_INFO`, `SCOPE`) VALUES ('authent.hub.seclin', 'Vendome', 'U7G', '{
	"machineInfo": {
	"tpacsk01v": {
		"additionalInfo": {
		"hub.jks.truststore.file": "EntrustJKS.jks",
		"hub.p12.truststore.file": "u7g.fo.wlp-acs.com.p12",
		"hub.temp.configuration.file": "hub-configs.properties",
		"hub.proxy.host": "proxy-prod-acs.vdm.svc.meshcore.net",
		"hub.proxy.port": "3128"
		},
		"serviceUrl": "https://ssl-prd-h0g-fo-hub-cpr-sticky-scl.ita.stg.as8677.net/proxy/rest/",
		"servicePort": null,
		"proxyHost": null,
		"proxyPort": null,
		"serverUrl": "https://ssl-prd-h0g-fo-hub-cpr-sticky-scl.ita.stg.as8677.net/proxy/rest/",
		"serviceStatus": "OK",
		"serviceStatusInfo": null,
		"serviceDependencies": [

		],
		"version": "1.1.22-ICG"
	},
	"tpacsk02v": {
		"additionalInfo": {
		"hub.jks.truststore.file": "EntrustJKS.jks",
		"hub.p12.truststore.file": "u7g.fo.wlp-acs.com.p12",
		"hub.temp.configuration.file": "hub-configs.properties",
		"hub.proxy.host": "proxy-prod-acs.vdm.svc.meshcore.net",
		"hub.proxy.port": "3128"
		},
		"serviceUrl": "https://ssl-prd-h0g-fo-hub-cpr-sticky-scl.ita.stg.as8677.net/proxy/rest/",
		"servicePort": null,
		"proxyHost": null,
		"proxyPort": null,
		"serverUrl": "https://ssl-prd-h0g-fo-hub-cpr-sticky-scl.ita.stg.as8677.net/proxy/rest/",
		"serviceStatus": "OK",
		"serviceStatusInfo": null,
		"serviceDependencies": [

		],
		"version": "1.1.22-ICG"
	},
	"tpacsk03v": {
		"additionalInfo": {
		"hub.jks.truststore.file": "EntrustJKS.jks",
		"hub.p12.truststore.file": "u7g.fo.wlp-acs.com.p12",
		"hub.temp.configuration.file": "hub-configs.properties",
		"hub.proxy.host": "proxy-prod-acs.vdm.svc.meshcore.net",
		"hub.proxy.port": "3128"
		},
		"serviceUrl": "https://ssl-prd-h0g-fo-hub-cpr-sticky-scl.ita.stg.as8677.net/proxy/rest/",
		"servicePort": null,
		"proxyHost": null,
		"proxyPort": null,
		"serverUrl": "https://ssl-prd-h0g-fo-hub-cpr-sticky-scl.ita.stg.as8677.net/proxy/rest/",
		"serviceStatus": "OK",
		"serviceStatusInfo": null,
		"serviceDependencies": [

		],
		"version": "1.1.22-ICG"
	},
	"tpacsk04v": {
		"additionalInfo": {
		"hub.jks.truststore.file": "EntrustJKS.jks",
		"hub.p12.truststore.file": "u7g.fo.wlp-acs.com.p12",
		"hub.temp.configuration.file": "hub-configs.properties",
		"hub.proxy.host": "proxy-prod-acs.vdm.svc.meshcore.net",
		"hub.proxy.port": "3128"
		},
		"serviceUrl": "https://ssl-prd-h0g-fo-hub-cpr-sticky-scl.ita.stg.as8677.net/proxy/rest/",
		"servicePort": null,
		"proxyHost": null,
		"proxyPort": null,
		"serverUrl": "https://ssl-prd-h0g-fo-hub-cpr-sticky-scl.ita.stg.as8677.net/proxy/rest/",
		"serviceStatus": "OK",
		"serviceStatusInfo": null,
		"serviceDependencies": [

		],
		"version": "1.1.22-ICG"
	}
	}
}', '0');

INSERT INTO `SERVICE_INFO` (`SERVICE_NAME`, `SITE_NAME`, `ACS_ID`, `ADDITIONAL_INFO`, `SCOPE`) VALUES ('authent.hub.vendome', 'Vendome', 'U7G', '{
	"machineInfo": {
		"tpacsk02v": {
		"additionalInfo": {
			"hub.jks.truststore.file": "EntrustJKS.jks",
			"hub.p12.truststore.file": "u7g.fo.wlp-acs.com.p12",
			"hub.temp.configuration.file": "hub-configs.properties",
			"hub.proxy.host": "proxy-prod-acs.vdm.svc.meshcore.net",
			"hub.proxy.port": "3128"
		},
		"serviceUrl": "https://ssl-prd-h0g-fo-hub-cpr-sticky-vdm.ita.stg.as8677.net/proxy/rest/",
		"servicePort": null,
		"proxyHost": null,
		"proxyPort": null,
		"serverUrl": "https://ssl-prd-h0g-fo-hub-cpr-sticky-vdm.ita.stg.as8677.net/proxy/rest/",
		"serviceStatus": "OK",
		"serviceStatusInfo": null,
		"serviceDependencies": [

		],
		"version": "1.1.22-ICG"
		},
		"tpacsk01v": {
		"additionalInfo": {
			"hub.jks.truststore.file": "EntrustJKS.jks",
			"hub.p12.truststore.file": "u7g.fo.wlp-acs.com.p12",
			"hub.temp.configuration.file": "hub-configs.properties",
			"hub.proxy.host": "proxy-prod-acs.vdm.svc.meshcore.net",
			"hub.proxy.port": "3128"
		},
		"serviceUrl": "https://ssl-prd-h0g-fo-hub-cpr-sticky-vdm.ita.stg.as8677.net/proxy/rest/",
		"servicePort": null,
		"proxyHost": null,
		"proxyPort": null,
		"serverUrl": "https://ssl-prd-h0g-fo-hub-cpr-sticky-vdm.ita.stg.as8677.net/proxy/rest/",
		"serviceStatus": "OK",
		"serviceStatusInfo": null,
		"serviceDependencies": [

		],
		"version": "1.1.22-ICG"
		},
		"tpacsk03v": {
		"additionalInfo": {
			"hub.jks.truststore.file": "EntrustJKS.jks",
			"hub.p12.truststore.file": "u7g.fo.wlp-acs.com.p12",
			"hub.temp.configuration.file": "hub-configs.properties",
			"hub.proxy.host": "proxy-prod-acs.vdm.svc.meshcore.net",
			"hub.proxy.port": "3128"
		},
		"serviceUrl": "https://ssl-prd-h0g-fo-hub-cpr-sticky-vdm.ita.stg.as8677.net/proxy/rest/",
		"servicePort": null,
		"proxyHost": null,
		"proxyPort": null,
		"serverUrl": "https://ssl-prd-h0g-fo-hub-cpr-sticky-vdm.ita.stg.as8677.net/proxy/rest/",
		"serviceStatus": "OK",
		"serviceStatusInfo": null,
		"serviceDependencies": [

		],
		"version": "1.1.22-ICG"
		},
		"tpacsk04v": {
		"additionalInfo": {
			"hub.jks.truststore.file": "EntrustJKS.jks",
			"hub.p12.truststore.file": "u7g.fo.wlp-acs.com.p12",
			"hub.temp.configuration.file": "hub-configs.properties",
			"hub.proxy.host": "proxy-prod-acs.vdm.svc.meshcore.net",
			"hub.proxy.port": "3128"
		},
		"serviceUrl": "https://ssl-prd-h0g-fo-hub-cpr-sticky-vdm.ita.stg.as8677.net/proxy/rest/",
		"servicePort": null,
		"proxyHost": null,
		"proxyPort": null,
		"serverUrl": "https://ssl-prd-h0g-fo-hub-cpr-sticky-vdm.ita.stg.as8677.net/proxy/rest/",
		"serviceStatus": "OK",
		"serviceStatusInfo": null,
		"serviceDependencies": [

		],
		"version": "1.1.22-ICG"
		}

	}
}', '0');

INSERT INTO `SERVICE_INFO` (`SERVICE_NAME`, `SITE_NAME`, `ACS_ID`, `ADDITIONAL_INFO`, `SCOPE`) VALUES ('authent.hub.vendome', 'Brussels', 'U7G', '{
	"machineInfo": {
		"tpacsk02b": {
		"additionalInfo": {
			"hub.jks.truststore.file": "EntrustJKS.jks",
			"hub.p12.truststore.file": "u7g.fo.wlp-acs.com.p12",
			"hub.temp.configuration.file": "hub-configs.properties",
			"hub.proxy.host": "proxy-prod-acs.brs.svc.meshcore.net",
			"hub.proxy.port": "3128"
		},
		"serviceUrl": "https://ssl-prd-h0g-fo-hub-cpr-sticky-vdm.ita.stg.as8677.net/proxy/rest/",
		"servicePort": null,
		"proxyHost": null,
		"proxyPort": null,
		"serverUrl": "https://ssl-prd-h0g-fo-hub-cpr-sticky-vdm.ita.stg.as8677.net/proxy/rest/",
		"serviceStatus": "OK",
		"serviceStatusInfo": null,
		"serviceDependencies": [

		],
		"version": "1.1.22-ICG"
		},
		"tpacsk01b": {
		"additionalInfo": {
			"hub.jks.truststore.file": "EntrustJKS.jks",
			"hub.p12.truststore.file": "u7g.fo.wlp-acs.com.p12",
			"hub.temp.configuration.file": "hub-configs.properties",
			"hub.proxy.host": "proxy-prod-acs.brs.svc.meshcore.net",
			"hub.proxy.port": "3128"
		},
		"serviceUrl": "https://ssl-prd-h0g-fo-hub-cpr-sticky-vdm.ita.stg.as8677.net/proxy/rest/",
		"servicePort": null,
		"proxyHost": null,
		"proxyPort": null,
		"serverUrl": "https://ssl-prd-h0g-fo-hub-cpr-sticky-vdm.ita.stg.as8677.net/proxy/rest/",
		"serviceStatus": "OK",
		"serviceStatusInfo": null,
		"serviceDependencies": [

		],
		"version": "1.1.22-ICG"
		},
		"tpacsk03b": {
		"additionalInfo": {
			"hub.jks.truststore.file": "EntrustJKS.jks",
			"hub.p12.truststore.file": "u7g.fo.wlp-acs.com.p12",
			"hub.temp.configuration.file": "hub-configs.properties",
			"hub.proxy.host": "proxy-prod-acs.brs.svc.meshcore.net",
			"hub.proxy.port": "3128"
		},
		"serviceUrl": "https://ssl-prd-h0g-fo-hub-cpr-sticky-vdm.ita.stg.as8677.net/proxy/rest/",
		"servicePort": null,
		"proxyHost": null,
		"proxyPort": null,
		"serverUrl": "https://ssl-prd-h0g-fo-hub-cpr-sticky-vdm.ita.stg.as8677.net/proxy/rest/",
		"serviceStatus": "OK",
		"serviceStatusInfo": null,
		"serviceDependencies": [

		],
		"version": "1.1.22-ICG"
		},
		"tpacsk04b": {
		"additionalInfo": {
			"hub.jks.truststore.file": "EntrustJKS.jks",
			"hub.p12.truststore.file": "u7g.fo.wlp-acs.com.p12",
			"hub.temp.configuration.file": "hub-configs.properties",
			"hub.proxy.host": "proxy-prod-acs.brs.svc.meshcore.net",
			"hub.proxy.port": "3128"
		},
		"serviceUrl": "https://ssl-prd-h0g-fo-hub-cpr-sticky-vdm.ita.stg.as8677.net/proxy/rest/",
		"servicePort": null,
		"proxyHost": null,
		"proxyPort": null,
		"serverUrl": "https://ssl-prd-h0g-fo-hub-cpr-sticky-vdm.ita.stg.as8677.net/proxy/rest/",
		"serviceStatus": "OK",
		"serviceStatusInfo": null,
		"serviceDependencies": [

		],
		"version": "1.1.22-ICG"
		}
	}
}', '0');

