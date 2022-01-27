import { Component, OnInit } from '@angular/core';
import { ComponentModalConfig, FuiBaseModal, ModalSize } from 'ngx-fomantic-ui';
import { PickingMode } from '../../../dashboard/file-manager/file-manager.component';
export interface IFileManagerModalContext{
  title:string;
  pickingMode:PickingMode;
}
@Component({
  selector: 'app-file-manager-modal',
  templateUrl: './file-manager-modal.component.html',
  styleUrls: ['./file-manager-modal.component.scss']
})
export class FileManagerModalComponent implements OnInit {

  constructor(public modal: FuiBaseModal<IFileManagerModalContext, any, void>) { }

  ngOnInit(): void {
  }
  onApproved(data:any){
    this.modal.approve(data);
  }
  onDenied()
  {
    this.modal.deny();
  }

}
export class FileManagerModal extends ComponentModalConfig<IFileManagerModalContext,void,void>{
  /**
   *
   */
  constructor(context:IFileManagerModalContext) {
    super(FileManagerModalComponent,context);
    super.isClosable = false;
    super.transitionDuration = 500;
    super.size = ModalSize.Large;
    super.isCentered = true;
  }
}
