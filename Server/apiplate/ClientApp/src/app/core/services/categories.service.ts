import { HttpClient } from '@angular/common/http';
import { Inject, Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Category } from '../models/category.model';
import { PagedResponse } from '../models/wrappers/PagedResponse.mode';

@Injectable({
  providedIn: 'root'
})
export class CategoriesService {

  constructor(private http: HttpClient, @Inject('BASE_URL') private baseUrl: string) { }
  get(pageIndex = 1, pageSize = 10,title="",orderBy="lastUpdate",ascending = false): Observable<PagedResponse<Category[]>> {
    console.log(`${this.baseUrl}api/categories?pageSize=${pageSize}&pageIndex=${pageIndex}`);
    return this.http.get(`${this.baseUrl}api/categories?pageIndex=${pageIndex}&pageSize=${pageSize}&title=${title}&orderBy=${orderBy}&ascending=${ascending}`) as Observable<PagedResponse<Category[]>>;
  }
  post(user: Category) {
    return this.http.post(`${this.baseUrl}api/categories`, user);
  }
  put(user: Category) {
    return this.http.put(`${this.baseUrl}api/categories/${user.id}`, user);
  }
  delete(id: number) {
    return this.http.delete(`${this.baseUrl}api/categories/${id}`);
  }
  downloadCSV() {
    this.http.get(`${this.baseUrl}api/categories/export/csv`, { responseType: 'blob' }).subscribe(res => {
      let blob = new Blob([res], { type: 'text/plain' });
      var downloadURL = window.URL.createObjectURL(res);
      var link = document.createElement('a');
      link.href = downloadURL;
      link.download = "categories.csv";
      link.click();
    })
  }
}
