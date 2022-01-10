import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { CmsRoutingModule } from './cms-routing.module';
import { FomanticUIModule } from 'ngx-fomantic-ui';
import { SharedModule } from 'src/app/shared/shared.module';
import { FormsModule } from '@angular/forms';
import { CmsComponent } from './cms.component';


@NgModule({
  declarations: [
    CmsComponent
  ],
  imports: [
    CommonModule,
    CmsRoutingModule,
    FomanticUIModule,
    SharedModule,
    FormsModule
  ]
})
export class CmsModule { }
