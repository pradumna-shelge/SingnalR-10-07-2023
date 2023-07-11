export interface Message {
    id?:number,
    user: string;
    content: string;
    timestamp?:Date
  }


  export interface User {
    id: number;
    name: string;
    img: string;
    convId:number,
    isOnline:boolean
  }

  export interface SearchUser {
    id: number;
    name: string;
    img: string;
   
  }

  export interface Chat{
    message:string,
    timestamp:Date,
    author:number
  }

  export interface conversionAdd{
    user1:number,
    user2:number,
   
  }



  export interface ChatMessage {
    
    conversationId: number;
    author: number;
    content: string;
    receiver:number
   
  }


  
  export interface Status{
    userId:number,
    status:boolean
  }