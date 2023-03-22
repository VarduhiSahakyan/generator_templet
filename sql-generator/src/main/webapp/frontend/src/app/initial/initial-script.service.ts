import { Injectable } from '@angular/core';
import {HttpClient} from "@angular/common/http";

@Injectable({
  providedIn: 'root'
})
export class InitialScriptService {

  constructor(private http: HttpClient) { }

  uploadInitialFileJson1(file: File) {
    const data: FormData = new FormData();
    data.append('file', file);
    return this.http.post('/initial/file/json/01/upload', data, {responseType: 'text'});
  }

  uploadInitialFileJson2(file: File) {
    const data: FormData = new FormData();
    data.append('file', file);
    return this.http.post('/initial/file/json/02/upload', data, {responseType: 'text'});
  }

  generateInitialScript1(sqlMode1: string){
    return this.http.post('/initial/file/sql/01/script', sqlMode1, {responseType: 'text'});
  }

  generateInitialScript2(sqlMode: string){
    return this.http.post('/initial/file/sql/02/script', sqlMode, {responseType: 'text'});
  }
}
