import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { DashboardComponent } from './dashboard.component';

const routes: Routes = [
  {
    path: "",
    component: DashboardComponent,
    children: [
      {
        path: '',
        pathMatch: 'full',
        redirectTo: 'home'
      },
      {
        path: "home",
        loadChildren: () => import('./home/home.module').then(c => c.HomeModule)
      },
      {
        path: "users",
        loadChildren: () => import('./users/users.module').then(c => c.UsersModule)
      },
      {
        path: "roles",
        loadChildren: () => import('./roles/roles.module').then(c => c.RolesModule)
      },
      {
        path: "messages",
        loadChildren: () => import('./messages/messages.module').then(c => c.MessagesModule)
      },
      {
        path: "profile",
        loadChildren: () => import('./profile/profile.module').then(c => c.ProfileModule)
      },
      {
        path: "settings",
        loadChildren: () => import('./settings/settings.module').then(c => c.SettingsModule)
      },
      {
        path: "cms",
        loadChildren: () => import('./cms/cms.module').then(c => c.CmsModule)
      },
      {
        path: "cms",
        loadChildren: () => import('./cms/cms.module').then(c => c.CmsModule)
      },
      {
        path:"files-manager",
        loadChildren: () => import("./file-manager/file-manager.module").then(c => c.FileManagerModule)
      }
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class DashboardRoutingModule { }
