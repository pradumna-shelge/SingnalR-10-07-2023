import { Component } from '@angular/core';
import { ConversionService } from '../Services/conversion.service';
import { Chat, ChatMessage, User } from 'src/Model/message.model';
import { ChatService } from '../Services/chat.service';
import { Observable } from 'rxjs';
import { AuthService } from 'src/app/Services/auth.service';
import * as signalR from '@microsoft/signalr';

@Component({
  selector: 'app-conversations',
  templateUrl: './conversations.component.html',
  styleUrls: ['./conversations.component.css']
})
export class ConversationsComponent {
  private hubConnection: signalR.HubConnection;
  message: string='';
  currentConId:number=-1
  constructor(private conServ:ConversionService, private chatServ:ChatService,private authSertv:AuthService){
    this.ChatData$=[]

    this.hubConnection = new signalR.HubConnectionBuilder()
      .withUrl('https://localhost:5000/chatsocket')
      .build();

      this.hubConnection.start()
      .then(() => {
        console.log('SignalR connection started.');
        // this.hubConnection.invoke('AddToGroup', this.username);
      })
      .catch(err => console.error('Error starting SignalR connection:', err));


    


      
  }
  ConvData$=this.conServ.get()
  ChatData$!:Chat[]
  currUserId=this.conServ.id

  onSelectConv(u:User){
    this.currUserId=this.conServ.id
    this.currentConId=u.convId
    this.chatServ.getChat(u.convId).subscribe({
      next:(d:Chat[])=>{
        this.ChatData$=d
      },
      error:(e:any)=>{
        alert("Error in chat ")
      }
    })

    this.hubConnection.on('ReceiveMessage',(mess:Chat)=>{
      this.ChatData$.push(mess);
    })


  }


  send() {
    const ob:ChatMessage = {
    conversationId:this.currentConId,
    author:this.conServ.id,
    content:this.message
    }
    this.message=''
    this.hubConnection.invoke('SendMessage',ob )
      .then(() => {
        console.log("message send");
        
      })
      .catch(err => console.error('Error sending message:', err));
  }





}
