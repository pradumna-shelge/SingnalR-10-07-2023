export interface Message {
    id?:number,
    user: string;
    content: string;
    timestamp?:Date
  }


  export interface User {
    id: string;
    name: string;
    img: string;
    convId:number
  }

  export interface Chat{
    message:string,
    timestamp:Date,
    author:number
  }


  export interface ChatMessage {
    
    conversationId: number;
    author: number;
    content: string;
   
  }
  