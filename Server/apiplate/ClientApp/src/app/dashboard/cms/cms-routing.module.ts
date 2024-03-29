import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { CmsComponent } from './cms.component';

const routes: Routes = [
  {
    path:'',
    component:CmsComponent
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class CmsRoutingModule { }
