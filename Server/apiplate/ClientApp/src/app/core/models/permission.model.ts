import { Base } from "./base.model";

export class Permission extends Base{
    create:boolean;
    read:boolean;
    update:boolean;
    delete:boolean;
}
