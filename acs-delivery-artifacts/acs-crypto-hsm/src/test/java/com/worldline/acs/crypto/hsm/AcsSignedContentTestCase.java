package com.worldline.acs.crypto.hsm;

import com.nimbusds.jose.util.Base64URL;
import com.worldline.acs.crypto.enums.SignatureAlgorithm;
import com.worldline.acs.crypto.exception.CryptoOperationFailedException;
import com.worldline.acs.crypto.hsm.model.AcsSignedContent;
import org.bouncycastle.jce.provider.BouncyCastleProvider;
import org.codehaus.jackson.map.ObjectMapper;
import org.jose4j.base64url.Base64Url;
import org.jose4j.jwk.EcJwkGenerator;
import org.jose4j.jwk.EllipticCurveJsonWebKey;
import org.jose4j.jwk.JsonWebKey;
import org.jose4j.jws.AlgorithmIdentifiers;
import org.jose4j.jws.JsonWebSignature;
import org.jose4j.jwx.CompactSerializer;
import org.jose4j.keys.EllipticCurves;
import org.jose4j.keys.X509Util;
import org.jose4j.lang.JoseException;
import org.jose4j.lang.StringUtil;
import org.junit.Assert;
import org.junit.Test;

import java.io.IOException;
import java.security.*;
import java.security.cert.X509Certificate;
import java.util.Arrays;
import java.util.Map;
import java.util.UUID;

public class AcsSignedContentTestCase {
    private static X509Certificate signingCertificate;
    private static X509Certificate rootCertificate;
    private static PrivateKey acsPrivateKey;
    private static PublicKey acsPublicKey;
    private ObjectMapper objectMapper = new ObjectMapper();

