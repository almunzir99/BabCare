import { Component, OnInit } from '@angular/core';
import { Validators } from '@angular/forms';
import { FuiModalService } from 'ngx-fomantic-ui';
import { Customer } from 'src/app/core/models/customer.model';
import { CustomersService } from 'src/app/core/services/customers.service';
import { Column } from 'src/app/shared/data-table/models/column.model';
import { ControlTypes } from 'src/app/shared/form-builder/models/control-type.enum';
import { FormBuilderGroup } from 'src/app/shared/form-builder/models/form-builder-group.model';
import { FormBuilderModal } from 'src/app/shared/modals/form-builder-modal/form-builder-modal.component';
import { MessageModal, MessageTypes } from 'src/app/shared/modals/message-modal/message-modal.component';

@Component({
  selector: 'app-customers',
  templateUrl: './customers.component.html',
  styleUrls: ['./customers.component.scss']
})
export class CustomersComponent implements OnInit {

  cols: Column[];
  customers: Customer[] = [];
  isDataLoading = false;
  pageIndex = 1;
  pageSize = 10;
  totalRecords = 0;
  totalPages = 1;
  DimLoading = false;
  orderBy = "lastUpdate";
  ascending = false;
  searchValue = "";
  constructor(private _service: CustomersService,private modalService: FuiModalService) {
   
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
   
  initData() {
    this.isDataLoading = true;
    this._service.get(this.pageIndex, this.pageSize,this.searchValue,this.orderBy,this.ascending).subscribe(res => {
      this.customers = res.data;
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
        prop: "id",
        title: "الرقم التعريفي",
        show:true,
        sortable:true

      },
     
      {
        prop: "username",
        title: "اسم المستخدم",
        show:true,
        sortable:true

      },
      {
        prop: "phone",
        title: "رقم الهاتف",
        show:true,
        sortable:true


      },
      {
        prop: "location",
        title: "العنوان",
        show:true,
        sortable:true


      },
      {
        prop: "createdAt",
        title: "تاريخ الانشاء",
        show:true,
        sortable:true


      },
      {
        prop: "lastUpdate",
        title: "تاريخ التعديل",
        show:true,
        sortable:true


      }, {
        prop: "Actions",
        title: "الافعال",
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
        title: "تأكيد",
        content: "هل انت متأكد كن انك تريد حذف هذا العنصر ؟", isConfirm: true , messageType:MessageTypes.Danger
      }))
      .onApprove(() => {
          this.DimLoading = true;
          this._service.delete(id).subscribe(res =>{
              this.DimLoading = false;
              this.modalService.open(new MessageModal({
                title: "نجاح",
                content: "تم حذف العنصر بنجاح", isConfirm: false , messageType:MessageTypes.Success
              }))
              this.initData();
          },err =>{
            this.DimLoading = false;

          });
      })
      
  }
  openFormModal(customer:Customer) {
      const form: FormBuilderGroup[] = [
        {

          title: "عام",
          controls: [
            {
              title: "id",
              name: "id",
              controlType: ControlTypes.Hidden,
              width: "0px",
              value: customer ? customer.id : undefined
            },
            {
              title: "اسم المستخدم",
              name: "username",
              icon: "user tie icon",
              controlType: ControlTypes.TextInput,
              width: "50%",
              value: customer ? customer.username : undefined,
              validators: [
                Validators.required,
                Validators.minLength(8),
                Validators.maxLength(25),
              ]
            },
            {
              title: "رقم الهاتف",
              name: "phone",
              icon: "phone icon",
              controlType: ControlTypes.NumberInput,
              width: "50%",
              value: customer ? customer.phone : undefined,
              validators:[
                Validators.required,
                Validators.minLength(10),
                Validators.maxLength(12),

              ]

            },
            {
              title: "العنوان",
              name: "location",
              icon: "map icon",
              controlType: ControlTypes.TextInput,
              width: "100%",
              value: customer ? customer.email : undefined,
 

            },
            {
              title: "كلمة المرور",
              name: "password",
              icon: "key icon",

              controlType: ControlTypes.PasswordInput,
              width: "50%",
              validators:[
                Validators.required
              ]

            },
            {
              title: "اعد ادخال كلمة المرور",
              name: "repassword",
              icon: "key icon",
              validators:[
                Validators.required
              ],

              controlType: ControlTypes.PasswordInput,
              width: "50%"
            },
            {
              title: "الصورة",
              name: "image",
              controlType: ControlTypes.LocalFilePicker,
              width: "100%",
              value: customer ? customer.image : undefined,

            },
            
            
          ]
        }
      ];
      this.modalService.open(new FormBuilderModal(
        {
          title: customer ? "تعديل بيانات مستخدم" : "مستخدم جديد",
          controlGroups: form
        }
      )).onApprove((result) => {
        if(customer)
        this.update(result as Customer); 
        else 
        this.create(result as Customer); 
      
      });
     }
  create(customer:Customer){
    this.DimLoading = true;
    this._service.post(customer).subscribe(res =>{
      this.initData();
      this.DimLoading = false;
      this.modalService.open(new MessageModal({
        title: "نجاح",
        content: "تم انشاء العنصر بنجاح", isConfirm: false , messageType:MessageTypes.Success
      }))
    },err=>{
      console.log(err);
      this.DimLoading = false;
       
    })
  }
  update(customer:Customer){
    this.DimLoading = true;
    this._service.put(customer).subscribe(res =>{
      this.initData();
      this.DimLoading = false;
      this.modalService.open(new MessageModal({
        title: "نجاج",
        content: "تم تحديث بيانات العنصر بنجاح", isConfirm: false , messageType:MessageTypes.Success
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
