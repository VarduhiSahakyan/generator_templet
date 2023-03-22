package com.energizeglobal.sqlgenerator.json.rule;

import com.energizeglobal.sqlgenerator.json.profile.AcsBoProfile;
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
public class Rule implements Serializable {

    @JsonProperty("ruleName")
    private String ruleName;

    @JsonProperty("ruleOrder")
    private String ruleOrder;

    @JsonProperty("conditions")
    private List<RuleCondition> conditions;

    @JsonProperty("profile")
    private AcsBoProfile profile;

}
