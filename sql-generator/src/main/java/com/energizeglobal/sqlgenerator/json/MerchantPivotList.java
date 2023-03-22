package com.energizeglobal.sqlgenerator.json;

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
public class MerchantPivotList implements Serializable {

    @JsonProperty("level")
    private String level;

    @JsonProperty("keyword")
    private String keyword;

    @JsonProperty("type")
    private String type;

    @JsonProperty("amount")
    private int amount;

    @JsonProperty("display")
    private int display;

    @JsonProperty("forceAuthent")
    private boolean forceAuthent;

    @JsonProperty("expertMode")
    private int expertMode;

}
