import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { ProductDetailRoutingModule } from './product-detail-routing.module';
import { ProductDetailComponent } from './product-detail.component';
import { SharedModule } from 'src/app/shared/shared.module';
import { FomanticUIModule } from 'ngx-fomantic-ui';
import { FormsModule } from '@angular/forms';


@NgModule({
  declarations: [
    ProductDetailComponent,

  ],
  imports: [
    CommonModule,
    ProductDetailRoutingModule,
    SharedModule,
    FomanticUIModule,
    FormsModule
  ]
})
export class ProductDetailModule { }
