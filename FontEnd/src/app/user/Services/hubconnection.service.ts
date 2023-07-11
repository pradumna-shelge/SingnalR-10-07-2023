import { Injectable } from '@angular/core';
import * as signalR from '@microsoft/signalr';
import { BehaviorSubject } from 'rxjs';
import { Chat, Status, User } from 'src/Model/message.model';
import { ConversionService } from './conversion.service';

@Injectable({
  providedIn: 'root'
})
export class HubconnectionService {
  private hubConnection!: signalR.HubConnection;
  conversation :BehaviorSubject<User[]>= new BehaviorSubject<User[]>([])

  constructor(private ser:ConversionService) { 


    this.hubConnection = new signalR.HubConnectionBuilder()
      .withUrl('https://localhost:5000/chatsocket?userId=' + this.id)
      .build();

      this.hubConnection.start()
      .then(() => {
        console.log('SignalR connection started.');
      })
      .catch(err => console.error('Error starting SignalR connection:', err));

this.listeners();
      this.loadConversation();

  }


  get id(){
    let temp = JSON.parse(localStorage.getItem('user') as string) as User
    return Number(temp.id)
  }

  loadConversation(){

this.ser.get().subscribe({
  next:(data:User[])=>{
this.conversation.next(data)
  },
  error:(err)=>{

  }
})
  }


  listeners(){
    this.hubConnection.on('ReceiveStatus',(UserStatus:Status)=>{
      this.conversation.forEach((data:User[])=>{
            data.forEach((u:User)=>{
           if(u.id===UserStatus.userId){
             u.isOnline=UserStatus.status
           }
          })
         });
     })

     this.hubConnection.on('getConverstion',()=>{
       this.loadConversation()
     })
     
  }


}
