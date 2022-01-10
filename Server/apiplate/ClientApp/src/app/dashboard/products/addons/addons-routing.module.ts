import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { AddonsComponent } from './addons.component';

const routes: Routes = [
  {
    path:'',
    component:AddonsComponent
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class AddonsRoutingModule { }
