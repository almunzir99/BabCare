import { Component, Inject, OnInit } from '@angular/core';

@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.scss']
})
export class DashboardComponent implements OnInit {

  toggle:boolean = true;
  currentMenuItem:any;
  constructor(@Inject("DIRECTION") public direction:string) { }
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
