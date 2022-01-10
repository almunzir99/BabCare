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

@Injectable()
export class AccessDeniedInterceptor implements HttpInterceptor {

  constructor(private modalService:FuiModalService) {}

  intercept(request: HttpRequest<unknown>, next: HttpHandler): Observable<HttpEvent<unknown>> {
    return next.handle(request).pipe(tap(evt =>{}),catchError((err:any)=>{
      if(err instanceof HttpErrorResponse)
      {
        if(err.status == 403)
        {
          this.modalService.open(new MessageModal({
            title: "Access Denied",
            content: "You don't have required permission for this operation", isConfirm: false , messageType:MessageTypes.Warning
          }));
          
        }
      }
      throw err;
    }));
  }
}
