import { HttpClient } from '@angular/common/http';
import { Inject, Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Product } from '../models/product.model';
import { PagedResponse } from '../models/wrappers/PagedResponse.mode';

@Injectable({
  providedIn: 'root'
})
export class ProductsService {

  constructor(private http: HttpClient, @Inject('BASE_URL') private baseUrl: string) { }
  get(pageIndex = 1, pageSize = 10,title="",orderBy="lastUpdate",ascending = false): Observable<PagedResponse<Product[]>> {
    console.log(`${this.baseUrl}api/products?pageSize=${pageSize}&pageIndex=${pageIndex}`);
    return this.http.get(`${this.baseUrl}api/products?pageIndex=${pageIndex}&pageSize=${pageSize}&title=${title}&orderBy=${orderBy}&ascending=${ascending}`) as Observable<PagedResponse<Product[]>>;
  }
  post(user: Product) {
    return this.http.post(`${this.baseUrl}api/products`, user);
  }
  put(user: Product) {
    return this.http.put(`${this.baseUrl}api/products/${user.id}`, user);
  }
  delete(id: number) {
    return this.http.delete(`${this.baseUrl}api/products/${id}`);
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
