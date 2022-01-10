import { Component, OnInit } from '@angular/core';
import { ComponentModalConfig, FuiBaseModal, ModalSize } from 'ngx-fomantic-ui';
import { FormBuilderGroup } from '../../form-builder/models/form-builder-group.model';
interface IFormBuilderModalContext {
  title: string;
  controlGroups: FormBuilderGroup[];
}
@Component({
  selector: 'form-builder-modal',
  templateUrl: './form-builder-modal.component.html',
  styleUrls: ['./form-builder-modal.component.scss']
})
export class FormBuilderModalComponent implements OnInit {

  constructor(private modal: FuiBaseModal<IFormBuilderModalContext, any, void>) { }
  onApproved(data:any){
    this.modal.approve(data);
  }
  onDenied()
  {
    this.modal.deny();
  }

  ngOnInit(): void {
  }
}
export class FormBuilderModal extends ComponentModalConfig<IFormBuilderModalContext, void, void>{
  /**
   *
   */
  constructor(context: IFormBuilderModalContext, size = ModalSize.Normal) {
    super(FormBuilderModalComponent, context);
    this.isClosable = false;
    this.transitionDuration = 500;
    this.size = size;
    this.isCentered = true;

  }

}
