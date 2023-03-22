package com.energizeglobal.sqlgenerator.json.general;

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
public class AcsBoGeneral implements Serializable {

    @JsonProperty("databaseACS_BO")
    private String databaseAcsBo;

    @JsonProperty("createdBy")
    private String createdBy;

    @JsonProperty("updateState")
    private String updateState;

    @JsonProperty("description")
    private String description;

    @JsonProperty("usedScheme")
    private List<String> usedScheme;

}
