import { Component, EventEmitter, Inject, Input, OnInit, Output } from '@angular/core';
import { NavigationEnd, NavigationStart, Router } from '@angular/router';
import { User } from 'src/app/core/models/user.model';
import { AuthService } from 'src/app/core/services/auth.service';
import { MenuList } from './constants/menu.list';
import { MenuGroup } from './models/menu.group';
import { MenuItem } from './models/menu.item';

@Component({
  selector: 'apiplate-menu',
  templateUrl: './menu.component.html',
  styleUrls: ['./menu.component.scss']
})
export class MenuComponent implements OnInit {
  menuItems = MenuList;
  selectedMenuItem!: MenuItem;
  currentUser: User;
  @Input('opened') opened = true;
  @Output("menuItemChange") menuItemChange = new EventEmitter<any>();
  constructor(private router: Router, private authService: AuthService, @Inject("DIRECTION") public direction: string) {
    authService.$currentUser.subscribe(res => {
      this.currentUser = res;
    });

  }
  logout() {
    localStorage.clear();
    this.router.navigate(['login']);

  }

  ngAfterContentInit() {
    this.updateMenu();
    this.router.events.subscribe(ev => {
      if (ev instanceof NavigationEnd) {
        this.updateMenu();
      }
    });

  }
  updateMenu() {
    this.menuItems.forEach(group => {
      group.children.forEach((item: MenuItem) => {
        if (item.route == this.router.url) {
          this.selectedMenuItem = item;
          this.menuItemChange.emit({
            group: group.title,
            page: item.title
          })
          return;
        }
        if (item.children != undefined) {
          item.children.forEach(child => {
            if (child.route == this.router.url) {
              this.menuItemChange.emit({
                group: group.title,
                page: item.title
              })
              this.selectedMenuItem = child;
            }
          });
        }
      })
    })
  }
  ngOnInit(): void {
  }
  selectItem(index: number, group: MenuGroup, childIndex = -1) {
    console.log(childIndex);
    var item = group.children[index];
    if (item.children != undefined && childIndex == -1) {
      item.open = !item.open;
      return;
    }
    if(item.open && childIndex != -1)
    {
      var childItem = item.children[childIndex];
      this.router.navigate([childItem.route]);
      this.selectedMenuItem = childItem;
      this.menuItemChange.emit({
        group: group.title,
        page: childItem.title
      });
      this.menuItemChange.emit({
        group: group.title,
        page: childItem.title
      })
        return;
    }
    this.router.navigate([item.route]);
    this.selectedMenuItem = item;
    this.menuItemChange.emit({
      group: group.title,
      page: item.title
    })

  }

}
