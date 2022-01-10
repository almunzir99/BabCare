import { HttpClient } from '@angular/common/http';
import { Inject, Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Message } from '../models/message.model';
import { PagedResponse } from '../models/wrappers/PagedResponse.mode';

@Injectable({
  providedIn: 'root'
})
export class MessagesService {

  constructor(private http: HttpClient, @Inject('BASE_URL') private baseUrl: string) {
  }
  get(pageIndex = 1, pageSize = 10, title = "", orderBy = "lastUpdate", ascending = false): Observable<PagedResponse<Message[]>> {
    return this.http.get(`${this.baseUrl}api/Messages?pageIndex=${pageIndex}&pageSize=${pageSize}&title=${title}&orderBy=${orderBy}&ascending=${ascending}`) as Observable<PagedResponse<Message[]>>;
  }
}
