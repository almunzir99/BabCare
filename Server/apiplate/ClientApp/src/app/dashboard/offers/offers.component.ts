import { Component, OnInit } from '@angular/core';
import { Validators } from '@angular/forms';
import { FuiModalService, ModalSize } from 'ngx-fomantic-ui';
import { Offer } from 'src/app/core/models/offer.model';
import { OffersService } from 'src/app/core/services/offers.service';
import { Column } from 'src/app/shared/data-table/models/column.model';
import { ControlTypes } from 'src/app/shared/form-builder/models/control-type.enum';
import { FormBuilderGroup } from 'src/app/shared/form-builder/models/form-builder-group.model';
import { FormBuilderModal } from 'src/app/shared/modals/form-builder-modal/form-builder-modal.component';
import { MessageModal, MessageTypes } from 'src/app/shared/modals/message-modal/message-modal.component';

@Component({
  selector: 'app-offers',
  templateUrl: './offers.component.html',
  styleUrls: ['./offers.component.scss']
})
export class OffersComponent implements OnInit {

  cols: Column[];
  offers: Offer[] = [];
  isDataLoading = false;
  pageIndex = 1;
  pageSize = 10;
  totalRecords = 0;
  totalPages = 1;
  DimLoading = false;
  orderBy = "lastUpdate";
  ascending = false;
  searchValue = "";
  constructor(private _service: OffersService, private modalService: FuiModalService) {

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
      this.offers = res.data;
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
        title: "الصورة",
        show: true,

      },
      {
        prop: "id",
        title: "الرقم التعريفي",
        show: true,
        sortable: true

      },

      {
        prop: "title",
        title: "اسم الصنف",
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
        prop: "startDate",
        title: "تاريخ البداية",
        show: true,
        sortable: true

      },
      {
        prop: "endDate",
        title: "تاريج الانتهاء",
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
  openFormModal(offer: Offer) {
    const form: FormBuilderGroup[] = [
      {

        title: "عام",
        controls: [
          {
            title: "id",
            name: "id",
            controlType: ControlTypes.Hidden,
            width: "0px",
            value: offer ? offer.id : undefined
          },
          {
            title: "اسم الصنف",
            name: "title",
            icon: "tags icon",
            controlType: ControlTypes.TextInput,
            width: "50%",
            value: offer ? offer.title : undefined,
            validators: [
              Validators.required,
              Validators.maxLength(25),
            ]
          },
          {
            title: "قيمة التخفيض",
            name: "discount",
            icon: "percent icon",
            controlType: ControlTypes.NumberInput,
            width: "50%",
            value: offer ? offer.discount : undefined,
             
          },
          {
            title: "بداية العرض",
            name: "startDate",
            icon: "calendar alternate icon",
            controlType: ControlTypes.DatePicker,
            width: "50%",
            value: offer ? offer.startDate : undefined,
            
          },
          {
            title: "نهاية العرض",
            name: "endDate",
            icon: "calendar alternate icon",
            controlType: ControlTypes.DatePicker,
            width: "50%",
            value: offer ? offer.endDate : undefined,
            
          },
          {
            title: "الصورة",
            name: "image",
            controlType: ControlTypes.LocalFilePicker,
            width: "100%",
            value: offer ? offer.image?.path : undefined,

          },


        ]
      }
    ];
    this.modalService.open(new FormBuilderModal(
      {
        title: offer ? "تعديل بيانات صنف" : "صنف جديد",
        controlGroups: form
      },
      ModalSize.Normal

    )).onApprove((result) => {
      result['image'] = {path:result['image']};
      if (offer)
        this.update(result as Offer);
      else
        this.create(result as Offer);

    });
  }
  create(offer: Offer) {
    this.DimLoading = true;
    this._service.post(offer).subscribe(res => {
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
  update(offer: Offer) {
    this.DimLoading = true;
    this._service.put(offer).subscribe(res => {
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
