import { MenuGroup } from "../models/menu.group";

export const MenuList: MenuGroup[] = [
    {
        title: "عام",
        children: [
            {
                title: "الصفحة الرئيسية",
                icon: "las la-home",
                route: "/dashboard/home"

            },
            {
                title: "ادارة المشرفين",
                icon: "las la-user-friends",
                route: "/dashboard/users"
            },
            {
                title: "ادارة الصلاحيات",
                icon: "las la-users-cog",
                route: "/dashboard/roles"

            }
        ]
    },
    {
        title: "الصفحات",
        children: [

            {
                title: "الرسائل",
                icon: "las la-envelope",
                route: "/dashboard/messages"

            },
        ]
    },
    {
        title: "المزيد",
        children: [

            {
                title: "ادارة الملفات",
                icon: "las la-folder-open",
                route: "/dashboard/files-manager"

            },

            {
                title: "الحساب  الشخصي",
                icon: "las la-user-cog",
                children:[
                    {
                        title:"المعلومات الاساسية",
                        route: "/dashboard/profile/edit",
                        icon:"las la-user-edit"
                    },
                    {
                        title:"تغيير كلمة المرور",
                        route: "/dashboard/profile/password",
                        icon:"las la-user-shield"
                    },
                ]

            },
            {
                title: "الاعدادات",
                icon: "las la-cog",
                route: "/dashboard/settings"

            },
        ]
    }
];