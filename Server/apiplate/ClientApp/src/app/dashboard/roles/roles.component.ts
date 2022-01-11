import { Component, OnInit } from '@angular/core';
import { FuiModalService, ModalSize } from 'ngx-fomantic-ui';
import { Permission } from 'src/app/core/models/permission.model';
import { Role } from 'src/app/core/models/role.model';
import { RolesService } from 'src/app/core/services/roles.service';
import { ControlTypes } from 'src/app/shared/form-builder/models/control-type.enum';
import { FormBuilderGroup } from 'src/app/shared/form-builder/models/form-builder-group.model';
import { FormBuilderModal } from 'src/app/shared/modals/form-builder-modal/form-builder-modal.component';
import { MessageModal, MessageTypes } from 'src/app/shared/modals/message-modal/message-modal.component';
 

@Component({
  selector: 'app-roles',
  templateUrl: './roles.component.html',
  styleUrls: ['./roles.component.scss']
})
export class RolesComponent implements OnInit {
  roles:Role[];
  isLoading = false;
  DimLoading = false;
  defaultPermission:Permission = {
    create:false,
    delete:false,
    update:false,
    read:false
}
  constructor(private _service:RolesService,private modalService:FuiModalService) {
    this.initData();
      }
  initData(){
    this.isLoading = true;
    this._service.get().subscribe(res =>{
      this.roles = res.data;
      console.log(this.roles);
      this.roles.forEach(role => {
        this.initRole(role);
      });
      this.isLoading = false;
    },err=> {
      this.isLoading = false;
    })
  }
  initRole(role:Role)
  {
    for(const key in role)
    {
      if(key.includes("Permissions"))
      if(role[key] == null)
      role[key] = {...this.defaultPermission};
    }
  }
  GetPermissions(obj:any) : string[]
  {
    let permissions = [];
   for(const key in obj){
     if(key.includes("Permissions"))
     permissions.push(key);
   }
    return permissions;
  }
   
  onApply(role:Role){
    console.log(role);
    this.DimLoading = true;
    this._service.put(role).subscribe(res =>{
      this.DimLoading = false;
      this.initData();
      this.modalService.open(new MessageModal({
        title: "Success",
        content: "Item Updated Successfully", isConfirm: false , messageType:MessageTypes.Success
      }));

    },err=>{
      console.log(err);
     

    });
  }
  create(){ 
    var controls : FormBuilderGroup[] = [
        {
          title:undefined,
          controls:[
            {
              title:"Role Title",
              name:"title",
              controlType:ControlTypes.TextInput,
              width:"100%",
              icon:"options icon"
            }
          ]
        }
    ];
    this.modalService.open(new FormBuilderModal({title:"New Role",controlGroups:controls},ModalSize.Mini)).onApprove(result =>{
        let role : Role = {
          title:result['title'],
          rolesPermissions: this.defaultPermission,
          usersPermissions: this.defaultPermission,
          messagesPermissions: this.defaultPermission,
          deliveryPermissions:this.defaultPermission,
          customersPermissions:this.defaultPermission

        }
        this.DimLoading = true;
        this._service.post(role).subscribe(res =>{
          this.DimLoading = false;
          this.initData();
          this.modalService.open(new MessageModal({
            title: "Success",
            content: "Item Created Successfully", isConfirm: false , messageType:MessageTypes.Success
          }));
        },err => {
          this.DimLoading = false;
          this.modalService.open(new MessageModal({
            title: "Error",
            content: "Operation Failed", isConfirm: false , messageType:MessageTypes.Danger
          }));
        });
    });

  }
  onDelete(id:number){
    this.DimLoading = true;
    this.modalService.open(new MessageModal({title:"Confirm",content:"are you sure you want to delete this item ?",isConfirm:true,messageType:MessageTypes.Warning})).onApprove(() =>{
      this._service.delete(id).subscribe(res => {
        this.DimLoading = false;
        this.initData();
        this.modalService.open(new MessageModal({
          title: "Success",
          content: "Item Updated Successfully", isConfirm: false , messageType:MessageTypes.Success
        }));
  

      },err=>{
        console.log(err);
        this.modalService.open(new MessageModal({
          title: "Error",
          content: "Operation Failed", isConfirm: false , messageType:MessageTypes.Danger
        }));
      });
    })
  }
  ngOnInit(): void {
  }

}
