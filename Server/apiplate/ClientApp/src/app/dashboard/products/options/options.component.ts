import { Component, OnInit } from '@angular/core';
import { Validators } from '@angular/forms';
import { FuiModalService, ModalSize } from 'ngx-fomantic-ui';
import { Option } from 'src/app/core/models/option.model';
import { OptionsService } from 'src/app/core/services/options.service';
import { Column } from 'src/app/shared/data-table/models/column.model';
import { ControlTypes } from 'src/app/shared/form-builder/models/control-type.enum';
import { FormBuilderGroup } from 'src/app/shared/form-builder/models/form-builder-group.model';
import { FormBuilderModal } from 'src/app/shared/modals/form-builder-modal/form-builder-modal.component';
import { MessageModal, MessageTypes } from 'src/app/shared/modals/message-modal/message-modal.component';

@Component({
  selector: 'app-options',
  templateUrl: './options.component.html',
  styleUrls: ['./options.component.scss']
})
export class OptionsComponent implements OnInit {

  cols: Column[];
  options: Option[] = [];
  isDataLoading = false;
  pageIndex = 1;
  pageSize = 10;
  totalRecords = 0;
  totalPages = 1;
  DimLoading = false;
  orderBy = "lastUpdate";
  ascending = false;
  searchValue = "";
  constructor(private _service: OptionsService, private modalService: FuiModalService) {

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
      this.options = res.data;
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
        show: true,
        sortable: true

      },

      {
        prop: "title",
        title: "اسم الخيار",
        show: true,
        sortable: true

      },
      {
        prop: "values",
        title: "عدد العناصر",
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
  openFormModal(option: Option) {
    const form: FormBuilderGroup[] = [
      {

        title: "عام",
        controls: [
          {
            title: "id",
            name: "id",
            controlType: ControlTypes.Hidden,
            width: "0px",
            value: option ? option.id : undefined
          },
          {
            title: "اسم الاضافة",
            name: "title",
            icon: "utensils icon",
            controlType: ControlTypes.TextInput,
            width: "100%",
            value: option ? option.title : undefined,
            validators: [
              Validators.required,
              Validators.maxLength(25),
            ]
          },
          {
            title: "قيم الاضافة",
            name: "values",
            controlType: ControlTypes.TableBuilder,
            width: "100%",
            value: option ? option.values : [],
            controls: [
              {
                title: undefined,
                controls: [
                  {
                    title: "الاسم",
                    name: "title",
                    icon:"utensils icon",
                    controlType: ControlTypes.TextInput,
                    width: "50%"
                  },
                  {
                    title: "القيمة",
                    icon:"dollar sign icon",
                    name: "value",
                    controlType: ControlTypes.TextInput,
                    width: "50%"
                  }
                ],
              }
            ],
            // validators: [
            //   Validators.required,
            //   Validators.maxLength(25),
            // ]
          },



        ]
      }
    ];
    this.modalService.open(new FormBuilderModal(
      {
        title: option ? "تعديل بيانات خيار" : "خيار جديد",
        controlGroups: form,
        tableDeleteClick: (event) => {
          if (!option) {
            var index = event.values.indexOf(event.target);
            console.log(index);
            event.values = event.values.splice(index, 1);
          }
          else{

          }
        }
      },
      ModalSize.Normal
    )).onApprove((result) => {
      console.log(result);
      if (option)
        this.update(result as Option);
      else
        this.create(result as Option);

    });
  }
  deleteOptionValue(){
    
  }
  create(option: Option) {
    this.DimLoading = true;
    this._service.post(option).subscribe(res => {
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
  update(option: Option) {
    this.DimLoading = true;
    this._service.put(option).subscribe(res => {
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
