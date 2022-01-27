import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { FuiModalService, ModalSize } from 'ngx-fomantic-ui';
import { Order } from 'src/app/core/models/order.model';
import { DeliveryService } from 'src/app/core/services/delivery.service';
import { OrdersService } from 'src/app/core/services/orders.service';
import { Column } from 'src/app/shared/data-table/models/column.model';
import { ControlTypes } from 'src/app/shared/form-builder/models/control-type.enum';
import { FormBuilderModal } from 'src/app/shared/modals/form-builder-modal/form-builder-modal.component';
import { MessageModal, MessageTypes } from 'src/app/shared/modals/message-modal/message-modal.component';

@Component({
  selector: 'app-order-detail',
  templateUrl: './order-detail.component.html',
  styleUrls: ['./order-detail.component.scss']
})
export class OrderDetailComponent implements OnInit {
  currentOrder: Order;
  isLoading = false;
  productCols: Column[] = [];
  dimLoading = false;
  statuses = [
    "جديد",
    "تم التأكيد",
    "قيد التحضير",
    "قيد التوصيل",
    "مكتمل",
    "مغلي من طرف العميل",
    "ملغي من الادارة"
  ];
  constructor(private route: ActivatedRoute, private _service: OrdersService, private modalService: FuiModalService,private _deliveryService:DeliveryService) {

  }
  get(id: number) {
    this.isLoading = true;
    this._service.single(id).subscribe(res => {

      this.currentOrder = res.data;
      this.isLoading = false;


    }, err => {
      console.log(err)
      this.isLoading = false;
    });
  }
  initProductCols() {
    this.productCols = [
      {
        title: "الرقم التعريفي",
        prop: "id",
        show: true
      },
      {
        title: "الاسم",
        prop: "product",
        show: true
      },
      {
        title: "السعر",
        prop: "product",
        show: true
      },
      {
        title: "الكمية",
        prop: "product",
        show: true
      },
      {
        title: "مجموع السعر",
        prop: "product",
        show: true
      },
      {
        title: "الاضافات",
        prop: "orderedAddons",
        show: true
      },
      {
        title: "الخيارات",
        prop: "orderedOptions",
        show: true
      }

    ];
  }
  changeStatus(step:number) {
    if(step == 3)
    {
      this.assignDeliveryDriver();
      return;
    }
    this.modalService.open(new FormBuilderModal({
      title: "ارفاق تعليق",

      controlGroups: [
        {
          title: undefined,
          controls: [
            {
              title: "ارفاق تعليق", name: "feedback", controlType: ControlTypes.TextArea, icon: "text icon", width: "100%"
            }
          ]
        }
      ]
    }, ModalSize.Mini)).onApprove(result => {
      var feedBack = result['feedback'] ?? null;
      if(step == 1)
      this.confirmOrder(feedBack)
      if(step == 2)
      this.prepareOrder(feedBack)
      if(step == -1)
      this.cancelOrder(feedBack)
      
    });
  }
  confirmOrder(feedback:string){
    this.dimLoading = true;
      this._service.confirmOrder(this.currentOrder.id, feedback).subscribe(res => {
        this.dimLoading = false;
        this.route.params.subscribe(res => this.get(res['id']));
      }, err => {
        this.dimLoading = false;
        console.log(err);
        this.modalService.open(new MessageModal({
          title: "خطأ",
          content: "فشلت العملية", isConfirm: false, messageType: MessageTypes.Danger
        }));
        console.log(err);
      })
  }
  prepareOrder(feedback:string){
    this.dimLoading = true;
      this._service.prepareOrder(this.currentOrder.id, feedback).subscribe(res => {
        this.dimLoading = false;
        this.route.params.subscribe(res => this.get(res['id']));
      }, err => {
        this.dimLoading = false;
        console.log(err);
        this.modalService.open(new MessageModal({
          title: "خطأ",
          content: "فشلت العملية", isConfirm: false, messageType: MessageTypes.Danger
        }));
        console.log(err);
      })
  }
  cancelOrder(feedback:string){
    this.dimLoading = true;
      this._service.cancelOrder(this.currentOrder.id, feedback).subscribe(res => {
        this.dimLoading = false;
        this.route.params.subscribe(res => this.get(res['id']));
      }, err => {
        this.dimLoading = false;
        console.log(err);
        this.modalService.open(new MessageModal({
          title: "خطأ",
          content: "فشلت العملية", isConfirm: false, messageType: MessageTypes.Danger
        }));
        console.log(err);
      })
  }
  assignDeliveryDriver()
  {
    this.dimLoading = true;
    var drivers;
    this._deliveryService.get().subscribe(res => {
      drivers = res.data;
      console.log(drivers);
      this.dimLoading = false; 
      this.modalService.open(new FormBuilderModal({
        title: "تعيين سائق",
  
        controlGroups: [
          {
            title: undefined,
            controls: [
              {
                title: "اختر السائق",
                name: "driverId",
                controlType: ControlTypes.Selection,
                data: drivers,
                isObjectData:true,
                labelProp:"username",
                valueProp:"id",
                width: "100%",
                value: undefined,
  
              },
              {
                title: "ارفاق تعليق", name: "feedback", controlType: ControlTypes.TextArea, icon: "text icon", width: "100%"
              }
            ]
          }
        ]
      }, ModalSize.Mini)).onApprove(result => {
        this.dimLoading = true;
        this._service.assignDelivery(this.currentOrder.id, result['driverId'] ,result['feedback']).subscribe(res => {
          this.dimLoading = false;
          this.route.params.subscribe(res => this.get(res['id']));
        }, err => {
          this.dimLoading = false;
          console.log(err);
          this.modalService.open(new MessageModal({
            title: "خطأ",
            content: "فشلت العملية", isConfirm: false, messageType: MessageTypes.Danger
          }));
          console.log(err);
        })
      });

    },err => this.dimLoading = false);
  }
  ngOnInit(): void {
    this.route.params.subscribe(res => {
      this.get(res['id']);
    })
    this.initProductCols();
  }

}
