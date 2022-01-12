import { Component, EventEmitter, Inject, Input, OnInit, Output } from '@angular/core';
import { Column } from './models/column.model';
@Component({
  selector: 'data-table',
  templateUrl: './data-table.component.html',
  styleUrls: ['./data-table.component.scss']
})
export class DataTableComponent implements OnInit {
  @Input('cols') columns: Column[];
  @Input('rows') rows: any[];
  @Input('loading') loading = false;
  @Input('cell-template') cellTemplate;
  @Input("pageIndex") pageIndex;
  @Output('pageIndexChanged') pageIndexChanged = new EventEmitter<number>();
  @Input('total-items') totalItems = 1;
  @Input('page-size') pageSize = 1;
  @Input("show-footer") showFooter = true;
  @Output('sortChange') sortChange = new EventEmitter<object>();
  sortProp = "lastUpdate";
  ascending = false;
  openTableModal = false;
  resizers: NodeListOf<HTMLElement>;
  cols: NodeListOf<HTMLElement>;
  constructor(@Inject("DIRECTION") public direction:string) {

  }
  openTableSetting() {
    this.openTableModal = true;
  }
  closeTableSetting() {
    this.openTableModal = false;
  }
  ngAfterViewInit() {
    this.resizers = document.querySelectorAll(".resizer") as NodeListOf<HTMLElement>;
    this.cols = document.querySelectorAll("th") as NodeListOf<HTMLElement>;
    this.cols.forEach((col, index) => {
      this.createResizableColumn(col, this.resizers[index]);

    });
  }
  onSortChange(sortable:boolean,prop: string) {
    if(!sortable)
    return;
    this.sortProp = prop;
    this.ascending = !this.ascending;
    this.sortChange.emit({ orderBy: this.sortProp, ascending: this.ascending })
  }
  pageIndexChange(index: number) {
    this.pageIndex = index;
    console.log(this.pageIndex);
    this.pageIndexChanged.emit(index);
  }
  createResizableColumn(col: HTMLElement, resizer: HTMLElement) {
    let x = 0;
    let w = 0;
    const mouseDownHandler = (ev) => {
      x = ev.clientX;
      const styles = window.getComputedStyle(col);
      w = parseInt(styles.width, 10);
      document.addEventListener('mousemove', mouseMoveHandler);
      document.addEventListener('mouseup', mouseUpHandler);
    }
    const mouseMoveHandler = function (e) {
      const dx = e.clientX - x;

      col.style.width = `${w + dx}px`;
    };

    const mouseUpHandler = function () {
      document.removeEventListener('mousemove', mouseMoveHandler);
      document.removeEventListener('mouseup', mouseUpHandler);
    };
    resizer.addEventListener('mousedown', mouseDownHandler);
  }
  ngOnInit(): void {
  }

}
