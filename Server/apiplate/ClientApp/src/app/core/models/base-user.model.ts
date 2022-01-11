import { Base } from "./base.model";

export abstract class BaseUser extends Base {
    username: string;
    phone: string;
    password?: string;
    image: string;
    email: string;
    token: string;

}

