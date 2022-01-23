import { HttpClient } from '@angular/common/http';
import { Inject, Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Offer } from '../models/offer.model';
import { PagedResponse } from '../models/wrappers/PagedResponse.mode';

@Injectable({
  providedIn: 'root'
})
export class OffersService {

  constructor(private http: HttpClient, @Inject('BASE_URL') private baseUrl: string) { }
  get(pageIndex = 1, pageSize = 10,title="",orderBy="lastUpdate",ascending = false): Observable<PagedResponse<Offer[]>> {
    console.log(`${this.baseUrl}api/offers?pageSize=${pageSize}&pageIndex=${pageIndex}`);
    return this.http.get(`${this.baseUrl}api/offers?pageIndex=${pageIndex}&pageSize=${pageSize}&title=${title}&orderBy=${orderBy}&ascending=${ascending}`) as Observable<PagedResponse<Offer[]>>;
  }
  post(Offer: Offer) {
    return this.http.post(`${this.baseUrl}api/offers`, Offer);
  }
  put(Offer: Offer) {
    return this.http.put(`${this.baseUrl}api/offers/${Offer.id}`, Offer);
  }
  delete(id: number) {
    return this.http.delete(`${this.baseUrl}api/offers/${id}`);
  }
  downloadCSV() {
    this.http.get(`${this.baseUrl}api/offers/export/csv`, { responseType: 'blob' }).subscribe(res => {
      let blob = new Blob([res], { type: 'text/plain' });
      var downloadURL = window.URL.createObjectURL(res);
      var link = document.createElement('a');
      link.href = downloadURL;
      link.download = "offers.csv";
      link.click();
    })
  }
}
