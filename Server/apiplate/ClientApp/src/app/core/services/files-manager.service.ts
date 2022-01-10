import { HttpClient } from '@angular/common/http';
import { Inject, Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { DirectoryModel } from '../models/directory.model';
import { ApiResponse } from '../models/wrappers/apiResponse.model';

@Injectable({
  providedIn: 'root'
})
export class FilesManagerService {

  constructor(private http:HttpClient,@Inject('BASE_URL') private baseUrl: string) { }
  getDirectory(path ="") : Observable<ApiResponse<DirectoryModel>>{
     path = path.substr(0,path.length - 1);
     console.log(path);
     return this.http.get(`${this.baseUrl}api/FilesManager/directories/single${ (path == "") ? "" : `?path=${path}`}`) as Observable<ApiResponse<DirectoryModel>>;
  }
  postDirectory(title:string,path ="") : Observable<ApiResponse<DirectoryModel>>{
    return this.http.post(`${this.baseUrl}api/FilesManager/directories?directoryName=${title}${ (path == "") ? "" : `&path=${path}`}`,{}) as Observable<ApiResponse<DirectoryModel>>;
 }
 deleteDirectory(title:string,path:string){
   return this.http.delete(`${this.baseUrl}api/FilesManager/directories?directoryName=${title}${ (path == "") ? "" : `&path=${path}`}`);
 }
 renameDirectory(path:string,oldTitle:string,newTitle:string){
  return this.http.get(`${this.baseUrl}api/FilesManager/directories/rename?oldName=${oldTitle}&newName=${newTitle}&path=${path == "" ? "/" : path}`);
}
renameFile(path:string,oldTitle:string,newTitle:string){
  return this.http.get(`${this.baseUrl}api/FilesManager/files/rename?oldName=${oldTitle}&newName=${newTitle}&path=${path == "" ? "/" : path}`);
}
moveDirectory(dirName:string,oldPath:string,newPath:string){
  return this.http.get(`${this.baseUrl}api/FilesManager/directories/move?DirectoryName=${dirName}&oldPath=${oldPath}&newPath=${newPath}`);
}
moveFile(dirName:string,oldPath:string,newPath:string){
  return this.http.get(`${this.baseUrl}api/FilesManager/files/move?fileName=${dirName}&oldPath=${oldPath}&newPath=${newPath}`);
}
 deleteFile(title:string,path:string){
  return this.http.delete(`${this.baseUrl}api/FilesManager/files?fileName=${title}${ (path == "") ? "" : `&path=${path}`}`);
}
 uploadFile(files:File[],path =""){

   var formData = new FormData();
    for (let index = 0; index < files.length; index++) {
      formData.append("files",files[index]);
    }
  return this.http.post(`${this.baseUrl}api/FilesManager/upload${ (path == "") ? " " : `?path=${path}`}`,formData,{
    reportProgress: true,
    observe: 'events',
  });

 }
}
