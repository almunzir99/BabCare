import { Injectable } from '@angular/core';
import {
  HttpRequest,
  HttpHandler,
  HttpEvent,
  HttpInterceptor,
  HttpErrorResponse
} from '@angular/common/http';
import { Observable,of } from 'rxjs';
import {tap,catchError} from 'rxjs/operators';
import { FuiModalService } from 'ngx-fomantic-ui';
import { MessageModal, MessageTypes } from 'src/app/shared/modals/message-modal/message-modal.component';
import { ApiResponse } from '../models/wrappers/apiResponse.model';

@Injectable()
export class ErrorInterceptor implements HttpInterceptor {

  constructor(private modalService:FuiModalService) {}

  intercept(request: HttpRequest<unknown>, next: HttpHandler): Observable<HttpEvent<unknown>> {
    return next.handle(request).pipe(tap(evt =>{}),catchError((err:any)=>{
      console.log(err);
      if(err instanceof HttpErrorResponse)
      {
        console.log(err.error instanceof ApiResponse);
        if(err.status != 403 && typeof(err.error) == typeof(new ApiResponse()))
        {
          this.modalService.open(new MessageModal({
            title: "Request failed",
            content: err.error.errors[0], isConfirm: false , messageType:MessageTypes.Danger
          }));
          
        }
      }
      throw err;
    }));
  }
}
