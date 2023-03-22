package com.energizeglobal.sqlgenerator.json.subissuer;

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
public class AcsBoSubIssuerConfig implements Serializable {

    @JsonProperty("defaultDelayInExemption")
    public boolean defaultDelayInExemption;

    @JsonProperty("authDataAddition")
    public boolean authDataAddition;

    @JsonProperty("defaultTransactionSearchPeriod")
    public boolean defaultTransactionSearchPeriod;

    @JsonProperty("displayCardExpiryDate")
    public boolean displayCardExpiryDate;

    @JsonProperty("changeCardStatus")
    public boolean changeCardStatus;

    @JsonProperty("displayCardId")
    public boolean displayCardId;

    @JsonProperty("displayCardUpdatedTime")
    public boolean displayCardUpdatedTime;

    @JsonProperty("displayCardDeletedTime")
    public boolean displayCardDeletedTime;

}
