package com.energizeglobal.sqlgenerator.json;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

import javax.xml.bind.annotation.XmlRootElement;
import java.io.Serializable;

@Data
@XmlRootElement
@JsonIgnoreProperties(ignoreUnknown = true)
public class CurrencyFormat implements Serializable {

    @JsonProperty("useAlphaCurrencySymbol")
    private boolean useAlphaCurrencySymbol;

    @JsonProperty("currencySymbolPosition")
    private String currencySymbolPosition;

    @JsonProperty("decimalDelimiter")
    private String decimalDelimiter;

    @JsonProperty("thousandDelimiter")
    private String thousandDelimiter;

}
