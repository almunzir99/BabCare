import { Component, Inject } from '@angular/core';
import { Router } from '@angular/router';
import { AuthService } from './core/services/auth.service';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: [
    './app.component.scss'
  ]
})
export class AppComponent {
  loading = true;
  constructor(private authService:AuthService,private router:Router,@Inject("DIRECTION") public direction){
      
  }
  ngOnInit(){
    var id = parseInt(localStorage.getItem('apiplate_id'));
      this.authService.getById(id).subscribe(res =>{
        this.authService.$currentUser.next(res.data);
        this.loading = false;
      },err=>{
          this.router.navigate(['login']);
        this.loading = false;

      });
      
  }
   
  title = 'app';
}

