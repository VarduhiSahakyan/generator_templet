package com.energizeglobal.sqlgenerator.json;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.Setter;

import javax.xml.bind.annotation.XmlRootElement;
import java.util.List;

@Getter
@Setter
@XmlRootElement
@JsonIgnoreProperties(ignoreUnknown = true)
public class Issuer {

    @JsonProperty("issuerCode")
    String code;

    @JsonProperty("issuerName")
    String name;

    @JsonProperty("issuerLabel")
    String label;

    @JsonProperty("updateMode")
    String updateMode;

    @JsonProperty("issuerAvailaibleAuthentMean")
    List<String> availaibleAuthentMean;

    public String getAvailaibleAuthentMean() {
        return String.join("|", availaibleAuthentMean);
    }
}
