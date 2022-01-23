import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { OffersRoutingModule } from './offers-routing.module';
import { OffersComponent } from './offers.component';
import { SharedModule } from 'src/app/shared/shared.module';
import { FomanticUIModule } from 'ngx-fomantic-ui';
import { FormsModule } from '@angular/forms';


@NgModule({
  declarations: [
    OffersComponent
  ],
  imports: [
    CommonModule,
    OffersRoutingModule,
    SharedModule,
    FomanticUIModule,
    FormsModule

  ]
})
export class OffersModule { }
