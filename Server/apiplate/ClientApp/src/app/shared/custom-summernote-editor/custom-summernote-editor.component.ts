import { Component, EventEmitter, Inject, Input, OnInit, Output, Renderer2 } from '@angular/core';
import { FuiModalService } from 'ngx-fomantic-ui';
import { FileModel } from 'src/app/core/models/file.Model';
import { FileManagerModal } from 'src/app/dashboard/file-manager/file-manager-modal/file-manager-modal.component';
import { PickingMode } from 'src/app/dashboard/file-manager/file-manager.component';
declare var $: any;
@Component({
  selector: 'custom-summernote-editor',
  templateUrl: './custom-summernote-editor.component.html',
  styleUrls: ['./custom-summernote-editor.component.scss']
})
export class CustomSummernoteEditorComponent implements OnInit {
  @Input() htmlContent;
  @Output() htmlContentChange = new EventEmitter<any>();
  @Input() editorId;
  @Input() doChanges = false;
  constructor(private modalService: FuiModalService,private renderer:Renderer2,@Inject('BASE_URL') private baseUrl: string) { 
     
}
  ngOnInit(): void {
  }
  summernoteModal: HTMLElement;
  imageInputElement:HTMLElement;
  config = {};
  noteEditor : HTMLElement;
  rendered = false;
  ngOnChanges(): void {
    if(this.doChanges)
    $(`#${this.editorId}`).summernote('code',this.htmlContent);
  }
  
  ngAfterViewInit() {
    $(`#${this.editorId}`).summernote('code',this.htmlContent);
    var filePickerNode = this.createFilePickerElement();
    var targetEditor = document.querySelector(`#${this.editorId}`).nextElementSibling;
   var insertPic = targetEditor.getElementsByClassName('note-insert').item(0);
    this.noteEditor = (targetEditor.querySelector('.note-editable') as HTMLElement);
    this.noteEditor.style.backgroundColor = "white";
    this.noteEditor.style.height = "300px";
    insertPic.addEventListener('click', () => {
      (document.querySelectorAll(".note-modal-backdrop").item(0) as HTMLElement).style.zIndex ="990";
      (targetEditor.querySelectorAll(".note-modal.open").item(0) as HTMLElement).style.zIndex ="999";
      (targetEditor.querySelectorAll(".note-modal-content").item(1) as HTMLElement).style.padding ="20px 0px";
      (targetEditor.querySelectorAll(".note-image-btn").item(0) as HTMLElement).removeAttribute("disabled");
      this.summernoteModal = targetEditor.querySelectorAll(".note-modal-body")[1] as HTMLElement;
      var imageInput = this.summernoteModal.querySelector('.note-group-image-url') as HTMLElement;
      imageInput.style.display = "none";
      this.imageInputElement = imageInput.querySelector('.note-image-url') as HTMLElement;
      this.summernoteModal.appendChild(filePickerNode);
    });
    this.noteEditor.addEventListener('DOMSubtreeModified',()=>{
      var   tempNoteEditor = (targetEditor.querySelector('.note-editable') as HTMLElement);
      this.htmlContentChange.emit(this.noteEditor.innerHTML);

     });
  }
  createFilePickerElement(): HTMLElement {
    var container = this.renderer.createElement('div');
    container.classList.add('ui', 'action', 'input', 'fluid');
    var input = this.renderer.createElement('input');
    input.placeholder = "file url";
    var button = this.renderer.createElement('button');
    this.renderer.listen(button,"click",()=>{
      this.modalService.open(new FileManagerModal({ title: "Select Destination Folder", pickingMode: PickingMode.Files })).onApprove((result: FileModel[]) => {
      (document.getElementById(this.imageInputElement.id) as HTMLInputElement).value = result[0].uri;
      input.value = result[0].uri;
      });
  
    });
    button.classList.add("ui", "yellow", "right", "labeled", "icon", "button");
    button.textContent = "Pick";
    var icon = this.renderer.createElement('i');
    icon.classList.add('folder', 'icon');
    button.appendChild(icon);
    container.append(input);
    container.append(button);
    return container;
  }
  
}
