import { HttpClient } from '@angular/common/http';
import { Inject, Injectable } from '@angular/core';
import { BehaviorSubject, Observable } from 'rxjs';
import { Product } from '../models/product.model';
import { ApiResponse } from '../models/wrappers/apiResponse.model';
import { PagedResponse } from '../models/wrappers/PagedResponse.mode';

@Injectable({
  providedIn: 'root'
})
export class ProductsService {
  public $currentProduct = new BehaviorSubject<Product | null>(null);
  constructor(private http: HttpClient, @Inject('BASE_URL') private baseUrl: string) { }
  get(pageIndex = 1, pageSize = 10,title="",orderBy="lastUpdate",ascending = false): Observable<PagedResponse<Product[]>> {
    console.log(`${this.baseUrl}api/products?pageSize=${pageSize}&pageIndex=${pageIndex}`);
    return this.http.get(`${this.baseUrl}api/products?pageIndex=${pageIndex}&pageSize=${pageSize}&title=${title}&orderBy=${orderBy}&ascending=${ascending}`) as Observable<PagedResponse<Product[]>>;
  }
  post(product: Product) {
    return this.http.post(`${this.baseUrl}api/products`, product);
  }
  put(product: Product) {
    return this.http.put(`${this.baseUrl}api/products/${product.id}`, product);
  }
  delete(id: number) {
    return this.http.delete(`${this.baseUrl}api/products/${id}`);
  }
  single(id: number) :Observable<ApiResponse<Product>> {
    return this.http.get(`${this.baseUrl}api/products/${id}`) as Observable<ApiResponse<Product>>;
  }
  addOption(productId?:number,optionId?:number)
  {
      return this.http.post(`${this.baseUrl}api/products/options/add?productId=${productId}&optionId=${optionId}`,{});
  }
  removeOption(productId?:number,optionId?:number)
  {
      return this.http.delete(`${this.baseUrl}api/products/options/remove?productId=${productId}&optionId=${optionId}`,{});
  }
  addAddon(productId?:number,addonId?:number)
  {
      return this.http.post(`${this.baseUrl}api/products/addons/add?productId=${productId}&addonId=${addonId}`,{});
  }
  removeAddon(productId?:number,addonId?:number)
  {
      return this.http.delete(`${this.baseUrl}api/products/addons/remove?productId=${productId}&addonId=${addonId}`,{});
  }
  downloadCSV() {
    this.http.get(`${this.baseUrl}api/products/export/csv`, { responseType: 'blob' }).subscribe(res => {
      let blob = new Blob([res], { type: 'text/plain' });
      var downloadURL = window.URL.createObjectURL(res);
      var link = document.createElement('a');
      link.href = downloadURL;
      link.download = "products.csv";
      link.click();
    })
  }
}
