import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { AddonsRoutingModule } from './addons-routing.module';
import { AddonsComponent } from './addons.component';


@NgModule({
  declarations: [
    AddonsComponent
  ],
  imports: [
    CommonModule,
    AddonsRoutingModule
  ]
})
export class AddonsModule { }
