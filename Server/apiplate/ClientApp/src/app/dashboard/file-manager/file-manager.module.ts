import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { FileManagerRoutingModule } from './file-manager-routing.module';
import { FomanticUIModule } from 'ngx-fomantic-ui';
import { SharedModule } from 'src/app/shared/shared.module';
import { FormsModule } from '@angular/forms';
import { FileManagerComponent } from './file-manager.component';
import { FileManagerModalComponent } from './file-manager-modal/file-manager-modal.component';
 

@NgModule({
  declarations: [
    FileManagerComponent,
    FileManagerModalComponent
  ],
  imports: [
    CommonModule,
    FileManagerRoutingModule,
    FomanticUIModule,
    SharedModule,
    FormsModule,
  ],
  exports : [
    FileManagerComponent,
    FileManagerModalComponent

  ]
})
export class FileManagerModule { }
