import { HttpClient } from '@angular/common/http';
import { Inject, Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Statistics } from '../models/statistics.model';
import { PagedResponse } from '../models/wrappers/PagedResponse.mode';

@Injectable({
  providedIn: 'root'
})
export class StatisticsService {

  constructor(private http: HttpClient, @Inject('BASE_URL') private baseUrl: string) { }
  get() : Observable<PagedResponse<Statistics>>{
      return this.http.get(`${this.baseUrl}api/statistics`) as Observable<PagedResponse<Statistics>>;
  }
}
