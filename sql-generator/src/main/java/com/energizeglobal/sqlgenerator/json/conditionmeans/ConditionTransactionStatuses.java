package com.energizeglobal.sqlgenerator.json.conditionmeans;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.Setter;

import javax.xml.bind.annotation.XmlRootElement;

@Getter
@Setter
@XmlRootElement
@JsonIgnoreProperties(ignoreUnknown = true)
public class ConditionTransactionStatuses {

    @JsonProperty("ruleConditionName")
    private String ruleConditionName;

    @JsonProperty("transactionStatusType")
    private String transactionStatusType;

    @JsonProperty("reversed")
    private String reversed;

    @JsonProperty("subIssuerCode")
    private String subIssuerCode;
}
