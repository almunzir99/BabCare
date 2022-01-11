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
                title: "ادارة العملاء",
                icon: "las la-user-friends",
                route: "/dashboard/customers"

            },
            {
                title: "ادارة التوصيل",
                icon: "las la-bicycle",
                route: "/dashboard/delivery"

            },
            {
                title: "ادارة الفروع",
                icon: "las la-code-branch",
                route: "/dashboard/branches"

            },
            {
                title: "ادارة الاصناف",
                icon: "la la-layer-group",
                route: "/dashboard/categories"

            },
            {
                title: "ادارة المنتجات",
                icon: "la la-box",
                children:[
                    {
                        title: "كل المنتجات",
                        icon: "la la-boxes",
                        route: "/dashboard/products/all"
        
                    },
                    {
                        title: "ادراة الخيارات",
                        icon: "la la-utensils",
                        route: "/dashboard/products/options"
        
                    },
                    {
                        title: "ادارة الاضافات",
                        icon: "la la-puzzle-piece",
                        route: "/dashboard/products/addons"
        
                    },
                ]

            },
            {
                title: "ادارة الطلبات",
                icon: "la la-layer-group",
                route: "/dashboard/orders"

            },
            {
                title: "ادارة العروض",
                icon: "la la-percentage",
                route: "/dashboard/offers"

            },
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