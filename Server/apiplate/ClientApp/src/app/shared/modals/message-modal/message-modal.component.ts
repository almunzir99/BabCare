import { Component, OnInit } from '@angular/core';
import { ComponentModalConfig, FuiBaseModal, ModalSize } from 'ngx-fomantic-ui';

interface IMessageModalContext{
  title:String;
  content:string;
  isConfirm:boolean;
  messageType?:MessageTypes
}
export enum MessageTypes {
  Success ="success",
  Warning = "warning",
  Danger ="danger",
}
@Component({
  selector: 'app-message-modal',
  templateUrl: './message-modal.component.html',
  styleUrls: ['./message-modal.component.scss']
})
export class MessageModalComponent implements OnInit {
  types = MessageTypes;
  constructor(public modal:FuiBaseModal<IMessageModalContext, void,void>) {
    
   }

  ngOnInit(): void {
  }

}
export class MessageModal extends ComponentModalConfig<IMessageModalContext,void,void>{
    constructor(context:IMessageModalContext,size = ModalSize.Mini) {
      super(MessageModalComponent,context);
      this.isClosable = false;
        this.transitionDuration = 500;
        this.size = size;
        this.isCentered = true;
    }
}