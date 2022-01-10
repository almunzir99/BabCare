import { Validators } from "@angular/forms";
import { ControlTypes } from "./control-type.enum";

export class FormBuilderControl {
        title:string;
        name:string;
        icon?:string;
        controlType :ControlTypes;
        width?:string = "100%";
        alignRight?:boolean = false;
        data?:any;
        value?:any; 
        validators?:Validators = [];
        //required for selection
        isObjectData?:boolean = false;
        labelProp?:string;
        valueProp?:string;


}