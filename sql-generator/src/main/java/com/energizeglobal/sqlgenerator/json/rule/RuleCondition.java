package com.energizeglobal.sqlgenerator.json.rule;

import com.energizeglobal.sqlgenerator.json.conditionmeans.ConditionMeansProcessStatus;
import com.energizeglobal.sqlgenerator.json.conditionmeans.ConditionTransactionStatuses;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.Setter;

import javax.xml.bind.annotation.XmlRootElement;
import java.io.Serializable;
import java.util.List;

@Getter
@Setter
@XmlRootElement
@JsonIgnoreProperties(ignoreUnknown = true)
public class RuleCondition implements Serializable {

    @JsonProperty("transactionStatuses")
    private List<ConditionTransactionStatuses> transactionStatuses;

    @JsonProperty("meansProcessStatuses")
    private List<ConditionMeansProcessStatus> meansProcessStatuses;

}
