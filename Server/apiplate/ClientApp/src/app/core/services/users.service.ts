import { HttpClient } from '@angular/common/http';
import { Inject, Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { User } from '../models/user.model';
import { ApiResponse } from '../models/wrappers/apiResponse.model';
import { PagedResponse } from '../models/wrappers/PagedResponse.mode';

@Injectable({
  providedIn: 'root'
})
export class UsersService {

  constructor(private http: HttpClient, @Inject('BASE_URL') private baseUrl: string) { }
  get(pageIndex = 1, pageSize = 10,title="",orderBy="lastUpdate",ascending = false): Observable<PagedResponse<User[]>> {
    console.log(`${this.baseUrl}api/admins?pageSize=${pageSize}&pageIndex=${pageIndex}`);
    return this.http.get(`${this.baseUrl}api/admins?pageIndex=${pageIndex}&pageSize=${pageSize}&title=${title}&orderBy=${orderBy}&ascending=${ascending}`) as Observable<PagedResponse<User[]>>;
  }
  post(user: User) {
    console.log(user);
    return this.http.post(`${this.baseUrl}api/admins/register`, user);
  }
  put(user: User) {
    return this.http.put(`${this.baseUrl}api/admins/${user.id}`, user);
  }
  changePassword(oldPassword:string,newPassword)
  {
    return this.http.put(`${this.baseUrl}api/admins/profile/password-reset`, {newPassword:newPassword,oldPassword:oldPassword});

  }
  delete(id: number) {
    return this.http.delete(`${this.baseUrl}api/admins/${id}`);
  }
  downloadCSV() {
    this.http.get(`${this.baseUrl}api/admins/export/csv`, { responseType: 'blob' }).subscribe(res => {
      let blob = new Blob([res], { type: 'text/plain' });
      var downloadURL = window.URL.createObjectURL(res);
      var link = document.createElement('a');
      link.href = downloadURL;
      link.download = "admins.csv";
      link.click();
    })
  }

}
