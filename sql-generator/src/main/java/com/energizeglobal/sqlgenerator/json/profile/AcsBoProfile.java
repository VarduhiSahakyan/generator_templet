package com.energizeglobal.sqlgenerator.json.profile;

import com.energizeglobal.sqlgenerator.json.CustomItem;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.Setter;

import javax.xml.bind.annotation.XmlRootElement;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@XmlRootElement
@JsonIgnoreProperties(ignoreUnknown = true)
public class AcsBoProfile implements Serializable {

    @JsonProperty("name")
    private String name;

    @JsonProperty("description")
    private String description;

    @JsonProperty("maxAttempts")
    private int maxAttempts;

    @JsonProperty("dataEntryFormat")
    private String  dataEntryFormat;

    @JsonProperty("dataEntryAllowedPattern")
    private String dataEntryAllowedPattern;

    @JsonProperty("authenticationMethod")
    private String authenticationMethod = "10";

    @JsonProperty("authentMeans")
    private String authentMeans;

    @JsonProperty("isCallbackCompatible")
    private boolean isCallbackCompatible;

    @JsonProperty("customItems")
    private List<CustomItem> customItems;

//    public List<CustomItem> getCustomItems() {
//        List<CustomItem> filteredItems = new ArrayList<>();
//        if (customItems != null){
//            for (CustomItem customItem: customItems){
//                if ("insert".equalsIgnoreCase(customItem.getUpdateMode()) || "update".equalsIgnoreCase(customItem.getUpdateMode())){
//                    filteredItems.add(customItem);
//                }
//            }
//        }
//        return filteredItems;
//    }
}
