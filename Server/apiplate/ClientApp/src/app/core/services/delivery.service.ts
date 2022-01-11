import { HttpClient } from '@angular/common/http';
import { Inject, Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Delivery } from '../models/delivery.model';
import { PagedResponse } from '../models/wrappers/PagedResponse.mode';

@Injectable({
  providedIn: 'root'
})
export class DeliveryService {

  constructor(private http: HttpClient, @Inject('BASE_URL') private baseUrl: string) { }
  get(pageIndex = 1, pageSize = 10,title="",orderBy="lastUpdate",ascending = false): Observable<PagedResponse<Delivery[]>> {
    console.log(`${this.baseUrl}api/delivery?pageSize=${pageSize}&pageIndex=${pageIndex}`);
    return this.http.get(`${this.baseUrl}api/delivery?pageIndex=${pageIndex}&pageSize=${pageSize}&title=${title}&orderBy=${orderBy}&ascending=${ascending}`) as Observable<PagedResponse<Delivery[]>>;
  }
  post(user: Delivery) {
    return this.http.post(`${this.baseUrl}api/delivery/register`, user);
  }
  put(user: Delivery) {
    return this.http.put(`${this.baseUrl}api/delivery/${user.id}`, user);
  }
  changePassword(oldPassword:string,newPassword)
  {
    return this.http.put(`${this.baseUrl}api/delivery/profile/password-reset`, {newPassword:newPassword,oldPassword:oldPassword});

  }
  delete(id: number) {
    return this.http.delete(`${this.baseUrl}api/delivery/${id}`);
  }
  downloadCSV() {
    this.http.get(`${this.baseUrl}api/delivery/export/csv`, { responseType: 'blob' }).subscribe(res => {
      let blob = new Blob([res], { type: 'text/plain' });
      var downloadURL = window.URL.createObjectURL(res);
      var link = document.createElement('a');
      link.href = downloadURL;
      link.download = "delivery.csv";
      link.click();
    })
  }
}
