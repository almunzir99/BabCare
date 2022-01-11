import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { DeliveryRoutingModule } from './delivery-routing.module';
import { DeliveryComponent } from './delivery.component';
import { SharedModule } from 'src/app/shared/shared.module';
import { FormsModule } from '@angular/forms';
import { FomanticUIModule } from 'ngx-fomantic-ui';


@NgModule({
  declarations: [
    DeliveryComponent
  ],
  imports: [
    CommonModule,
    DeliveryRoutingModule,
    SharedModule,
    FormsModule,
    FomanticUIModule
  ]
})
export class DeliveryModule { }
