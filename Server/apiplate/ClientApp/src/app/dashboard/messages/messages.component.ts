import { Component, Inject, OnInit } from '@angular/core';
import { FuiModalService } from 'ngx-fomantic-ui';
import { Message } from 'src/app/core/models/message.model';
import { MessagesService } from 'src/app/core/services/messages.service';
import { Column } from 'src/app/shared/data-table/models/column.model';
 

@Component({
  selector: 'app-messages',
  templateUrl: './messages.component.html',
  styleUrls: ['./messages.component.scss']
})
export class MessagesComponent implements OnInit {
  cols: Column[];
  data:Message[];
  pageIndex = 1;
  pageSize = 10;
  totalRecords = 0;
  totalPages = 1;
  DimLoading = false;
  orderBy = "lastUpdate";
  ascending = false;
  searchValue = "";
  isDataLoading: boolean = false;
  constructor(private _service:MessagesService,private modalService:FuiModalService) {
    this.initCols();
    this.initData();
  }
  ngOnInit(): void {
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
  pageIndexChanged(index: number) {
    this.pageIndex = index;
    this.initData();

  }
  pageSizeChanged(size: number) {
    this.pageSize = size;
    this.initData();

  }
  initData() {
    this.isDataLoading = true;
    this._service.get(this.pageIndex, this.pageSize,this.searchValue,this.orderBy,this.ascending).subscribe(res => {
      this.data = res.data;
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
        title: "Id",
        prop: "id",
        show: true,
        sortable: true
      },
      {
        title: "full Name",
        prop: "fullName",
        show: true,
        sortable: true
      },
      {
        title: "email",
        prop: "email",
        show: true,
        sortable: true
      },
      {
        title: "phone",
        prop: "phone",
        show: true,
        sortable: true
      },
      {
        title: "Content",
        prop: "content",
        show: true,
        sortable: true
      },
      {
        title: "Sent At",
        prop: "createdAt",
        show: true,
        sortable: true
      },
      {
        title: "Actions",
        prop: "actions",
        show: true,
      }
    ]
  }
   


  range(total: number, beginIndex: number = 0, step: number = 1): number[] {
    let list: number[] = [];
    for (let index = beginIndex; index < total; index += step) {
      list.push(index);
    }
    return list;
  }
}
