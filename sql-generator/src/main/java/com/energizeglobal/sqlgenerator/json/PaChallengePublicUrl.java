package com.energizeglobal.sqlgenerator.json;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.Setter;

import javax.xml.bind.annotation.XmlRootElement;

@Getter
@Setter
@XmlRootElement
@JsonIgnoreProperties(ignoreUnknown = true)
public class PaChallengePublicUrl {

    @JsonProperty("Vendome")
    private String vendome;

    @JsonProperty("Seclin")
    private String seclin;

    @JsonProperty("Unknown")
    private String unknown;

}
