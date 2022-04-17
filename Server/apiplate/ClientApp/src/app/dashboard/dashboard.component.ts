import { Component, Inject, OnInit } from '@angular/core';
import { AuthService } from '../core/services/auth.service';
import { SignalrService } from '../core/services/signalr.service';

@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.scss']
})
export class DashboardComponent implements OnInit {

  toggle:boolean = true;
  currentMenuItem:any;
  constructor(@Inject("DIRECTION") public direction:string,private signalRService:SignalrService,private authService:AuthService) { }
  toggleMenu(toggle:boolean){
    var dataTableBody = document.getElementById("data-table-body") as HTMLElement;
    if(dataTableBody){
      if(toggle){
        dataTableBody.style.width ="78vw";
      }
      else{
        dataTableBody.style.width ="95.7vw";

      }
    }
    this.toggle = toggle;
  }
  ngOnInit(): void {
    this.signalRService.startConnection().then(_ => {
      this.signalRService.onNotificationRecieved(notification => {
        console.log(notification);
          this.authService.$notifications.value.unshift(notification);
      })
    });
  }

  
  menuItemChange(event){
    setTimeout(() => {
    this.currentMenuItem = event;
      
    });
  }
   
  close(){
    this.toggle = false;
  }
}
