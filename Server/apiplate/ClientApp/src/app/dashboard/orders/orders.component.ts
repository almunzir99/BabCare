import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { FuiModalService } from 'ngx-fomantic-ui';
import { OrderStatus } from 'src/app/core/models/order-status.enum';
import { Order } from 'src/app/core/models/order.model';
import { OrdersService } from 'src/app/core/services/orders.service';
import { Column } from 'src/app/shared/data-table/models/column.model';

@Component({
  selector: 'app-orders',
  templateUrl: './orders.component.html',
  styleUrls: ['./orders.component.scss']
})
export class OrdersComponent implements OnInit {
  cols: Column[];
  isDataLoading = false;
  pageIndex = 1;
  pageSize = 10;
  totalRecords = 0;
  totalPages = 1;
  DimLoading = false;
  orderBy = "lastUpdate";
  ascending = false;
  searchValue: any;
  orders: Order[];
  status: OrderStatus;
  initCols() {
    this.cols = [
      {
        prop: "id",
        title: "الرقم التعريفي",
        show: true,
        sortable: true
      },
      {
        prop: "customer",
        title: "اسم العميل",
        show: true,
        sortable: true
      },
      {
        prop: "products",
        title: "عدد المنتجات",
        show: true,
        sortable: true
      },
      {
        prop: "delivery",
        title: "سائق التوصيل",
        show: true,
      },
      {
        prop: "status",
        title: "حالة الطلب",
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

    ];
  }
  statuses = [
    "جديد",
    "تم التأكيد",
    "قيد التحضير",
    "قيد التوصيل",
    "مكتمل",
    "مغلي من طرف العميل",
    "ملغي من الادارة"
  ];
  constructor(private _service: OrdersService, private modalService: FuiModalService,private router:Router) { }
  onSearchChange(value) {
    this.searchValue = value;
    this.initData();
  }
  onSortChange(event) {
    this.orderBy = event.orderBy;
    this.ascending = event.ascending;
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
  statusChanged(status: string) {

    var statIndex = this.statuses.indexOf(status);
    console.log(statIndex);
    if (statIndex != -1) { this.status = statIndex; this.initData(); }
  }
  initData() {
    this.isDataLoading = true;
    this._service.get(this.pageIndex, this.pageSize, this.searchValue, this.orderBy, this.status, this.ascending).subscribe(res => {
      this.orders = res.data;
      console.log(res.data);
      this.totalRecords = res.totalRecords;
      this.totalPages = res.totalPages;
      this.isDataLoading = false;

    }, err => {
      this.isDataLoading = false;

    });
  }
  range(total: number, beginIndex: number = 0, step: number = 1): number[] {
    let list: number[] = [];
    for (let index = beginIndex; index < total; index += step) {
      list.push(index);
    }
    return list;
  }
  goToDetails(order:Order)
  {
    // this._service.$currentProduct.next(product);
    this.router.navigate(['/','dashboard','orders',order.id]);

  }
  ngOnInit(): void {
    this.initCols();
    this.initData();
  }

}
