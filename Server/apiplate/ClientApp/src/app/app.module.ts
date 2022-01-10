import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { HttpClientModule, HTTP_INTERCEPTORS } from '@angular/common/http';
import { AppComponent } from './app.component'; 
import { FomanticUIModule } from 'ngx-fomantic-ui';
import { SharedModule } from './shared/shared.module';
import { CoreModule } from './core/core.module';
import { JwtInterceptor } from './core/interceptors/jwt.interceptor';
import { MessageModalComponent } from './shared/modals/message-modal/message-modal.component';
import { FormBuilderModalComponent } from './shared/modals/form-builder-modal/form-builder-modal.component';
import { AccessDeniedInterceptor } from './core/interceptors/access-denied.interceptor';
import { ErrorInterceptor } from './core/interceptors/error.interceptor';
import { environment } from 'src/environments/environment';
import { FileManagerModalComponent } from './dashboard/file-manager/file-manager-modal/file-manager-modal.component';
import { FileManagerModule } from './dashboard/file-manager/file-manager.module';
import { AppRoutingModule } from './app-routing.module';

@NgModule({
  declarations: [
    AppComponent,
 
  ],
  imports: [
    BrowserModule.withServerTransition({ appId: 'ng-cli-universal' }),
    AppRoutingModule,
    HttpClientModule,
    FormsModule,
    FomanticUIModule,
    SharedModule,
    CoreModule,
    FileManagerModule,

  ],
  providers: [
    {
      provide:"DIRECTION",
      useValue: environment.direction
    },
    { provide: HTTP_INTERCEPTORS, useClass: JwtInterceptor, multi: true },
    { provide: HTTP_INTERCEPTORS, useClass: AccessDeniedInterceptor, multi: true },
    { provide: HTTP_INTERCEPTORS, useClass:ErrorInterceptor, multi: true }


  ],
  bootstrap: [AppComponent],
  entryComponents:[
    MessageModalComponent,
    FormBuilderModalComponent,
    FileManagerModalComponent

  ]
})
export class AppModule { }
