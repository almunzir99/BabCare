import { HttpClient } from '@angular/common/http';
import { Inject, Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Option } from '../models/option.model';
import { PagedResponse } from '../models/wrappers/PagedResponse.mode';

@Injectable({
  providedIn: 'root'
})
export class OptionsService {

  constructor(private http: HttpClient, @Inject('BASE_URL') private baseUrl: string) { }
  get(pageIndex = 1, pageSize = 10,title="",orderBy="lastUpdate",ascending = false): Observable<PagedResponse<Option[]>> {
    console.log(`${this.baseUrl}api/products/options?pageSize=${pageSize}&pageIndex=${pageIndex}`);
    return this.http.get(`${this.baseUrl}api/products/options?pageIndex=${pageIndex}&pageSize=${pageSize}&title=${title}&orderBy=${orderBy}&ascending=${ascending}`) as Observable<PagedResponse<Option[]>>;
  }
  post(user: Option) {
    return this.http.post(`${this.baseUrl}api/products/options`, user);
  }
  put(user: Option) {
    return this.http.put(`${this.baseUrl}api/products/options/${user.id}`, user);
  }
  delete(id: number) {
    return this.http.delete(`${this.baseUrl}api/products/options/${id}`);
  }
  downloadCSV() {
    this.http.get(`${this.baseUrl}api/products/options/export/csv`, { responseType: 'blob' }).subscribe(res => {
      let blob = new Blob([res], { type: 'text/plain' });
      var downloadURL = window.URL.createObjectURL(res);
      var link = document.createElement('a');
      link.href = downloadURL;
      link.download = "products/options.csv";
      link.click();
    })
  }
}
