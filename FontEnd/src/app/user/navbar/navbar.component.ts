import { Component } from '@angular/core';
import { AuthService } from 'src/app/Services/auth.service';

@Component({
  selector: 'app-navbar',
  templateUrl: './navbar.component.html',
  styleUrls: ['./navbar.component.css']
})
export class NavbarComponent {

  
  constructor(private authServ:AuthService) {
    
  }

  onLogout(){
    this.authServ.logout()
  }



}
