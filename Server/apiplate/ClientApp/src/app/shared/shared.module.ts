import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { DataTableComponent } from './data-table/data-table.component';
import { FomanticUIModule, FuiModal } from 'ngx-fomantic-ui';
import { MessageModalComponent } from './modals/message-modal/message-modal.component';
import { FormBuilderComponent } from './form-builder/form-builder.component';
import { FormBuilderModalComponent } from './modals/form-builder-modal/form-builder-modal.component';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { ImageLocalPickerComponent } from './image-local-picker/image-local-picker.component';
import { CustomSummernoteEditorComponent } from './custom-summernote-editor/custom-summernote-editor.component';
import { NgxSummernoteModule } from 'ngx-summernote';
import { PreloaderComponent } from './preloader/preloader.component';
import { AgmCoreModule } from '@agm/core';




@NgModule({
  declarations: [
    DataTableComponent,
    MessageModalComponent,
    FormBuilderComponent,
    FormBuilderModalComponent,
    ImageLocalPickerComponent,
    CustomSummernoteEditorComponent, 
    PreloaderComponent,
  ],
  imports: [
    CommonModule,
    FomanticUIModule,
    FormsModule,
    NgxSummernoteModule,
    ReactiveFormsModule,
    AgmCoreModule.forRoot({
      apiKey: 'AIzaSyCsE5KDJqjPpbTHsQFqSjnJHclQuCBw8c4'
    }),
    

  ],
  exports:[
    DataTableComponent,
    MessageModalComponent,
    FormBuilderComponent,
    ImageLocalPickerComponent,
    CustomSummernoteEditorComponent,
    PreloaderComponent,



  ],
   
  
})
export class SharedModule { }
