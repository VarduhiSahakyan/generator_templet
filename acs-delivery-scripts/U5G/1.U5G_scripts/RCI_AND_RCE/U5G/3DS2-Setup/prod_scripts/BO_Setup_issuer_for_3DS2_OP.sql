USE U5G_ACS_BO;

-- OP

SET @subIssuerCode = '20000';

SET @subIssuerId = (SELECT id FROM U5G_ACS_BO.SubIssuer where code = @subIssuerCode);

UPDATE SubIssuer SET 3DS2AdditionalInfo = ' { "VISA": { "operatorId": "10066894", "dsKeyAlias": "dsvisa_call_alias_cert_01" }, "MASTERCARD": { "operatorId": "ACS-V210-EQUENSWORLDLINE-34926", "dsKeyAlias": "dsmc_call_alias_cert_01" } }' where id = @subIssuerId;

UPDATE SubIssuer SET protocol2FlowMode = 'AUTHENT_AND_CHALLENGE_MODE' where id = @subIssuerId;

UPDATE CryptoConfig SET protocolTwo = '{ "cavvKeyIndicator": "01", "cipherKeyIdentifier": "EC09250002314B544F4B5F4F505F5F5F5F5F00", "acsIdForCrypto": "09", "binKeyIdentifier": "1", "hubAESKey": "01", "cardNetworkAlgorithmMap": { "VISA": "CVV_WITH_ATN" }, "cardNetworkSeqGenerationMethodMap": { "VISA": "STRING_TIMESTAMP" }, "cardNetworkIdentifierMap": { "VISA": "240925000231434156565F4F505F5F5F5F5F01" }, "acsSignedContentCertificateKeyMap": { "VISA": "ED09250002314B544F525F434C455F54454303" }, "acsSignedContentCertificateMap": { "VISA": { "signingCertificate": "MIIFejCCBGKgAwIBAgIRALEZIu2tL/DpK7sKurwFrwwwDQYJKoZIhvcNAQELBQAwcTELMAkGA1UEBhMCVVMxDTALBgNVBAoTBFZJU0ExLzAtBgNVBAsTJlZpc2EgSW50ZXJuYXRpb25hbCBTZXJ2aWNlIEFzc29jaWF0aW9uMSIwIAYDVQQDExlWaXNhIGVDb21tZXJjZSBJc3N1aW5nIENBMB4XDTE5MDUyODE3NDcwNVoXDTIxMDgyNjE3NDcwNVowgZQxDzANBgNVBAcTBkJlem9uczEWMBQGA1UECBMNSWxlLWRlLUZyYW5jZTELMAkGA1UEBhMCRlIxGDAWBgNVBAoTD0VxdWVuc1dvcmxkbGluZTEcMBoGA1UECxMTRXF1ZW5zV29ybGRsaW5lIEFDUzEkMCIGA1UEAxMbUFJPRC1FV0wtQUNTLVNJR05BVFVSRS1WSVNBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAzY1t7VexSEXMp1ix0SnOamEQQpKAHiZrlXBCKocXvNi7zMkkA/BjaLLRV5YPSEtZLrMRCttGNdSoOlDrBqYCK8XpGhqtsdmkWoHMKOPynlTbgAUrQws5seW6jVi3qGZTOrziS+PFHxVPqLbLwoRuw/i01kKviFnTIlJIWWJuRxftCqheDZHymX+LVcxT+tI3UkxabtzjF3B9mGl0fRpvim7PQVkPRrdYT71odIrp8DuA9H0KTBaJoVXgBmW8FFcRkvfZ7C+Faa5C7mHZfcWnSR4upe8c2cqrMjLyqCuSbOi4PkXcIGfTEMlBoM82+y/7uO70wgRLng1gpjTqjvkqWwIDAQABo4IB5zCCAeMwZQYIKwYBBQUHAQEEWTBXMCUGCCsGAQUFBzABhhlodHRwOi8vb2NzcC52aXNhLmNvbS9vY3NwMC4GCCsGAQUFBzAChiJodHRwOi8vZW5yb2xsLnZpc2FjYS5jb20vZWNvbW0uY2VyMB8GA1UdIwQYMBaAFN/DKlUuL0I6ekCdkqD3R3nXj4eKMAwGA1UdEwEB/wQCMAAwgcoGA1UdHwSBwjCBvzAooCagJIYiaHR0cDovL0Vucm9sbC52aXNhY2EuY29tL2VDb21tLmNybDCBkqCBj6CBjIaBiWxkYXA6Ly9FbnJvbGwudmlzYWNhLmNvbTozODkvY249VmlzYSBlQ29tbWVyY2UgSXNzdWluZyBDQSxjPVVTLG91PVZpc2EgSW50ZXJuYXRpb25hbCBTZXJ2aWNlIEFzc29jaWF0aW9uLG89VklTQT9jZXJ0aWZpY2F0ZVJldm9jYXRpb25MaXN0MBMGA1UdJQQMMAoGCCsGAQUFBwMCMA4GA1UdDwEB/wQEAwIHgDAdBgNVHQ4EFgQU9vg1bDNqnFBx2WPAYbPV0X//4KYwOgYDVR0gBDMwMTAvBgZngQMBAQEwJTAjBggrBgEFBQcCARYXaHR0cDovL3d3dy52aXNhLmNvbS9wa2kwDQYJKoZIhvcNAQELBQADggEBAKj/IjBh2i7XqaWkVc2v0EaD9RllBxcu6dcyWxLuIneIRwMtkEDwk/Ld1Mw9PF62L0Xx0lTkcGdZaqHRNs1S/lMN3aEIj5yc0P9s+gg9+/ce58BcK4Jz6MvzhVlb6upWM0ePTttJlIx3XfxFB3UodYUko3NChMfXupnWzYUzNPJpjPlYYgex5Qf4jGJGwgTJNgq/IHaFWJCzI1QzNmxxMagIcJtf5/A5/2lh906t7HdvMCOTJHTwboDe1RueuFxFB6Alk1gXCXpfgM1b4Fx58ZeUSPJaPDLNCg8a4nRy0kDsbO4D37OvgDBkYkHzBwnqsII87ASf1J9xqb8NmVb5Mco=", "authorityCertificate": "MIIFGzCCBAOgAwIBAgIRANh0YTBB/DxEoLzGXWw28RAwDQYJKoZIhvcNAQELBQAwazELMAkGA1UEBhMCVVMxDTALBgNVBAoTBFZJU0ExLzAtBgNVBAsTJlZpc2EgSW50ZXJuYXRpb25hbCBTZXJ2aWNlIEFzc29jaWF0aW9uMRwwGgYDVQQDExNWaXNhIGVDb21tZXJjZSBSb290MB4XDTE1MDYyNDE1MjcwNloXDTIyMDYyMjAwMTYwN1owcTELMAkGA1UEBhMCVVMxDTALBgNVBAoTBFZJU0ExLzAtBgNVBAsTJlZpc2EgSW50ZXJuYXRpb25hbCBTZXJ2aWNlIEFzc29jaWF0aW9uMSIwIAYDVQQDExlWaXNhIGVDb21tZXJjZSBJc3N1aW5nIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEArkmC50Q+GkmQyZ29kKxp1d+nJ43JwXhGZ7aFF1PiM5SlCESQ22qV/lBA3wHYYP8i17/GQQYNBiF3u4r6juXIHFwjwvKyFMF6kmBYXvcQa8Pd75FC1n3ffIrhEj+ldbmxidzK0hPfYyXEZqDpHhkunmvD7qz1BEWKE7NUYVFREfopViflKiVZcYrHi7CJAeBNY7dygvmIMnHUeH4NtDS5qf/n9DQQffVyn5hJWi5PeB87nTlty8zdji2tj7nA2+Y3PLKRJU3y1IbchqGlnXqxaaKfkTLNsiZq9PTwKaryH+um3tXf5u4mulzRGOWh2U+Uk4LntmMFCb/LqJkWnUVe+wIDAQABo4IBsjCCAa4wHwYDVR0jBBgwFoAUFTiDDz8sP3AzHs1G/geMIODXw7cwEgYDVR0TAQH/BAgwBgEB/wIBADA5BgNVHSAEMjAwMC4GBWeBAwEBMCUwIwYIKwYBBQUHAgEWF2h0dHA6Ly93d3cudmlzYS5jb20vcGtpMIIBCwYDVR0fBIIBAjCB/zA2oDSgMoYwaHR0cDovL0Vucm9sbC52aXNhY2EuY29tL1Zpc2FDQWVDb21tZXJjZVJvb3QuY3JsMDygOqA4hjZodHRwOi8vd3d3LmludGwudmlzYWNhLmNvbS9jcmwvVmlzYUNBZUNvbW1lcmNlUm9vdC5jcmwwgYaggYOggYCGfmxkYXA6Ly9FbnJvbGwudmlzYWNhLmNvbTozODkvY249VmlzYSBlQ29tbWVyY2UgUm9vdCxvPVZJU0Esb3U9VmlzYSBJbnRlcm5hdGlvbmFsIFNlcnZpY2UgQXNzb2NpYXRpb24/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdDAOBgNVHQ8BAf8EBAMCAQYwHQYDVR0OBBYEFN/DKlUuL0I6ekCdkqD3R3nXj4eKMA0GCSqGSIb3DQEBCwUAA4IBAQB9Y+F99thHAOhxZoQcT9CbConVCtbm3hWlf2nBJnuaQeoftdOKWtj0YOTj7PUaKOWfwcbZSHB63rMmLiVm7ZqIVndWxvBBRL1TcgbwagDnLgArQMKHnY2uGQfPjEMAkAnnWeYJfd+cRJVo6K3R4BbQGzFSHa2i2ar6/oXzINyaxAXdoG04Cz2P0Pm613hMCpjFyYilS/425he1Tk/vHsTnFwFlk9yY2L8VhBa6j40faaFu/6fin78Kopk96gHdAIN1tbA12NNmr7bQ1pUs0nKHhzQGoRXguYd7UYO9i2sNVC1C5A3F8dopwsv2QK2+33q05O2/4DgnF4m5us6RV94D", "rootCertificate": "MIIDojCCAoqgAwIBAgIQE4Y1TR0/BvLB+WUF1ZAcYjANBgkqhkiG9w0BAQUFADBrMQswCQYDVQQGEwJVUzENMAsGA1UEChMEVklTQTEvMC0GA1UECxMmVmlzYSBJbnRlcm5hdGlvbmFsIFNlcnZpY2UgQXNzb2NpYXRpb24xHDAaBgNVBAMTE1Zpc2EgZUNvbW1lcmNlIFJvb3QwHhcNMDIwNjI2MDIxODM2WhcNMjIwNjI0MDAxNjEyWjBrMQswCQYDVQQGEwJVUzENMAsGA1UEChMEVklTQTEvMC0GA1UECxMmVmlzYSBJbnRlcm5hdGlvbmFsIFNlcnZpY2UgQXNzb2NpYXRpb24xHDAaBgNVBAMTE1Zpc2EgZUNvbW1lcmNlIFJvb3QwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvV95WHm6h2mCxlCfLF9sHP4CFT8icttD0b0/Pmdjh28JIXDqsOTPHH2qLJj0rNfVIsZHBAk4ElpF7sDPwsRROEW+1QK8bRaVK7362rPKgH1g/EkZgPI2h4H3PVz4zHvtH8aoVlwdVZqW1LS7YgFmypw23RuwhY/81q6UCzyr0TP579ZRdhE2o8mCP2w4lPJ9zcc+U30rq299yOIzzlr3xF7zSujtFWsan9sYXiwGd/BmoKoMWuDpI/k4+oKsGGelT84ATB+0tvz8KPFUgOSwsAGl0lUq8ILKpeeUYiZGo3BxN77t+Nwtd/jmliFKMAGzsGHxBvfaLdXe6YJ2E5/4tAgMBAAGjQjBAMA8GA1UdEwEB/wQFMAMBAf8wDgYDVR0PAQH/BAQDAgEGMB0GA1UdDgQWBBQVOIMPPyw/cDMezUb+B4wg4NfDtzANBgkqhkiG9w0BAQUFAAOCAQEAX/FBfXxcCLkr4NWSR/pnXKUTwwMhmytMiUbPWU3J/qVAtmPN3XEolWcRzCSs00Rsca4BIGsDoo8Ytyk6feUWYFN4PMCvFYP3j1IzJL1kk5fui/fbGKhtcbP3LBfQdCVp9/5rPJS+TUtBjE7ic9DjkCJzQ83z7+pzzkWKsKZJ/0x9nXGIxHYdkFsd7v3M9+79YKWxehZx0RbQfBI8bGmX265fOZpwLwU8GUYEmSA20GBuYQa7FkKMcPcw++DbZqMAAb3mLNqRX6BGi01qnD093QVG/na/oAo85ADmJ7f/hC3euiInlhBx6yLt398znM/jra6O1I7mT1GvFpLgXPYHDw==", "signingCertificateExpiryDate": "26/08/2021", "authorityCertificateExpiryDate": "22/06/2022", "rootCertificateExpiryDate": "24/06/2022" } } }' WHERE id = (SELECT fk_id_cryptoConfig from SubIssuer where id = @subIssuerId);