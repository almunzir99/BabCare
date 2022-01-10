import { MenuGroup } from "../models/menu.group";

export const MenuList: MenuGroup[] = [
    {
        title: "General",
        children: [
            {
                title: "Home",
                icon: "las la-home",
                route: "/dashboard/home"

            },
            {
                title: "Users",
                icon: "las la-user-friends",
                route: "/dashboard/users"
            },
            {
                title: "Roles",
                icon: "las la-users-cog",
                route: "/dashboard/roles"

            }
        ]
    },
    {
        title: "Pages",
        children: [

            {
                title: "Messages",
                icon: "las la-envelope",
                route: "/dashboard/messages"

            },
        ]
    },
    {
        title: "More",
        children: [

            {
                title: "Files Manager",
                icon: "las la-folder-open",
                route: "/dashboard/files-manager"

            },
            {
                title: "Website Content",
                icon: "las la-globe-europe",
                route: "/dashboard/cms"

            },


            {
                title: "Profile",
                icon: "las la-user-cog",
                children:[
                    {
                        title:"Basic Information",
                        route: "/dashboard/profile/edit",
                        icon:"las la-user-edit"
                    },
                    {
                        title:"change Password",
                        route: "/dashboard/profile/password",
                        icon:"las la-user-shield"
                    },
                ]

            },
            {
                title: "Settings",
                icon: "las la-cog",
                route: "/dashboard/settings"

            },
        ]
    }
];