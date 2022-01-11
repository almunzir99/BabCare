import { Activity } from "./activity.model";
import { BaseUser } from "./base-user.model";
import { Role } from "./role.model";

export class User extends BaseUser{
    activities:Activity[];
    roleId:number;
    role:Role;
    
}
