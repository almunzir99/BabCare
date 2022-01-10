import { Component, EventEmitter, Input, OnInit, Output } from '@angular/core';
import { FuiModalService } from 'ngx-fomantic-ui';
import { FileModel } from 'src/app/core/models/File.Model';
import { FileManagerModal } from 'src/app/dashboard/file-manager/file-manager-modal/file-manager-modal.component';
import { PickingMode } from 'src/app/dashboard/file-manager/file-manager.component';

@Component({
  selector: 'file-local-picker',
  templateUrl: './image-local-picker.component.html',
  styleUrls: ['./image-local-picker.component.scss']
})
export class ImageLocalPickerComponent implements OnInit {
  @Input()fileUrl :string;
  @Output()fileUrlChange = new EventEmitter<string>();
  @Input('width') width = "100%";
  @Input("name") name =undefined;

  constructor(private modalService:FuiModalService) { }
  pick(){
    this.modalService.open(new FileManagerModal({title:"Select Destination Folder",pickingMode:PickingMode.Files})).onApprove((result:FileModel[]) =>{
        this.fileUrl = result[0].uri;
        this.fileUrlChange.emit(this.fileUrl);
    });
  }
  ngOnInit(): void {
  }

}
 