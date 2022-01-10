import { Component, OnInit } from '@angular/core';
import { FuiModalService, ModalSize } from 'ngx-fomantic-ui';
import { langs } from 'src/app/shared/extras/languages';
import { ControlTypes } from 'src/app/shared/form-builder/models/control-type.enum';
import { FormBuilderModal } from 'src/app/shared/modals/form-builder-modal/form-builder-modal.component';
import { MessageModal, MessageTypes } from 'src/app/shared/modals/message-modal/message-modal.component';
import { CmsService } from '../../core/services/cms.service';
export class Node {
  parent: string;
  key: string;
  value: string;
}
@Component({
  selector: 'app-cms',
  templateUrl: './cms.component.html',
  styleUrls: ['./cms.component.scss']
})
export class CmsComponent implements OnInit {
  langs = [];
  currentJson = null;
  currentLang;
  currentNode: Node = null;
  DimLoading = false;
  isLoading = false;
  currentNodeValue: string;
  editingMode = 1;
  constructor(private _service: CmsService, private modalService: FuiModalService) {
    this.getsLangs();
  }

  getsLangs(){
    this.isLoading = true;
    this._service.getLangs().subscribe(res =>{
      this.isLoading = false;
      this.langs = res as any[];
      this.currentLang = this.langs[0];
    this.getObj();

    },err =>{
      console.log(err);
      this.isLoading = false;

      this.modalService.open(new MessageModal({
        title: "Error",
        content: "Operation Failed, please try again", isConfirm: false, messageType: MessageTypes.Danger
      }))
    })
  }
  createLang(){
    let codes = langs.map(e => e.code);
    this.modalService.open(new FormBuilderModal({
      title:"Create language",
      controlGroups:[
        {
          title:null,
          controls:[
            {
              title:"languages codes",
              name:"code",
              controlType:ControlTypes.Selection,
              data: codes,
              width:"100%"
            }
          ]
        }
      ]
    },ModalSize.Mini)).onApprove(result =>{
      this.DimLoading = true;
      this._service.createLang(result['code']).subscribe(res =>{
       
        this.modalService.open(new MessageModal({
          title: "Success",
          content: "language Created Successfully", isConfirm: false, messageType: MessageTypes.Success
        }))
        this.DimLoading = false;
        this.getsLangs();
      },err =>{
        this.modalService.open(new MessageModal({
          title: "Error",
          content: "Operation Failed, please try again", isConfirm: false, messageType: MessageTypes.Danger
        }))
        this.DimLoading = false;

      })
    })
  }
  getObj() {
    this.isLoading = true;
    this._service.getJsonObject(this.currentLang).subscribe(res => {
      this.currentJson = res;
      this.isLoading = false;

    }, err => {
      this.isLoading = false;

      this.modalService.open(new MessageModal({
        title: "Error",
        content: "Operation Failed, please try again", isConfirm: false, messageType: MessageTypes.Danger
      }))
    });
  }
  getKeys(obj) {
    if (obj != null)
      return Object.keys(obj);
  }
  selectNode(parent, node) {
    this.currentNode = {
      parent: parent,
      key: node,
      value: this.currentJson[parent][node]
    }
    this.currentNodeValue = this.currentNode.value;
  }
  ngOnInit(): void {
  }
  onAdd(parent: string) {
    this.currentNode = {
      parent: parent,
      key: undefined,
      value: ''
    }
    this.editingMode = 0;
  }
  editorChange(content) {
    console.log(content);
    this.currentNodeValue = content;
  }
  changeLang(value){
      var index = this.langs.indexOf(value);
      this.currentLang = this.langs[index];
      this.getObj();
  }
  onApply() {
    this.DimLoading = true;
    (
      this.editingMode == 0 ?
      this._service.CreateNode(this.currentNode.parent, this.currentNodeValue, this.currentNode.key,this.currentLang) :
      this._service.editNode(this.currentNode.parent, this.currentNodeValue, this.currentNode.key,this.currentLang)).subscribe(res => {
      this.getObj();
      this.currentNode.value = this.currentNodeValue;
      this.DimLoading = false;
      this.editingMode = 1;
    }, err => {
      this.DimLoading = false;
      this.editingMode = 1;
      this.modalService.open(new MessageModal({
        title: "Error",
        content: "Operation Failed, please try again", isConfirm: false, messageType: MessageTypes.Danger
      }))

    })
  }
  CreateParent() {
    this.modalService.open(new FormBuilderModal({
      title: "Create New Parent",

      controlGroups: [
        {
          title: undefined,
          controls: [
            {
              title: "New Parent", name: "title", controlType: ControlTypes.TextInput, icon: "folder icon", width: "100%"
            }
          ]
        }
      ]
    }, ModalSize.Mini)).onApprove(result => {
      this.DimLoading = true;
      this._service.createParentObject(result['title'], this.currentLang).subscribe(res => {
        this.getObj();
        this.DimLoading = false;

      }, err => {
        this.DimLoading = false;

        this.modalService.open(new MessageModal({
          title: "Error",
          content: "Operation Failed, please try again", isConfirm: false, messageType: MessageTypes.Danger
        }))
      });
    });
  }
  DeleteNode(){
    this.modalService.open(new MessageModal({title:"Confirm",
    content:"are you sure you want to delete this folder ?",
    isConfirm:true,messageType:MessageTypes.Warning})).onApprove(()=>{
      this.DimLoading = true;
      this._service.deleteNode(this.currentNode.parent,this.currentNode.key,this.currentLang).subscribe(res =>{
          this.DimLoading = false;
          this.currentNode = null;
          this.getObj();
      },err=>{
        this.DimLoading = false;
        this.modalService.open(new MessageModal({
          title: "Error",
          content: "Operation Failed, please try again", isConfirm: false, messageType: MessageTypes.Danger
        }))
      });

    });
  }
  getFlag(code:string) : string{
    var result = "en";
    langs.forEach(lang =>{
        if(lang.code == code)
        {
          result = lang.flag;
          return;
        }
    });
    return result;
  }
}
