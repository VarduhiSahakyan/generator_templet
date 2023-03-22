package com.energizeglobal.sqlgenerator.json.crypto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.Setter;

import javax.xml.bind.annotation.XmlRootElement;
import java.io.Serializable;

@Getter
@Setter
@XmlRootElement
@JsonIgnoreProperties(ignoreUnknown = true)
public class ProtocolTwo implements Serializable {

    @JsonProperty("cavvKeyIndicator")
    private String cavvKeyIndicator;

    @JsonProperty("cipherKeyIdentifier")
    private String cipherKeyIdentifier;

    @JsonProperty("acsIdForCrypto")
    private String acsIdForCrypto;

    @JsonProperty("binKeyIdentifier")
    private String binKeyIdentifier;

    @JsonProperty("hubAESKey")
    private String hubAESKey;

    @JsonProperty("informationalData")
    private String informationalData;

    @JsonProperty("cardNetworkAlgorithmMap")
    private CardNetworkAlgorithmMap cardNetworkAlgorithmMap;

    @JsonProperty("cardNetworkSeqGenerationMethodMap")
    private CardNetworkSeqGenerationMethodMap cardNetworkSeqGenerationMethodMap;

    @JsonProperty("cardNetworkIdentifierMap")
    private CardNetworkIdentifierMap cardNetworkIdentifierMap;

    @JsonProperty("cardNetworkSignatureKeyMap")
    private CardNetworkSignatureKeyMap cardNetworkSignatureKeyMap;

    @JsonProperty("acsSignedContentCertificateKeyMap")
    private AcsSignedContentCertificateKeyMap acsSignedContentCertificateKeyMap;

    @JsonProperty("acsSignedContentCertificateMap")
    private CardNetworkCertificateMap cardNetworkCertificateMap;

}
