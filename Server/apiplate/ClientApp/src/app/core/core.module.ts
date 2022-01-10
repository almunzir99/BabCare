import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FomanticUIModule } from 'ngx-fomantic-ui';
import { SharedModule } from '../shared/shared.module';
import { FormsModule } from '@angular/forms';
import { RouterModule } from '@angular/router';



@NgModule({
  declarations: [    
  ],
  imports: [
    CommonModule,
    FomanticUIModule,
    SharedModule, 
    FormsModule,
    RouterModule



  ]
})
export class CoreModule { }
