package com.energizeglobal.sqlgenerator.json.conditionmeans;

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
public class ConditionMeansProcessStatus implements Serializable {

    @JsonProperty("meansProcessStatusType")
    private String meansProcessStatusType;

    @JsonProperty("reversed")
    private boolean reversed;

    @JsonProperty("authentMeans")
    private String authentMeans;

    @JsonProperty("ruleConditionName")
    private String ruleConditionName;

}