    static {
        try {
            Security.addProvider(new BouncyCastleProvider());
            KeyPairGenerator gen = KeyPairGenerator.getInstance("RSA");
            gen.initialize(2048);
            KeyPair key = gen.generateKeyPair();
            acsPrivateKey = key.getPrivate();
            acsPublicKey = key.getPublic();
            // certificate values don't matter for the test
            signingCertificate = rootCertificate= new X509Util().fromBase64Der("MIIDODCCAiCgAwIBAgIEWfb3fzANBgkqhkiG9w0BAQsFADBeMRAwDgYJKoZIhvcN\n" +
                "AQkBFgFlMQswCQYDVQQGEwJGUjELMAkGA1UECAwCc3QxCjAIBgNVBAcMAWwxCjAI\n" +
                "BgNVBAoMAW8xCzAJBgNVBAsMAm91MQswCQYDVQQDDAJjbjAeFw0xNzEwMzAwOTU3\n" +
                "NDFaFw0xODEwMzAwOTU3NDFaMF4xEDAOBgkqhkiG9w0BCQEWAWUxCzAJBgNVBAYT\n" +
                "AkZSMQswCQYDVQQIDAJzdDEKMAgGA1UEBwwBbDEKMAgGA1UECgwBbzELMAkGA1UE\n" +
                "CwwCb3UxCzAJBgNVBAMMAmNuMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC\n" +
                "AQEAr8jdTYRpfNOykmKwaJMT19dU5Kpa6Sb2bup/+z8hcBJNrdutBNC3TIAN8416\n" +
                "lFxrV9FUbkATtGiH2SS1n5BYH6y3ZQ3l2IFdURQiKZkT/WZcJpy8eWWcsANLZwFk\n" +
                "gCO/Kwfj7T7j/L1KE2Fov0e6H7eoDI5fK34DD6VHJzqReqpe5vi+5b4JhLOQwPT1\n" +
                "rUV6RGjGgu0QwN5CQNSYAWWsyu3jlM8/bgO74u93r874B4o4d/X1w8Iaiuod6mum\n" +
                "9hb+6UB7rOmEZeUDkoys0dnJD+YYQYyAJNzo+Z4EuIY5LGgv7fzLiCGz2wgKe5dO\n" +
                "I66YP+U1A3EdcbeCRZQ+lTMZDQIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQAywb9V\n" +
                "SaSB+D2sZWVfmk6Zrz7/aTlFA4zrBO2ZGLGxfqMb2ryfhg4hXjWJn2Jfo1PdQ1C8\n" +
                "CfYmsZxqsOv7BqJscu3/RwPHZ36AJENAKmtoSK1Ic+Jbp/o8iTOCqvBtH6Nx7LIc\n" +
                "6UGP3u84LrZoFGjWGZhKyZN2XY/QVKOxisxujb/HXbg/L11SOtGBmQCMezHufZ2S\n" +
                "cAWNqZaUqbx/6qlm6+rDUHNu8GGiJDD6L87eVi5b6lTyZ3dGEZdDY7aA0Ht5P7hS\n" +
                "aqqOWoyKUxvPFziv0Sc5IZGAJShsIiQYgQvtmvJ4Byb5qV4Ii3uePMInIArI3tGO\n" +
                "VceSAvGPMEGEeDIr");
        } catch (JoseException | NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
    }

    @Test
    public void itShouldCreateCorrectJWS() throws JoseException, IOException {
        String areqSdkEphemPubKey = "{\"kty\":\"EC\",\"x\":\"u4U-jQ82cJtkDdYa4qjEh7KhVUa9hVWNldczslNrkDg\",\"y\":\"TmtBbmvKDRE1rT0p2bk07WLeJLr_AQ4MF5YkI8E2N8Q\",\"crv\":\"P-256\"}";
        // generate the ACS ephemeral key pair
        EllipticCurveJsonWebKey acsKeyPair = EcJwkGenerator.generateJwk(EllipticCurves.P256);;
        acsKeyPair.setKeyId(UUID.randomUUID().toString());
        // rebuild the sdk ephemeral public key from JSON raw string
        EllipticCurveJsonWebKey sdkEphemPubKey = (EllipticCurveJsonWebKey) JsonWebKey.Factory.newJwk(areqSdkEphemPubKey);

        // build the JWS Payload according to the specs
        AcsJWSPayload acsJWSPayload = new AcsJWSPayload();
        acsJWSPayload.setAcsEphemPubKey(acsKeyPair.toParams(EllipticCurveJsonWebKey.OutputControlLevel.PUBLIC_ONLY));
        acsJWSPayload.setSdkEphemPubKey(sdkEphemPubKey.toParams(EllipticCurveJsonWebKey.OutputControlLevel.PUBLIC_ONLY));
        acsJWSPayload.setAcsURL("https://ssl-qlf-u9f-fo-acs-pa.wlp-acs.com/acs-challenge-service/challenge/challengeRequest");
        // serialize the payload for signature
        byte[] payload = objectMapper.writeValueAsBytes(acsJWSPayload);

        // generate JWS
        JsonWebSignature jws = new JsonWebSignature();
        jws.setCertificateChainHeaderValue(signingCertificate, rootCertificate);
        jws.setPayloadBytes(payload);
        jws.setAlgorithmHeaderValue(AlgorithmIdentifiers.RSA_PSS_USING_SHA256);
        jws.setKey(acsPrivateKey);
        String compactJws = jws.getCompactSerialization();

        // Verify JWS
        JsonWebSignature jsonWebSignature = new JsonWebSignature();
        jsonWebSignature.setCompactSerialization(compactJws);
        jsonWebSignature.setKey(acsPublicKey);
        Assert.assertTrue(jsonWebSignature.verifySignature());

    }

    @Test
    public void itShouldHaveSameHeaderWithObjectMapperOrToString() throws JoseException, IOException, CryptoOperationFailedException {
        // ######################################################################################
        // Initialization
        // ######################################################################################
        AcsJWSPayload acsJWSPayload = initJws();

        String signingCertificate = "MIIFtTCCA52gAwIBAgIGAWdkAsLYMA0GCSqGSIb3DQEBCwUAMHwxCzAJBgNVBAYTAk5MMSkwJwYDVQQKDCBVTCBUcmFuc2FjdGlvbiBTZWN1cml0eSBkaXZpc2lvbjEgMB4GA1UECwwXVUwgVFMgM0QtU2VjdXJlIFJPT1QgQ0ExIDAeBgNVBAMMF1VMIFRTIDNELVNlY3VyZSBST09UIENBMB4XDTE4MTEzMDA5NDYwMVoXDTE5MTEzMDA5NDYwMVowgacxCzAJBgNVBAYTAkZSMRMwEQYDVQQIDApTb21lLVN0YXRlMRUwEwYDVQQHDAxWaWxsZXVyYmFubmUxEjAQBgNVBAoMCVdvcmxkbGluZTEMMAoGA1UECwwDSVRBMQwwCgYDVQQDDANBQ1MxPDA6BgkqhkiG9w0BCQEWLWRsLWZyLWFjcy1wcm9kdWN0LXN1cHBvcnRAZXF1ZW5zd29ybGRsaW5lLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMkO9NLAcsw9P9K90pgpNlSY8pw47ZtQxEvjIYE1MQ1Ph6PQ3YRDPPHVN0UenQD+DAUFTOxtEk5A+1NFQYFwzjpmLv66AD5xSQ98ClhcSNfDOZ+uY/PWwfu3zcKbC7Q5WHq9CY7v7wgAc8e4oZJCzdCEZvuvCJzAwgr/avRUKwLQbksudrfAZpdEYbHW6Lbk2aeH9Te+oR4TUAGFw9c/N9QUmEHNN0unkX8dPrXWcNlLYtcRJBdwUgjHI4dACA61fuVRQwI+dRplU/BaeLo9gQ6A38gOGrKrLOI+gOqrxFXujmxjuOqw2rG65ebtI+CJ9eUesrUWa3ojvdm//EzY4B0CAwEAAaOCAQ8wggELMIGvBgNVHSMEgacwgaSAFJh2a4aLgmzAYDObAIgx79LwG3vyoYGApH4wfDELMAkGA1UEBhMCTkwxKTAnBgNVBAoMIFVMIFRyYW5zYWN0aW9uIFNlY3VyaXR5IGRpdmlzaW9uMSAwHgYDVQQLDBdVTCBUUyAzRC1TZWN1cmUgUk9PVCBDQTEgMB4GA1UEAwwXVUwgVFMgM0QtU2VjdXJlIFJPT1QgQ0GCCQCTL73rI5g8oTAdBgNVHQ4EFgQUY/V3v2wUVs2zdGHLXviT5/cu8lEwCQYDVR0TBAIwADAOBgNVHQ8BAf8EBAMCBeAwHQYDVR0lBBYwFAYIKwYBBQUHAwEGCCsGAQUFBwMCMA0GCSqGSIb3DQEBCwUAA4ICAQCLf83LgnEEtfuhQysRCxzxPBBs27+cfib9lttYMOHjdQc7FeKlbAQYYnrRKnp9+xoProoDxidNAwpobQ9xQDOYgDoeQY2bf+ngSmxKXdS6+oRzcdLglxpLYjkVmUy+ZaDJ6htLNvGmy6TnJxYOQD2/20/xGsy3JM7c9SOW/zCenvgPmYe2zhWMUPa8pKOD+eXWJfI+e/EwOMBqfyIFyFSF/+efEyB6THf7fiQ0MWI5Dtgy0rqtdvaGVt27HqyNl7PDLJJ7BdjTyhbz7NNppW5N5jf7ofKDGRTP2uLo6bebiP45FNFG8hmMe703E48MUqp9BWrU5v/DTdWfFwbdd6JPyu9+fBlc0bTCe5jJzEMQCw0EfhONbicnQ7Hjjo7HnqZ+IlUf0F1RiTHN20Ww1PzXZ+2dQToSxMMlv0rz1kRnnfQ1Px1UyZHhW7rl7pCsYKEhN9e7dA6bX+lTl1wgY08QePQZ6SYLj45QtdPfJ6nFhh/2t22r9+hYUz6mHruJ+luAho5s6/gl7BSP8TDpBlGw9wXouQWmNKdwCRWh45vyElrFgFQJQFAHKm3cQRYmi0ex2SjG/eJtzfj9TgJoGNDo3VOUEKVnyoNhsUtDuDZITMfSWaMTw0dAUIUFrTySEUPElF5gCit7EFC7BmRYQYm3ONgZiH6ixKXDj6n2mZtvng==";
        String authorityCertificate = "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";
        String rootCertificate =null;

        // ######################################################################################
        // logic
        // ######################################################################################
        AcsSignedContent acsSignedContent = new AcsSignedContent();
        //For this test, we assume that the signature has been already done
//		acsSignedContent.setSignature("eyJ4NWMiOlsiTUlJRnRUQ0NBNTJnQXdJQkFnSUdBV2RrQXNMWU1BMEdDU3FHU0liM0RRRUJDd1VBTUh3eEN6QUpCZ05WQkFZVEFrNU1NU2t3SndZRFZRUUtEQ0JWVENCVWNtRnVjMkZqZEdsdmJpQlRaV04xY21sMGVTQmthWFpwYzJsdmJqRWdNQjRHQTFVRUN3d1hWVXdnVkZNZ00wUXRVMlZqZFhKbElGSlBUMVFnUTBFeElEQWVCZ05WQkFNTUYxVk1JRlJUSURORUxWTmxZM1Z5WlNCU1QwOVVJRU5CTUI0WERURTRNVEV6TURBNU5EWXdNVm9YRFRFNU1URXpNREE1TkRZd01Wb3dnYWN4Q3pBSkJnTlZCQVlUQWtaU01STXdFUVlEVlFRSURBcFRiMjFsTFZOMFlYUmxNUlV3RXdZRFZRUUhEQXhXYVd4c1pYVnlZbUZ1Ym1VeEVqQVFCZ05WQkFvTUNWZHZjbXhrYkdsdVpURU1NQW9HQTFVRUN3d0RTVlJCTVF3d0NnWURWUVFEREFOQlExTXhQREE2QmdrcWhraUc5dzBCQ1FFV0xXUnNMV1p5TFdGamN5MXdjbTlrZFdOMExYTjFjSEJ2Y25SQVpYRjFaVzV6ZDI5eWJHUnNhVzVsTG1OdmJUQ0NBU0l3RFFZSktvWklodmNOQVFFQkJRQURnZ0VQQURDQ0FRb0NnZ0VCQU1rTzlOTEFjc3c5UDlLOTBwZ3BObFNZOHB3NDdadFF4RXZqSVlFMU1RMVBoNlBRM1lSRFBQSFZOMFVlblFEK0RBVUZUT3h0RWs1QSsxTkZRWUZ3empwbUx2NjZBRDV4U1E5OENsaGNTTmZET1ordVkvUFd3ZnUzemNLYkM3UTVXSHE5Q1k3djd3Z0FjOGU0b1pKQ3pkQ0VadnV2Q0p6QXdnci9hdlJVS3dMUWJrc3VkcmZBWnBkRVliSFc2TGJrMmFlSDlUZStvUjRUVUFHRnc5Yy9OOVFVbUVITk4wdW5rWDhkUHJYV2NObExZdGNSSkJkd1VnakhJNGRBQ0E2MWZ1VlJRd0krZFJwbFUvQmFlTG85Z1E2QTM4Z09HcktyTE9JK2dPcXJ4Rlh1am14anVPcXcyckc2NWVidEkrQ0o5ZVVlc3JVV2Ezb2p2ZG0vL0V6WTRCMENBd0VBQWFPQ0FROHdnZ0VMTUlHdkJnTlZIU01FZ2Fjd2dhU0FGSmgyYTRhTGdtekFZRE9iQUlneDc5THdHM3Z5b1lHQXBINHdmREVMTUFrR0ExVUVCaE1DVGt3eEtUQW5CZ05WQkFvTUlGVk1JRlJ5WVc1ellXTjBhVzl1SUZObFkzVnlhWFI1SUdScGRtbHphVzl1TVNBd0hnWURWUVFMREJkVlRDQlVVeUF6UkMxVFpXTjFjbVVnVWs5UFZDQkRRVEVnTUI0R0ExVUVBd3dYVlV3Z1ZGTWdNMFF0VTJWamRYSmxJRkpQVDFRZ1EwR0NDUUNUTDczckk1ZzhvVEFkQmdOVkhRNEVGZ1FVWS9WM3Yyd1VWczJ6ZEdITFh2aVQ1L2N1OGxFd0NRWURWUjBUQkFJd0FEQU9CZ05WSFE4QkFmOEVCQU1DQmVBd0hRWURWUjBsQkJZd0ZBWUlLd1lCQlFVSEF3RUdDQ3NHQVFVRkJ3TUNNQTBHQ1NxR1NJYjNEUUVCQ3dVQUE0SUNBUUNMZjgzTGduRUV0ZnVoUXlzUkN4enhQQkJzMjcrY2ZpYjlsdHRZTU9IamRRYzdGZUtsYkFRWVluclJLbnA5K3hvUHJvb0R4aWROQXdwb2JROXhRRE9ZZ0RvZVFZMmJmK25nU214S1hkUzYrb1J6Y2RMZ2x4cExZamtWbVV5K1phREo2aHRMTnZHbXk2VG5KeFlPUUQyLzIwL3hHc3kzSk03YzlTT1cvekNlbnZnUG1ZZTJ6aFdNVVBhOHBLT0QrZVhXSmZJK2UvRXdPTUJxZnlJRnlGU0YvK2VmRXlCNlRIZjdmaVEwTVdJNUR0Z3kwcnF0ZHZhR1Z0MjdIcXlObDdQRExKSjdCZGpUeWhiejdOTnBwVzVONWpmN29mS0RHUlRQMnVMbzZiZWJpUDQ1Rk5GRzhobU1lNzAzRTQ4TVVxcDlCV3JVNXYvRFRkV2ZGd2JkZDZKUHl1OStmQmxjMGJUQ2U1akp6RU1RQ3cwRWZoT05iaWNuUTdIampvN0hucVorSWxVZjBGMVJpVEhOMjBXdzFQelhaKzJkUVRvU3hNTWx2MHJ6MWtSbm5mUTFQeDFVeVpIaFc3cmw3cENzWUtFaE45ZTdkQTZiWCtsVGwxd2dZMDhRZVBRWjZTWUxqNDVRdGRQZko2bkZoaC8ydDIycjkraFlVejZtSHJ1SitsdUFobzVzNi9nbDdCU1A4VERwQmxHdzl3WG91UVdtTktkd0NSV2g0NXZ5RWxyRmdGUUpRRkFIS20zY1FSWW1pMGV4MlNqRy9lSnR6Zmo5VGdKb0dORG8zVk9VRUtWbnlvTmhzVXREdURaSVRNZlNXYU1UdzBkQVVJVUZyVHlTRVVQRWxGNWdDaXQ3RUZDN0JtUllRWW0zT05nWmlINml4S1hEajZuMm1adHZuZz09IiwiTUlJRjNqQ0NBOGFnQXdJQkFnSUpBSk12dmVzam1EeWhNQTBHQ1NxR1NJYjNEUUVCQ3dVQU1Id3hDekFKQmdOVkJBWVRBazVNTVNrd0p3WURWUVFLRENCVlRDQlVjbUZ1YzJGamRHbHZiaUJUWldOMWNtbDBlU0JrYVhacGMybHZiakVnTUI0R0ExVUVDd3dYVlV3Z1ZGTWdNMFF0VTJWamRYSmxJRkpQVDFRZ1EwRXhJREFlQmdOVkJBTU1GMVZNSUZSVElETkVMVk5sWTNWeVpTQlNUMDlVSUVOQk1CNFhEVEUyTVRJeU1ERXpOVEF3TlZvWERUTTJNVEl4TlRFek5UQXdOVm93ZkRFTE1Ba0dBMVVFQmhNQ1Rrd3hLVEFuQmdOVkJBb01JRlZNSUZSeVlXNXpZV04wYVc5dUlGTmxZM1Z5YVhSNUlHUnBkbWx6YVc5dU1TQXdIZ1lEVlFRTERCZFZUQ0JVVXlBelJDMVRaV04xY21VZ1VrOVBWQ0JEUVRFZ01CNEdBMVVFQXd3WFZVd2dWRk1nTTBRdFUyVmpkWEpsSUZKUFQxUWdRMEV3Z2dJaU1BMEdDU3FHU0liM0RRRUJBUVVBQTRJQ0R3QXdnZ0lLQW9JQ0FRREVmWTJ4dUxOak04LzN4ckc2emQ3RmJ1WEhmQ0ZpZUJFUlJ1R1FTTFlNbUVTNWtoZ2padGVONTlOZW9EYkl1M1hORkNtNFRSMlRUcFRkam1TRlU4ZUQxRTMrQ1hXOU02UWN6Q29UdTVPWmgraDZ5T1lUTUVrdCt3RGYzQzBoWmUvN2pqeTJQb2RpSEhmdWUwU1NaSUpRNVZtNHNVa21FRGJEYmNTZFJsRm14VWUyYXlYM3RsWXl4em1laFpTR1E4am1WaG5XMFhXZzM2bVFKTnN2WDJuTG5CQjU4RUUyR3RHZFg5Ym5LZFhOZlpUQVBTcmRTT25YTVA5N0doK1JwMXVkM1lBbmNLTzRST3ppTlNXanpEb2EwT2Z3bmFKV3N4Mkk2ZGJXQlBTNVFIUVp0bi93MGlIYXlwWG9UTWVaVWpJVlNyS0h4MFpBSHIzdjZwVUg2b3krUTlCOTM5RWxPZmxPcmFGeWRhbFBrMzNpK3R4QjZCenlMd2xzREdaYWVJbTRKYmxycWx4MFF5elFaL1QwYmFmYmZsbUZ6b2RsNlp2QWdTRDRPblBvNUFRN0RsNEU5WGlJYTg1bDBqbGI3MXMrWHkvOXBOQnZzcGQzS0hUdDBiL0o1ajdzelJrT2J0bmlrckZzRXU1NUhjUjloejVmRW9mb3ZjYmtMQkx2TkNMY1pyem1pREpoTDZXc3JwbzA3VW1ZLzlUL0RCbWpOT1RpREtrM2N5L045c1BqV2VvYXV5Q2Zmc242eUxuTkxaNGhzRCtIN3ZDcG9QTXh5RnhKYU5PYXd2MDhaRisxN3JxQ2N1UnBmUFU2VVdMTkNtQ0ExZlNNWWJjdE8yOFN0UzJvNmFjV0YzbllkcWduVlpDZzAvSDJNM2I1VE9lVm1BdUNRV0RWQWNveGdRSURBUUFCbzJNd1lUQWRCZ05WSFE0RUZnUVVtSFpyaG91Q2JNQmdNNXNBaURIdjB2QWJlL0l3SHdZRFZSMGpCQmd3Rm9BVW1IWnJob3VDYk1CZ001c0FpREh2MHZBYmUvSXdEd1lEVlIwVEFRSC9CQVV3QXdFQi96QU9CZ05WSFE4QkFmOEVCQU1DQVlZd0RRWUpLb1pJaHZjTkFRRUxCUUFEZ2dJQkFLUnM1Vm9lYnh1NHl6VE1JYzJuYndzb3hlMFpkQWlSVTQ0QW4zajRnend1cUNpYzgwSzRZbG9pRE9JQWZSV0c3SGJGMWJHMzdvU2ZRQmhSMFgyenZIL1I4QlZsU2ZhcW92cjc4ckdPeWVqTkFzdGZHcG1JYVlUMHp1RTJqdmplUitZS21GQ29ybmhCb2ptQUx6WU5RQmJGcExVQzQ1SGU4ejVnQjJqc252N2wwSFJzWEpHTjExYVVRdkpnd2pRVGJjNEZiQW5XSVd2QUtjVXR5ZVdpQ0J2RncvRlR4MjNaV01VVzhqTXJqZHlpUmFuN2RYYzZuNXZEL0RWM3R1TTVyTVdFQTV4MDdEOTdEVi93dnMvTThJOERMNm1JMnRFUGZ3VmYvUUlXNFVPTnBubEFoNmk5RGV2QitzS3JxcmlsWEU5MXBQT0NtQlhZWEJ4YkFQVzhNM0doN2syVlZXL2pMNGtxb0I0SGZIMElESHFJVmVTWGlyU0h4b3ZLL2ZHSXFqRXVlZExXek1NS1RjRWNZaTdMVlNxRnZGWVYva2hpbXVtQWw4U0ZWcEhRc1E3THZzS2ltMUNzdXBrTytmVWI0NGRrYVV1bTZRQy9pSW5rNzhLUmdHVjhYWkEyNXl3NHcvRkphV2VrMGpudUNKazdWKzc3TjZQR0swRnhtU2RySFJOek5Tb1RrbWE0UHRaSVRuR05UR3FYZVRWMEh2cjhDbGJRZkJXcHFhWnRLQjhkVGtoUkNUVVBhc1laWkxGdGoyWTJXY1hzaE1CQWhFbkJpQ3NvYUlHejF4eGN5Rkg0SW9pQzJHS2JmaTVwalhySGZScnRQSXIxQjQvdVdNSHhJdHRFRkszcUsvM1ZjMWJqZFg2SDRJVVdOVjYyUDUya3dkc01YTm9RNTVqdyJdLCJhbGciOiJQUzI1NiJ9.eyJhY3NFcGhlbVB1YktleSI6eyJrdHkiOiJFQyIsImtpZCI6IjdjZmYyOWI5LWQ1OWEtNDgxYi04YjkzLTFhNjZmNGM5MGM4YSIsIngiOiJkanUyY21GTFJPbnQ2emY3d091TnpfWlJRajVoWHZybUxEbW9ITE9aY0lFIiwieSI6InF5QXp0SFR5d29ORTVIeEY0RTJLMEhMQXg2ZFBJb1VwcGZKZE5qWjhLWTAiLCJjcnYiOiJQLTI1NiJ9LCJzZGtFcGhlbVB1YktleSI6eyJrdHkiOiJFQyIsIngiOiJ0Y0pZUGtGM19kVW1KOVF2T1JsQklYb2o4WlB4QVBvM0JJXzVIcGxqLXowIiwieSI6InBhVzJGR1g3Wl9VbFNZbkN3WUZxUGQzNXFsMzZBejhtNUl6YnRUZFBJYTAiLCJjcnYiOiJQLTI1NiJ9LCJhY3NVUkwiOiJodHRwczovL3NzbC1xbGYtdTlmLWZvLWFjcy1wYS53bHAtYWNzLmNvbS9hY3MtY2hhbGxlbmdlLWFwcC1zZXJ2aWNlL2NoYWxsZW5nZUFwcC9jaGFsbGVuZ2VSZXF1ZXN0L2FwcEJhc2UifQ");
        acsSignedContent.constructHeader(signingCertificate,authorityCertificate,rootCertificate,"PS256");
        acsSignedContent.setPayload(objectMapper.writeValueAsBytes(acsJWSPayload));

        String jwsToEvaluated = acsSignedContent.getCompactSerialization();

        String headerStringify = acsSignedContent.getHeader().toString();

        // ######################################################################################
        // tests
        // ######################################################################################
        Assert.assertEquals(new Base64Url().base64UrlEncodeUtf8ByteRepresentation(headerStringify),jwsToEvaluated.split("\\.")[0]);
    }

    @Test
    public void itShouldCreateAcsSignedContent() throws JoseException, IOException, CryptoOperationFailedException {
        // ######################################################################################
        // Initialization
        // ######################################################################################
        AcsJWSPayload acsJWSPayload = initJws();

        String signingCertificate = "MIIFtTCCA52gAwIBAgIGAWdkAsLYMA0GCSqGSIb3DQEBCwUAMHwxCzAJBgNVBAYTAk5MMSkwJwYDVQQKDCBVTCBUcmFuc2FjdGlvbiBTZWN1cml0eSBkaXZpc2lvbjEgMB4GA1UECwwXVUwgVFMgM0QtU2VjdXJlIFJPT1QgQ0ExIDAeBgNVBAMMF1VMIFRTIDNELVNlY3VyZSBST09UIENBMB4XDTE4MTEzMDA5NDYwMVoXDTE5MTEzMDA5NDYwMVowgacxCzAJBgNVBAYTAkZSMRMwEQYDVQQIDApTb21lLVN0YXRlMRUwEwYDVQQHDAxWaWxsZXVyYmFubmUxEjAQBgNVBAoMCVdvcmxkbGluZTEMMAoGA1UECwwDSVRBMQwwCgYDVQQDDANBQ1MxPDA6BgkqhkiG9w0BCQEWLWRsLWZyLWFjcy1wcm9kdWN0LXN1cHBvcnRAZXF1ZW5zd29ybGRsaW5lLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMkO9NLAcsw9P9K90pgpNlSY8pw47ZtQxEvjIYE1MQ1Ph6PQ3YRDPPHVN0UenQD+DAUFTOxtEk5A+1NFQYFwzjpmLv66AD5xSQ98ClhcSNfDOZ+uY/PWwfu3zcKbC7Q5WHq9CY7v7wgAc8e4oZJCzdCEZvuvCJzAwgr/avRUKwLQbksudrfAZpdEYbHW6Lbk2aeH9Te+oR4TUAGFw9c/N9QUmEHNN0unkX8dPrXWcNlLYtcRJBdwUgjHI4dACA61fuVRQwI+dRplU/BaeLo9gQ6A38gOGrKrLOI+gOqrxFXujmxjuOqw2rG65ebtI+CJ9eUesrUWa3ojvdm//EzY4B0CAwEAAaOCAQ8wggELMIGvBgNVHSMEgacwgaSAFJh2a4aLgmzAYDObAIgx79LwG3vyoYGApH4wfDELMAkGA1UEBhMCTkwxKTAnBgNVBAoMIFVMIFRyYW5zYWN0aW9uIFNlY3VyaXR5IGRpdmlzaW9uMSAwHgYDVQQLDBdVTCBUUyAzRC1TZWN1cmUgUk9PVCBDQTEgMB4GA1UEAwwXVUwgVFMgM0QtU2VjdXJlIFJPT1QgQ0GCCQCTL73rI5g8oTAdBgNVHQ4EFgQUY/V3v2wUVs2zdGHLXviT5/cu8lEwCQYDVR0TBAIwADAOBgNVHQ8BAf8EBAMCBeAwHQYDVR0lBBYwFAYIKwYBBQUHAwEGCCsGAQUFBwMCMA0GCSqGSIb3DQEBCwUAA4ICAQCLf83LgnEEtfuhQysRCxzxPBBs27+cfib9lttYMOHjdQc7FeKlbAQYYnrRKnp9+xoProoDxidNAwpobQ9xQDOYgDoeQY2bf+ngSmxKXdS6+oRzcdLglxpLYjkVmUy+ZaDJ6htLNvGmy6TnJxYOQD2/20/xGsy3JM7c9SOW/zCenvgPmYe2zhWMUPa8pKOD+eXWJfI+e/EwOMBqfyIFyFSF/+efEyB6THf7fiQ0MWI5Dtgy0rqtdvaGVt27HqyNl7PDLJJ7BdjTyhbz7NNppW5N5jf7ofKDGRTP2uLo6bebiP45FNFG8hmMe703E48MUqp9BWrU5v/DTdWfFwbdd6JPyu9+fBlc0bTCe5jJzEMQCw0EfhONbicnQ7Hjjo7HnqZ+IlUf0F1RiTHN20Ww1PzXZ+2dQToSxMMlv0rz1kRnnfQ1Px1UyZHhW7rl7pCsYKEhN9e7dA6bX+lTl1wgY08QePQZ6SYLj45QtdPfJ6nFhh/2t22r9+hYUz6mHruJ+luAho5s6/gl7BSP8TDpBlGw9wXouQWmNKdwCRWh45vyElrFgFQJQFAHKm3cQRYmi0ex2SjG/eJtzfj9TgJoGNDo3VOUEKVnyoNhsUtDuDZITMfSWaMTw0dAUIUFrTySEUPElF5gCit7EFC7BmRYQYm3ONgZiH6ixKXDj6n2mZtvng==";
        String authorityCertificate = "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";
        String rootCertificate =null;

        // ######################################################################################
        // logic
        // ######################################################################################
        AcsSignedContent acsSignedContent = new AcsSignedContent();
        //For this test, we assume that the signature has been already done
//		acsSignedContent.setSignature("eyJ4NWMiOlsiTUlJRnRUQ0NBNTJnQXdJQkFnSUdBV2RrQXNMWU1BMEdDU3FHU0liM0RRRUJDd1VBTUh3eEN6QUpCZ05WQkFZVEFrNU1NU2t3SndZRFZRUUtEQ0JWVENCVWNtRnVjMkZqZEdsdmJpQlRaV04xY21sMGVTQmthWFpwYzJsdmJqRWdNQjRHQTFVRUN3d1hWVXdnVkZNZ00wUXRVMlZqZFhKbElGSlBUMVFnUTBFeElEQWVCZ05WQkFNTUYxVk1JRlJUSURORUxWTmxZM1Z5WlNCU1QwOVVJRU5CTUI0WERURTRNVEV6TURBNU5EWXdNVm9YRFRFNU1URXpNREE1TkRZd01Wb3dnYWN4Q3pBSkJnTlZCQVlUQWtaU01STXdFUVlEVlFRSURBcFRiMjFsTFZOMFlYUmxNUlV3RXdZRFZRUUhEQXhXYVd4c1pYVnlZbUZ1Ym1VeEVqQVFCZ05WQkFvTUNWZHZjbXhrYkdsdVpURU1NQW9HQTFVRUN3d0RTVlJCTVF3d0NnWURWUVFEREFOQlExTXhQREE2QmdrcWhraUc5dzBCQ1FFV0xXUnNMV1p5TFdGamN5MXdjbTlrZFdOMExYTjFjSEJ2Y25SQVpYRjFaVzV6ZDI5eWJHUnNhVzVsTG1OdmJUQ0NBU0l3RFFZSktvWklodmNOQVFFQkJRQURnZ0VQQURDQ0FRb0NnZ0VCQU1rTzlOTEFjc3c5UDlLOTBwZ3BObFNZOHB3NDdadFF4RXZqSVlFMU1RMVBoNlBRM1lSRFBQSFZOMFVlblFEK0RBVUZUT3h0RWs1QSsxTkZRWUZ3empwbUx2NjZBRDV4U1E5OENsaGNTTmZET1ordVkvUFd3ZnUzemNLYkM3UTVXSHE5Q1k3djd3Z0FjOGU0b1pKQ3pkQ0VadnV2Q0p6QXdnci9hdlJVS3dMUWJrc3VkcmZBWnBkRVliSFc2TGJrMmFlSDlUZStvUjRUVUFHRnc5Yy9OOVFVbUVITk4wdW5rWDhkUHJYV2NObExZdGNSSkJkd1VnakhJNGRBQ0E2MWZ1VlJRd0krZFJwbFUvQmFlTG85Z1E2QTM4Z09HcktyTE9JK2dPcXJ4Rlh1am14anVPcXcyckc2NWVidEkrQ0o5ZVVlc3JVV2Ezb2p2ZG0vL0V6WTRCMENBd0VBQWFPQ0FROHdnZ0VMTUlHdkJnTlZIU01FZ2Fjd2dhU0FGSmgyYTRhTGdtekFZRE9iQUlneDc5THdHM3Z5b1lHQXBINHdmREVMTUFrR0ExVUVCaE1DVGt3eEtUQW5CZ05WQkFvTUlGVk1JRlJ5WVc1ellXTjBhVzl1SUZObFkzVnlhWFI1SUdScGRtbHphVzl1TVNBd0hnWURWUVFMREJkVlRDQlVVeUF6UkMxVFpXTjFjbVVnVWs5UFZDQkRRVEVnTUI0R0ExVUVBd3dYVlV3Z1ZGTWdNMFF0VTJWamRYSmxJRkpQVDFRZ1EwR0NDUUNUTDczckk1ZzhvVEFkQmdOVkhRNEVGZ1FVWS9WM3Yyd1VWczJ6ZEdITFh2aVQ1L2N1OGxFd0NRWURWUjBUQkFJd0FEQU9CZ05WSFE4QkFmOEVCQU1DQmVBd0hRWURWUjBsQkJZd0ZBWUlLd1lCQlFVSEF3RUdDQ3NHQVFVRkJ3TUNNQTBHQ1NxR1NJYjNEUUVCQ3dVQUE0SUNBUUNMZjgzTGduRUV0ZnVoUXlzUkN4enhQQkJzMjcrY2ZpYjlsdHRZTU9IamRRYzdGZUtsYkFRWVluclJLbnA5K3hvUHJvb0R4aWROQXdwb2JROXhRRE9ZZ0RvZVFZMmJmK25nU214S1hkUzYrb1J6Y2RMZ2x4cExZamtWbVV5K1phREo2aHRMTnZHbXk2VG5KeFlPUUQyLzIwL3hHc3kzSk03YzlTT1cvekNlbnZnUG1ZZTJ6aFdNVVBhOHBLT0QrZVhXSmZJK2UvRXdPTUJxZnlJRnlGU0YvK2VmRXlCNlRIZjdmaVEwTVdJNUR0Z3kwcnF0ZHZhR1Z0MjdIcXlObDdQRExKSjdCZGpUeWhiejdOTnBwVzVONWpmN29mS0RHUlRQMnVMbzZiZWJpUDQ1Rk5GRzhobU1lNzAzRTQ4TVVxcDlCV3JVNXYvRFRkV2ZGd2JkZDZKUHl1OStmQmxjMGJUQ2U1akp6RU1RQ3cwRWZoT05iaWNuUTdIampvN0hucVorSWxVZjBGMVJpVEhOMjBXdzFQelhaKzJkUVRvU3hNTWx2MHJ6MWtSbm5mUTFQeDFVeVpIaFc3cmw3cENzWUtFaE45ZTdkQTZiWCtsVGwxd2dZMDhRZVBRWjZTWUxqNDVRdGRQZko2bkZoaC8ydDIycjkraFlVejZtSHJ1SitsdUFobzVzNi9nbDdCU1A4VERwQmxHdzl3WG91UVdtTktkd0NSV2g0NXZ5RWxyRmdGUUpRRkFIS20zY1FSWW1pMGV4MlNqRy9lSnR6Zmo5VGdKb0dORG8zVk9VRUtWbnlvTmhzVXREdURaSVRNZlNXYU1UdzBkQVVJVUZyVHlTRVVQRWxGNWdDaXQ3RUZDN0JtUllRWW0zT05nWmlINml4S1hEajZuMm1adHZuZz09IiwiTUlJRjNqQ0NBOGFnQXdJQkFnSUpBSk12dmVzam1EeWhNQTBHQ1NxR1NJYjNEUUVCQ3dVQU1Id3hDekFKQmdOVkJBWVRBazVNTVNrd0p3WURWUVFLRENCVlRDQlVjbUZ1YzJGamRHbHZiaUJUWldOMWNtbDBlU0JrYVhacGMybHZiakVnTUI0R0ExVUVDd3dYVlV3Z1ZGTWdNMFF0VTJWamRYSmxJRkpQVDFRZ1EwRXhJREFlQmdOVkJBTU1GMVZNSUZSVElETkVMVk5sWTNWeVpTQlNUMDlVSUVOQk1CNFhEVEUyTVRJeU1ERXpOVEF3TlZvWERUTTJNVEl4TlRFek5UQXdOVm93ZkRFTE1Ba0dBMVVFQmhNQ1Rrd3hLVEFuQmdOVkJBb01JRlZNSUZSeVlXNXpZV04wYVc5dUlGTmxZM1Z5YVhSNUlHUnBkbWx6YVc5dU1TQXdIZ1lEVlFRTERCZFZUQ0JVVXlBelJDMVRaV04xY21VZ1VrOVBWQ0JEUVRFZ01CNEdBMVVFQXd3WFZVd2dWRk1nTTBRdFUyVmpkWEpsSUZKUFQxUWdRMEV3Z2dJaU1BMEdDU3FHU0liM0RRRUJBUVVBQTRJQ0R3QXdnZ0lLQW9JQ0FRREVmWTJ4dUxOak04LzN4ckc2emQ3RmJ1WEhmQ0ZpZUJFUlJ1R1FTTFlNbUVTNWtoZ2padGVONTlOZW9EYkl1M1hORkNtNFRSMlRUcFRkam1TRlU4ZUQxRTMrQ1hXOU02UWN6Q29UdTVPWmgraDZ5T1lUTUVrdCt3RGYzQzBoWmUvN2pqeTJQb2RpSEhmdWUwU1NaSUpRNVZtNHNVa21FRGJEYmNTZFJsRm14VWUyYXlYM3RsWXl4em1laFpTR1E4am1WaG5XMFhXZzM2bVFKTnN2WDJuTG5CQjU4RUUyR3RHZFg5Ym5LZFhOZlpUQVBTcmRTT25YTVA5N0doK1JwMXVkM1lBbmNLTzRST3ppTlNXanpEb2EwT2Z3bmFKV3N4Mkk2ZGJXQlBTNVFIUVp0bi93MGlIYXlwWG9UTWVaVWpJVlNyS0h4MFpBSHIzdjZwVUg2b3krUTlCOTM5RWxPZmxPcmFGeWRhbFBrMzNpK3R4QjZCenlMd2xzREdaYWVJbTRKYmxycWx4MFF5elFaL1QwYmFmYmZsbUZ6b2RsNlp2QWdTRDRPblBvNUFRN0RsNEU5WGlJYTg1bDBqbGI3MXMrWHkvOXBOQnZzcGQzS0hUdDBiL0o1ajdzelJrT2J0bmlrckZzRXU1NUhjUjloejVmRW9mb3ZjYmtMQkx2TkNMY1pyem1pREpoTDZXc3JwbzA3VW1ZLzlUL0RCbWpOT1RpREtrM2N5L045c1BqV2VvYXV5Q2Zmc242eUxuTkxaNGhzRCtIN3ZDcG9QTXh5RnhKYU5PYXd2MDhaRisxN3JxQ2N1UnBmUFU2VVdMTkNtQ0ExZlNNWWJjdE8yOFN0UzJvNmFjV0YzbllkcWduVlpDZzAvSDJNM2I1VE9lVm1BdUNRV0RWQWNveGdRSURBUUFCbzJNd1lUQWRCZ05WSFE0RUZnUVVtSFpyaG91Q2JNQmdNNXNBaURIdjB2QWJlL0l3SHdZRFZSMGpCQmd3Rm9BVW1IWnJob3VDYk1CZ001c0FpREh2MHZBYmUvSXdEd1lEVlIwVEFRSC9CQVV3QXdFQi96QU9CZ05WSFE4QkFmOEVCQU1DQVlZd0RRWUpLb1pJaHZjTkFRRUxCUUFEZ2dJQkFLUnM1Vm9lYnh1NHl6VE1JYzJuYndzb3hlMFpkQWlSVTQ0QW4zajRnend1cUNpYzgwSzRZbG9pRE9JQWZSV0c3SGJGMWJHMzdvU2ZRQmhSMFgyenZIL1I4QlZsU2ZhcW92cjc4ckdPeWVqTkFzdGZHcG1JYVlUMHp1RTJqdmplUitZS21GQ29ybmhCb2ptQUx6WU5RQmJGcExVQzQ1SGU4ejVnQjJqc252N2wwSFJzWEpHTjExYVVRdkpnd2pRVGJjNEZiQW5XSVd2QUtjVXR5ZVdpQ0J2RncvRlR4MjNaV01VVzhqTXJqZHlpUmFuN2RYYzZuNXZEL0RWM3R1TTVyTVdFQTV4MDdEOTdEVi93dnMvTThJOERMNm1JMnRFUGZ3VmYvUUlXNFVPTnBubEFoNmk5RGV2QitzS3JxcmlsWEU5MXBQT0NtQlhZWEJ4YkFQVzhNM0doN2syVlZXL2pMNGtxb0I0SGZIMElESHFJVmVTWGlyU0h4b3ZLL2ZHSXFqRXVlZExXek1NS1RjRWNZaTdMVlNxRnZGWVYva2hpbXVtQWw4U0ZWcEhRc1E3THZzS2ltMUNzdXBrTytmVWI0NGRrYVV1bTZRQy9pSW5rNzhLUmdHVjhYWkEyNXl3NHcvRkphV2VrMGpudUNKazdWKzc3TjZQR0swRnhtU2RySFJOek5Tb1RrbWE0UHRaSVRuR05UR3FYZVRWMEh2cjhDbGJRZkJXcHFhWnRLQjhkVGtoUkNUVVBhc1laWkxGdGoyWTJXY1hzaE1CQWhFbkJpQ3NvYUlHejF4eGN5Rkg0SW9pQzJHS2JmaTVwalhySGZScnRQSXIxQjQvdVdNSHhJdHRFRkszcUsvM1ZjMWJqZFg2SDRJVVdOVjYyUDUya3dkc01YTm9RNTVqdyJdLCJhbGciOiJQUzI1NiJ9.eyJhY3NFcGhlbVB1YktleSI6eyJrdHkiOiJFQyIsImtpZCI6IjdjZmYyOWI5LWQ1OWEtNDgxYi04YjkzLTFhNjZmNGM5MGM4YSIsIngiOiJkanUyY21GTFJPbnQ2emY3d091TnpfWlJRajVoWHZybUxEbW9ITE9aY0lFIiwieSI6InF5QXp0SFR5d29ORTVIeEY0RTJLMEhMQXg2ZFBJb1VwcGZKZE5qWjhLWTAiLCJjcnYiOiJQLTI1NiJ9LCJzZGtFcGhlbVB1YktleSI6eyJrdHkiOiJFQyIsIngiOiJ0Y0pZUGtGM19kVW1KOVF2T1JsQklYb2o4WlB4QVBvM0JJXzVIcGxqLXowIiwieSI6InBhVzJGR1g3Wl9VbFNZbkN3WUZxUGQzNXFsMzZBejhtNUl6YnRUZFBJYTAiLCJjcnYiOiJQLTI1NiJ9LCJhY3NVUkwiOiJodHRwczovL3NzbC1xbGYtdTlmLWZvLWFjcy1wYS53bHAtYWNzLmNvbS9hY3MtY2hhbGxlbmdlLWFwcC1zZXJ2aWNlL2NoYWxsZW5nZUFwcC9jaGFsbGVuZ2VSZXF1ZXN0L2FwcEJhc2UifQ");
        acsSignedContent.constructHeader(signingCertificate,authorityCertificate,rootCertificate,"PS256");
        acsSignedContent.setPayload(objectMapper.writeValueAsBytes(acsJWSPayload));

        String jwsToEvaluated = acsSignedContent.getCompactSerialization();

        // ######################################################################################
        // tests
        // ######################################################################################
        JsonWebSignature jsonWebSignature = new JsonWebSignature();
        jsonWebSignature.setCompactSerialization(jwsToEvaluated);

        Assert.assertEquals(acsSignedContent.getEncodedPayload(), jsonWebSignature.getEncodedPayload());
        Assert.assertEquals(acsSignedContent.getEncodedHeader(), Base64URL.encode(jsonWebSignature.getHeader()).toString());
        Assert.assertTrue(Arrays.equals(acsSignedContent.getSigningInputBytes(), StringUtil.getBytesAscii(jsonWebSignature.getHeaders().getEncodedHeader()+"."+jsonWebSignature.getEncodedPayload())));
    }

    private AcsJWSPayload initJws() throws JoseException {
        String areqSdkEphemPubKey = "{\"kty\":\"EC\",\"x\":\"tcJYPkF3_dUmJ9QvORlBIXoj8ZPxAPo3BI_5Hplj-z0\",\"y\":\"paW2FGX7Z_UlSYnCwYFqPd35ql36Az8m5IzbtTdPIa0\",\"crv\":\"P-256\"}";
        String acsPubKey = "{\"kty\":\"EC\",\"kid\":\"7cff29b9-d59a-481b-8b93-1a66f4c90c8a\",\"x\":\"dju2cmFLROnt6zf7wOuNz_ZRQj5hXvrmLDmoHLOZcIE\",\"y\":\"qyAztHTywoNE5HxF4E2K0HLAx6dPIoUppfJdNjZ8KY0\",\"crv\":\"P-256\"}";
        // generate the ACS ephemeral key pair
        // rebuild the sdk ephemeral public key from JSON raw string
        EllipticCurveJsonWebKey sdkEphemPubKey = (EllipticCurveJsonWebKey) JsonWebKey.Factory.newJwk(areqSdkEphemPubKey);
        EllipticCurveJsonWebKey acsEphemPubKey = (EllipticCurveJsonWebKey) JsonWebKey.Factory.newJwk(acsPubKey);

        // build the JWS Payload according to the specs
        AcsJWSPayload acsJWSPayload = new AcsJWSPayload();
        acsJWSPayload.setAcsEphemPubKey(acsEphemPubKey.toParams(EllipticCurveJsonWebKey.OutputControlLevel.PUBLIC_ONLY));
        acsJWSPayload.setSdkEphemPubKey(sdkEphemPubKey.toParams(EllipticCurveJsonWebKey.OutputControlLevel.PUBLIC_ONLY));
        acsJWSPayload.setAcsURL("https://ssl-qlf-u9f-fo-acs-pa.wlp-acs.com/acs-challenge-app-service/challengeApp/challengeRequest/appBase");
        return acsJWSPayload;
    }

    @Test
    public void itShouldDecodableBySDKLibrairies() throws Exception{
        AcsSignedContent acsSignedContent = new AcsSignedContent();

        acsSignedContent.constructHeader("a","a","a", SignatureAlgorithm.PS256.getAlgorithmName());
        acsSignedContent.setPayload("test".getBytes());
        acsSignedContent.setSignatureBytes("signature of  hedaer + test".getBytes());


        JsonWebSignature jsonWebSignature = new JsonWebSignature();
        jsonWebSignature.setCompactSerialization(acsSignedContent.getCompactSerialization());

        Assert.assertEquals(acsSignedContent.getEncodedHeader(),jsonWebSignature.getHeaders().getEncodedHeader());
        Assert.assertEquals(acsSignedContent.getEncodedPayload(),jsonWebSignature.getEncodedPayload());
        Assert.assertEquals(acsSignedContent.getEncodedSignature(),jsonWebSignature.getEncodedSignature());

        String signingInputString = CompactSerializer.serialize(jsonWebSignature.getHeaders().getEncodedHeader(), jsonWebSignature.getEncodedPayload());
        byte[] signingInputFromJose4J = StringUtil.getBytesAscii(signingInputString);

        Assert.assertTrue(Arrays.equals(acsSignedContent.getSigningInputBytes(),signingInputFromJose4J));
    }

    @Test(expected = CryptoOperationFailedException.class)
    public void itShouldThrowExceptionIfNotSigningCertificate() throws CryptoOperationFailedException {
        AcsSignedContent acsSignedContent = new AcsSignedContent();
        acsSignedContent.constructHeader(null,null,null,null);
    }

    public class AcsJWSPayload {

        private Map<String, Object> acsEphemPubKey;
        private Map<String, Object> sdkEphemPubKey;
        private String acsURL;

        public Map<String, Object> getAcsEphemPubKey() {
            return acsEphemPubKey;
        }

        public void setAcsEphemPubKey(Map<String, Object> acsEphemPubKey) {
            this.acsEphemPubKey = acsEphemPubKey;
        }

        public Map<String, Object> getSdkEphemPubKey() {
            return sdkEphemPubKey;
        }

        public void setSdkEphemPubKey(Map<String, Object> sdkEphemPubKey) {
            this.sdkEphemPubKey = sdkEphemPubKey;
        }

        public String getAcsURL() {
            return acsURL;
        }

        public void setAcsURL(String acsURL) {
            this.acsURL = acsURL;
        }
    }
}
