import { Component, EventEmitter, Input, Output } from '@angular/core';
import { Group, SearchUser, User } from 'src/Model/message.model';
import { ConversionService } from '../Services/conversion.service';

@Component({
  selector: 'app-add-group',
  templateUrl: './add-group.component.html',
  styleUrls: ['./add-group.component.css']
})
export class AddGroupComponent {
  @Output() refresh = new EventEmitter<Group>();
  @Input() groupData:User[]=[];
  
  data:Group = {
    GroupName:'',
    CreatedBy:-1,
    Members:[],
    imageUrl:''
  }
  
  mes='Result'
  constructor(private ser:ConversionService ){
  
  }

 
    add( id:number, event:any){
       if(event.target.checked==true){
        this.data.Members.push(id)
       }
       else{
       this.data.Members=this.data.Members.filter(d=>d!==id)
       }

       console.log(this.data);
       
    }


    createGroup(){
    this.refresh.emit(this.data)
    }
}
