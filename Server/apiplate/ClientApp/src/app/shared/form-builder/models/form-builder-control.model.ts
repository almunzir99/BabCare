import { Validators } from "@angular/forms";
import { Column } from "../../data-table/models/column.model";
import { ControlTypes } from "./control-type.enum";
import { FormBuilderGroup } from "./form-builder-group.model";

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
        // required for table builder
        controls?:FormBuilderGroup[]


} 