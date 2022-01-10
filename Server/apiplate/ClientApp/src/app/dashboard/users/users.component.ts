import { Component, OnInit } from '@angular/core';
import { Validators } from '@angular/forms';
import { FuiModalService } from 'ngx-fomantic-ui';
import { User } from 'src/app/core/models/user.model';
import { RolesService } from 'src/app/core/services/roles.service';
import { UsersService } from 'src/app/core/services/users.service';
import { Column } from 'src/app/shared/data-table/models/column.model';
import { ControlTypes } from 'src/app/shared/form-builder/models/control-type.enum';
import { FormBuilderGroup } from 'src/app/shared/form-builder/models/form-builder-group.model';
import { FormBuilderModal } from 'src/app/shared/modals/form-builder-modal/form-builder-modal.component';
import { MessageModal, MessageTypes } from 'src/app/shared/modals/message-modal/message-modal.component';
 

@Component({
  selector: 'app-users',
  templateUrl: './users.component.html',
  styleUrls: ['./users.component.scss']
})
export class UsersComponent implements OnInit {
  cols: Column[];
  users: User[] = [];
  isDataLoading = false;
  pageIndex = 1;
  pageSize = 10;
  totalRecords = 0;
  totalPages = 1;
  DimLoading = false;
  orderBy = "lastUpdate";
  ascending = false;
  searchValue = "";
  showActivities = false;
  targetUserForActivities:User;
  constructor(private _service: UsersService, private _roleService: RolesService, private modalService: FuiModalService) {
   
  }
  onSearchChange(value){
    this.searchValue = value;
    this.initData();
  }
  onSortChange(event){
    this.orderBy = event.orderBy;
    this.ascending = event.ascending;
    this.initData();

  }
  onActivityClick(user:User){
    this.targetUserForActivities = user;
    console.log(this.targetUserForActivities);
    this.showActivities = true;
  }
  activityModalDismissed(){
    this.showActivities = false;
  }
  initData() {
    this.isDataLoading = true;
    this._service.get(this.pageIndex, this.pageSize,this.searchValue,this.orderBy,this.ascending).subscribe(res => {
      this.users = res.data;
      this.totalRecords = res.totalRecords;
      this.totalPages = res.totalPages;
      this.isDataLoading = false;

    }, err => {
      this.isDataLoading = false;

    });
  }
  initCols() {
    this.cols = [
      {
        prop: "image",
        title: "Image",
        show:true,


      },
      {
        prop: "id",
        title: "Id",
        show:true,
        sortable:true

      },
     
      {
        prop: "username",
        title: "Username",
        show:true,
        sortable:true

      },
      {
        prop: "phone",
        title: "Phone Number",
        show:true,
        sortable:true


      },
      {
        prop: "email",
        title: "email",
        show:true,
        sortable:true


      },
      {
        prop: "role",
        title: "role",
        show:true,


      },
      {
        prop: "createdAt",
        title: "Created At",
        show:true,
        sortable:true


      },
      {
        prop: "lastUpdate",
        title: "Last Update",
        show:true,
        sortable:true


      }, {
        prop: "Actions",
        title: "Actions",
        show:true,

      }
    ]
  }
  ngOnInit(): void {
    this.initCols();
    this.initData();
  }
  pageIndexChanged(index: number) {
    this.pageIndex = index;
    this.initData();

  }
  pageSizeChanged(size: number) {
    this.pageSize = size;
    this.initData();

  }
  delete(id:number) {
    this.modalService
      .open(new MessageModal({
        title: "Confirm Message",
        content: "are you sure you want to delete this item ?", isConfirm: true , messageType:MessageTypes.Danger
      }))
      .onApprove(() => {
          this.DimLoading = true;
          this._service.delete(id).subscribe(res =>{
              this.DimLoading = false;
              this.modalService.open(new MessageModal({
                title: "Success",
                content: "Item Deleted Successfully", isConfirm: false , messageType:MessageTypes.Success
              }))
              this.initData();
          },err =>{
            this.DimLoading = false;

          });
      })
      
  }
  openFormModal(user:User) {
    console.log(user);
    var roles;
    this.DimLoading = true;
    this._roleService.get().subscribe(res => {
      roles = res.data;
      this.DimLoading = false;
      const form: FormBuilderGroup[] = [
        {

          title: "General",
          controls: [
            {
              title: "id",
              name: "id",
              controlType: ControlTypes.Hidden,
              width: "0px",
              value: user ? user.id : undefined
            },
            {
              title: "username",
              name: "username",
              icon: "user tie icon",
              controlType: ControlTypes.TextInput,
              width: "50%",
              value: user ? user.username : undefined,
              validators: [
                Validators.required,
                Validators.minLength(8),
                Validators.maxLength(25),
              ]
            },
            {
              title: "phone",
              name: "phone",
              icon: "phone icon",
              controlType: ControlTypes.NumberInput,
              width: "50%",
              value: user ? user.phone : undefined,
              validators:[
                Validators.required,
                Validators.minLength(10),
                Validators.maxLength(12),

              ]

            },
            {
              title: "email",
              name: "email",
              icon: "mail icon",
              controlType: ControlTypes.TextInput,
              width: "100%",
              value: user ? user.email : undefined,
              validators:[
                Validators.required

              ]

            },
            {
              title: "password",
              name: "password",
              icon: "key icon",

              controlType: ControlTypes.PasswordInput,
              width: "50%",
              validators:[
                Validators.required
              ]

            },
            {
              title: "re-enter the password",
              name: "repassword",
              icon: "key icon",
              validators:[
                Validators.required
              ],

              controlType: ControlTypes.PasswordInput,
              width: "50%"
            },
            {
              title: "Role",
              name: "roleId",
              controlType: ControlTypes.Selection,
              data: roles,
              isObjectData:true,
              labelProp:"title",
              valueProp:"id",
              width: "100%",
              value: user ? user.roleId : undefined,

            },
            {
              title: "image",
              name: "image",
              controlType: ControlTypes.LocalFilePicker,
              width: "100%",
              value: user ? user.image : undefined,

            },
            
            
          ]
        }
      ];
      this.modalService.open(new FormBuilderModal(
        {
          title: user ? "Update User Info" : "New User",
          controlGroups: form
        }
      )).onApprove((result) => {
        if(user)
        this.update(result as User); 
        else 
        this.create(result as User); 
      
      });
    }, err => {
      this.DimLoading = false;
      return;
    });
  }
  create(user:User){
    this.DimLoading = true;
    this._service.post(user).subscribe(res =>{
      this.initData();
      this.DimLoading = false;
      this.modalService.open(new MessageModal({
        title: "Success",
        content: "Item Created Successfully", isConfirm: false , messageType:MessageTypes.Success
      }))
    },err=>{
      console.log(err);
      this.DimLoading = false;
       
    })
  }
  update(user:User){
    this.DimLoading = true;
    this._service.put(user).subscribe(res =>{
      this.initData();
      this.DimLoading = false;
      this.modalService.open(new MessageModal({
        title: "Success",
        content: "Item Updated Successfully", isConfirm: false , messageType:MessageTypes.Success
      }))
    },err=>{
      console.log(err);
      this.DimLoading = false;
       
    })
  }
  
  range(total: number, beginIndex: number = 0, step: number = 1): number[] {
    let list: number[] = [];
    for (let index = beginIndex; index < total; index += step) {
      list.push(index);
    }
    return list;
  }
  downloadCSV(){
    this._service.downloadCSV();
  }

}
