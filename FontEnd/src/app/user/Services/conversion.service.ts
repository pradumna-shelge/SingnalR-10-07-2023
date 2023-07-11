import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { SearchUser, User, conversionAdd } from 'src/Model/message.model';

@Injectable({
  providedIn: 'root'
})
export class ConversionService {

  private url = 'https://localhost:5000/api/Conversation/'
  
  constructor(private http:HttpClient) { 
    
  }

  get id(){
    let temp = JSON.parse(localStorage.getItem('user') as string) as User
    return Number(temp.id)
  }


  get(){    
  return  this.http.get<User[]>(this.url+this.id)
  }


  getAll(){
    return this.http.get<SearchUser[]>('https://localhost:5000/api/Account/'+this.id)
  }

  add(user1:number){
    const data:conversionAdd ={
      user1:user1,
      user2:this.id
    } ;
    return this.http.post('https://localhost:5000/api/Conversation',data)
  }
}
