import { ChangeDetectorRef, Component, EventEmitter, Input, OnInit, Output } from '@angular/core';
import { FormBuilderGroup } from './models/form-builder-group.model';
import { ControlTypes } from './models/control-type.enum';
import { FormControl, FormGroup } from '@angular/forms';

@Component({
  selector: 'form-builder',
  templateUrl: './form-builder.component.html',
  styleUrls: ['./form-builder.component.scss']
})
export class FormBuilderComponent implements OnInit {
  @Input("title") title: String;
  @Input("control-groups") ControlsGroups: FormBuilderGroup[];
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
  
  ngOnInit(): void {
  }

}
