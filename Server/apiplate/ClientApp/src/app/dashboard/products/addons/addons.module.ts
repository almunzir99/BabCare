import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { AddonsRoutingModule } from './addons-routing.module';
import { AddonsComponent } from './addons.component';
import { SharedModule } from 'src/app/shared/shared.module';
import { FomanticUIModule } from 'ngx-fomantic-ui';
import { FormsModule } from '@angular/forms';


@NgModule({
  declarations: [
    AddonsComponent
  ],
  imports: [
    CommonModule,
    AddonsRoutingModule,
    SharedModule,
    FomanticUIModule,
    FormsModule
  ]
})
export class AddonsModule { }
