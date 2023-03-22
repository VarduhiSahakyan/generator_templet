package com.energizeglobal.sqlgenerator.json.binrange;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.List;

@JsonIgnoreProperties(ignoreUnknown = true)
public class AcsBoBinRange {

    @JsonProperty("BinRanges")
    private List<BinRange> binRanges;

    public List<BinRange> getBinRanges() {
        return binRanges;
    }

}
