import { Base } from "./base.model";
import { Permission } from "./permission.model";

export class Role extends Base{
    title:string;
    messagesPermissions:Permission;
    rolesPermissions:Permission;
    usersPermissions:Permission;
    customersPermissions:Permission;
    deliveryPermissions:Permission;



}