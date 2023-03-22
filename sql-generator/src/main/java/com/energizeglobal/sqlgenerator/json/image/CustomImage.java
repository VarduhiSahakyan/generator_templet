package com.energizeglobal.sqlgenerator.json.image;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@JsonIgnoreProperties(ignoreUnknown = true)
public class CustomImage {

    @JsonProperty("name")
    private String imageName;

    @JsonProperty("imageFilePath")
    private String imageFilePath;

    @JsonProperty("binaryData")
    private String binaryData;

}
