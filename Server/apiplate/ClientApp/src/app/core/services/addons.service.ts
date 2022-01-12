import { HttpClient } from '@angular/common/http';
import { Inject, Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { AddOn } from '../models/add-on.model';
import { Option } from '../models/option.model';
import { PagedResponse } from '../models/wrappers/PagedResponse.mode';

@Injectable({
  providedIn: 'root'
})
export class AddonsService {

  constructor(private http: HttpClient, @Inject('BASE_URL') private baseUrl: string) { }
  get(pageIndex = 1, pageSize = 10,title="",orderBy="lastUpdate",ascending = false): Observable<PagedResponse<AddOn[]>> {
    console.log(`${this.baseUrl}api/products/addons?pageSize=${pageSize}&pageIndex=${pageIndex}`);
    return this.http.get(`${this.baseUrl}api/products/addons?pageIndex=${pageIndex}&pageSize=${pageSize}&title=${title}&orderBy=${orderBy}&ascending=${ascending}`) as Observable<PagedResponse<AddOn[]>>;
  }
  post(user: AddOn) {
    return this.http.post(`${this.baseUrl}api/products/addons`, user);
  }
  put(user: AddOn) {
    return this.http.put(`${this.baseUrl}api/products/addons/${user.id}`, user);
  }
  delete(id: number) {
    return this.http.delete(`${this.baseUrl}api/products/addons/${id}`);
  }
  downloadCSV() {
    this.http.get(`${this.baseUrl}api/products/addons/export/csv`, { responseType: 'blob' }).subscribe(res => {
      let blob = new Blob([res], { type: 'text/plain' });
      var downloadURL = window.URL.createObjectURL(res);
      var link = document.createElement('a');
      link.href = downloadURL;
      link.download = "products/addons.csv";
      link.click();
    })
  }
}
