import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Chat } from 'src/Model/message.model';

@Injectable({
  providedIn: 'root'
})
export class ChatService {

  constructor(private http:HttpClient) { }
  private url = 'https://localhost:5000/api/Message/'

  getChat(cid:number){
    return this.http.get<Chat[]>(this.url+cid);
  }
}
