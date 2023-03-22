package com.energizeglobal.sqlgenerator.json.binrange;

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
public class BinRange implements Serializable {

    @JsonProperty("activeState")
    private String activeState;

    @JsonProperty("name")
    private String name;

    @JsonProperty("immediateActivation")
    private boolean immediateActivation;

    @JsonProperty("associatedCardType")
    private String associatedCardType = "NONE";

    @JsonProperty("virtualCardsOnly")
    private boolean virtualCardsOnly;

    @JsonProperty("lowerBound")
    private String lowerBound;

    @JsonProperty("panLength")
    private String panLength;

    @JsonProperty("sharedBinRange")
    private boolean sharedBinRange;

    @JsonProperty("upperBound")
    private String upperBound;

    @JsonProperty("network")
    private String network;

    @JsonProperty("toExport")
    private boolean toExport;

    @JsonProperty("subIssuerCode")
    private String subIssuerCode;

}
