package com.energizeglobal.sqlgenerator.json;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.Setter;

import javax.xml.bind.annotation.XmlRootElement;

@Getter
@Setter
@XmlRootElement
@JsonIgnoreProperties(ignoreUnknown = true)
public class CustomPageLayout {

    @JsonProperty("controller")
    private String controller;

    @JsonProperty("pageType")
    private String pageType;

    @JsonProperty("description")
    private String description;

    @JsonProperty("subIssuerCode")
    String subIssuerCode;
    
}
