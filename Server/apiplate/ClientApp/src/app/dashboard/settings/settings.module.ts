import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { SettingsRoutingModule } from './settings-routing.module';
import { FomanticUIModule } from 'ngx-fomantic-ui';
import { SharedModule } from 'src/app/shared/shared.module';
import { FormsModule } from '@angular/forms';


@NgModule({
  declarations: [],
  imports: [
    CommonModule,
    SettingsRoutingModule, 
    FomanticUIModule,
    SharedModule,
    FormsModule
  ]
})
export class SettingsModule { }
