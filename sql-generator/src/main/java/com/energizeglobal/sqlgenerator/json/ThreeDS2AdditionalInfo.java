package com.energizeglobal.sqlgenerator.json;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

@Getter
@Setter
public class ThreeDS2AdditionalInfo implements Serializable {

    VisaObj visaObj = new VisaObj();

    MasterCard masterCard = new MasterCard();

}
