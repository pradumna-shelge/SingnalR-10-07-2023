import { Component, EventEmitter, Input, Output } from '@angular/core';
import { SearchUser, User } from 'src/Model/message.model';
import { ConversionService } from '../Services/conversion.service';

@Component({
  selector: 'app-add-group',
  templateUrl: './add-group.component.html',
  styleUrls: ['./add-group.component.css']
})
export class AddGroupComponent {
  @Output() refresh = new EventEmitter();
  @Input() groupData:User[]=[];
  
  mes='Result'
  constructor(private ser:ConversionService ){
  
    
  
  }

 
   

  
  
    add( id:number){
      

    }
}
