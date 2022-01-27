import { Component, OnInit } from '@angular/core';
import { Validators } from '@angular/forms';
import { Router, RouterLink } from '@angular/router';
import { FuiModalService, ModalSize } from 'ngx-fomantic-ui';
import { Product } from 'src/app/core/models/product.model';
import { CategoriesService } from 'src/app/core/services/categories.service';
import { ProductsService } from 'src/app/core/services/products.service';
import { Column } from 'src/app/shared/data-table/models/column.model';
import { ControlTypes } from 'src/app/shared/form-builder/models/control-type.enum';
import { FormBuilderGroup } from 'src/app/shared/form-builder/models/form-builder-group.model';
import { FormBuilderModal } from 'src/app/shared/modals/form-builder-modal/form-builder-modal.component';
import { MessageModal, MessageTypes } from 'src/app/shared/modals/message-modal/message-modal.component';

@Component({
  selector: 'app-products',
  templateUrl: './products.component.html',
  styleUrls: ['./products.component.scss']
})
export class ProductsComponent implements OnInit {

  cols: Column[];
  products: Product[] = [];
  isDataLoading = false;
  pageIndex = 1;
  pageSize = 10;
  totalRecords = 0;
  totalPages = 1;
  DimLoading = false;
  orderBy = "lastUpdate";
  ascending = false;
  searchValue = "";
  constructor(private _service: ProductsService,private _categoriesService : CategoriesService, private modalService: FuiModalService,private router:Router) {

  }
  onSearchChange(value) {
    this.searchValue = value;
    this.initData();
  }
  onSortChange(event) {
    this.orderBy = event.orderBy;
    this.ascending = event.ascending;
    this.initData();

  }

  initData() {
    this.isDataLoading = true;
    this._service.get(this.pageIndex, this.pageSize, this.searchValue, this.orderBy, this.ascending).subscribe(res => {
      this.products = res.data;
      this.totalRecords = res.totalRecords;
      this.totalPages = res.totalPages;
      this.isDataLoading = false;
      
    }, err => {
      this.isDataLoading = false;

    });
  }
  goToDetails(product:Product)
  {
    this._service.$currentProduct.next(product);
    this.router.navigate(['/','dashboard','products',product.id]);

  }
  initCols() {
    this.cols = [
      {
        prop: "images",
        title: "الصورة",
        show: true,
        sortable: true

      },
      {
        prop: "id",
        title: "الرقم التعريفي",
        show: true,
        sortable: true

      },

      {
        prop: "title",
        title: "اسم المنتج",
        show: true,
        sortable: true

      },
      {
        prop: "categoryName",
        title: "صنف المنتج",
        show: true,
        sortable: true

      },
      {
        prop: "price",
        title: "سعر المنتج",
        show: true,
        sortable: true

      },
      {
        prop: "discount",
        title: "قيمة التخفيض",
        show: true,
        sortable: true

      },

      {
        prop: "createdAt",
        title: "تاريخ الانشاء",
        show: true,
        sortable: true


      },
      {
        prop: "lastUpdate",
        title: "تاريخ التعديل",
        show: true,
        sortable: true


      }, {
        prop: "Actions",
        title: "الافعال",
        show: true,

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
  delete(id: number) {
    this.modalService
      .open(new MessageModal({
        title: "تأكيد",
        content: "هل انت متأكد كن انك تريد حذف هذا العنصر ؟", isConfirm: true, messageType: MessageTypes.Danger
      }))
      .onApprove(() => {
        this.DimLoading = true;
        this._service.delete(id).subscribe(res => {
          this.DimLoading = false;
          this.modalService.open(new MessageModal({
            title: "نجاح",
            content: "تم حذف العنصر بنجاح", isConfirm: false, messageType: MessageTypes.Success
          }))
          this.initData();
        }, err => {
          this.DimLoading = false;

        });
      })

  }
  openFormModal(product: Product) {
    this._categoriesService.get().subscribe(res => {
      const form: FormBuilderGroup[] = [
        {
  
          title: "عام",
          controls: [
            {
              title: "id",
              name: "id",
              controlType: ControlTypes.Hidden,
              width: "0px",
              value: product ? product.id : undefined
            },
            {
              title: "اسم المنتج",
              name: "title",
              icon: "tags icon",
              controlType: ControlTypes.TextInput,
              width: "100%",
              value: product ? product.title : undefined,
              validators: [
                Validators.required,
                Validators.maxLength(25),
              ]
            },
            {
              title: "الصنف",
              name: "categoryId",
              controlType: ControlTypes.Selection,
              data: res.data,
              isObjectData:true,
              labelProp:"title",
              valueProp:"id",
              width: "50%",
              value: product ? product.categoryId : undefined,

            },
            {
              title: "سعر المنتج",
              name: "price",
              icon: "dollar sign icon",
              controlType: ControlTypes.NumberInput,
              width: "50%",
              value: product ? product.price : undefined,
              validators: [
                Validators.required,
                Validators.maxLength(25),
              ]
            },
            
           
            {
              title: "الوصف",
              name: "description",
              controlType: ControlTypes.TextArea,
              width: "100%",
              value: product ? product.description : undefined,
              validators: [
                Validators.required,
                Validators.maxLength(25),
              ]
            },
            {
              title: "صور المنتج",
              name: "images",
              controlType: ControlTypes.LocalFilePicker,
              width: "100%",
              value:  undefined,

            },
  
          ]
        }
      ];
      this.modalService.open(new FormBuilderModal(
        {
          title: product ? "تعديل بيانات منتج" : "منتج جديد",
          controlGroups: form
        },
        ModalSize.Normal

      )).onApprove((result) => {

         if(typeof(result['images']) == "string" )
            result['images'] = [{path: result['images']}];
          if(typeof(result['images']) == "object")
          result['images'] = result['images'].map(e => {
            return {path:e};
          });
        if (product)
          this.update(result as Product);
        else
          this.create(result as Product);
  
      });
    },err =>{
      this.DimLoading = false;
      return;
    });
  }
  create(product: Product) {
    this.DimLoading = true;
    this._service.post(product).subscribe(res => {
      this.initData();
      this.DimLoading = false;
      this.modalService.open(new MessageModal({
        title: "نجاح",
        content: "تم انشاء العنصر بنجاح", isConfirm: false, messageType: MessageTypes.Success
      }))
    }, err => {
      console.log(err);
      this.DimLoading = false;

    })
  }
  update(product: Product) {
    this.DimLoading = true;
    this._service.put(product).subscribe(res => {
      this.initData();
      this.DimLoading = false;
      this.modalService.open(new MessageModal({
        title: "نجاج",
        content: "تم تحديث بيانات العنصر بنجاح", isConfirm: false, messageType: MessageTypes.Success
      }))
    }, err => {
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
  downloadCSV() {
    this._service.downloadCSV();
  }

}
