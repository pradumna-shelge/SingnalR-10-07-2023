import { AfterViewChecked, AfterViewInit, Component, ElementRef, OnDestroy, OnInit, Output, QueryList, ViewChild, ViewChildren } from '@angular/core';
import { ConversionService } from '../Services/conversion.service';
import { Chat, ChatMessage, Group, Status, User } from 'src/Model/message.model';
import { ChatService } from '../Services/chat.service';
import { Observable, Observer } from 'rxjs';
import { AuthService } from 'src/app/Services/auth.service';
import * as signalR from '@microsoft/signalr';

@Component({
  selector: 'app-conversations',
  templateUrl: './conversations.component.html',
  styleUrls: ['./conversations.component.css']
})
export class ConversationsComponent implements OnInit, OnDestroy, AfterViewChecked {
  private hubConnection!: signalR.HubConnection;

  @ViewChild('scrollMe') private myScrollContainer!: ElementRef;

  ngAfterViewChecked() {
    this.scrollToBottom();
  }

  scrollToBottom(): void {
    try {
      this.myScrollContainer.nativeElement.scrollTop = this.myScrollContainer.nativeElement.scrollHeight;
    } catch (err) { }
  }

  message: string = '';
  currentConId: number = -1
  currentRecId: number = -1
  ConvData$: User[] = []
  constructor(private conServ: ConversionService, private chatServ: ChatService, private authSertv: AuthService) {
    this.ChatData$ = []

    this.getConverstion();

  }

  getConverstion() {
    // alert('emit')
    this.conServ.get().subscribe({
      next: (resp: User[]) => {
        this.ConvData$ = resp
      },
      error: (err: any) => {
        console.log(err);
      }
    })




  }
  ngOnInit(): void {

    this.hubConnection = new signalR.HubConnectionBuilder()
      .withUrl('https://localhost:5000/chatsocket?userId=' + this.currUserId)
      .build();

    this.hubConnection.start()
      .then(() => {
        console.log('SignalR connection started.');
        // this.hubConnection.invoke('AddToGroup', this.username);
      })
      .catch(err => console.error('Error starting SignalR connection:', err));
    this.hubConnection.on('ReceiveMessage', (mess: Chat) => {
      console.log(mess);
      
      if (mess.convId === this.currUser.convId) {
        console.log(mess.author);
        console.log(this.currentRecId);
        this.ChatData$.push(mess);
      }
    })
    this.hubConnection.on('ReceiveStatus', (UserStatus: Status) => {
      this.ConvData$.forEach(u => {
        if (u.id === UserStatus.userId) {
          u.isOnline = UserStatus.status
        }
      });
    })

    this.hubConnection.on('getConverstion', () => {
      this.getConverstion()
    })

    this.scrollToBottom();
  }
  ngOnDestroy(): void {
    this.hubConnection.stop()

  }



  ChatData$!: Chat[]
  currUserId = this.conServ.id
  currUser!: User

  onSelectConv(u: User) {
    this.currUser = u
    this.currUserId = this.conServ.id
    this.currentConId = u.convId;
    this.currentRecId = u.id;
    this.chatServ.getChat(u.convId).subscribe({
      next: (d: Chat[]) => {
        this.ChatData$ = d
        this.hubConnection.invoke('IsUserOnline', this.currUser.id).then(
          (resp: boolean) => {
            console.log(this.currUser);
            this.currUser.isOnline = resp
          }
        )
      },
      error: (e: any) => {
        alert("Error in chat ")
      }
    })

    
    
    if (u.isGroup) {

      const data={
        id: this.conServ.id,
        name: u.id.toString() 
      }
      this.hubConnection.invoke('GrpAdd', data).then(
        (resp) => { console.log("added to group  " + resp) }
      )
    }


  }




  send() {
    let ob: ChatMessage = {
      conversationId: this.currentConId,
      author: this.conServ.id,
      content: this.message,
      receiver: this.currentRecId,
      group: '',
      isGroup: false
    }

    if (this.currUser.isGroup) {
      ob.group = this.currUser.id.toString();
      ob.isGroup = true;
    }

    this.message = ''
    this.hubConnection.invoke('SendMessages', ob)
      .then(() => {
        const data: Chat = {
          message: ob.content,
          timestamp: new Date(),
          author: ob.author
        }
        console.log("message send");
        // this.ChatData$.push(data);

      })
      .catch(err => console.error('Error sending message:', err));
  }



  groupData(data: Group) {

    data.CreatedBy = this.conServ.id;
    data.Members.push(data.CreatedBy);
    this.hubConnection.invoke('createGroup', data).then(() => {
      console.log("Group created successfully");

    })



  }



 
}
