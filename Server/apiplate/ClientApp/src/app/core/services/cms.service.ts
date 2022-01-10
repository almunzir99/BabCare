import { HttpClient } from '@angular/common/http';
import { Inject, Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class CmsService {

  constructor(private http: HttpClient, @Inject('BASE_URL') private baseUrl: string) {
  }
  getJsonObject(lang: string = "en") {
      return this.http.get(`${this.baseUrl}api/cms/${lang}`);
  }
  getLangs() {
    return this.http.get(`${this.baseUrl}api/cms/langs`);
}
  createParentObject(parent:string,lang:string = "en"){
      return this.http.post(`${this.baseUrl}api/cms/${lang}/parent?name=${parent}`,{},{responseType:'text'});

  }
  CreateNode(parent:string,value:string,key:string,lang:string = "en"){
    return this.http.post(`${this.baseUrl}api/cms/${lang}/node?parent=${parent}&key=${key}&value=${value}`,{},{responseType:'text'});

  }
  editNode(parent:string,value:string,key:string,lang:string = "en"){
    return this.http.put(`${this.baseUrl}api/cms/${lang}/node?parent=${parent}&key=${key}&value=${value}`,{},{responseType:'text'});

  }
  deleteNode(parent:string,key:string,lang:string = "en"){
    return this.http.delete(`${this.baseUrl}api/cms/${lang}/node?parent=${parent}&key=${key}`,{responseType:'text'});

  }
  createLang(code:string){
    return this.http.post(`${this.baseUrl}api/cms?langCode=${code}`,{},{responseType:'text'});
  }
  
}
