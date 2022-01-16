import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { BranchesRoutingModule } from './branches-routing.module';
import { BranchesComponent } from './branches.component';
import { SharedModule } from 'src/app/shared/shared.module';
import { FomanticUIModule } from 'ngx-fomantic-ui';
import { FormsModule } from '@angular/forms';


@NgModule({
  declarations: [
    BranchesComponent
  ],
  imports: [
    CommonModule,
    BranchesRoutingModule,
    SharedModule,
    FomanticUIModule,
    FormsModule
  ]
})
export class BranchesModule { }
