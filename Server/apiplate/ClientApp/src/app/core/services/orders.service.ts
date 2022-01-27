import { HttpClient, HttpParams } from '@angular/common/http';
import { Inject, Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { OrderStatus } from '../models/order-status.enum';
import { Order } from "../models/order.model";
import { ApiResponse } from '../models/wrappers/apiResponse.model';
import { PagedResponse } from '../models/wrappers/PagedResponse.mode';

@Injectable({
  providedIn: 'root'
})
export class OrdersService {

  constructor(private http: HttpClient, @Inject('BASE_URL') private baseUrl: string) { 

  }
  get(pageIndex = 1, pageSize = 10,id:number,orderBy="lastUpdate",status:OrderStatus,ascending = false): Observable<PagedResponse<Order[]>> {
     
    var httpParams = new HttpParams();
    httpParams =  httpParams.set("pageIndex",`${pageIndex}`);
    httpParams =  httpParams.set("pageSize",`${pageSize}`);
    if(id)
    httpParams =  httpParams.set("id",`${id}`);
    httpParams =  httpParams.set("orderBy",`${orderBy}`);
    if(status != null && status != undefined)
    httpParams =  httpParams.set("status",`${status}`);
    httpParams =  httpParams.set("ascending",`${ascending}`);
    return this.http.get(`${this.baseUrl}api/orders`,{params:httpParams}) as Observable<PagedResponse<Order[]>>;
  }
  single(id:number) : Observable<ApiResponse<Order>>
  {
      return this.http.get(`${this.baseUrl}api/orders/${id}`) as Observable<ApiResponse<Order>>;
  }
  confirmOrder(orderId:number,feedback:string = null){
    return this.http.post(`${this.baseUrl}api/orders/confirm`,{orderId:orderId,feedback:feedback});
  }
  prepareOrder(orderId:number,feedback:string = null){
    return this.http.post(`${this.baseUrl}api/orders/prepare`,{orderId:orderId,feedback:feedback});
  }
  cancelOrder(orderId:number,feedback:string = null){
    return this.http.post(`${this.baseUrl}api/orders/cancel`,{orderId:orderId,feedback:feedback});
  }
  assignDelivery(orderId:number,deliveryDriver:number,feedback:string = null){
    return this.http.post(`${this.baseUrl}api/orders/assign-delivery`,{orderId:orderId,deliveryId:deliveryDriver,feedback:feedback});
  }
}
