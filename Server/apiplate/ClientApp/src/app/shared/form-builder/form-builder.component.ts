import { ChangeDetectorRef, Component, EventEmitter, Input, OnInit, Output } from '@angular/core';
import { FormBuilderGroup } from './models/form-builder-group.model';
import { ControlTypes } from './models/control-type.enum';
import { FormControl, FormGroup } from '@angular/forms';
import { FormBuilderControl } from './models/form-builder-control.model';
import { Column } from '../data-table/models/column.model';

@Component({
  selector: 'form-builder',
  templateUrl: './form-builder.component.html',
  styleUrls: ['./form-builder.component.scss']
})
export class FormBuilderComponent implements OnInit {
  @Input("title") title: String;
  @Input("control-groups") ControlsGroups: FormBuilderGroup[];
  @Input("inner-form") innerForm:boolean = false; 
  @Output("submit") submitEventEmitter = new EventEmitter<any>();
  @Output("cancel") cancelEventEmitter = new EventEmitter<void>();
  formGroup: FormGroup;
  resultObject = {};
  controlTypes = ControlTypes;
  viewInitiated: boolean = false;
  constructor(private cdr: ChangeDetectorRef) {
  }
  
  initResult() {
    this.ControlsGroups.forEach(group => {
      group.controls.forEach(control => {

        this.resultObject[control.name] = control.value;
      });
    });
  }
  onSubmit() {
    this.submitEventEmitter.emit(this.resultObject);
  }
  onCancel() {
    console.log(this.resultObject);
    this.cancelEventEmitter.emit();
  }
  editorChange(controlName:string,content){
    this.resultObject[controlName] = content;
  }
  ngAfterContentInit() {
    this.initResult();
    this.formGroup  = new FormGroup({});
    this.ControlsGroups.forEach(group => {
      group.controls.forEach(control => {
        this.formGroup.addControl(control.name, new FormControl(control.name, control.validators));
      });
    });

  }
  ngAfterViewInit(){
    this.viewInitiated = true;
  }
  selectionChanged(controlName:string,value){
    this.resultObject[controlName]=value;
  }
  mapControlsToCols(groups:FormBuilderGroup[]) : Column[]
  {
      var cols : Column[] = [];
      groups.forEach(group =>{
        group.controls.forEach(control =>{
            var col:Column =  {title:control.title,prop:control.name,show:true};
            cols.push(col);
        });
      });
      cols.push({title:"الافعال",prop:"actions",show:true});
      return cols;
  }
  innerFormAdd(event,value:any[])
  {
    value.push({...event});
  }
  innerFormRemove(target,value:any[])
  {
    var index =  value.indexOf(target);
    console.log(index);
    value = value.splice(index,1);
  }

  ngOnInit(): void {
  }

}
