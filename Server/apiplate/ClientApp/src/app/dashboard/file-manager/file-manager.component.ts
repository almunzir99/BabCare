import { HttpEventType } from '@angular/common/http';
import { Component, EventEmitter, Input, OnInit, Output } from '@angular/core';
import { FuiModalService, ModalSize } from 'ngx-fomantic-ui';
import { DirectoryModel } from 'src/app/core/models/directory.model';
import { FileModel } from 'src/app/core/models/File.Model';
import { FilesManagerService } from 'src/app/core/services/files-manager.service';
import { ControlTypes } from 'src/app/shared/form-builder/models/control-type.enum';
import { FormBuilderModal } from 'src/app/shared/modals/form-builder-modal/form-builder-modal.component';
import { MessageModal, MessageTypes } from 'src/app/shared/modals/message-modal/message-modal.component';
 
import { FileManagerModal } from './file-manager-modal/file-manager-modal.component';

export enum PickingMode {
  Folder,
  Files,
  None,
}
@Component({
  selector: 'file-manager',
  templateUrl: './file-manager.component.html',
  styleUrls: ['./file-manager.component.scss']
})
export class FileManagerComponent implements OnInit {
  @Input('picking-mode') pickingMode = PickingMode.None;
  @Output('onSelect') selectEventEmitter = new EventEmitter<any>();
  @Output('onCancel') cancelEventEmitter = new EventEmitter<any>();

