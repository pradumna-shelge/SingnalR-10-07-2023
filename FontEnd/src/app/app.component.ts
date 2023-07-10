import { HttpClient } from '@angular/common/http';
import { Component } from '@angular/core';
import * as signalR from '@microsoft/signalr';
import { HubConnection, HubConnectionBuilder } from '@microsoft/signalr';
import { Message } from 'src/Model/message.model';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'FrontEnd';

  // isLoggedIn = false;
  // username!: string;
  // password!: string;
  // users: string[] = [];
  // messages: Message[] = [];
  // newMessage!: string;

  // private hubConnection: signalR.HubConnection;

  // constructor(private http: HttpClient) {
  //   this.hubConnection = new signalR.HubConnectionBuilder()
  //     .withUrl('https://localhost:5000/chatsocket')
  //     .build();

  //   this.hubConnection.on('ReceiveMessage', (user: string, message: string) => {
  //     this.messages.push({ user, content: message });
  //   });

  //   this.hubConnection.on('UserListUpdated', (users: string[]) => {
  //     this.users = users;
  //   });
  //   this.startSignalRConnection();
  //       this.loadUsers();
  //       this.loadMessages();
  // }

  // // authenticate() {
  // //   this.http.post<any>('https://localhost:5000/api/user/authenticate', { username: this.username, password: this.password })
  // //     .subscribe(response => {
  // //       const token = response.token;
  // //       localStorage.setItem('token', token);
  // //       this.isLoggedIn = true;
  // //       this.startSignalRConnection();
  // //       this.loadUsers();
  // //       this.loadMessages();
  // //     });
  // // }

  // startSignalRConnection() {
  //   this.hubConnection.start()
  //     .then(() => {
  //       console.log('SignalR connection started.');
  //       this.hubConnection.invoke('AddToGroup', this.username);
  //     })
  //     .catch(err => console.error('Error starting SignalR connection:', err));
  // }

  // loadUsers() {
  //   // Make an API request to fetch the list of users
  //   // Example code:
  //   this.http.get<string[]>('https://localhost:5000/api/user')
  //     .subscribe(users => {
  //       this.users = users;
  //     });
  // }

  // loadMessages() {
  //   // Make an API request to fetch the list of messages
  //   // Example code:
  //   this.http.get<Message[]>('https://localhost:5000/api/Message')
  //     .subscribe(messages => {
  //       this.messages = messages;
  //     });
  // }

  // sendMessage() {
  //   this.hubConnection.invoke('SendMessage', "nirmal", this.newMessage)
  //     .then(() => {
  //       this.newMessage = '';
  //     })
  //     .catch(err => console.error('Error sending message:', err));
  // }



}

