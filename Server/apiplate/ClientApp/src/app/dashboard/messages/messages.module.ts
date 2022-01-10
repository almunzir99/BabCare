import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { MessagesRoutingModule } from './messages-routing.module';
import { FomanticUIModule } from 'ngx-fomantic-ui';
import { SharedModule } from 'src/app/shared/shared.module';
import { FormsModule } from '@angular/forms';
import { MessagesComponent } from './messages.component';


@NgModule({
  declarations: [
    MessagesComponent
  ],
  imports: [
    CommonModule,
    MessagesRoutingModule,
    FomanticUIModule,
    SharedModule,
    FormsModule
  ]
})
export class MessagesModule { }
