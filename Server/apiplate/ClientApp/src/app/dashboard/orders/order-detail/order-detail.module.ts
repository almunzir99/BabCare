import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { OrderDetailRoutingModule } from './order-detail-routing.module';
import { OrderDetailComponent } from './order-detail.component';
import { SharedModule } from 'src/app/shared/shared.module';
import { FomanticUIModule } from 'ngx-fomantic-ui';
import { FormsModule } from '@angular/forms';
import { AgmCoreModule } from '@agm/core';


@NgModule({
  declarations: [
    OrderDetailComponent
  ],
  imports: [
    CommonModule,
    OrderDetailRoutingModule,
    SharedModule,
    FomanticUIModule,
    FormsModule,
    AgmCoreModule.forRoot({
      apiKey: 'AIzaSyDDkRc6lMOXlmRyWhv_2g0JbxJRQxKWsLc'
    })

  ]
})
export class OrderDetailModule { }
