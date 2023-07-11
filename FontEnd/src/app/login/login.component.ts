import { Component } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { AuthService } from '../Services/auth.service';
import { User } from 'src/Model/message.model';
import { Router } from '@angular/router';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent {
  loginForm!: FormGroup;

  constructor(private formBuilder: FormBuilder, private serv:AuthService,private route:Router) { }

  ngOnInit() {
    this.loginForm = this.formBuilder.group({
      username: ['', Validators.required],
      password: ['', Validators.required]
    });
  }

  get username() { return this.loginForm.get('username'); }
  get password() { return this.loginForm.get('password'); }

  onSubmit() {
    if (this.loginForm.valid) {
      // Perform login logic here
      console.log(this.loginForm.value);
      this.serv.loginUser(this.loginForm.value).subscribe({
        next:(resp:User)=>{
          console.log(resp);
          localStorage.setItem('user',JSON.stringify(resp))
          
          
          this.route.navigate(['/user'])
        },
        error:(err:any)=>{
          console.log(err);
        }
      })
    }
  }
}
