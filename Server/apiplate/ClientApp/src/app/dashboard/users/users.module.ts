import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { UsersRoutingModule } from './users-routing.module';
import { UsersComponent } from './users.component';
import { FomanticUIModule } from 'ngx-fomantic-ui';
import { SharedModule } from 'src/app/shared/shared.module';
import { FormsModule } from '@angular/forms';
import { FileManagerModule } from '../file-manager/file-manager.module';


@NgModule({
  declarations: [
    UsersComponent
  ],
  imports: [
    FomanticUIModule,
    CommonModule,
    UsersRoutingModule,
    SharedModule,
    FormsModule,
  ]
})
export class UsersModule { }
