import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { User } from 'src/Model/message.model';

@Injectable({
  providedIn: 'root'
})
export class ConversionService {

  private url = 'https://localhost:5000/api/Conversation/'
id:number
  constructor(private http:HttpClient) { 
    let temp = JSON.parse(localStorage.getItem('user') as string) as User
    this.id=Number(temp.id)
  }


  get(){    
  return  this.http.get<User[]>(this.url+this.id)
  }
}
