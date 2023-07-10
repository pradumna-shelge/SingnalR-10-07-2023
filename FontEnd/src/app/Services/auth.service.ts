import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { UserLoginDto, UserRegisterDto } from 'src/Model/auth.model';
import { Router } from '@angular/router';

@Injectable({
  providedIn: 'root'
})
export class AuthService {
  private apiUrl = 'https://localhost:5000/api/Account'; // Replace with your actual API endpoint

  constructor(private http: HttpClient, private router:Router) { }

  registerUser(userData: UserRegisterDto): Observable<any> {
    const url = `${this.apiUrl}/register`;
    return this.http.post(url, userData);
  }

  loginUser(credentials: UserLoginDto): Observable<any> {
    const url = `${this.apiUrl}/login`;
    return this.http.post(url, credentials);
  }

  logout(){
    localStorage.removeItem('user');
    this.router.navigate([''])
  }
}
