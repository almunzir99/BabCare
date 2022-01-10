import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { RolesRoutingModule } from './roles-routing.module';
import { RolesComponent } from './roles.component';
import { FomanticUIModule } from 'ngx-fomantic-ui';
import { SharedModule } from 'src/app/shared/shared.module';
import { FormsModule } from '@angular/forms';


@NgModule({
  declarations: [
    RolesComponent
  ],
  imports: [
    CommonModule, 
    RolesRoutingModule,
    FomanticUIModule,
    SharedModule,
    FormsModule
  ]
})
export class RolesModule { }
