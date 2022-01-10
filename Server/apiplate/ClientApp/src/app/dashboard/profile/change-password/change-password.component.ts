import { Component, OnInit } from '@angular/core';
import { Validators } from '@angular/forms';
import { FuiModalService } from 'ngx-fomantic-ui';
import { User } from 'src/app/core/models/user.model';
import { AuthService } from 'src/app/core/services/auth.service';
import { UsersService } from 'src/app/core/services/users.service';
import { ControlTypes } from 'src/app/shared/form-builder/models/control-type.enum';
import { FormBuilderGroup } from 'src/app/shared/form-builder/models/form-builder-group.model';
import { MessageModal, MessageTypes } from 'src/app/shared/modals/message-modal/message-modal.component';

@Component({
  selector: 'app-change-password',
  templateUrl: './change-password.component.html',
  styleUrls: ['./change-password.component.scss']
})
export class ChangePasswordComponent implements OnInit {

  formGroups: FormBuilderGroup[];
  loading = false;
  constructor(private userService: UsersService, private modalService: FuiModalService) {
  }
  initFormGroups() {
    this.formGroups = [
      {

        title: undefined,
        controls: [
          {
            title: "كلمة المرور القديمة",
            name: "oldPassword",
            icon: "key icon",

            controlType: ControlTypes.PasswordInput,
            width: "100%",
            validators: [
              Validators.required
            ]

          },
          {
            title: "كلمة المرور الجديد",
            name: "newPassword",
            icon: "key icon",

            controlType: ControlTypes.PasswordInput,
            width: "100%",
            validators: [
              Validators.required
            ]

          },
          {
            title: "اعد ادخال كلمة المرور",
            name: "repassword",
            icon: "key icon",
            validators: [
              Validators.required
            ],

            controlType: ControlTypes.PasswordInput,
            width: "100%"
          },
        ]
      }
    ];
  }
  submit(event) { 
     console.log(event);
    this.loading = true;
    this.userService.changePassword(event.oldPassword,event.newPassword).subscribe(res => {
      this.modalService.open(new MessageModal({
        title: "نجاح",
        content: "تم تحديث البيانات بنجاح , الرجاء اعادة تسجيل الدخول للتأكيد", isConfirm: false, messageType: MessageTypes.Success
      }))
      this.loading = false;

    }, err => { 
      this.loading = false;

    });
  }
  ngOnInit(): void {
    this.initFormGroups();

  }


}
