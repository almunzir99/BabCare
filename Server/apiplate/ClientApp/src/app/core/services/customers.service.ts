import { HttpClient } from '@angular/common/http';
import { Inject, Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Customer } from '../models/customer.model';
import { PagedResponse } from '../models/wrappers/PagedResponse.mode';

@Injectable({
  providedIn: 'root'
})
export class CustomersService {

  constructor(private http: HttpClient, @Inject('BASE_URL') private baseUrl: string) { }
  get(pageIndex = 1, pageSize = 10,title="",orderBy="lastUpdate",ascending = false): Observable<PagedResponse<Customer[]>> {
    console.log(`${this.baseUrl}api/customers?pageSize=${pageSize}&pageIndex=${pageIndex}`);
    return this.http.get(`${this.baseUrl}api/customers?pageIndex=${pageIndex}&pageSize=${pageSize}&title=${title}&orderBy=${orderBy}&ascending=${ascending}`) as Observable<PagedResponse<Customer[]>>;
  }
  post(user: Customer) {
    return this.http.post(`${this.baseUrl}api/customers/register`, user);
  }
  put(user: Customer) {
    return this.http.put(`${this.baseUrl}api/customers/${user.id}`, user);
  }
  changePassword(oldPassword:string,newPassword)
  {
    return this.http.put(`${this.baseUrl}api/customers/profile/password-reset`, {newPassword:newPassword,oldPassword:oldPassword});

  }
  delete(id: number) {
    return this.http.delete(`${this.baseUrl}api/customers/${id}`);
  }
  downloadCSV() {
    this.http.get(`${this.baseUrl}api/customers/export/csv`, { responseType: 'blob' }).subscribe(res => {
      let blob = new Blob([res], { type: 'text/plain' });
      var downloadURL = window.URL.createObjectURL(res);
      var link = document.createElement('a');
      link.href = downloadURL;
      link.download = "customers.csv";
      link.click();
    })
  }
}
