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
  @Input("inner-form") innerForm: boolean = false;
  @Output("submit") submitEventEmitter = new EventEmitter<any>();
  @Output("cancel") cancelEventEmitter = new EventEmitter<void>();
  @Output("tableDelete") tableDeleteEvent = new EventEmitter<any>();
  formGroup: FormGroup;
  resultObject = {};
  controlTypes = ControlTypes;
  viewInitiated: boolean = false;
  lat = 0.0;
  long = 0.0;
  zoom = 15;
  constructor(private cdr: ChangeDetectorRef) {
  }

  initResult() {

    this.ControlsGroups.forEach(group => {
      group.controls.forEach(control => {

        if (control.controlType == ControlTypes.MapPicker && control.value == null && control.value == undefined) {
          control.value = {
            lat: this.lat,
            long: this.long
          }

        }
        this.resultObject[control.name] = control.value;

      });
    });
    console.log(this.resultObject);
  }
  onSubmit() {
    this.submitEventEmitter.emit(this.resultObject);
  }
  onCancel() {
    console.log(this.resultObject);
    this.cancelEventEmitter.emit();
  }
  editorChange(controlName: string, content) {
    this.resultObject[controlName] = content;
  }
  ngAfterContentInit() {
    this.initResult();
    this.setMapLocation();
    this.formGroup = new FormGroup({});
    this.ControlsGroups.forEach(group => {
      group.controls.forEach(control => {
        this.formGroup.addControl(control.name, new FormControl(control.value, control.validators));
      });
    });
    this.cdr.detectChanges();

  }
  ngAfterViewInit() {
    this.viewInitiated = true;
  }
  selectionChanged(controlName: string, value) {
    this.resultObject[controlName] = value;
  }
  mapControlsToCols(groups: FormBuilderGroup[]): Column[] {
    var cols: Column[] = [];
    groups.forEach(group => {
      group.controls.forEach(control => {
        var col: Column = { title: control.title, prop: control.name, show: true };
        cols.push(col);
      });
    });
    cols.push({ title: "الافعال", prop: "actions", show: true });
    return cols;
  }
  innerFormAdd(event, value: any[]) {
    value.push({ ...event });
  }
  innerFormRemove(target, values: any[]) {
    this.tableDeleteEvent.emit({ target: target, values: values });
  }
  // Configure map
  private setMapLocation() {
    if ("geolocation" in navigator) {
      navigator.geolocation.getCurrentPosition(pos => {
        console.log(pos);
        this.lat = pos.coords.latitude;
        this.long = pos.coords.longitude;
        this.initResult();


      } );

    }
  }
  ngOnInit(): void {

  }
  changeMarkCoords(event, control) {
    control.value['lat'] = event.coords.lat;
    control.value['long'] = event.coords.lng;
    console.log(control.value);
  }
}
