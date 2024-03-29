import { Component, OnInit } from '@angular/core';
import { Validators } from '@angular/forms';
import { FuiModalService, ModalSize } from 'ngx-fomantic-ui';
import { Branch } from 'src/app/core/models/branch.model';
import { BranchesService } from 'src/app/core/services/branches.service';
import { Column } from 'src/app/shared/data-table/models/column.model';
import { ControlTypes } from 'src/app/shared/form-builder/models/control-type.enum';
import { FormBuilderGroup } from 'src/app/shared/form-builder/models/form-builder-group.model';
import { FormBuilderModal } from 'src/app/shared/modals/form-builder-modal/form-builder-modal.component';
import { MessageModal, MessageTypes } from 'src/app/shared/modals/message-modal/message-modal.component';

@Component({
  selector: 'app-branches',
  templateUrl: './branches.component.html',
  styleUrls: ['./branches.component.scss']
})
export class BranchesComponent implements OnInit {

  cols: Column[];
  branches: Branch[] = [];
  isDataLoading = false;
  pageIndex = 1;
  pageSize = 10;
  totalRecords = 0;
  totalPages = 1;
  DimLoading = false;
  orderBy = "lastUpdate";
  ascending = false;
  searchValue = "";
  constructor(private _service: BranchesService, private modalService: FuiModalService) {

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
      this.branches = res.data;
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
        title: "اسم الفرع",
        show: true,
        sortable: true

      },
      {
        prop: "location",
        title: "عنوان الفرع",
        show: true,
        sortable: true

      },
      {
        prop: "pricePerMeter",
        title: "قيمة التوصيل",
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
  openFormModal(branch: Branch) {
    const form: FormBuilderGroup[] = [
      {

        title: "عام",
        controls: [
          {
            title: "id",
            name: "id",
            controlType: ControlTypes.Hidden,
            width: "0px",
            value: branch ? branch.id : undefined
          },
          {
            title: "اسم الفرع",
            name: "title",
            icon: "map icon",
            controlType: ControlTypes.TextInput,
            width: "100%",
            value: branch ? branch.title : undefined,
            validators: [
              Validators.required,
              Validators.maxLength(25),
            ]
          },
          {
            title: "عنوان الفرع",
            name: "location",
            icon: "map marker icon",
            controlType: ControlTypes.TextInput,
            width: "100%",
            value: branch ? branch.title : undefined,
            validators: [
              Validators.required,
              Validators.maxLength(25),
            ]
          },
          {
            title: "قيمة التوصيل للمتر",
            name: "pricePerMeter",
            icon: "dollar sign icon",
            controlType: ControlTypes.TextInput,
            width: "100%",
            value: branch ? branch.pricePerMeter : undefined,
            validators: [
              Validators.required,
            ]
          },
          {
            title: "عنوان الفرع على الخريطة",
            name: "map_location",
            controlType: ControlTypes.MapPicker,
            width: "100%",
            value: branch ? {lat:branch.lat,long:branch.long} : {lat:0.0,long:0.0},
            validators: [
              Validators.required,
              Validators.maxLength(25),
            ]
          },


        ]
      }
    ];
    this.modalService.open(new FormBuilderModal(
      {
        title: branch ? "تعديل بيانات فرع" : "فرع جديد",
        controlGroups: form
      },
      ModalSize.Normal
    )).onApprove((result) => {
      result['lat'] = result['map_location']['lat'];
      result['long'] = result['map_location']['long'];
      if (branch)
        this.update(result as Branch);
      else
        this.create(result as Branch);

    });
  }
  create(branch: Branch) {
    this.DimLoading = true;
    this._service.post(branch).subscribe(res => {
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
  update(branch: Branch) {
    this.DimLoading = true;
    this._service.put(branch).subscribe(res => {
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
