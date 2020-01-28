USE U5G_ACS_BO;

-- OP

SET @subIssuerCode = '20000';

SET @subIssuerId = (SELECT id FROM U5G_ACS_BO.SubIssuer where code = @subIssuerCode);

UPDATE SubIssuer SET 3DS2AdditionalInfo = '  {
      "VISA": {
        "operatorId": "acsOperatorVisa",
        "dsKeyAlias": "3DS2-VISA-CERTIFICATION"
      },
      "MASTERCARD": {
        "operatorId": "acsOperatorMasterCard",
        "dsKeyAlias": "key-masterCard"
      }
    }' where id = @subIssuerId;

UPDATE SubIssuer SET protocol2FlowMode = 'AUTHENT_AND_CHALLENGE_MODE' where id = @subIssuerId;

UPDATE CryptoConfig SET protocolTwo = '{
  "cavvKeyIndicator": "01",
  "cipherKeyIdentifier": "EC11223344554B544F4B5F4D5554555F414301",
  "acsIdForCrypto": "0A",
  "binKeyIdentifier": "1",
  "hubAESKey": "01",
  "cardNetworkAlgorithmMap": {
    "MASTERCARD": "MASTERCARD_SPA",
    "VISA": "CVV_WITH_ATN"
  },
  "cardNetworkSeqGenerationMethodMap": {
    "MASTERCARD": "HEX_TIMESTAMP",
    "VISA": "STRING_TIMESTAMP"
  },
  "cardNetworkIdentifierMap": {
    "MASTERCARD": "241122334455554341465F4D5554555F414300",
    "VISA": "241122334455434156565F4D5554555F414302"
  },
  "acsSignedContentCertificateKeyMap": {
    "VISA": "ED11223344554B544F525F4D5554555F414317",
    "MASTERCARD": "ED11223344554B544F525F4D5554555F414320"
  },
  "acsSignedContentCertificateMap": {
    "MASTERCARD": {
      "signingCertificate": "MIIFxDCCA6ygAwIBAgIQCT5Ic/L81er7N5du78y6BzANBgkqhkiG9w0BAQsFADB7MQswCQYDVQQGEwJVUzETMBEGA1UEChMKTWFzdGVyQ2FyZDEoMCYGA1UECxMfTWFzdGVyQ2FyZCBJZGVudGl0eSBDaGVjayBHZW4gMzEtMCsGA1UEAxMkVmFsRmFjIE1hc3RlckNhcmQgM0RTMiBJc3N1ZXIgU3ViIENBMB4XDTE5MDQwNDEyNTIyMFoXDTIxMDQwMzEyNTAwNFowgagxCzAJBgNVBAYTAkZSMRYwFAYDVQQIEw1JbGUtZGUtRnJhbmNlMQ8wDQYDVQQHEwZCZXpvbnMxGDAWBgNVBAoTD0VRVUVOU1dPUkxETElORTExMC8GA1UECxMoQUNTTVMtTVRGLUFDUy1WMjEwLUVRVUVOU1dPUkxETElORS0zNDkyNjEjMCEGA1UEAxMaSE9NT0wtRVdMLUFDUy1TSUdOQVRVUkUtTUMwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvR0RaWY8Tbl6C0DlYLj+qZCooWiv3SJ/oR8jkD546aYUp/NV7BkfIMM/KpufsYrrUwnkxn/as6ZP0Vv/Y+OtV3Na0W+B5Ct6dSlQnKdzx2WR6hC/UmLDbuCpIlkxO4W8IWfZY1Q45+mDciX7p29MlU2qMTdqSNMIP8Ku+8ZRQN4rPyFkrMQ32M2ehFuouB0qMe0NYk1hO6U95dm3pBQdCO/qGlg3kJOxAxo8HSjN4pFQ7IljyUhJKTAvIOIMjHD89kRle1DECk5olRwqvlkwG4KZxadgKlx5YKKxv0d3r/HTn8mP+uQKA+1fs0pwJ2Vu7tX/+yVN7Nj5jcvIvn8XxAgMBAAGjggEUMIIBEDAOBgNVHQ8BAf8EBAMCB4AwCQYDVR0TBAIwADAfBgNVHSMEGDAWgBSdk6Hf8UoLt3a0FyuPTCLscXb50TBIBggrBgEFBQcBAQQ8MDowOAYIKwYBBQUHMAGGLGh0dHA6Ly9vY3NwLnBraS5pZGVudGl0eWNoZWNrLm1hc3RlcmNhcmQuY29tMGkGA1UdHwRiMGAwXqBcoFqGWGh0dHA6Ly9jcmwucGtpLmlkZW50aXR5Y2hlY2subWFzdGVyY2FyZC5jb20vOWQ5M2ExZGZmMTRhMGJiNzc2YjQxNzJiOGY0YzIyZWM3MTc2ZjlkMS5jcmwwHQYDVR0OBBYEFKzw2A/mXeUDkPRKXuJh2Hf+iwDRMA0GCSqGSIb3DQEBCwUAA4ICAQAWzXgiyzgUfeVR+mijS/zVfLksy1AAxCIiN1hmiwLltf4x2fuays5V7skdrY/+qNGMpcqOHwvohyTNgA13mEHsiL1MPEL1kqQhs3e2UV/DwLVv8bdiAWJegtEtKWdWyJBNeD/lmW0UMeep8U1X68c3D7cX0MtWcO8X0fDLzM5FVaWevlX63LJvBnINxwKP8gsOXSzFOUNKix0oBYfOKMbylAaytKvZC4CFctK5QWYkqSq/k2uyvwEHPQv4w0vtVDnRx1aWP3I25DaFXtCaoR9EqQ9soCil5P95DYtvmzzFRDxAPBhiveqAoj9f7qcemqIBI/woqnXv2qA1I1PvwUJjQ6AWIcf2tA49vkMHOq4H6l8s6tJKn79R/q66autrZweyzMmfflB4/U+qL0ZR8wsZBt2B1Ajyg9YDzhhI9/IEf30VR0V8eaEc131yXKgnYCqEoWRK6cvQLy2ieU97H1q1/b8HW6ezvmgjAjd20K5dSsd6ANXj7M7miGvKROFRgZjmcN6iwkRPs+XmWtvs4jqR/GNU0TsJ02igiWqQiQVNbjkuDWuuJ/SfdYkhEo9hOW8UAgQpG1vdwK/JJLjJMK18phZvjFjnYS7HrhiFRnXbdmB4LXrgBaQW8tDKitkmlBco2awRl//aSNp8fjihkYGQCuxmvZPov0upvo8S+7F0Fg==",
      "authorityCertificate": "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",
      "rootCertificate": "MIIFzjCCA7agAwIBAgIRAO1jVXkQsXKwwm83tAnIHVMwDQYJKoZIhvcNAQELBQAwfzELMAkGA1UEBhMCVVMxEzARBgNVBAoTCk1hc3RlckNhcmQxKDAmBgNVBAsTH01hc3RlckNhcmQgSWRlbnRpdHkgQ2hlY2sgR2VuIDMxMTAvBgNVBAMTKFZhbEZhYyBNYXN0ZXJDYXJkIElkZW50aXR5IENoZWNrIFJvb3QgQ0EwHhcNMTYwNzE0MDcxMjAwWhcNMzAwNzE1MDgxMDAwWjB/MQswCQYDVQQGEwJVUzETMBEGA1UEChMKTWFzdGVyQ2FyZDEoMCYGA1UECxMfTWFzdGVyQ2FyZCBJZGVudGl0eSBDaGVjayBHZW4gMzExMC8GA1UEAxMoVmFsRmFjIE1hc3RlckNhcmQgSWRlbnRpdHkgQ2hlY2sgUm9vdCBDQTCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAMHjJpH1vy2MgK7CWy1b1RbDIKnqKiz/38g9pUbvcjrg3S2kc7D7IjuwZSlzeDg+lqM4P4iWdFL5viNNbUOmABlxLZ+EZyaMMnq8usWHbMAd4mQY/KKsEl9o1tK4FJlOPi5qHIS9PUmmkgRsbJHgskS4pIDZtuTJ1xOVBv+0gX/fKi+pu4PAx9GZSwnMEpf1DTqoA3OO6yBA5ROrxMD6HnjpLANs7kke56qdgKytfhfdCQuvF+FCGgbqZis422vihBiJkD51AGOuxUCe21rjFaXxsJpFSXoJ91eGeHG5gqKtBuNUPDCm+ShyHQN89jfRjMsNNH2xShmEPnS+OitrRIUiJykYEbAZvx++zac8rJYzTxTAJS6VxLhG/UsMgls2JAbHng4kGGlubRKsExUl4eXZrgjbgEQlhCdUBnt8gz73jaz2L4G0j3t2RQENkxTjuLCObOWRTxUQTYGyn64zBhdQCmSC49it17ECUsNBY3+Yso7dnCjN/4TIw42+iX/FBocfcn9lUgYPlwgGXrU2+PJ76D+4FFbPCepiGWJnzMNjbsPFgSUqUQxC7bj77c3Wea65kz3Y7SDoPaFsfHBRDU30AxbBEwk4q3KZtzLV5sBJ/z6duXxq01ckHy0UiGBr2zY+ScNippbdCELipanM10b34u7tfDlYpHLTnuT61LajAgMBAAGjRTBDMA4GA1UdDwEB/wQEAwIBhjASBgNVHRMBAf8ECDAGAQH/AgEBMB0GA1UdDgQWBBSnEPJoAOCMunB5/OW44ISGR8YK6TANBgkqhkiG9w0BAQsFAAOCAgEAl4/YrKfsaUbNFrnSbMQlEwWUuESbfL+uv/eCwAoPdE5FbFZtkfX+BWPA5BEc7pOTUFBJiWwzs+ngLz5k97iyAYYOzQr27yj5A8aOj6Na0239T9NMI2t/rEARTfMP6fPzOpimgofTbLuiNtkCiwJfs9A6N0SvLxe+r++aYYfPx0/pmQnWIF7Uliskr8jTXiaIK19XTkFmsF4gZHuKBxUrtacTfSqClLJAuXl6avNVvDuaH4ebcNx7XZwHuWz8JOwDNaT/HD45Ku1FqohtUvF7o/PV/goaKAqiUChavqoqJgYQ15UED7lNgLcT5ZpchCTFlUSflZnAbDiopU1NQxQPPdbWWKY1Q9SbGEOIyfoVXi8OcmEGPRz49vaGSq9JPX9aDp8g1PpJLjK+uwHZ/QZO4CZETSwXvxVvE0eI/gnhUAe4zC0SQmaRwMIVN0Ivf5fvSQsPQMbKHxqCWb0FWi6GCiZryR6oJ8z7OEuq1yxg3fas0NxK3GvnSOH3xpzoTuUijQ0Xu1pQqmGkXINmcKAbX/CxEssdgEx9EasfFifbizJpnTnSu05bRBAP5RV5l+GVuxe01w8uYtDIKmKXsMtzZ88tV5GIb0s/THzLvDr6E/khD+pVNsME4VurwW1Rgk831sXS+TRUQIxvA0qH3IyasIjPmtyXyGStiJ58gh8o+Uw=",
      "signingCertificateExpiryDate": null,
      "authorityCertificateExpiryDate": null,
      "rootCertificateExpiryDate": null
    },
    "VISA": {
      "signingCertificate": "MIIDyDCCArCgAwIBAgIVAITdgE7zNahVEUI9pz7TYTVocGKlMA0GCSqGSIb3DQEBCwUAMH8xJjAkBgNVBAMTHVZCVlRFU1RTVUlURTJfUlNBX1NJR05fQ0FfQ1RFMRUwEwYDVQQLEwxWQlZURVNUU1VJVEUxDTALBgNVBAoTBFZJU0ExDzANBgNVBAcTBkRlbnZlcjERMA8GA1UECBMIQ29sb3JhZG8xCzAJBgNVBAYTAlVTMB4XDTE5MDUxNjA3MzczNVoXDTE5MDkxMzA3MzczNVowgZUxCzAJBgNVBAYTAkZSMRYwFAYDVQQIEw1JbGUtZGUtRnJhbmNlMQ8wDQYDVQQHEwZCZXpvbnMxGDAWBgNVBAoTD0VxdWVuc1dvcmxkbGluZTEcMBoGA1UECxMTRXF1ZW5zV29ybGRsaW5lIEFDUzElMCMGA1UEAxMcSE9NT0wtRVdMLUFDUy1TSUdOQVRVUkUtVklTQTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAPd4xeo9Pv2wbVjbIVm7Lgw3oa1yLShzzqzIyVNM/kUCYt3po9hNOhdTKxTUi1NnGNTA+yRkq6bJ/bsooRwUo2WzDph+TW4tT9cfZgeDzgob6dQwNmYOM4Pp8g2XDBTYvdCDesCFuazjNEL8V+9//GP101pkIE73PE4G6flte3tHZ0GB8oKk8khik+ZqAIvMVT/Nc77D2o22FLANvDWHNsE5RPVNZaO/jRX/r3DsHiZV+O9DPBXEKhe4zmywuU0qwkA/lEv+AoTdYvp+A6z/DGt0j12JfdY8jVHwGAw6CApeIeiT2Kaq2SDAyGPu+CxZKgscz0YtRCSlSjBxPZjSJfsCAwEAAaMkMCIwCwYDVR0PBAQDAgeAMBMGA1UdJQQMMAoGCCsGAQUFBwMCMA0GCSqGSIb3DQEBCwUAA4IBAQBuzpx/4Vi88qBBleXt5USLhpc/A4QJ1tPSZ+DjcA/p2PprTqIp6OAsbUd+IpDlpDgsf5C+gjx8CbjCV7hTEZRukw0kd7v1I66s/jPsrmsDbwGX/FtuLS/9pR/tdvk9OJIqXmwl+L2v7ui1jcSiu6XgEN8XTQzN9tDiBIXZ4czjmudJa49ltqtZlp1QeLbb2ow8OiN2+qMrd3QYmTUXU3qGswve6o3XF/iJ0DeFX2ufV4HYm43Po0IzUwWkOeP9kmnDvximdxJRNB/+ILNF1aEJagFDMFvJQu8Ub7Y+XSVtVrzx7nZQ1iof5bU1dLmq1YBMYqnXjZuOpG8VT1p2TfPR",
      "authorityCertificate": "MIIELzCCAxegAwIBAgIQIsB7FwBdgljBd50GLaxkAzANBgkqhkiG9w0BAQsFADBpMQswCQYDVQQGEwJVUzENMAsGA1UEChMEVmlzYTEvMC0GA1UECxMmVmlzYSBJbnRlcm5hdGlvbmFsIFNlcnZpY2UgQXNzb2NpYXRpb24xGjAYBgNVBAMTEVZpc2EgZWNvbW1lcmNlIFFBMB4XDTE3MDQwNTE4MTgxNVoXDTIyMDQwNTE4MTgxNlowfzEmMCQGA1UEAxMdVkJWVEVTVFNVSVRFMl9SU0FfU0lHTl9DQV9DVEUxFTATBgNVBAsTDFZCVlRFU1RTVUlURTENMAsGA1UEChMEVklTQTEPMA0GA1UEBxMGRGVudmVyMREwDwYDVQQIEwhDb2xvcmFkbzELMAkGA1UEBhMCVVMwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCEOIppdHllRtXnfW59DOcVgodC+GerzxFYG6N/girVHk1bETED77jCw5mbbnJyHXO40SynSCHzKaWxdFR9TuRZjf/a4D7SheLFd3Fhzdm9FCdOdAOVx7+0hHxtqUIGBOX9k8aohHumVyf7x5Mj9L4Fwv0jqBFvD6VJVEq7EpE/VCQxKs1pnFKsZ33YdDwTaduSSKytyBC9pwI/2bCSN+meBewWx/qZUj0AK3HKIDuxZ2NwPNnAP8YCIRTaTiueHmHBeVgum3JIOxL6K0Eui4PKqWwTgiHblzUrl670vBUGxZeG2bp+5eQWHVEmSaDvXnL9d8bftsmz2sajnHdqt4XRAgMBAAGjgbwwgbkwEgYDVR0TAQH/BAgwBgEB/wIBADB0BgNVHSAEbTBrMGkGBWeBAwEBMGAwIwYIKwYBBQUHAgEWF2h0dHA6Ly93d3cudmlzYS5jb20vcGtpMDkGCCsGAQUFBwICMC0wGBYRUmVwbGFjZSBUaGlzIFRleHQwAwIBARoRUmVwbGFjZSBUaGlzIFRleHQwDgYDVR0PAQH/BAQDAgEGMB0GA1UdDgQWBBQHgy8dWx4MOByoGrI0B36j65/WlDANBgkqhkiG9w0BAQsFAAOCAQEAysCcn4p0fE1Os6AiRDwoNTzvUelHXWfL2xv0LSJLoCaZLRJI544V5D9epQD5Eni14qM96k2hSdQxeyUFhWMs2/IJsRSdZCQxjGCB4Oac0Fq1H7rzny0+6T2TsUBPNOksN0SUA3arnS3GYcAA2JMBbA7v143YfLZK16JERas5cIiHdEmCm7JQDA7d8UZ4Os4tkeswFkHJWD0LsNwqi1nxhMO4B+AyUfN8lNVip1iLLfGylFc8Z5CkccG1fqSgBDl7YNcCq84eh/NP5ZHoC1aLhGrGDA0oJnz2qdMpWFDMp2GU3Mb+cl57y8zBnryQMKQBz3d4CQbecV6IRfgdOJ43Kw==",
      "rootCertificate": "MIIEFjCCAv6gAwIBAgIQetu1SMxpnENAnnOz1P+PtTANBgkqhkiG9w0BAQUFADBpMQswCQYDVQQGEwJVUzENMAsGA1UEChMEVmlzYTEvMC0GA1UECxMmVmlzYSBJbnRlcm5hdGlvbmFsIFNlcnZpY2UgQXNzb2NpYXRpb24xGjAYBgNVBAMTEVZpc2EgZWNvbW1lcmNlIFFBMB4XDTEzMDExMjAzMzc0OVoXDTMzMDExMjAzMzc0OVowaTELMAkGA1UEBhMCVVMxDTALBgNVBAoTBFZpc2ExLzAtBgNVBAsTJlZpc2EgSW50ZXJuYXRpb25hbCBTZXJ2aWNlIEFzc29jaWF0aW9uMRowGAYDVQQDExFWaXNhIGVjb21tZXJjZSBRQTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBANkUflKmpn52tYI3ZtBNPWPY4s4KJn/HVWcFD+SViaOUBWh8GeydubN/oCwGItkfKxvSiDRRmSfCUIJBq0WlEQ3ucALb/B+IOrRwQgisq3bN0IZLAc0zHIpyWXumaoks7saRvDsa2wrbz/Et1qkM0j/oH/vOrDdaKH9J95qkCq4TZ7sEcy5nKwfDkpF2fokZt0UKKFtxVHcSEPSE1zNN1xkNxSNp7vpXyxvLSsC/Xdr8G7TCg2b1yxXWFjrP01uAv6EnJKTnZI4C2UehwxjuTACfSsT/AGvxDhfWPrrEtA6TCcD9rOp9DpwXNiSJGPzkcUUWfHGUxXg9eYgiTEo924cCAwEAAaOBuTCBtjAPBgNVHRMBAf8EBTADAQH/MHQGA1UdIARtMGswaQYFZ4EDAQEwYDAjBggrBgEFBQcCARYXaHR0cDovL3d3dy52aXNhLmNvbS9wa2kwOQYIKwYBBQUHAgIwLTAYFhFSZXBsYWNlIFRoaXMgVGV4dDADAgEBGhFSZXBsYWNlIFRoaXMgVGV4dDAOBgNVHQ8BAf8EBAMCAQYwHQYDVR0OBBYEFBx8HyadQAWl4BuB3UDx9zzFNkIzMA0GCSqGSIb3DQEBBQUAA4IBAQCe1G2hPsAA+RoNo0cVn1+Tec8SYdQBAF7qCnL9Fehau47e36fVGNizOkyIT9AHGor6R1LIahKX+E6mqQTYsznJS5hXJ8G8c0P0mxjVScb7ykwQ5wBYqXWM2bXKpiLTeYVWf1ArFWqp1y9G6R0AOanLjmwNRBArgyv6l1QZb7UM3Bf9S5l0urFML06En8B79lle5X32Iv9jfucu6caIrBLkPSx6Yq+q8ECs48NRSON+/Pqm9Hxw1H3/yz2qLG4zTI7xJVDESZGEXadLwCJXD6OReX2F/BtUd8q23djXZbVYiIfE9ebr4g3152BlVCHZ2GyPdjhIuLeH21VbT/dyEHHA",
      "signingCertificateExpiryDate": null,
      "authorityCertificateExpiryDate": null,
      "rootCertificateExpiryDate": null
    }
  }
}' WHERE id = (SELECT fk_id_cryptoConfig from SubIssuer where id = @subIssuerId);