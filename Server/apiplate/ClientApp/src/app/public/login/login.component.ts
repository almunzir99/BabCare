import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { AuthService } from 'src/app/core/services/auth.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})
export class LoginComponent implements OnInit {

  constructor(private _authService:AuthService,private router:Router) { }
  isLoading = false;
  error = true;
  ngOnInit(): void {
  }
  submit(email:string,password:string){
    this.isLoading = true;
      this._authService.login(email,password).subscribe(res => {
        console.log(res);
        this._authService.saveToken(res.data.token,res.data.id);
        this._authService.$currentUser.next(res.data);
        this._authService.getNotifications().subscribe(res => {
          this.isLoading = false;
          this.router.navigate(['dashboard']);
          this._authService.$notifications.next(res.data);
        },err => {
            throw err;
        } );
      },err => {
        console.log(err);
        this.isLoading = false;
        

      })
  }

}
