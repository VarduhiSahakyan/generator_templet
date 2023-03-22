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
public class Visa implements Serializable {

    @JsonProperty("signingCertificate")
    String signingCertificate;

    @JsonProperty("authorityCertificate")
    String authorityCertificate;

    @JsonProperty("rootCertificate")
    String rootCertificate;

}
