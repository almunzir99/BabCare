import { HttpClient } from '@angular/common/http';
import { Inject, Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Branch } from '../models/branch.model';
import { PagedResponse } from '../models/wrappers/PagedResponse.mode';

@Injectable({
  providedIn: 'root'
})
export class BranchesService {
  constructor(private http: HttpClient, @Inject('BASE_URL') private baseUrl: string) { }
  get(pageIndex = 1, pageSize = 10,title="",orderBy="lastUpdate",ascending = false): Observable<PagedResponse<Branch[]>> {
    console.log(`${this.baseUrl}api/branches?pageSize=${pageSize}&pageIndex=${pageIndex}`);
    return this.http.get(`${this.baseUrl}api/branches?pageIndex=${pageIndex}&pageSize=${pageSize}&title=${title}&orderBy=${orderBy}&ascending=${ascending}`) as Observable<PagedResponse<Branch[]>>;
  }
  post(branch: Branch) {
    return this.http.post(`${this.baseUrl}api/branches`, branch);
  }
  put(branch: Branch) {
    return this.http.put(`${this.baseUrl}api/branches/${branch.id}`, branch);
  }
  delete(id: number) {
    return this.http.delete(`${this.baseUrl}api/branches/${id}`);
  }
  downloadCSV() {
    this.http.get(`${this.baseUrl}api/branches/export/csv`, { responseType: 'blob' }).subscribe(res => {
      let blob = new Blob([res], { type: 'text/plain' });
      var downloadURL = window.URL.createObjectURL(res);
      var link = document.createElement('a');
      link.href = downloadURL;
      link.download = "branches.csv";
      link.click();
    })
  }
}
