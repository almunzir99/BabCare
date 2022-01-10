import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { BranchesRoutingModule } from './branches-routing.module';
import { BranchesComponent } from './branches.component';


@NgModule({
  declarations: [
    BranchesComponent
  ],
  imports: [
    CommonModule,
    BranchesRoutingModule
  ]
})
export class BranchesModule { }
