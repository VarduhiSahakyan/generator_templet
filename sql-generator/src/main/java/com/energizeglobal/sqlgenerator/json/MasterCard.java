package com.energizeglobal.sqlgenerator.json;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MasterCard {

    @JsonProperty("operatorId")
    private String operatorId;

    @JsonProperty("dsKeyAlias")
    private String dsKeyAlias;

}
