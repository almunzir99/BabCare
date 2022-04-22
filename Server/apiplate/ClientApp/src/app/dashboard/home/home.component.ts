import { Component, OnInit } from '@angular/core';
import { Statistics } from 'src/app/core/models/statistics.model';
import { StatisticsService } from 'src/app/core/services/statistics.service';
 
@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.scss']
})
export class HomeComponent implements OnInit {
  isLoading  = false;
  stats:Statistics;
  categoriesSampleData = [
    {
      name:"بتيزا",
      value:200,
    },
    {
      name:"بيرقر",
      value:500,
    },
    {
      name:"عصائر ",
      value:1000,
    },
    {
      name:"بلدي",
      value:350,
    }
  ];
  ordersSampleData = [
    {
      name :"طلبات خلال الاسبوع",
      series:[
        {
          name:"السبت",
          value: 200,

        },
        {
          name:"الاحد",
          value: 100,

        },
        {
          name:"الاثنين",
          value: 150,

        },
        {
          name:"الثلاثاء",
          value: 80,

        },
        {
          name:"الاربعاء",
          value: 250,

        },
        {
          name:"الخميس",
          value: 210,

        },
        {
          name:"الجمعة",
          value: 160,

        }
      ]
    }
  ];
  colorScheme = {
    domain: ["#DC143C","#DC143C90","#DC143C80","#DC143C70","#DC143C60"]
  };

  constructor(private _service:StatisticsService) {
    this.getStats();
  }
  getStats() {
    this.isLoading = true;
    this._service.get().subscribe(res => {
      this.stats = res.data;
      this.isLoading = false;
    },err =>{
        this.isLoading = false;
    });
  }

  ngOnInit(): void {
  }

}
