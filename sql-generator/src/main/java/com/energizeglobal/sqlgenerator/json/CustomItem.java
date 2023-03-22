package com.energizeglobal.sqlgenerator.json;

import com.fasterxml.jackson.annotation.JsonProperty;

import javax.xml.bind.annotation.XmlRootElement;
import java.io.Serializable;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@XmlRootElement
public class CustomItem implements Serializable {

    @JsonProperty("DType")
    private String DType;

    @JsonProperty("name")
    private String name;

    @JsonProperty("ordinal")
    private int ordinal;

    @JsonProperty("pageType")
    private String pageType;

    @JsonProperty("locale")
    private String locale;

    @JsonProperty("value")
    private String value;

    @JsonProperty("network")
    private String network;

    @JsonProperty("associatedCardType")
    private String associatedCardType;

    @JsonProperty("subIssuerCode")
    private String subIssuerCode;

    @JsonProperty("imageBinaryDataKey")
    private String imageBinaryDataKey;

    @JsonProperty("messageCategory")
    private String messageCategory;

    @JsonProperty("threeDSRequestorAuthenticationIndicator")
    private String threeDSRequestorAuthenticationIndicator;

    @JsonProperty("updateMode")
    private String updateMode;

    public String getDType() { return DType; }

    public void setDType(String DType) { this.DType = DType; }

}