  navigationStack: DirectoryModel[] = [];
  currentStackIndex = 0;
  CurrentDirectory: DirectoryModel;
  currentPath: string = "";
  isLoading = false;
  DimLoading = false;
  DimUploading = false;
  progress = 0;
  selectedFiles: FileModel[] = [];
  PickMode = PickingMode;
  constructor(private _service: FilesManagerService, private modalService: FuiModalService) {
  }
  initData() {
    this.isLoading = true;
    var path = this.currentPath;
    this._service.getDirectory(path).subscribe(res => {
      if (this.navigationStack.length == 0) {
        this.navigationStack.push(res.data);
        this.CurrentDirectory = this.navigationStack[this.navigationStack.length - 1];
      }
      else {
        this.CurrentDirectory = res.data;

      }
      this.isLoading = false;

    }, err => {
      this.isLoading = true;
      console.log(err);
      this.isLoading = false;
    })
  }
  onSelectClick() {
    if (this.pickingMode == PickingMode.Files)
      this.selectEventEmitter.emit(this.selectedFiles);
    else if (this.pickingMode == PickingMode.Folder)
      this.selectEventEmitter.emit(this.currentPath);

  }
  onCancel() {
    this.cancelEventEmitter.emit();
  }
  onFileClick(file: FileModel) {
    if (this.pickingMode == PickingMode.Files) {
      if (this.selectedFiles.includes(file)) {
        this.selectedFiles = this.selectedFiles.filter(c => c != file);
      }
      else {
        this.selectedFiles.push(file);
      }
    }
  }
  moveDir(dir: DirectoryModel) {
    this.modalService.open(new FileManagerModal({ title: "Select Destination Folder", pickingMode: PickingMode.Folder })).onApprove((result: string) => {
      console.log(result);
      this.DimLoading = true;
      let path = this.currentPath;
      if (result == "") result = "/";
      if (this.currentPath == "") path = "/";

      this._service.moveDirectory(dir.title, this.currentPath, result).subscribe(res => {
        this.DimLoading = false;
        this.initData();
        this.modalService.open(new MessageModal({ title: "success", content: "item moved successfully", messageType: MessageTypes.Success, isConfirm: false }));
      }, err => {
        this.DimLoading = false;
        console.log(err);
        this.modalService.open(new MessageModal({
          title: "Error",
          content: "Operation Failed", isConfirm: false, messageType: MessageTypes.Danger
        }));
      });
    });
  }
  moveFile(file: FileModel) {
    this.modalService.open(new FileManagerModal({ title: "Select Destination Folder", pickingMode: PickingMode.Folder })).onApprove((result: string) => {
      console.log(result);
      let path = this.currentPath;
      this.DimLoading = true;
      if (result == "") result = "/";
      if (this.currentPath == "") path = "/";

      this._service.moveFile(file.title, path, result).subscribe(res => {
        this.DimLoading = false;
        this.initData();
        this.modalService.open(new MessageModal({ title: "success", content: "item moved successfully", messageType: MessageTypes.Success, isConfirm: false }));
      }, err => {
        this.DimLoading = false;
        console.log(err);
        this.modalService.open(new MessageModal({
          title: "Error",
          content: "Operation Failed", isConfirm: false, messageType: MessageTypes.Danger
        }));
      });
    });
  }
  getShortenTitle(file: FileModel): string {
    if (file.title.length > 15) {
      return `${file.title.substr(0, 15)}... ${file.contentType}`;
    }
    else
      return file.title;
  }
  deleteDirectory(dir: DirectoryModel) {
    this.modalService.open(new MessageModal({
      title: "Confirm",
      content: "are you sure you want to delete this folder ?",
      isConfirm: true, messageType: MessageTypes.Warning
    })).onApprove(() => {
      this.DimLoading = true;
      let path = this.currentPath.replace(`${dir.title}/`, "");
      this._service.deleteDirectory(dir.title, path).subscribe(res => {
        this.DimLoading = false;
        this.initData();
        this.modalService.open(new MessageModal({
          title: "Success",
          content: "folder deleted Successfully", isConfirm: false, messageType: MessageTypes.Success
        }));
      }, err => {
        this.DimLoading = false;
        console.log(err);
        this.modalService.open(new MessageModal({
          title: "Error",
          content: "Operation Failed", isConfirm: false, messageType: MessageTypes.Danger
        }));
      });

    })
  }
  copyUrl(uri: string) {
    document.addEventListener('copy', (ev: ClipboardEvent) => {
      ev.clipboardData.setData('text/plain', uri);
      ev.preventDefault();
      document.removeEventListener('copy', null);

    })
    document.execCommand('copy');
    console.log('copied');
  }
  downloadFile(file: FileModel) {
    const link = document.createElement('a');
    link.setAttribute('target', '_blank');
    link.setAttribute('href', file.uri);
    link.setAttribute('download', file.title);
    link.click();
    link.remove();
  }
  deleteFile(file: FileModel) {
    this.modalService.open(new MessageModal({
      title: "Confirm",
      content: "are you sure you want to delete this file ?",
      isConfirm: true, messageType: MessageTypes.Warning
    })).onApprove(() => {
      this.DimLoading = true;
      this._service.deleteFile(file.title, this.currentPath).subscribe(res => {
        this.DimLoading = false;
        this.initData();
        this.modalService.open(new MessageModal({
          title: "Success",
          content: "file deleted Successfully", isConfirm: false, messageType: MessageTypes.Success
        }));
      }, err => {
        this.DimLoading = false;
        console.log(err);
        this.modalService.open(new MessageModal({
          title: "Error",
          content: "Operation Failed", isConfirm: false, messageType: MessageTypes.Danger
        }));
      });

    })
  }
  renameDir(dir: DirectoryModel) {
    this.modalService.open(new FormBuilderModal({
      title: "Rename Folder",

      controlGroups: [
        {
          title: undefined,
          controls: [
            {
              title: "Folder", name: "title", controlType: ControlTypes.TextInput, icon: "folder icon", width: "100%", value: dir.title
            }
          ]
        }
      ]
    }, ModalSize.Mini)).onApprove(result => {
      this.DimLoading = true;
      this._service.renameDirectory(this.currentPath, dir.title, result['title']).subscribe(res => {
        this.DimLoading = false;
        this.initData();
      }, err => {
        this.DimLoading = false;
        console.log(err);
      });
    });
  }
  renameFile(file: FileModel) {
    this.modalService.open(new FormBuilderModal({
      title: "Rename File",

      controlGroups: [
        {
          title: undefined,
          controls: [
            {
              title: "Folder", name: "title", controlType: ControlTypes.TextInput, icon: "file icon", width: "100%", value: file.title
            }
          ]
        }
      ]
    }, ModalSize.Mini)).onApprove(result => {
      this.DimLoading = true;
      this._service.renameFile(this.currentPath, file.title, result['title']).subscribe(res => {
        this.DimLoading = false;
        this.initData();
      }, err => {
        this.DimLoading = false;
        console.log(err);
      });
    });
  }
  uploadFile(files: File[]) {
    this.DimUploading = true;
    this._service.uploadFile(files, this.currentPath).subscribe(events => {
      if (events.type === HttpEventType.UploadProgress) {
        this.progress = Math.round(100 * events.loaded / events.total);
      }
      this.DimUploading = false;
      this.initData();


    }, err => {
      console.log(err);
      this.DimUploading = false;

    })
  }
  navigate(directory: DirectoryModel) {
    this.navigationStack.push(directory);
    this.CurrentDirectory = this.navigationStack[this.navigationStack.length - 1];
    this.currentPath += `${directory.title}/`;
    this.currentStackIndex++;


  }
  goBack() {
    if (this.navigationStack.length > 1) {
      this.currentPath = this.currentPath.replace(`${this.CurrentDirectory.title}/`, "");
      this.navigationStack.pop();
      this.CurrentDirectory = this.navigationStack[this.navigationStack.length - 1];


    }
  }
  createFolder() {
    this.modalService.open(new FormBuilderModal({
      title: "New Folder",

      controlGroups: [
        {
          title: undefined,
          controls: [
            {
              title: "Folder", name: "title", controlType: ControlTypes.TextInput, icon: "folder icon", width: "100%"
            }
          ]
        }
      ]
    }, ModalSize.Mini)).onApprove(result => {
      this.DimLoading = true;
      this._service.postDirectory(result['title'], this.currentPath).subscribe(res => {
        this.DimLoading = false;
        this.initData();
      }, err => {
        this.DimLoading = false;
        console.log(err);
      });
    });
  }
  ngAfterViewInit(){
    console.log("view initied");
  }
  ngOnInit(): void {
    console.log("initializing");
    this.initData();

  }

}
