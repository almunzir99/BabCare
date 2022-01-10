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
      },
      {
        path: "customers",
        loadChildren: () => import('./customers/customers.module').then(c => c.CustomersModule)
      },
      {
        path: "branches",
        loadChildren: () => import('./branches/branches.module').then(c => c.BranchesModule)
      },
      {
        path: "categories",
        loadChildren: () => import('./categories/categories.module').then(c => c.CategoriesModule)
      },
      {
        path: "delivery",
        loadChildren: () => import('./delivery/delivery.module').then(c => c.DeliveryModule)
      },
      {
        path: "orders",
        loadChildren: () => import('./orders/orders.module').then(c => c.OrdersModule)
      },
      {
        path: "offers",
        loadChildren: () => import('./offers/offers.module').then(c => c.OffersModule)
      },
      {
        path: "products",
        loadChildren: () => import('./products/products.module').then(c => c.ProductsModule)
      },
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class DashboardRoutingModule { }
