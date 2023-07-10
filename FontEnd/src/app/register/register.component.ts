import { Component } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { AuthService } from '../Services/auth.service';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css']
})
export class RegisterComponent {
  registerForm!: FormGroup;

  constructor(private formBuilder: FormBuilder, private serv:AuthService) { }

  ngOnInit() {
    this.registerForm = this.formBuilder.group({
      username: ['', Validators.required],
      password: ['', Validators.required],
      imageUrl: 'https://tse2.mm.bing.net/th/id/OIP.QsTQiIXafX4lsEPvCmognAHaHS?w=212&h=208&c=7&r=0&o=5&pid=1.7'
    });
  }

  get username() { return this.registerForm.get('username'); }
  get password() { return this.registerForm.get('password'); }

  onSubmit() {
    if (this.registerForm.valid) {
      // Register the user or perform any desired action
      console.log(this.registerForm.value);

      this.serv.registerUser(this.registerForm.value).subscribe({
        next:(resp:any)=>{
          console.log(resp);
        },
        error:(err:any)=>{
          console.log(err);
        }
      })

    }
  }
}
