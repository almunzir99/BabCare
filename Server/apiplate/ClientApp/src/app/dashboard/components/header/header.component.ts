import { Component, EventEmitter, Inject, Input, OnInit, Output } from '@angular/core';
import { Router } from '@angular/router';
import { User } from 'src/app/core/models/user.model';
import { AuthService } from 'src/app/core/services/auth.service';

@Component({
  selector: 'apiplate-header',
  templateUrl: './header.component.html',
  styleUrls: ['./header.component.scss']
})
export class HeaderComponent implements OnInit {
  @Input("group-title") group:string;
  @Input("page-title") page:string ="Current Page";
  @Output("toggleChange") toggleChangedEventEmitter = new EventEmitter<boolean>();
  currentUser: User;
  toggleMenu = true;
  constructor(private authService: AuthService,private router:Router,@Inject("DIRECTION") public direction:string) {
    authService.$currentUser.subscribe(res => {
      this.currentUser = res;
    });

  }
  onToggleClicked(){
    this.toggleMenu = ! this.toggleMenu;
    this.toggleChangedEventEmitter.emit(this.toggleMenu);
  }
  

  ngOnInit(): void {
  }

}
