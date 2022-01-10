import { HttpClient } from '@angular/common/http';
import { Inject, Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { ApiResponse } from '../models/wrappers/apiResponse.model';
export interface Counters{
  programs:number;
  events:number;
  slides:number;
  news:number;
  users:number;
  messages:number;


}
@Injectable({
  providedIn: 'root'
})
export class GeneralService {

  constructor(private http: HttpClient, @Inject('BASE_URL') private baseUrl: string) { }
  getCounter() : Observable<ApiResponse<Counters>>{
    return this.http.get(`${this.baseUrl}api/general/counters`) as Observable<ApiResponse<Counters>>;
  }
}
