import { NgModule } from "@angular/core";
import { RouterModule, Routes } from "@angular/router";
import { AuthGuard } from "./core/guards/auth.guard";

const routes: Routes = [
  
    {
        path: '',
        pathMatch: 'full',
        redirectTo: 'dashboard'
    },
    {

        path: "login",
        loadChildren:() => import("./public/public.module").then(c => c.PublicModule)
    },
    {
        path:"dashboard",
        canActivate: [AuthGuard],
        loadChildren:() =>  import("./dashboard/dashboard.module").then(c => c.DashboardModule)
        
    }
  ];
  
  @NgModule({
    imports: [RouterModule.forRoot(routes)],
    exports: [RouterModule]
  })
  export class AppRoutingModule { }
  