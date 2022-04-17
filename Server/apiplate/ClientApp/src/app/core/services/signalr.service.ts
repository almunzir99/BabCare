import { Inject, Injectable } from '@angular/core';
import { HubConnection, HubConnectionBuilder } from '@aspnet/signalr';
import { ApiNotification } from '../models/api-notification.model';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class SignalrService {
  private hubConnection!: HubConnection;
  constructor(@Inject("BASE_URL") private baseUrl: string,private authService:AuthService) { }
  async startConnection() {
    this.hubConnection = new HubConnectionBuilder().withUrl(`${this.baseUrl}notification-hub?type=admin&userId=${this.authService.$currentUser.value.id}`).build();
    await this.hubConnection.start().then(value => {
    }).catch(err => console.log(err));
    this.hubConnection.onclose(err => console.log(err));
  }
  onNotificationRecieved(callBack:(notification:ApiNotification) => void)
  {
    if (this.hubConnection) {
      this.hubConnection.on("recieveNotification", callBack);
    }
  }
}
