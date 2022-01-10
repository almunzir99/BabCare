import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { ChangePasswordComponent } from './change-password/change-password.component';
import { ProfileComponent } from './profile.component';

const routes: Routes = [
  {
    path:'',
    redirectTo:"edit",
    pathMatch:"full"
  },
  {
    path:'edit',
    component:ProfileComponent,
    
  },
  {
    path:'password',
    component:ChangePasswordComponent,
    
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ProfileRoutingModule { }
