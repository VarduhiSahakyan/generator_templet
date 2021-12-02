
USE `U7G_ACS_BO`;

UPDATE `CryptoConfig` SET `protocolOne` = 
'{"acsIdForCrypto":"01","binKeyIdentifier":"1","informationalData":"","cardNetworkAlgorithmMap":{"VISA":"CAVV_V7","MASTERCARD":"HMAC_MASTERCARD_SPA"},"cardNetworkCertificateMap":{"VISA":{"authorityCertificate":"MIIFGzCCBAOgAwIBAgIRANh0YTBB/DxEoLzGXWw28RAwDQYJKoZIhvcNAQELBQAwazELMAkGA1UEBhMCVVMxDTALBgNVBAoTBFZJU0ExLzAtBgNVBAsTJlZpc2EgSW50ZXJuYXRpb25hbCBTZXJ2aWNlIEFzc29jaWF0aW9uMRwwGgYDVQQDExNWaXNhIGVDb21tZXJjZSBSb290MB4XDTE1MDYyNDE1MjcwNloXDTIyMDYyMjAwMTYwN1owcTELMAkGA1UEBhMCVVMxDTALBgNVBAoTBFZJU0ExLzAtBgNVBAsTJlZpc2EgSW50ZXJuYXRpb25hbCBTZXJ2aWNlIEFzc29jaWF0aW9uMSIwIAYDVQQDExlWaXNhIGVDb21tZXJjZSBJc3N1aW5nIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEArkmC50Q+GkmQyZ29kKxp1d+nJ43JwXhGZ7aFF1PiM5SlCESQ22qV/lBA3wHYYP8i17/GQQYNBiF3u4r6juXIHFwjwvKyFMF6kmBYXvcQa8Pd75FC1n3ffIrhEj+ldbmxidzK0hPfYyXEZqDpHhkunmvD7qz1BEWKE7NUYVFREfopViflKiVZcYrHi7CJAeBNY7dygvmIMnHUeH4NtDS5qf/n9DQQffVyn5hJWi5PeB87nTlty8zdji2tj7nA2+Y3PLKRJU3y1IbchqGlnXqxaaKfkTLNsiZq9PTwKaryH+um3tXf5u4mulzRGOWh2U+Uk4LntmMFCb/LqJkWnUVe+wIDAQABo4IBsjCCAa4wHwYDVR0jBBgwFoAUFTiDDz8sP3AzHs1G/geMIODXw7cwEgYDVR0TAQH/BAgwBgEB/wIBADA5BgNVHSAEMjAwMC4GBWeBAwEBMCUwIwYIKwYBBQUHAgEWF2h0dHA6Ly93d3cudmlzYS5jb20vcGtpMIIBCwYDVR0fBIIBAjCB/zA2oDSgMoYwaHR0cDovL0Vucm9sbC52aXNhY2EuY29tL1Zpc2FDQWVDb21tZXJjZVJvb3QuY3JsMDygOqA4hjZodHRwOi8vd3d3LmludGwudmlzYWNhLmNvbS9jcmwvVmlzYUNBZUNvbW1lcmNlUm9vdC5jcmwwgYaggYOggYCGfmxkYXA6Ly9FbnJvbGwudmlzYWNhLmNvbTozODkvY249VmlzYSBlQ29tbWVyY2UgUm9vdCxvPVZJU0Esb3U9VmlzYSBJbnRlcm5hdGlvbmFsIFNlcnZpY2UgQXNzb2NpYXRpb24/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdDAOBgNVHQ8BAf8EBAMCAQYwHQYDVR0OBBYEFN/DKlUuL0I6ekCdkqD3R3nXj4eKMA0GCSqGSIb3DQEBCwUAA4IBAQB9Y+F99thHAOhxZoQcT9CbConVCtbm3hWlf2nBJnuaQeoftdOKWtj0YOTj7PUaKOWfwcbZSHB63rMmLiVm7ZqIVndWxvBBRL1TcgbwagDnLgArQMKHnY2uGQfPjEMAkAnnWeYJfd+cRJVo6K3R4BbQGzFSHa2i2ar6/oXzINyaxAXdoG04Cz2P0Pm613hMCpjFyYilS/425he1Tk/vHsTnFwFlk9yY2L8VhBa6j40faaFu/6fin78Kopk96gHdAIN1tbA12NNmr7bQ1pUs0nKHhzQGoRXguYd7UYO9i2sNVC1C5A3F8dopwsv2QK2+33q05O2/4DgnF4m5us6RV94D","authorityCertificateExpiryDate":"22/06/2022","rootCertificate":"MIIDojCCAoqgAwIBAgIQE4Y1TR0/BvLB+WUF1ZAcYjANBgkqhkiG9w0BAQUFADBrMQswCQYDVQQGEwJVUzENMAsGA1UEChMEVklTQTEvMC0GA1UECxMmVmlzYSBJbnRlcm5hdGlvbmFsIFNlcnZpY2UgQXNzb2NpYXRpb24xHDAaBgNVBAMTE1Zpc2EgZUNvbW1lcmNlIFJvb3QwHhcNMDIwNjI2MDIxODM2WhcNMjIwNjI0MDAxNjEyWjBrMQswCQYDVQQGEwJVUzENMAsGA1UEChMEVklTQTEvMC0GA1UECxMmVmlzYSBJbnRlcm5hdGlvbmFsIFNlcnZpY2UgQXNzb2NpYXRpb24xHDAaBgNVBAMTE1Zpc2EgZUNvbW1lcmNlIFJvb3QwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvV95WHm6h2mCxlCfLF9sHP4CFT8icttD0b0/Pmdjh28JIXDqsOTPHH2qLJj0rNfVIsZHBAk4ElpF7sDPwsRROEW+1QK8bRaVK7362rPKgH1g/EkZgPI2h4H3PVz4zHvtH8aoVlwdVZqW1LS7YgFmypw23RuwhY/81q6UCzyr0TP579ZRdhE2o8mCP2w4lPJ9zcc+U30rq299yOIzzlr3xF7zSujtFWsan9sYXiwGd/BmoKoMWuDpI/k4+oKsGGelT84ATB+0tvz8KPFUgOSwsAGl0lUq8ILKpeeUYiZGo3BxN77t+Nwtd/jmliFKMAGzsGHxBvfaLdXe6YJ2E5/4tAgMBAAGjQjBAMA8GA1UdEwEB/wQFMAMBAf8wDgYDVR0PAQH/BAQDAgEGMB0GA1UdDgQWBBQVOIMPPyw/cDMezUb+B4wg4NfDtzANBgkqhkiG9w0BAQUFAAOCAQEAX/FBfXxcCLkr4NWSR/pnXKUTwwMhmytMiUbPWU3J/qVAtmPN3XEolWcRzCSs00Rsca4BIGsDoo8Ytyk6feUWYFN4PMCvFYP3j1IzJL1kk5fui/fbGKhtcbP3LBfQdCVp9/5rPJS+TUtBjE7ic9DjkCJzQ83z7+pzzkWKsKZJ/0x9nXGIxHYdkFsd7v3M9+79YKWxehZx0RbQfBI8bGmX265fOZpwLwU8GUYEmSA20GBuYQa7FkKMcPcw++DbZqMAAb3mLNqRX6BGi01qnD093QVG/na/oAo85ADmJ7f/hC3euiInlhBx6yLt398znM/jra6O1I7mT1GvFpLgXPYHDw==","rootCertificateExpiryDate":"24/06/2022","signingCertificate":"MIIFZzCCBE+gAwIBAgIQZt2mcCI+fjEs56HZebM/DzANBgkqhkiG9w0BAQsFADBxMQswCQYDVQQGEwJVUzENMAsGA1UEChMEVklTQTEvMC0GA1UECxMmVmlzYSBJbnRlcm5hdGlvbmFsIFNlcnZpY2UgQXNzb2NpYXRpb24xIjAgBgNVBAMTGVZpc2EgZUNvbW1lcmNlIElzc3VpbmcgQ0EwHhcNMjAwMjAzMDEyNDI3WhcNMjIwMjAyMDEyNDI3WjCBgzEPMA0GA1UEBwwGQmV6b25zMRYwFAYDVQQIDA1JbGUtZGUtRnJhbmNlMQswCQYDVQQGEwJGUjESMBAGA1UECgwJV29ybGRsaW5lMQ8wDQYDVQQLDAZVQlMgQUcxJjAkBgNVBAMMHVdMUC1BQ1MgVUJTIEFHIFNpZ25hdHVyZSBWSVNBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAwFiCiVhN93sT1BuXj29xtKdLksYB2p2CYsJrQW8fEvqYS1niX7Sd18/zPovDuTmwNOiPq+TDknhTPGLIR8BOzcWuDd/4tqFZuwaoQYRnwwuiqBg/73pwoT1mkCl7XDNRVpQB6rAgvZZr+uxE2qmY+aOzbcC9XA3zdoo00JQUjqSnGLr+xLSvyx9OwlzB5vEQ71+4cSZIX8sX1AV4PujkgWP30dDYRd8rHx0Wc9tryDH9U986UvJJU4pspNiNJGYXnevqC9ONwKWvstKlhk8a0ykHiT8yXLLMh9ylZ+grsM8bD6aZkbduE2Fomb7C3L5Op9pRxEHAcYlI4hXF1HFK7wIDAQABo4IB5jCCAeIwZQYIKwYBBQUHAQEEWTBXMC4GCCsGAQUFBzAChiJodHRwOi8vZW5yb2xsLnZpc2FjYS5jb20vZWNvbW0uY2VyMCUGCCsGAQUFBzABhhlodHRwOi8vb2NzcC52aXNhLmNvbS9vY3NwMB0GA1UdDgQWBBRPpi1jxBVXtBk5aKyQ8kNg03mEGDAMBgNVHRMBAf8EAjAAMB8GA1UdIwQYMBaAFN/DKlUuL0I6ekCdkqD3R3nXj4eKMDkGA1UdIAQyMDAwLgYFZ4EDAQEwJTAjBggrBgEFBQcCARYXaHR0cDovL3d3dy52aXNhLmNvbS9wa2kwgcoGA1UdHwSBwjCBvzAooCagJIYiaHR0cDovL0Vucm9sbC52aXNhY2EuY29tL2VDb21tLmNybDCBkqCBj6CBjIaBiWxkYXA6Ly9FbnJvbGwudmlzYWNhLmNvbTozODkvY249VmlzYSBlQ29tbWVyY2UgSXNzdWluZyBDQSxjPVVTLG91PVZpc2EgSW50ZXJuYXRpb25hbCBTZXJ2aWNlIEFzc29jaWF0aW9uLG89VklTQT9jZXJ0aWZpY2F0ZVJldm9jYXRpb25MaXN0MA4GA1UdDwEB/wQEAwIHgDATBgNVHSUEDDAKBggrBgEFBQcDAjANBgkqhkiG9w0BAQsFAAOCAQEALJ78C33ACBU/Z3urug0K1AV4bg24K09ra5/bVicULviUzCRlij/Ro9jyCUz5+xbFc3IBrqyCzN2u2XWo3dBTzK+h1oUyppGv2DcgM9HUCLADIAcvvH8/O14AoIbYE19BZ535zq/fH+f0tw4EVTUkXLoogXICvkhlLsEW3BUApAgXql/Qwuf+VwuE8ZzblMRIkQiB5/zvUxBBbjAY+26WXEPasASpt8Hg3Lv3gmW8M1EtzB+gkye7CaiyyCguzBhdXa4AYBMBike7z3UkBgEKJfaBe4y5aqpkN0gwzDlVlqqpSIFa/hx8yIPwYZPL0cTsuexLTN7m7ur8ihVpEneunA==","signingCertificateExpiryDate":"02/02/2022"},"MASTERCARD":{"authorityCertificate":"MIIEgDCCA2igAwIBAgIQQ3EBfDozHhKp3pmzcHr6ZzANBgkqhkiG9w0BAQUFADCBgDELMAkGA1UEBhMCVVMxHTAbBgNVBAoTFE1hc3RlckNhcmQgV29ybGR3aWRlMS4wLAYDVQQLEyVNYXN0ZXJDYXJkIFdvcmxkd2lkZSBTZWN1cmVDb2RlIEdlbiAyMSIwIAYDVQQDExlQUkQgTUMgU2VjdXJlQ29kZSBSb290IENBMB4XDTEyMDYyMjA5MjIxNFoXDTI1MDYyMTA5MjIxNVowgYYxCzAJBgNVBAYTAlVTMR0wGwYDVQQKExRNYXN0ZXJDYXJkIFdvcmxkd2lkZTEuMCwGA1UECxMlTWFzdGVyQ2FyZCBXb3JsZHdpZGUgU2VjdXJlQ29kZSBHZW4gMjEoMCYGA1UEAxMfUFJEIE1DIFNlY3VyZUNvZGUgSXNzdWVyIFN1YiBDQTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBANaeBgfjTKIFls7ueMTzI2nYwAbocHwkQqd8BsIyJbZdk21E+vyq9EhX1NIoiAhP7fl+y/hosX66drjfrbyspZLalrVG6gYbdB2j2Sr8zBRQnMZKKluDwYv/266nnRBeyGYW3FwyVu8L1ACYQc04ACke+07NI/AZ8OXQSoeboEEGUO520/76o1cER5Ok9HRi0jJD8E64j8dEt36Mcg0JaKQiDjShlyTw4ABYyzZ1Vxl0/iDrfwboxNEOOooC0rcGNnCpISXMWn2NmZH1QxiFt2jIZ8QzF3/z+M3iYradh9uZauleNqJ9LPKr/aFFDbe0Bv0PLbvXOnFpwOxvJODWUj8CAwEAAaOB7TCB6jAPBgNVHRMECDAGAQH/AgEAMA4GA1UdDwEB/wQEAwIBBjAdBgNVHQ4EFgQUwTArnR3hR1+Ij1uxMtqoPBm2j7swgacGA1UdIwSBnzCBnKGBhqSBgzCBgDELMAkGA1UEBhMCVVMxHTAbBgNVBAoTFE1hc3RlckNhcmQgV29ybGR3aWRlMS4wLAYDVQQLEyVNYXN0ZXJDYXJkIFdvcmxkd2lkZSBTZWN1cmVDb2RlIEdlbiAyMSIwIAYDVQQDExlQUkQgTUMgU2VjdXJlQ29kZSBSb290IENBghEA7qGSrpcB0q8DkgwCPcT3kzANBgkqhkiG9w0BAQUFAAOCAQEA3lJuYVdiy11ELUfBfLuib4gPTbkDdVLBEKosx0yUDczeXoTUOjBEc90f5KRjbpe4pilOGAQnPNUGpi3ZClS+0ysTBp6RdYz1efNLSuaTJtpJpoCOk1/nw6W+nJEWyDXUcC/yVqstZidcOG6AMfKU4EC5zBNELZCGf1ynM2l+gwvkcDUv4Y2et/n/NqIKBzywGSOktojTma0kHbkAe6pj6i65TpwEgEpywVl50oMmNKvXDNMznrAG6S9us+OHDjonOlmmyWmQxXdU1MzwdKzPjHfwl+Z6kByDXruHjEcNsx7P2rUTm/Bt3SWW1K48VfNNhVa/WctTZGJCrV3Zjl6A9g==","authorityCertificateExpiryDate":"21/06/2025","rootCertificate":"MIIDzzCCAregAwIBAgIRAO6hkq6XAdKvA5IMAj3E95MwDQYJKoZIhvcNAQEFBQAwgYAxCzAJBgNVBAYTAlVTMR0wGwYDVQQKExRNYXN0ZXJDYXJkIFdvcmxkd2lkZTEuMCwGA1UECxMlTWFzdGVyQ2FyZCBXb3JsZHdpZGUgU2VjdXJlQ29kZSBHZW4gMjEiMCAGA1UEAxMZUFJEIE1DIFNlY3VyZUNvZGUgUm9vdCBDQTAeFw0xMjA2MjIwOTA4MzBaFw0yNTA2MjIwOTA4MzFaMIGAMQswCQYDVQQGEwJVUzEdMBsGA1UEChMUTWFzdGVyQ2FyZCBXb3JsZHdpZGUxLjAsBgNVBAsTJU1hc3RlckNhcmQgV29ybGR3aWRlIFNlY3VyZUNvZGUgR2VuIDIxIjAgBgNVBAMTGVBSRCBNQyBTZWN1cmVDb2RlIFJvb3QgQ0EwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDptCms6aI22T9ST60k487SZP06TKbUBpom7Z1Bo8cQQAE/tM5UOt3THMdrhT+2aIkj9T0pA35IyNMCNGDt+ejhy7tHdw1r6eDX/KXYHb4FlemY03DwRrkQSH/L+ZueS5dCfLM3m2azxBXtrVXDdNebfht8tcWRLK2Ou6vjDzdIzunuWRZ6kRDQ6oc1LSVO2BxiFO0TKowJP/M7qWRT/Jsmb6TGg0vmmQG9QEpmVmOZIexVxuYy3rn7gEbV1tv3k4aG0USMp2Xq/Xe4qe+Ir7sFqR56G4yKezSVLUzQaIB/deeCk9WU2T0XmicAEYDBQoecoS61R4nj5ODmzwmGyxrlAgMBAAGjQjBAMA8GA1UdEwQIMAYBAf8CAQEwDgYDVR0PAQH/BAQDAgEGMB0GA1UdDgQWBBQqFTcxVDO/uxI1hpFF3VSSTFMGujANBgkqhkiG9w0BAQUFAAOCAQEAhDOQ5zUX2wByVv0Cqka3ebnm/6xRzQQbWelzneDUNVdctn1nhJt2PK1uGV7RBGAGukgdAubwwnBhD2FdbhBHTVbpLPYxBbdMAyeC8ezaXGirXOAAv0YbGhPl1MUFiDmqSliavBFUs4cEuBIas4BUoZ5Fz042dDSAWffbdf3l4zrU5Lzol93yXxxIjqgIsT3QI+sRM3gg/Gdwo80DUQ2fRffsGdAUH2C/8L8/wH+E9HspjMDkXlZohPII0xtKhdIPWzbOB6DOULl2PkdGHmJc4VXxfOwE2NJAQxmoaPRDYGgOFVvkzYtyxVkxXeXAPNt8URR3jfWvYrBGH2D5A44Atg==","rootCertificateExpiryDate":"22/06/2025","signingCertificate":"MIIEfTCCA2WgAwIBAgIQfke3dCXo6nXA+D3BCFWPCjANBgkqhkiG9w0BAQUFADCBhjELMAkGA1UEBhMCVVMxHTAbBgNVBAoTFE1hc3RlckNhcmQgV29ybGR3aWRlMS4wLAYDVQQLEyVNYXN0ZXJDYXJkIFdvcmxkd2lkZSBTZWN1cmVDb2RlIEdlbiAyMSgwJgYDVQQDEx9QUkQgTUMgU2VjdXJlQ29kZSBJc3N1ZXIgU3ViIENBMB4XDTIwMDExNzEzNDY0NFoXDTI0MDExNjEzMzkyNlowdzELMAkGA1UEBhMCRlIxFDASBgNVBAoTC1N3aXNza2V5IEFHMScwJQYDVQQLEx5BVE9TIFdvcmxkTGluZSBXTFAgLSBJQ0EgMjEwMTMxKTAnBgNVBAMTIFdMUC1BQ1MgU3dpc3NrZXkgQUcgU2lnbmF0dXJlIE1DMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA1wtqYdxnJOKQu0kuEVvAZ6POxUo0S75OzxVCKiaPH7FWr2SZjch8qKNBgKCo60i0PXCHRROAhvBXg04UfPKI4ytAzVsZudwToJqX8u1SR10SXriy2Wtxj29NktdCqqpupGtKKQP5SpV2/TkU+HBAaRQ3z+HAcTQm5bnnOc/3y4n3AhKicudDIk4HQs/givZY0tLG8a1E71GdD4D9/jwax5cJVKMN1W97nbi2uZe3eaCu5p9SXJn7gjOuKjIZIHlestezgpLcCoHvbP7Hx0/H+JjiXeSlPzFrCQ4o6tl9efNzDZlAdN4yQvUhu1HqA6dN4BO6Ocod8LmQxya1KbSUewIDAQABo4H0MIHxMCsGA1UdEAQkMCKADzIwMjAwMTE3MTM0NjQ0WoEPMjAyMzAxMTYxMzQ2NDRaMA4GA1UdDwEB/wQEAwIHgDAJBgNVHRMEAjAAMIGmBgNVHSMEgZ4wgZuhgYakgYMwgYAxCzAJBgNVBAYTAlVTMR0wGwYDVQQKExRNYXN0ZXJDYXJkIFdvcmxkd2lkZTEuMCwGA1UECxMlTWFzdGVyQ2FyZCBXb3JsZHdpZGUgU2VjdXJlQ29kZSBHZW4gMjEiMCAGA1UEAxMZUFJEIE1DIFNlY3VyZUNvZGUgUm9vdCBDQYIQQ3EBfDozHhKp3pmzcHr6ZzANBgkqhkiG9w0BAQUFAAOCAQEAsvubi1CXWeT6pkLh+IZdy0RNx9DOBIimQVSke2jeHQ18rU73UkVuj6fnSjczENKnATutIRECMncaO2iWeoo52r3RgjmmuFGV/cMy+Cwh9yzBac2t7TSib0o3LVNp2CzlbvHplVpx4Hm7DllQk8sxYLsBEtfpMg8IcPYY9Q5fSJvG/mCMSjwLqAhzBKyF4EPHNNq+Q6rjhZGg4VGjbb9twfRnnni3/pWiCZ1d3NV0wqrRszODK/LtC3Fr3a3OdGrYxn/37qof6Jzp6MVWM9hFie3EMSBX4b6IIRQJYmg6HSwrnroc/TEaglgJsOnmdR0WlER0M3zw4cbCbaxZgGXq+Q==","signingCertificateExpiryDate":"16/01/2024"}},"cardNetworkIdentifierMap":{"VISA":"2409250002314B434156565F4D555455553700","MASTERCARD":"2509250002314B4141565F4D5554555F483700"},"cardNetworkSeqGenerationMethodMap":{"VISA":"STRING_TIMESTAMP","MASTERCARD":"HEX_TIMESTAMP"},"cardNetworkSignatureKeyMap":{"VISA":"ED09250002314B544F525F5542535F5F5F5F00","MASTERCARD":"ED09250002314B544F525F4D5554555F553700"},"cavvKeyIndicator":"01","cipherKeyIdentifier":"EC09250002314B544F4B5F5542535F5F5F5F00","desCipherKeyIdentifier":"EC09250002314B544F4B5F4B454B5F41485300","desKeyId":"1","hubAESKey":"01","secondFactorAuthentication":"NO_SECOND_FACTOR"}'
WHERE `description` = 'CryptoConfig for UBS';