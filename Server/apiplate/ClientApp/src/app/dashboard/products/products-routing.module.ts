import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { ProductsComponent } from './products.component';

const routes: Routes = [
  {
    path:'',
    redirectTo:'all',
    pathMatch:"full"
  },
  {
    path:'all',
    component:ProductsComponent
  },
  {
    path:'options',
    loadChildren:() => import("./options/options.module").then(c => c.OptionsModule)
  },
  {
    path:'addons',
    loadChildren:() => import("./addons/addons.module").then(c => c.AddonsModule)
  },
  {
    path:":id",
    loadChildren:() => import("./product-detail/product-detail.module").then(c => c.ProductDetailModule)
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ProductsRoutingModule { }
