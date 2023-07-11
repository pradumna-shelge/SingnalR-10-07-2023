import { Component, EventEmitter, Output } from '@angular/core';
import { SearchUser } from 'src/Model/message.model';
import { ConversionService } from '../Services/conversion.service';

@Component({
  selector: 'app-add-user',
  templateUrl: './add-user.component.html',
  styleUrls: ['./add-user.component.css']
})
export class AddUserComponent {
  @Output() refresh = new EventEmitter();

mainData:SearchUser[]=[];
searchData:SearchUser[]=[];
mes='Result'
constructor(private ser:ConversionService ){

  
this.getAll()
}
getAll(){
  this.ser.getAll().subscribe({
    next:(data:SearchUser[])=>{
      this.mainData = data;
      this.searchData = this.mainData.slice(0,5)
    },
    error:(err)=>{
      console.log(err.message);
      
    }
  })
}
  filter(data:string){
    this.mes='Result'
    data = data.toLowerCase();
      this.searchData = this.mainData.filter(d=>d.name.toLowerCase().match(data));
     
      if(this.searchData.length<1){
        this.mes=' No Result Found .......'
      }
  }


  add( id:number){
    
    this.ser.add(id).subscribe({
      next:(val)=>{
        console.log(val);
        this.getAll();
        this.refresh.emit();
        
      }
      
    })
  }
}
