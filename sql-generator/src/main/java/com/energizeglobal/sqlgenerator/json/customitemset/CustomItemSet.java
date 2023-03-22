package com.energizeglobal.sqlgenerator.json.customitemset;

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
public class CustomItemSet implements Serializable {

    @JsonProperty("description")
    private String description;

    @JsonProperty("name")
    private String name;

    @JsonProperty("versionNumber")
    private int versionNumber;

    @JsonProperty("status")
    private String status;

    @JsonProperty("subIssuerCode")
    private String subIssuerCode;

}
