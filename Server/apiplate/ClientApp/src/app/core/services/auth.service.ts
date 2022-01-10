import { HttpClient } from '@angular/common/http';
import { Inject, Injectable } from '@angular/core';
import { BehaviorSubject, Observable } from 'rxjs';
import { User } from '../models/user.model';
import { ApiResponse } from '../models/wrappers/apiResponse.model';

@Injectable({
  providedIn: 'root'
})
export class AuthService {
  public $currentUser = new BehaviorSubject<User>(null);
  constructor(private http:HttpClient,@Inject('BASE_URL') private baseUrl: string) { 

  }
  login(username:string,password:string) : Observable<ApiResponse<User>>{
      return this.http.post(`${this.baseUrl}api/admins/authenticate`,{"email":username,"password":password}) as Observable<ApiResponse<User>>;
  }
  getById(id:number) : Observable<ApiResponse<User>>{
    return this.http.get(`${this.baseUrl}api/admins/profile`) as Observable<ApiResponse<User>>;
}
  saveToken(token:string,id:number){
    localStorage.setItem("apiplate_token",token);
    localStorage.setItem("apiplate_id",id.toString());

  }
  logout(){
    localStorage.removeItem('apiplate_token');
    this.$currentUser.next(null);
  }
}
