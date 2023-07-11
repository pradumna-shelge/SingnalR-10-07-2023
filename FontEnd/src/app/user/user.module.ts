import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { UserRoutingModule } from './user-routing.module';
import { HomepageComponent } from './homepage/homepage.component';
import { NavbarComponent } from './navbar/navbar.component';
import { ConversationsComponent } from './conversations/conversations.component';
import { FormsModule } from '@angular/forms';
import { AddUserComponent } from './add-user/add-user.component';
import { AddGroupComponent } from './add-group/add-group.component';


@NgModule({
  declarations: [
    HomepageComponent,
    NavbarComponent,
    ConversationsComponent,
    AddUserComponent,
    AddGroupComponent
  ],
  imports: [
    CommonModule,
    UserRoutingModule,
    FormsModule,
  
  ],
  providers:[]
})
export class UserModule { }
